---
type: adr
project: Doculyze
status: accepted
adr: 5
aliases: ["ADR-0005", "Processing Lease / Claim Fencing"]
tags: [doculyze, adr, ingest, concurrency]
updated: 2026-07-21
related: ["[[(C) Processing Lease Claim Fencing]]", "[[(C) Pull-Based Ingest Tracer]]", "[[ADR-0001 RabbitMQ as Ingest Broker]]"]
---

# ADR-0005: Processing-lease / claim fencing

**Status:** Accepted (2026-07-21) — recorded in the vault per maintainer ruling. Tracked as GitHub issue #12 (amendment to #4).

## Context

`claim_for_processing` returns `RERUN` **unconditionally** when a document is already `processing` — no staleness check. The Firestore transaction guarantees (a) atomic single-`CLAIMED` among racers on `uploaded` and (b) no regression on `ready`/`failed`, but it does **not** serialize concurrent *execution*: two live workers on the same doc both proceed.

- **Harmless in #4** — parse ends in memory; concurrent RERUNs share a terminal state.
- **Corruption once #5 lands** — RERUN triggers `deleteUserChunks` → `writeUserChunks`; concurrent RERUN interleaves them → duplicated / lost / partial chunks, and `mark_ready` can fire over a set another worker is mid-delete on.

`prefetch=1` does **not** prevent this — it is per-consumer (one unacked message each, fair dispatch), not per-queue. Concurrency needs ≥2 replicas + a duplicate envelope. The system is safe *today* only because compose runs a **single worker replica** — i.e. safety rests on deployment cardinality, not a code invariant, and any `--scale` / replica bump silently reintroduces corruption.

## Decision

Turn `processing` + `claimedAt` into a real **fencing lease**. Add a `Claim` outcome **`BUSY`/`DEFER`**:

| Status seen | `claimedAt` | Outcome |
|---|---|---|
| `uploaded` | — | `CLAIMED` |
| `processing` | **stale** (> lease TTL) | `RERUN` (crashed-worker takeover, refresh `claimedAt`) |
| `processing` | **fresh** | `BUSY` |
| `ready` / `failed` | — | `SKIP` |
| `pending` / missing | — | `ABSENT` |

The consumer maps `BUSY` → **NACK-requeue-with-delay** (retries until the live worker resolves the doc → then `SKIP`; self-heals if the "alive" worker actually died just after claiming).

## Consequences

- "One active job per document" becomes a **code invariant**, so horizontal scale-out (multiple ingest workers) is safe. Supersedes the implicit "single replica is a correctness requirement" constraint.
- **Lease TTL** must exceed worst-case *legit* job runtime (sandbox 20s + chunk + batched Voyage calls w/ backoff + Chroma writes). Recommend a job-level hard timeout, then set the TTL just above it; configurable; never evict a still-working worker.
- **"Requeue-with-delay" is not a single AMQP primitive** — plain NACK `requeue=true` redelivers immediately (busy-loop). It needs a **TTL-retry-queue that dead-letters back to `doc.ingest`** (reuses the [[ADR-0001 RabbitMQ as Ingest Broker|existing DLX]] wiring — recommended) or the delayed-message-exchange plugin.
- Branch-D delete-then-add remains the defense for *sequential* replay (crash → stale lease → RERUN takeover); the lease removes the *concurrent* case.
