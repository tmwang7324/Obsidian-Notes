---
title: "Embed + Chroma tenant gateway (ready = chunks in Chroma)"
github: https://github.com/tmwang7324/DocuLyze/issues/5
issue: 5
type: ticket
status: open
labels: [ready-for-agent]
parent: "[[0001-SPEC-data-architecture]]"
blocked_by: ["[[0004-pull-based-ingest-tracer]]"]
project: Doculyze
---

# 05 — Embed + Chroma tenant gateway

**Parent:** [[0001-SPEC-data-architecture]]

**What to build:** A parsed document becomes retrievable: the worker chunks the text, embeds via hosted Voyage, and writes chunks to a standalone Chroma service — at which point the document reaches `ready`, whose meaning is exactly "chunks are in Chroma; RAG works." All vector-store access goes through gateway functions (`writeUserChunks` / `queryUserChunks`) that always inject the tenant filter — the same "one place, can't drift" pattern as the storage-path formula. Single collection; chunk metadata `{ userId, docId }` so delete-by-doc and idempotent re-embed are possible. The embedding model + version is pinned and stored; changing it is an explicit full re-embed migration.

**Blocked by:** 04 — Pull-based ingest tracer (parsed text and worker pipeline).

**Status:** ready-for-agent

- [ ] `processing → ready` occurs only after chunks are written to Chroma; embed failure → `failed`.
- [ ] Every chunk write goes through the gateway and carries `{ userId, docId }` metadata; no call site touches Chroma directly.
- [ ] Embedding model + version are pinned in config and recorded with the stored chunks.
- [ ] Re-running ingest for the same docId replaces that document's chunks (idempotent — no duplicates).
- [ ] Voyage is faked at the embedding-client boundary in tests.
- [ ] Tests at the worker job-entry seam: envelope in → document `ready`, chunks retrievable through the gateway with correct tenant metadata; embed-failure path → `failed`.
