---
title: "Sync query path (question → answer from own docs)"
github: https://github.com/tmwang7324/DocuLyze/issues/6
issue: 6
type: ticket
status: open
labels: [ready-for-agent]
parent: "[[0001-SPEC-data-architecture]]"
blocked_by: ["[[0005-embed-chroma-gateway]]"]
project: Doculyze
---

# 06 — Sync query path

**Parent:** [[0001-SPEC-data-architecture]]

**What to build:** A user asks a question about a `ready` document and gets an answer generated from its content. The flow is synchronous end to end — no broker: the Next.js layer (sole auth boundary; `uid` from the verified session cookie) calls the internal-only query service (container 2), which embeds the question via Voyage, retrieves through `queryUserChunks(uid)` — the gateway always injects the tenant filter — and generates the answer. The query service scales on request concurrency, independent of the ingest worker, so embed bursts can't make chat slow.

**Blocked by:** 05 — Embed + Chroma tenant gateway.

**Status:** ready-for-agent

- [ ] A question about the user's own `ready` document returns an answer grounded in that document's chunks.
- [ ] All retrieval goes through `queryUserChunks(uid)`; user B's question retrieves nothing from user A's chunks — read-side tenant isolation proven by test.
- [ ] The query service is unreachable from the public internet; `uid` arrives only from the Next.js layer by provenance.
- [ ] The path is fully synchronous — no broker, no polling, no reply queues.
- [ ] Question embedding uses the same pinned model + version as ingest.
- [ ] Minimal question→answer surface in the app (a working ask flow; chat polish out of scope).
