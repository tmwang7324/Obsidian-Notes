---
title: "Pull-based ingest tracer (broker + sandboxed worker)"
github: https://github.com/tmwang7324/DocuLyze/issues/4
issue: 4
type: ticket
status: open
labels: [ready-for-agent]
parent: "[[0001-SPEC-data-architecture]]"
blocked_by: ["[[0002-mint-first-lifecycle]]"]
project: Doculyze
---

# 04 — Pull-based ingest tracer (broker + sandboxed worker)

**Parent:** [[0001-SPEC-data-architecture]]

**What to build:** After a successful upload, the document starts processing automatically with no user action. Finalize enqueues a tiny replayable envelope `{ uid, docId }` — never bytes — onto the broker (abstract async hand-off; RabbitMQ remains cut by name). A sandboxed, internal-only Python worker (container 1) consumes the envelope, pulls the object from Storage using the one canonical path formula (its 4th caller), runs a magic-number precheck in front of the parser, then parses. Bad or mismatched bytes → `failed`; a good file reaches `processing` with parsed text held for the next stage. The worker trusts `uid` by provenance — only the Next.js layer can enqueue.

Status transitions covered: `uploaded → processing`, `processing → failed` (precheck/parse). `processing → ready` arrives with ticket 05.

**Blocked by:** 02 — Mint-first lifecycle reversal (enqueue point and status lifecycle).

**Status:** ready-for-agent

- [ ] Successful finalize enqueues `{ uid, docId }`; nothing else ever transits the broker.
- [ ] Worker pulls the object itself from Storage at the canonical path — bytes never pass through the Next.js layer or the broker.
- [ ] Magic-number precheck rejects extension/content mismatches before the parser runs; status → `failed` (flag-only, object retained).
- [ ] Parser runs sandboxed; a parse failure → `failed` without taking the worker down.
- [ ] Worker is unreachable from the public internet; the only trigger is a broker envelope.
- [ ] Replaying the same envelope is safe (no duplicate side effects, no status regression).
- [ ] Tests at the worker job-entry seam: staged object + envelope in → observed status transitions and parse outcome, for good, mismatched, and corrupt files.
