---
type: synthesis
project: Doculyze
aliases: ["RAG Ingest and Query Data Architecture", "Data Architecture SPEC"]
tags: [doculyze, architecture, rag, ingest, chroma, spec]
date: 2026-07-17
updated: 2026-07-20
status: open
github: https://github.com/tmwang7324/DocuLyze/issues/1
issue: 1
sources: 1
---

# (C) RAG Ingest and Query Data Architecture

> **Design spec — mint-first lifecycle.** The umbrella design for Doculyze's retrieval half: an asynchronous ingest pipeline plus a synchronous query path. Moved into the wiki from `Projects/Doculyze/Issues/0001-SPEC-data-architecture.md` on 2026-07-20; the body below is preserved verbatim from the 2026-07-16 design session. Mirrored as [GitHub issue #1](https://github.com/tmwang7324/DocuLyze/issues/1).
>
> **This spec supersedes parts of [[(C) Architecture|Doculyze Architecture]] and [[(C) Two-Store Data Layer|Two-Store Data Layer]] that have not yet been reconciled** — see *Reconciliation needed* at the foot of this page.

The eight implementation tickets decomposed from this spec live in `Projects/Doculyze/Iteration Logs/` as `type: next-step` notes.

## Problem Statement

Users can upload documents to DocuLyze, but nothing happens after the upload: there is no analysis, no chat, no way to ask questions about a document. The entire retrieval half of the product — parsing, embedding, retrieval-augmented answers, and NLP enrichments (summary, NER, sentiment) — does not exist.

The upload lifecycle is also incomplete in a way users and operators will eventually feel: if a browser uploads bytes to Storage but never confirms (tab closed, network drop), the object is stranded with no record anywhere — invisible to the user, invisible to cleanup, silently accruing storage cost. And when a finalize check fails today, the system throws without recording anything, producing the same record-less orphan.

## Solution

Turn an uploaded document into a queryable, enriched document through an asynchronous ingest pipeline, and answer user questions about their own documents through a synchronous query path.

From the user's perspective: after uploading, a document visibly moves through a lifecycle (pending → uploaded → processing → ready, or failed), and once ready they can ask questions answered from that document's content, see its summary and named entities, and trust that no other user can ever see or retrieve from their documents.

From the system's perspective: every object in Storage is traceable from the moment a URL is signed ("no object without a record" — mint-first), failures mark records instead of vanishing, abandoned uploads are reaped by a cheap indexed query rather than a bucket walk, and heavy ingest work can never starve live queries.

## User Stories

1. As a document owner, I want my upload to appear in my dashboard immediately with a `pending` status, so that I can see the system acknowledged my upload before the bytes finish transferring.
2. As a document owner, I want my document's status to update to `uploaded` once the bytes are confirmed, so that I know the transfer succeeded.
3. As a document owner, I want my document to progress automatically to `processing` and then `ready` without any action from me, so that analysis starts the moment my upload lands.
4. As a document owner, I want a clear `failed` status when my document could not be processed (wrong format, corrupt bytes, size mismatch), so that I know to re-upload rather than wait forever.
5. As a document owner, I want to ask questions about a `ready` document and get answers generated from its actual content, so that I can extract information without reading the whole document.
6. As a document owner, I want answers drawn only from my own documents, so that my private content never leaks into another user's answers.
7. As a document owner, I want a summary of my document available once it is ready, so that I can triage documents without opening them.
8. As a document owner, I want named entities extracted from my document, so that I can see at a glance who and what it is about.
9. As a document owner, I want sentiment available for my document's content, so that I can gauge tone across what I've uploaded.
10. As a document owner, I want an enrichment that failed at ingest to be computed when I first ask for it (and remembered afterwards), so that one flaky enrichment step doesn't make my document less useful forever.
11. As a document owner, I want a document whose enrichment failed to still be queryable if its chunks landed, so that a cosmetic failure doesn't block the core product.
12. As a document owner, I want abandoned uploads (where I closed the tab mid-transfer) to eventually disappear from my dashboard, so that my document list reflects reality.
13. As a document owner, I want re-processing of the same document to be safe (no duplicate chunks, no duplicated records), so that retries never corrupt my data.
14. As a returning user, I want my chat context to persist across turns within a session, so that follow-up questions work naturally.
15. As a security-conscious user, I want a file whose bytes don't match its claimed format to be rejected before deep parsing, so that hostile files get minimal attack surface.
16. As a security-conscious user, I want raw uploaded bytes never served back to any browser, so that a malicious upload can't be weaponized against other users.
17. As an operator, I want ingest throughput to scale independently of query latency, so that a burst of large uploads never makes chat feel slow.
18. As an operator, I want failed documents flagged and retained rather than deleted, so that I can inspect what went wrong.
19. As an operator, I want cleanup of stale `pending` records to be a cheap indexed query, so that reconciliation never requires walking the storage bucket.
20. As an operator, I want the embedding model and version pinned and recorded, so that a model change is an explicit re-embed migration rather than silent retrieval garbage.
21. As an operator, I want ingest jobs to be tiny replayable envelopes rather than file payloads, so that the broker stays small and any job can be safely re-run.
22. As a developer, I want all vector-store access to go through one gateway that always applies the tenant filter, so that no future call site can forget it.
23. As a developer, I want exactly one place that computes the storage path and one place that filters by tenant, so that these invariants cannot drift across call sites.
24. As a developer, I want the Python services unreachable from the public internet and fed `uid` only by the trusted Next.js layer, so that there is exactly one auth boundary to reason about.

