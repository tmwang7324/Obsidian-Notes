---
type: next-step
project: Doculyze
status: open
effort: M
aliases:
  - Chat Context in Redis
tags:
  - next-step
  - doculyze
github: https://github.com/tmwang7324/DocuLyze/issues/8
issue: 8
parent: "[[(C) RAG Ingest and Query Data Architecture]]"
blocked_by: ["[[(C) Sync Query Path]]"]
updated: 2026-07-20
---

# (C) Chat Context in Redis

**Next step.** Follow-up questions work naturally: within a session, a user can ask "what about the second point?" and the query service resolves it against prior turns. Conversation context lives in Redis — its first real home in the architecture (explicitly not an enrichment store). Context is scoped to the user + session, expires rather than accumulating forever, and its loss degrades gracefully to single-turn answers.

## Acceptance criteria
- [ ] A follow-up question that only makes sense given the prior turn is answered correctly within a session.
- [ ] Chat context is keyed per user + session; one user's context can never leak into another's generation.
- [ ] Context entries expire (TTL) — Redis eviction or restart degrades to single-turn answering, never an error.
- [ ] Redis holds only chat context — enrichments and records remain in Firestore.
- [ ] Test through the query-service flow: seeded prior turn → follow-up resolves the reference; cleared context → graceful single-turn fallback.

- **Effort:** M — a feature touching the query service, a new Redis-backed context store, and session/TTL logic, requiring new tests.
- **Blocked by:** 06 — Sync query path.
- **Surfaced by:** [[(C) RAG Ingest and Query Data Architecture|the data-architecture SPEC]] · GitHub issue #8
