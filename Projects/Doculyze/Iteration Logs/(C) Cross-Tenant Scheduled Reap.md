---
type: next-step
project: Doculyze
status: open
effort: L
aliases:
  - Cross-Tenant Scheduled Reap
tags:
  - next-step
  - doculyze
labels: [enhancement]
github: https://github.com/tmwang7324/DocuLyze/issues/9
issue: 9
parent: "[[(C) RAG Ingest and Query Data Architecture]]"
blocked_by: ["[[(C) Stale-Pending Reap]]"]
updated: 2026-07-20
---

# (C) Cross-Tenant Scheduled Reap

> **Deferred.** Carried over from the source ticket as a backstop/enhancement — not queued for near-term work.

**Next step.** A session-less background job that reaps abandoned `pending` uploads across **all** users, regardless of who is browsing — the one population no in-request trigger can reach (a user who abandons an upload and never returns). This is the cross-tenant scheduled reap for stale-pending uploads (backstop for stale-pending).

**Context.** The stale-`pending` reap (`reapStalePendingDocuments()` in `doculyze/_lib/database.tsx`) is single-tenant and session-gated (`requireUid(false)`), triggered opportunistically on the dashboard render (`dashboard/page.tsx:21`). A design grill (2026-07-18) concluded that for a personal, low-volume, 5 MB-capped tool this is **sufficient** — login always redirects to `/dashboard` (`session.tsx:50`), so the opportunistic reap already fires for essentially everyone who returns. An additional in-request trigger (upload-page render, or inside `getPresignedUrl`) was considered and **rejected** as too narrow. This ticket parks the real cross-tenant scheduler as a future learning exercise.

## Design sketch (recommended answers from the grill)

1. **Identity / tenancy (load-bearing).** Current reap is `requireUid`-gated + single-collection → a session-less cron can't call it. Add a sibling `reapAllStalePendingDocuments()` querying `db.collectionGroup("documents")` under admin creds (no uid), deriving each record's path from its stored `storagePath`. Factor the per-record delete (record-first → `lastUpdateTime` precondition → object delete) into a shared helper so the two entry points can't drift.
2. **Index.** `collectionGroup` query needs a **`COLLECTION_GROUP`-scoped** composite index on `(status ASC, uploadedAt ASC)`. The current `firestore.indexes.json` entry is `COLLECTION` scope and won't serve it — add a second entry.
3. **Substrate.** Prefer **Firebase Cloud Functions `onSchedule`** (Cloud Scheduler-backed): already all-in on Firebase, admin creds for free, no public endpoint to protect. Vercel Cron → `/api/cron/reap` route handler is the alternative only if the Next app deploys to Vercel — and needs a shared-secret guard `onSchedule` avoids.
4. **Scale / frequency.** `.limit(N)` + loop so one run can't blow up; **hourly** cadence (above the 1-hour `STALE_PENDING_MAX_AGE_MS`). Real batching (BulkWriter) deferred.
5. **Coexistence.** Keep both. The `lastUpdateTime` precondition already makes concurrent reaps safe (loser's delete throws and skips), so the scheduler is a pure backstop to the dashboard fast-path — no coordination needed.

## Acceptance criteria
- [x] `reapAllStalePendingDocuments()` selects stale `pending` records across **all** users via a `collectionGroup` indexed query on status + age — never a bucket walk, never per-user iteration in app code.
- [ ] Per-record delete logic (record-first + `lastUpdateTime` precondition + object delete) is shared with the per-user reap, not duplicated.
- [ ] `COLLECTION_GROUP`-scoped composite index added to `firestore.indexes.json` and deployed.
- [ ] Runs on a schedule under admin identity with no session cookie and no publicly reachable trigger.
- [ ] Safe alongside the opportunistic dashboard reap and concurrent runs (precondition guard; no double-delete, no status regression).
- [ ] One run is bounded (`.limit`) so a large backlog can't produce an unbounded pass.
- [ ] Cross-tenant test at the DAL seam: seed stale `pending` records under multiple uids with no active session → scheduled reap → all reaped, non-`pending` and fresh-`pending` records untouched.

- **Effort:** L — a new scheduled Cloud Function service with its own admin-credentialed entry point, a cross-cutting Firestore composite index, and a shared delete-helper refactor across two entry points.
- **Blocked by:** 03 — Stale-pending reap (the per-user reap must exist first; it does).
- **Surfaced by:** [[(C) RAG Ingest and Query Data Architecture|the data-architecture SPEC]] · GitHub issue #9
