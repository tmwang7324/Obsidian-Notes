---
title: "Chat context in Redis (multi-turn follow-ups)"
github: https://github.com/tmwang7324/DocuLyze/issues/8
issue: 8
type: ticket
status: open
labels: [ready-for-agent]
parent: "[[0001-SPEC-data-architecture]]"
blocked_by: ["[[0006-sync-query-path]]"]
project: Doculyze
---

# 08 — Chat context in Redis

**Parent:** [[0001-SPEC-data-architecture]]

**What to build:** Follow-up questions work naturally: within a session, a user can ask "what about the second point?" and the query service resolves it against prior turns. Conversation context lives in Redis — its first real home in the architecture (explicitly not an enrichment store). Context is scoped to the user + session, expires rather than accumulating forever, and its loss degrades gracefully to single-turn answers.

**Blocked by:** 06 — Sync query path.

**Status:** ready-for-agent

- [ ] A follow-up question that only makes sense given the prior turn is answered correctly within a session.
- [ ] Chat context is keyed per user + session; one user's context can never leak into another's generation.
- [ ] Context entries expire (TTL) — Redis eviction or restart degrades to single-turn answering, never an error.
- [ ] Redis holds only chat context — enrichments and records remain in Firestore.
- [ ] Test through the query-service flow: seeded prior turn → follow-up resolves the reference; cleared context → graceful single-turn fallback.
