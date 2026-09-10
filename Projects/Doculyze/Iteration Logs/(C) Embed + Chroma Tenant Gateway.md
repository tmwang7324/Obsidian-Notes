---
type: next-step
project: Doculyze
status: open
effort: L
aliases:
  - Embed + Chroma Tenant Gateway
tags:
  - next-step
  - doculyze
github: https://github.com/tmwang7324/DocuLyze/issues/5
issue: 5
parent: "[[(C) RAG Ingest and Query Data Architecture]]"
blocked_by: ["[[(C) Pull-Based Ingest Tracer]]", "[[(C) Normalize to Markdown]]", "[[(C) Processing Lease Claim Fencing]]"]
updated: 2026-07-21
---

# (C) Embed + Chroma Tenant Gateway

**Next step.** A parsed document becomes retrievable: the worker chunks the text, embeds via hosted Voyage, and writes chunks to a standalone Chroma service — at which point the document reaches `ready`, whose meaning is exactly "chunks are in Chroma; RAG works." All vector-store access goes through gateway functions (`writeUserChunks` / `queryUserChunks`) that always inject the tenant filter — the same "one place, can't drift" pattern as the storage-path formula. Single collection; chunk metadata `{ userId, docId }` so delete-by-doc and idempotent re-embed are possible. The embedding model + version is pinned and stored; changing it is an explicit full re-embed migration.

## Acceptance criteria
- [ ] `processing → ready` occurs only after chunks are written to Chroma; embed failure → `failed`.
- [ ] Every chunk write goes through the gateway and carries `{ userId, docId }` metadata; no call site touches Chroma directly.
- [ ] Embedding model + version are pinned in config and recorded with the stored chunks.
- [ ] Re-running ingest for the same docId replaces that document's chunks (idempotent — no duplicates).
- [ ] Voyage is faked at the embedding-client boundary in tests.
- [ ] Tests at the worker job-entry seam: envelope in → document `ready`, chunks retrievable through the gateway with correct tenant metadata; embed-failure path → `failed`.

- **Effort:** L — introduces a new standalone Chroma service plus the tenant-scoped gateway abstraction the whole pipeline routes through, not a contained code change.
- **Blocked by:** [[(C) Pull-Based Ingest Tracer]] — parsed text + worker pipeline · [[(C) Normalize to Markdown]] (#11) — chunker consumes Markdown, so this lands first · [[(C) Processing Lease Claim Fencing]] (#12) — makes the Chroma writes safe under replay/scale-out.
- **Surfaced by:** [[(C) RAG Ingest and Query Data Architecture|the data-architecture SPEC]] · GitHub issue #5