## Implementation Decisions

All decisions below were resolved in the 2026-07-16 grill session (design-only; no build clock).

**Lifecycle — mint-first (reverses the 2026-07-11 record-after decision).** The presign action writes a `pending` document record *before* signing the upload URL. Finalize flips `pending → uploaded` on success and writes `failed` on size mismatch (never throw-into-void). Invariant: **no object without a record** — every live Storage object has a Firestore breadcrumb from before the bytes existed. Cleanup of client-abandoned uploads is a stale-`pending` reap by age (indexed Firestore query), never a bucket walk. Cost accepted: one extra Firestore write per upload.

**Status state machine** (from the design session):

| From | Event | To |
|---|---|---|
| ∅ | presign mints + signs | `pending` |
| `pending` | finalize, size OK | `uploaded` (→ enqueue) |
| `pending` | finalize, size mismatch | `failed` |
| `pending` | client abandons | stays `pending` → reaped by age |
| `uploaded` | worker picks up | `processing` |
| `processing` | precheck + parse + embed OK | `ready` (enrichments best-effort) |
| `processing` | precheck/parse/embed fail | `failed` |

`failed` is terminal; the object is retained (flag-only). `ready` means exactly "chunks are in the vector store — RAG works," nothing more.

**Ingest is pull-based.** The job envelope is `{ uid, docId }` — never bytes. The worker fetches the object itself from Storage using the single canonical path formula (becoming its 4th caller). Finalize is the enqueue point. This keeps jobs tiny and replayable and preserves the presigned trust boundary (bytes never transit a server).

**One broker flow, job count = 1.** Ingest is the only asynchronous, slow, retryable flow. "Queue/broker" is the abstract async hand-off role — RabbitMQ specifically remains cut by name. RAG query is **synchronous** (direct call; the user is waiting on a spinner; a broker there adds RPC reply-queue complexity for zero throughput gain).

**Ingest worker pipeline (single pass):** pull object → magic-number precheck (cheap format gate in front of the parser; mismatch → `failed`) → parse in a sandboxed worker (parser-as-sniff; the sandbox plus never serving raw bytes are the real malware controls — scan-before-storage protects nothing) → chunk → embed via hosted Voyage → write chunks to the vector store through the tenant gateway → compute enrichments (NER, summary, sentiment) → store enrichments in Firestore keyed by docId → status `ready`.

**Enrichment failure semantics.** Embed failure → `failed` (no product without chunks). Enrichment failure → still `ready` with the enrichment field `null`. Null reads use cache-with-fallback: compute on demand, backfill Firestore (durable — enrichment of an immutable document is compute-once-forever). Access goes through a `getEnrichment(docId)` seam so a read accelerator (Redis) can be added later without touching callers. Redis is **not** the enrichment store (recompute-on-eviction would defeat precompute); its first real home is chat context.

**Trust topology — one auth boundary.** Next.js server actions remain the sole auth boundary (`uid` from the verified session cookie). Python services are internal-only and trust `uid` by provenance: clients cannot address them; only the Next layer enqueues jobs or calls the query service. Express is retired.

**Two Python containers.** (1) Async ingest worker, scales on queue depth. (2) Sync query service, scales on request concurrency. Split so bursty embed work can't starve latency-sensitive queries. Hosted Voyage embeddings at MVP make the split free (no local model to double-load).

**Vector store tenancy — enforced gateway.** Chroma runs as a standalone shared service (both containers need it). Single collection; every access goes through gateway functions (`writeUserChunks(uid, …)` / `queryUserChunks(uid, …)`) that *always* inject the `userId` filter — same "one place, can't drift" pattern as the storage-path formula. Chunk metadata carries `{ userId, docId }` (enables delete-by-doc and idempotent re-embed). The embedding model + version is pinned and stored; changing it is a full re-embed migration (dimension drift produces silent garbage).

