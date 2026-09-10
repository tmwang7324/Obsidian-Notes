---
type: next-step
project: Doculyze
status: open
effort: M
aliases:
  - Mint-First Lifecycle Reversal
tags:
  - next-step
  - doculyze
github: https://github.com/tmwang7324/DocuLyze/issues/2
issue: 2
parent: "[[(C) RAG Ingest and Query Data Architecture]]"
blocked_by: []
updated: 2026-07-20
---

# (C) Mint-First Lifecycle Reversal

**Next step.** A document appears in the owner's dashboard as `pending` the moment the upload is signed — before any bytes move — and every later outcome is visible as a status, never a silent throw. On confirmed upload the record flips to `uploaded`; on a size mismatch it flips to `failed` (record written, object retained). This reverses the shipped record-after decision and establishes the invariant **no object without a record**: the presign action writes the `pending` record before returning a signed URL.

State machine slice covered by this ticket (from the design session):

| From | Event | To |
|---|---|---|
| ∅ | presign mints + signs | `pending` |
| `pending` | finalize, size OK | `uploaded` |
| `pending` | finalize, size mismatch | `failed` |

## Acceptance criteria
- [x] Presign writes a `pending` document record (owner-scoped, server-minted docId) before the signed URL is returned; the record is queryable immediately.
- [x] Successful finalize flips exactly that record `pending → uploaded`; re-running finalize is idempotent.
- [x] Size-mismatch finalize writes `failed` on the record instead of throwing without a trace; the Storage object is retained (flag-only).
- [x] A PUT that never finalizes leaves a `pending` record — no record-less object can exist.
- [x] Dashboard renders `pending` and `failed` documents distinguishably from `uploaded`.
- [x] Emulator-backed tests at the server-actions seam cover all three transitions — the repo's first tests; harness established here.

- **Effort:** M — a feature touching multiple files (presign action, finalize action, dashboard rendering) and requiring new tests (first emulator-backed test harness in the repo).
- **Blocked by:** None
- **Surfaced by:** [[(C) RAG Ingest and Query Data Architecture|the data-architecture SPEC]] · GitHub issue #2
