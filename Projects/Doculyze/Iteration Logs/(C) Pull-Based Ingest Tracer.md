---
type: next-step
project: Doculyze
status: open
effort: L
aliases:
  - Pull-Based Ingest Tracer
tags:
  - next-step
  - doculyze
github: https://github.com/tmwang7324/DocuLyze/issues/4
issue: 4
parent: "[[(C) RAG Ingest and Query Data Architecture]]"
blocked_by: ["[[(C) Mint-First Lifecycle Reversal]]"]
updated: 2026-07-20
---

# (C) Pull-Based Ingest Tracer

**Next step.** After a successful upload, the document starts processing automatically with no user action. Finalize enqueues a tiny replayable envelope `{ uid, docId }` — never bytes — onto the broker (abstract async hand-off; RabbitMQ remains cut by name). A sandboxed, internal-only Python worker (container 1) consumes the envelope, pulls the object from Storage using the one canonical path formula (its 4th caller), runs a magic-number precheck in front of the parser, then parses. Bad or mismatched bytes → `failed`; a good file reaches `processing` with parsed text held for the next stage. The worker trusts `uid` by provenance — only the Next.js layer can enqueue.

Status transitions covered: `uploaded → processing`, `processing → failed` (precheck/parse). `processing → ready` arrives with ticket 05.

## Acceptance criteria
- [ ] Successful finalize enqueues `{ uid, docId }`; nothing else ever transits the broker.
- [ ] Worker pulls the object itself from Storage at the canonical path — bytes never pass through the Next.js layer or the broker.
- [ ] Magic-number precheck rejects extension/content mismatches before the parser runs; status → `failed` (flag-only, object retained).
- [ ] Parser runs sandboxed; a parse failure → `failed` without taking the worker down.
- [ ] Worker is unreachable from the public internet; the only trigger is a broker envelope.
- [ ] Replaying the same envelope is safe (no duplicate side effects, no status regression).
- [ ] Tests at the worker job-entry seam: staged object + envelope in → observed status transitions and parse outcome, for good, mismatched, and corrupt files.

- **Effort:** L — stands up a new sandboxed worker container plus broker envelope plumbing; new service/infrastructure, not a contained code change.
- **Blocked by:** [[(C) Mint-First Lifecycle Reversal]] — Mint-first lifecycle reversal (enqueue point and status lifecycle).
- **Surfaced by:** [[(C) RAG Ingest and Query Data Architecture|the data-architecture SPEC]] · GitHub issue #4