**Query path:** embed the question (Voyage) → `queryUserChunks(uid)` → retrieve → generate → answer. Chat context lives in Redis.

## Testing Decisions

- Good tests exercise **external behavior at a seam**, not implementation details: statuses observed in Firestore, chunks retrievable through the gateway, errors surfaced to the caller — never internal call ordering.
- **Seam 1 (existing): the server actions** — presign and finalize, run against Firebase emulators. This seam proves the whole mint-first state machine: record exists before URL, `pending → uploaded` flip, size-mismatch → `failed` (record written, not thrown away), enqueue on success, and the stale-`pending` reap query.
- **Seam 2 (new): the ingest worker's job entry point** — feed a `{ uid, docId }` envelope with an object staged in (emulated) Storage; assert status transitions, chunk writes through the gateway with correct `{ userId, docId }` metadata, enrichment fields written or `null`, and `failed` on magic-number mismatch or corrupt bytes. The Voyage client is faked at the embedding-client boundary; replaying the same envelope must be idempotent.
- The Chroma gateway and `getEnrichment` are tested **through** these seams, not directly.
- Read-side tenant isolation (user B's query retrieves nothing from user A's chunks) can only be fully proven at the query-service endpoint, which is outside the two agreed seams — deferred until that endpoint exists; write-side metadata correctness at Seam 2 is the interim guarantee.
- Prior art: none — the repo currently has zero tests. These seams establish the first harness (emulator-backed integration tests); keep the harness minimal and the seams stable.

## Out of Scope

- **Building any of this before 2026-07-27.** The design is design-only; a Fable-coded prototype is a possibility afterwards. Publishing this spec sets no build clock.
- RabbitMQ specifically (the broker role is abstract; RabbitMQ remains cut by name).
- Translation (cut — it would have been the only second async job).
- Redis as an enrichment store or read cache (deferred behind `getEnrichment`; Redis's first home is chat context).
- A malware-scanning service (controls are the sandboxed parser + never serving raw bytes).
- HyDE / reranking and other retrieval-quality work beyond plain embed-retrieve-generate.
- Google OAuth; any Express backend work (Express is retired, removal is separate cleanup).
- MongoDB (the original plan's document store — superseded by Firestore + Storage).
- Chat UI/UX beyond a working question→answer path.

## Further Notes

- This spec **reverses two decisions** from the 2026-07-11 storage/upload grill: record-after → mint-first, and accept-leak + full-bucket reconciliation → `pending` + stale-reap. The shipped code (record-after, finalize-throws-without-record) intentionally diverges from this design until implementation starts.
- Known code debt this spec resolves when implemented: the finalize size-mismatch path currently throws with no record written (record-less orphan); the ingest enqueue point does not exist.
- Design provenance: GRILL-ME-data-architecture-2026-07-16 (Obsidian), which also updated the architecture wiki notes; decisions are cross-referenced there as Q1–Q9.

## Reconciliation needed

This spec (2026-07-17) contradicts [[(C) Architecture|Doculyze Architecture]] (last updated 2026-06-16) and [[(C) Two-Store Data Layer|Two-Store Data Layer]] (2026-06-15) on the following points. **These have not been reconciled** — the older pages still assert the superseded position, and proper ADRs for the reversals have not been authored:

| Older wiki pages say | This spec says |
|---|---|
| Express "mediates all data access" | Express is **retired**; Next.js server actions are the sole auth boundary |
| Chroma is local + persistent | Chroma is a **standalone shared service** |
| One Python/FastAPI service alongside Express | **Two** Python containers — async ingest worker + sync query service |
| Embedding model pinned to OpenAI `text-embedding-3-small` | **Hosted Voyage** |
| HyDE + re-ranking are Tier-2 goals | HyDE / re-ranking explicitly **out of scope** |
| Backend-language question open | Resolved → Python |

Additionally, the two decisions this spec reverses (record-after → mint-first; accept-leak → stale-reap) have **no decision records** in `Decisions/`, so there is nothing to mark `superseded`. Running `synthesize` is the intended path to author those ADRs and update the current-state map.

## Related

- [[(C) Architecture|Doculyze Architecture]] · [[(C) Doculyze|Doculyze Overview]] · [[(C) Two-Store Data Layer|Two-Store Data Layer]] · [[(C) Doculyze MVP Scope|Doculyze MVP Scope]] · [[(C) Auth Architecture|Auth Architecture]] · [[(C) Firebase|Firebase]] · [[(C) Next.js|Next.js]]

## Sources

- `GRILL-ME-data-architecture-2026-07-16` — the design session that resolved every decision above (cross-referenced there as Q1–Q9).
