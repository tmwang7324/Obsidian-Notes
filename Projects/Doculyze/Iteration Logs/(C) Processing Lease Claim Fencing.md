---
type: next-step
project: Doculyze
status: open
effort: M
aliases:
  - Processing Lease Claim Fencing
tags:
  - next-step
  - doculyze
github: https://github.com/tmwang7324/DocuLyze/issues/12
issue: 12
parent: "[[(C) RAG Ingest and Query Data Architecture]]"
blocked_by: []
updated: 2026-07-21
---

# (C) Processing Lease Claim Fencing

**Next step.** Amend the [[(C) Pull-Based Ingest Tracer|ingest]] claim transaction so `processing` becomes a real **lease**, not just a status. Today `claim_for_processing` returns `RERUN` unconditionally on a `processing` doc — the transaction serializes the claim compare-and-set and blocks regression, but it does **not** serialize concurrent *execution*: two live workers on one doc both proceed. Harmless in #4 (parse ends in memory), but a **silent corruption bug once [[(C) Embed + Chroma Tenant Gateway|#5]] lands** — concurrent RERUN interleaves `deleteUserChunks`/`writeUserChunks` → duplicated / lost / partial chunks. `prefetch=1` doesn't help (it's per-consumer). Safe today only because compose runs one worker replica — i.e. safety rests on deployment cardinality, not a code invariant. Fix: add a `BUSY`/`DEFER` outcome — stale `claimedAt` → RERUN (takeover), fresh → BUSY → NACK-requeue-with-delay.

## Acceptance criteria
- [ ] `claim_for_processing` returns `BUSY` when `claimedAt` is fresh, `RERUN` when stale.
- [ ] Consumer NACK-requeues `BUSY` with a delay (TTL-retry-queue that dead-letters back to `doc.ingest`, or the delayed-message-exchange plugin).
- [ ] Claim-seam tests: fresh `processing` → `BUSY`; stale `processing` → `RERUN`.
- [ ] Lease TTL configurable, documented as "must exceed max job runtime."
- [ ] `mark_finished` / `"finished"` dead code resolved.

- **Effort:** M — small transaction change, but the delayed-requeue needs a broker-topology addition (retry queue / DLX) and a tunable TTL.
- **Amendment to:** [[(C) Pull-Based Ingest Tracer]] — hardens its claim transaction.
- **Blocks:** [[(C) Embed + Chroma Tenant Gateway]] — makes #5's Chroma writes safe under replay/scale-out.
- **Surfaced by:** the #5 design grill (2026-07-21) · GitHub issue #12
