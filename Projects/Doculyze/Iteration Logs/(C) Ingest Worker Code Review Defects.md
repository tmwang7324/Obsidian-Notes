---
type: next-step
project: Doculyze
status: open
effort: L
aliases:
  - Ingest Worker Code Review Defects
tags:
  - next-step
  - doculyze
  - code-review
parent: "[[(C) Embed + Chroma Tenant Gateway]]"
updated: 2026-08-10
---

# (C) Ingest Worker Code Review Defects

**Next step.** A medium-effort code review scoped to `ingest-worker/` surfaced 10 confirmed correctness/robustness defects. Tenant isolation reviewed clean. Two were slated for immediate fix (a fix round was paused mid-flight); the rest are follow-ups.

## Fix-now (issue #29 scope)

### 1. Unbounded embed call — `vector_store.py`, `write_user_chunks`
**Severity:** HIGH. A single Voyage call with every chunk; a 5 MB text upload (~1250 chunks, >1M tokens) exceeds Voyage's per-request caps (1000 texts / 1M tokens). Raises client-side, doc marked terminally `failed`; every retry fails identically.
**Fix:** Batch `embed_fn` calls (128 texts per call, optionally token-budgeted using the already-computed `chunk.tokens`), concatenate vectors, single Chroma `add`.

### 2. Unguarded verification read — `job.py`, `run_ingest_job`
**Severity:** MEDIUM-HIGH. The `write_user_chunks` call is inside `try → mark_failed` but the `get_user_chunks` read-back three lines later isn't. A Chroma blip there raises, consumer NACKs to the dead queue, doc rests at `processing` — the exact state the adjacent comment claims impossible.
**Fix:** Bring the read into the same `try → mark_failed` path, or DLQ both consistently if the outage policy flips (see #3).

## Design tension (user decision required)

### 3. Outages become terminal `failed` — `job.py`
**Severity:** HIGH consequence, but deliberate per issue #29's acceptance ("embed failure → failed"). Contradicts CONTEXT.md ("failed never means a dependency was down; outages ride the DLQ"). A missing `VOYAGE_API_KEY` or a 30 s Chroma restart marks every in-flight doc `failed`; claim logic skips `ready`/`failed` forever, DLQ stays empty, recovery = hand-editing Firestore.
**Fix if policy flips:** Classify exceptions — document-level (empty content, oversized) → `failed`; network/API errors → raise → DLQ.

### 4. Non-atomic delete-then-add — `vector_store.py`, `write_user_chunks`
**Severity:** MEDIUM. Re-run of a doc that crashed between vector write and `mark_ready` deletes the good vectors first; if the re-embed then fails (compounded by #3) the doc is terminally `failed` with zero vectors.
**Fix:** Write new vectors under new ids before deleting old ones (add-then-delete-stale), or gate the delete on successful embedding.

## Pre-existing (issues #12 / #27 heritage)

### 5. `CHUNK_OUTPUT_DIR` debug output — `job.py`
**Severity:** MEDIUM in prod compose. Named volume mountpoint is root-owned while the container runs non-root → first doc raises `PermissionError` → DLQ, doc stuck at `processing`. Also never prunes stale chunk files on re-run and accumulates full user plaintext unbounded.
**Fix:** Drop from prod compose now that chunks live in Chroma (keep dev-only), or guard with `try/except` + pre-clean the doc dir.

### 6. Unfenced `mark_ready` / `mark_failed` — `firestore_status.py`
**Severity:** MEDIUM (only matters at multi-worker scale). Terminal writes are unconditional updates, so an evicted stale-lease worker finishing late can overwrite the takeover worker's outcome, including a `failed → ready` regression the module docstring forbids.
**Fix:** Transaction that re-checks `status == "processing"` and the caller's own `claimedAt` fencing token before writing.

### 7. Table chunks unbounded — `chunker.py`, `chunk_markdown`
**Severity:** MEDIUM retrieval quality. The `is_table` branch skips the `max_tokens` check. Huge tables become multi-thousand-token chunks; Voyage's default `truncation=True` silently cuts them, so stored text and vector disagree.
**Fix:** Split oversized tables by row groups (repeat header row per split), and/or pass truncation explicitly + log when a chunk exceeds the model context.

### 8. Table caption heuristic misfires — `chunker.py`, `_split_around_tables`
**Severity:** LOW-MEDIUM. A caption separated by a blank line is lost to prose (`rsplit` gives `caption=''`), while any single-line paragraph after a table — including `#### Subheading` — is welded into the atomic table chunk.
**Fix:** Recognize caption patterns (`Table N:`, italic lines) rather than positional `rsplit`, and exclude heading-prefixed lines from below-caption absorption.

### 9. tiktoken BPE fetched at runtime — `job.py` / `chunker.py` + `Dockerfile`
**Severity:** LOW-MEDIUM (deploy-env dependent). First `chunk_markdown` call downloads `cl100k_base`; in an egress-restricted deploy that raises a network error outside the `(ValueError, TypeError)` guard → DLQ, doc at `processing`.
**Fix:** Bake the encoding at image build (`TIKTOKEN_CACHE_DIR` + warmup `RUN`), mirroring the baked Docling models.

### 10. U+FFFD blindly rewritten to apostrophe — `chunker.py`, `chunk_markdown` preamble
**Severity:** LOW. U+FFFD marks any unmapped glyph; degree signs / Greek letters from subsetted fonts silently become apostrophes in both embedded and cited text.
**Fix:** Drop the substitution or log it; real repair belongs at the parser/decode layer.

## Also noted

- `ingest-worker/chunk-output/` holds real extracted user-document text and is **not gitignored** — a `git add -A` would commit it.
- `create_embedder()` builds a fresh `voyageai.Client` per document while `chroma_client()` is memoized (minor inefficiency).
