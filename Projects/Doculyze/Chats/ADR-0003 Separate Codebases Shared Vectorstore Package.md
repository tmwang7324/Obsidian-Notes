---
type: adr
project: Doculyze
status: accepted
adr: 3
aliases: ["ADR-0003", "Separate Codebases + Shared Vectorstore Package"]
tags: [doculyze, adr, rag, architecture]
updated: 2026-07-21
related: ["[[(C) Embed + Chroma Tenant Gateway]]", "[[(C) Sync Query Path]]"]
---

# ADR-0003: Separate codebases + shared `doculyze_vectorstore` package

**Status:** Accepted (2026-07-21) — recorded in the vault per maintainer ruling.

## Context

The tenant gateway (`writeUserChunks` / `queryUserChunks`) is needed by **two** deployables: the ingest worker (write side, #5) and the future query service ([[(C) Sync Query Path|#6]], read side). The tenant filter must live in exactly one place or it drifts — the same "one place, can't drift" invariant as the canonical storage-path formula. Three ways to share it were weighed:

1. One image, two entrypoints. 
2. Separate codebases + a shared package.
3. Gateway as its own HTTP service.

## Decision

**Option 2.** Separate top-level codebases in the monorepo, sharing a package **`doculyze_vectorstore`** under a new `packages/` dir, installed **editable / path-based** (`pip install -e ../packages/vectorstore`) — one on-disk source of truth.

- The package owns the **whole vector-space boundary**: `gateway.py` (the only importer of `chromadb`), `embeddings.py` (`embed_texts` + backoff; the only importer of the Voyage SDK), `config.py` (embedding pin + collection name).
- **ingest-worker (#5)** adds only chunking (write side) and calls `embed_texts → writeUserChunks → mark_ready`. Both gateway functions are built now — #5's test reads chunks back to verify tenant metadata.

**Rejected:** Option 1 (muddies top-level org — maintainer wants clear separation). Also, image becomes too large. Asychronous embedding requires independent scaling.  Option 3 (HTTP service only earns its keep with a non-Python caller or a centralized tenant-policy engine, neither of which exists; `uid` is trusted-by-provenance either way). A **separate git repo with a published/pinned version** was also rejected — it re-admits drift, since the worker and query service could pin different versions and run **two tenant filters at once.**

## Consequences

- Two deployables share exactly one tenant filter and one embedding pin.
- The query side must embed questions with the *same* pinned model as the chunks — which is *why* embeddings live in the shared package, not the worker.
- The monorepo gains a `packages/` dir; both apps take an editable dependency on it.
- Swapping Chroma or Voyage touches only the package internals, not either app's job logic.
