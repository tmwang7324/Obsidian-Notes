---
title: "Mint-first lifecycle reversal"
github: https://github.com/tmwang7324/DocuLyze/issues/2
issue: 2
type: ticket
status: open
labels: [ready-for-agent]
parent: "[[0001-SPEC-data-architecture]]"
blocked_by: []
project: Doculyze
---

# 02 — Mint-first lifecycle reversal

**Parent:** [[0001-SPEC-data-architecture]]

**What to build:** A document appears in the owner's dashboard as `pending` the moment the upload is signed — before any bytes move — and every later outcome is visible as a status, never a silent throw. On confirmed upload the record flips to `uploaded`; on a size mismatch it flips to `failed` (record written, object retained). This reverses the shipped record-after decision and establishes the invariant **no object without a record**: the presign action writes the `pending` record before returning a signed URL.

State machine slice covered by this ticket (from the design session):

| From | Event | To |
|---|---|---|
| ∅ | presign mints + signs | `pending` |
| `pending` | finalize, size OK | `uploaded` |
| `pending` | finalize, size mismatch | `failed` |

**Blocked by:** None — can start immediately.

**Status:** ready-for-agent

- [ ] Presign writes a `pending` document record (owner-scoped, server-minted docId) before the signed URL is returned; the record is queryable immediately.
- [ ] Successful finalize flips exactly that record `pending → uploaded`; re-running finalize is idempotent.
- [ ] Size-mismatch finalize writes `failed` on the record instead of throwing without a trace; the Storage object is retained (flag-only).
- [ ] A PUT that never finalizes leaves a `pending` record — no record-less object can exist.
- [ ] Dashboard renders `pending` and `failed` documents distinguishably from `uploaded`.
- [ ] Emulator-backed tests at the server-actions seam cover all three transitions — the repo's first tests; harness established here.
