---
type: next-step
project: Doculyze
status: open
effort: L
aliases:
  - Sync Query Path
tags:
  - next-step
  - doculyze
github: https://github.com/tmwang7324/DocuLyze/issues/6
issue: 6
parent: "[[(C) RAG Ingest and Query Data Architecture]]"
blocked_by: ["[[(C) Embed + Chroma Tenant Gateway]]"]
updated: 2026-07-20
---

# (C) Sync Query Path

*Question → answer from own docs.*

**Next step.** A user asks a question about a `ready` document and gets an answer generated from its content. The flow is synchronous end to end — no broker: the Next.js layer (sole auth boundary; `uid` from the verified session cookie) calls the internal-only query service (container 2), which embeds the question via Voyage, retrieves through `queryUserChunks(uid)` — the gateway always injects the tenant filter — and generates the answer. The query service scales on request concurrency, independent of the ingest worker, so embed bursts can't make chat slow.

## Acceptance criteria
- [ ] A question about the user's own `ready` document returns an answer grounded in that document's chunks.
- [ ] All retrieval goes through `queryUserChunks(uid)`; user B's question retrieves nothing from user A's chunks — read-side tenant isolation proven by test.
- [ ] The query service is unreachable from the public internet; `uid` arrives only from the Next.js layer by provenance.
- [ ] The path is fully synchronous — no broker, no polling, no reply queues.
- [ ] Question embedding uses the same pinned model + version as ingest.
- [ ] Minimal question→answer surface in the app (a working ask flow; chat polish out of scope).

- **Effort:** L — stands up a new internal-only query service (container 2) alongside the ingest worker, wired to the Next.js auth boundary and the Chroma tenant gateway, plus a read-side tenant-isolation test.
- **Blocked by:** 05 — Embed + Chroma tenant gateway.
- **Surfaced by:** [[(C) RAG Ingest and Query Data Architecture|the data-architecture SPEC]] · GitHub issue #6
