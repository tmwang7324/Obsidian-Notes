---
type: next-step
project: Doculyze
status: open
effort: M
aliases:
  - Stale-Pending Reap
tags:
  - next-step
  - doculyze
github: https://github.com/tmwang7324/DocuLyze/issues/3
issue: 3
parent: "[[(C) RAG Ingest and Query Data Architecture]]"
blocked_by: ["[[(C) Mint-First Lifecycle Reversal]]"]
updated: 2026-07-20
---

# (C) Stale-Pending Reap

**Next step.** Abandoned uploads clean themselves up. When a user closes the tab mid-transfer (or never PUTs at all), the document stays `pending`; a reap process finds `pending` records older than an age threshold via an indexed Firestore query — never a bucket walk — deletes the Storage object if the bytes landed, and removes the record. The user's dashboard stops showing ghost uploads.

## Acceptance criteria
- [ ] Reap selects only `pending` records past the age threshold, by indexed query on status + age.
- [ ] For each stale record: the Storage object is deleted if present, then the record is removed — no orphan in either direction after a reap pass.
- [ ] Records in any other status (`uploaded`, `processing`, `ready`, `failed`) are never touched.
- [ ] Reap is idempotent and safe to run concurrently with live uploads (a fresh `pending` mid-upload is not reaped).
- [ ] Test at the server-actions/DAL seam: sign-then-abandon → age past threshold → reap → record and object both gone.

- **Effort:** M — a feature touching a handful of files (reap query, deletion logic, DAL) and requiring new tests at the server-actions/DAL seam.
- **Blocked by:** [[(C) Mint-First Lifecycle Reversal]] — Mint-first lifecycle reversal (the `pending` breadcrumb must exist before it can be reaped).
- **Surfaced by:** [[(C) RAG Ingest and Query Data Architecture|the data-architecture SPEC]] · GitHub issue #3
