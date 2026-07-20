---
title: "Stale-pending reap"
github: https://github.com/tmwang7324/DocuLyze/issues/3
issue: 3
type: ticket
status: open
labels: [ready-for-agent]
parent: "[[0001-SPEC-data-architecture]]"
blocked_by: ["[[0002-mint-first-lifecycle]]"]
project: Doculyze
---

# 03 — Stale-pending reap

**Parent:** [[0001-SPEC-data-architecture]]

**What to build:** Abandoned uploads clean themselves up. When a user closes the tab mid-transfer (or never PUTs at all), the document stays `pending`; a reap process finds `pending` records older than an age threshold via an indexed Firestore query — never a bucket walk — deletes the Storage object if the bytes landed, and removes the record. The user's dashboard stops showing ghost uploads.

**Blocked by:** 02 — Mint-first lifecycle reversal (the `pending` breadcrumb must exist before it can be reaped).

**Status:** ready-for-agent

- [ ] Reap selects only `pending` records past the age threshold, by indexed query on status + age.
- [ ] For each stale record: the Storage object is deleted if present, then the record is removed — no orphan in either direction after a reap pass.
- [ ] Records in any other status (`uploaded`, `processing`, `ready`, `failed`) are never touched.
- [ ] Reap is idempotent and safe to run concurrently with live uploads (a fresh `pending` mid-upload is not reaped).
- [ ] Test at the server-actions/DAL seam: sign-then-abandon → age past threshold → reap → record and object both gone.
