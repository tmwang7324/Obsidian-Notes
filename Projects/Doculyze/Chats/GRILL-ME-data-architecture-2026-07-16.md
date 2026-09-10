---
title: Final Data Architecture — Scope Confrontation and the Ingest Byte Path
date: 2026-07-16
type: grill-me
status: complete
project: Doculyze
tags: [doculyze, architecture, rabbitmq, langchain, chroma, ingest, scope, grill-me]
related:
  - "[[(C) Architecture]]"
  - "[[(C) Two-Store Data Layer]]"
  - "[[(C) Doculyze MVP Scope]]"
  - "[[(C) Google SWE Offer Roadmap]]"
  - "[[GRILL-ME-document-storage-2026-06-24]]"
  - "[[GRILL-ME-storage-upload-auth-2026-07-11]]"
---

# Final Data Architecture — Grill-Me Session

> [!abstract] Starting question
> **"Reason through my final Doculyze data architecture"** — a proposed dataflow with
> RabbitMQ jobs on three paths (ingest, RAG query, NLP), bytes sent to a LangChain
> backend, Chroma batch upload, HyDE + Voyage reranking, and on-demand sentiment/NER.
>
> **Outcome:** the design is **design-only** — a post-Barclays exercise, possible
> Fable-coded prototype **after 2026-07-27**. Not a build plan. Full tree Q1–Q9 resolved.

> [!success] Session complete
> Every branch resolved (Q1–Q9 + the cleanup-invariant sub-tree). This session
> **reversed two decisions** from [[GRILL-ME-storage-upload-auth-2026-07-11]] — see
> "Cross-grill reversal" below.

---

## Ground truth found (2026-07-16)

Three drifts between what the docs claim and what the code does. All verified.

| Source | Claims | Reality |
|---|---|---|
| `[[(C) Architecture]]` (updated 06-16) | Express + Firebase Admin backend | Code migrated to **Next.js server actions + DAL** (`app/actions/`, `_lib/data.tsx`). Wiki is ~1 month stale. |
| Auto-memory `upload-auth-grill-open` | record-**after** + "no pending phantom" | `database.tsx:72` matches the memory — but **this session reverts it** back to mint-first (see Cross-grill reversal). |
| Proposed dataflow | "send bytes to LangChain backend" | `getPresignedUrl` → browser **PUTs direct to Storage**. Bytes never transit a server, deliberately (`upload_document.tsx:98`). |

**What exists in code:** auth (session cookie → DAL → `requireUid`), presigned upload + `finalizeUpload` metadata cross-check, Firestore doc records, dashboard list.

**What does not exist — zero lines:** `chroma`, `langchain`, `embedding`, `rabbit`, `voyage` appear in markdown only. `agents/` is empty. No chat route, no ask route, no chunker, no retriever. **The entire retrieval half of the app is unwritten.**

---

## Decision Log (complete)

| #                 | Question                                                                          | Decision                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| ----------------- | --------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Q1**            | Is this design work or avoidance? (asked on last day of the DP hard-pause block)  | **Design-only.** Prototype possibly built with Fable after Jul 27. No build clock. Roadmap cuts RabbitMQ by name; bleeding into the DP block → *cut, not extended*.                                                                                                                                                                                                                                                                                                                                 |
| **Q2**            | Does the ingest job **receive** bytes or **pull** them?                           | **Pulls.** Job = `{ uid, docId }` envelope, not a file. Worker fetches the object itself via GCS at `documentStoragePath(uid, docId)` — the 4th caller of the one path formula. Tiny replayable jobs; preserves the presigned trust boundary; `finalizeUpload` is the enqueue point.                                                                                                                                                                                                                |
| **Q2a**           | Parse-before-persist → doesn't that force byte transfer?                          | **No.** "Before persist" and "bytes transit a server" are independent axes. Worker *pulls* from Storage, parses, then writes the record — parse still precedes the record. Only "keep bytes out of Storage entirely" forces push, and that tears out the presigned boundary for near-zero gain (GCS is inert, tenant-isolated).                                                                                                                                                                     |
| **Q2b**           | Malware: scan before Storage?                                                     | **No.** Scanning *is* opening the bytes → the scanner is the thing at risk, and its exposure is **identical** whether Storage was written first or not. Real controls: **sandbox the worker** + never serve raw bytes. Moving the Storage write earlier protects nothing.                                                                                                                                                                                                                           |
| **Invariant**     | On failure: flag-only or flag-and-delete? Then: is the invariant even achievable? | **Mint-first + "no object without a record."** `getPresignedUrl` writes a `"pending"` record *before* signing; `finalizeUpload` flips `pending → uploaded`, and on size-mismatch writes `failed` (not throw-into-void). Every live object has a breadcrumb → cleanup is a **stale-`pending` reap** (Firestore query), never a full-bucket walk. Cost = **one extra Firestore write per upload**, worth it iff cleanup ever happens (it does).                                                       |
| **Q3**            | Ordering bug — chunks keyed `${docId}:${chunkIndex}` before the record exists?    | **Dissolved by mint-first.** The docId + record exist from step one (before the PUT). Ingest fires from `finalizeUpload` (needs the `uploaded` record); embedding is strictly later. A chunk can never precede its record.                                                                                                                                                                                                                                                                          |
| **Q4**            | Does the queue earn its place?                                                    | **Ingest only. Job count = 1.** Ingest is the sole genuinely-async, slow, retryable, idempotent-on-replay flow. "Queue" is the abstract async hand-off role, not a commitment to RabbitMQ (still cut by name).                                                                                                                                                                                                                                                                                      |
| **Q5**            | Sync RAG query behind a queue?                                                    | **No — synchronous direct call.** User waits on a spinner; a broker there needs RPC reply-queues/polling = latency + complexity for zero throughput gain.                                                                                                                                                                                                                                                                                                                                           |
| **Q6**            | NER / sentiment / summary: on-demand vs at ingest?                                | **Precompute-at-ingest.** Worker already holds parsed text → embed + NER + summarize in one pass, store in Firestore keyed by docId. Translation **cut from scope** (would've been the only 2nd async job). Interactive/selection NLP runs synchronously + cache.                                                                                                                                                                                                                                   |
| **Q6a**           | Partial failure in the folded job — what is `ready`?                              | **`ready` = chunks in Chroma (RAG works), nothing more.** Embed-fail → `failed` (no product). Enrichment-fail → **still `ready`**, field `null`. Null reads use **cache-with-fallback**: compute-on-demand, backfill **Firestore** (durable — enrichment of an immutable doc is compute-once-forever).                                                                                                                                                                                              |
| **Cache**         | Redis for enrichments?                                                            | **No** (sole store → recompute on eviction defeats precompute). Durable home = **Firestore**. Read accelerator **deferred behind a `getEnrichment(docId)` seam** (doc-open is a cold read; durable storage already ate the LLM cost). Redis's real first home = **chat context**.                                                                                                                                                                                                                   |
| **Q8 (trust)**    | How does `uid` cross into Python?                                                 | **Option 2.** Next server actions = **sole auth boundary**; Python is **internal-only**, trusts `uid` by provenance (client can't address it; only Next enqueues). Mirrors the upload boundary. **Express is retired.**                                                                                                                                                                                                                                                                             |
| **Q8 (topology)** | Deployment shape?                                                                 | **Two containers** — async ingest worker (scales on queue depth) + sync query service (scales on concurrency) — so the heavy bursty embed path can't starve the latency-sensitive query path. **Hosted embeddings (Voyage) at MVP** → split is free, no local model to double-load.                                                                                                                                                                                                                 |
| **Q9**            | Chroma hosting + tenancy?                                                         | **Standalone shared service** (forced by the split — both containers need it). **Single collection + enforced-gateway tenant filter**: all access via `writeUserChunks/queryUserChunks(uid, …)` that *always* injects `where: { userId }` — the `documentStoragePath` "one place, can't drift" pattern. Chunk metadata `{ userId, docId }` (delete-by-doc + idempotent re-embed). **Pin embedding model + version**, store it; change = full re-embed migration (dimension drift = silent garbage). |
| **Q7**            | Content-type verification placement?                                              | **Magic-number precheck in front of the parser** (cheap format gate, tiny attack surface, keeps mismatched/hostile bytes off the exploitable parser) + **parser-as-sniff** behind it. Failure → `failed` (flag-only; no ordering collision — record already exists). Three upstream claim-checks stay as pre-filters. Precheck complements the sandboxed parser, doesn't replace it.                                                                                                                |

---

## Final architecture

```
browser
  → Next.js server actions  ── SOLE auth boundary (requireUid from session cookie)
        │
        ├─ getPresignedUrl → mint "pending" record + sign URL
        ├─ (browser PUTs bytes DIRECT to Storage)
        ├─ finalizeUpload → verify size → flip "uploaded" → ENQUEUE {uid, docId}
        │                                   (mismatch → "failed")
        │
        ├─ broker ──> ingest worker (container 1, async, scales on queue depth)
        │               pull object → magic-number precheck → parse (sandboxed)
        │               → embed (Voyage) → write Chroma (via gateway, {userId,docId})
        │               → NER + summary → Firestore
        │               status: processing → ready | failed
        │
        └─ query → query service (container 2, sync, scales on concurrency)
                     embed question (Voyage) → queryUserChunks(uid) [where: userId]
                     → retrieve → generate → answer
                     Redis: chat context

Shared internal services: Chroma (standalone) · Firestore · Voyage (hosted) · broker
Express: RETIRED.
```

### Status state machine

| From | Event | To |
|---|---|---|
| ∅ | `getPresignedUrl` mints + signs | `pending` |
| `pending` | `finalizeUpload` size OK | `uploaded` (→ enqueue) |
| `pending` | `finalizeUpload` size mismatch | `failed` |
| `pending` | client abandons | stays `pending` → reaped by age |
| `uploaded` | worker picks up | `processing` |
| `processing` | precheck+parse+embed OK | `ready` (enrichments best-effort) |
| `processing` | precheck/parse/malware/embed fail | `failed` |

`failed` terminal, object retained (flag-only). Invariant: **every live object has a record.**

---

## Cross-grill reversal

This session overturns two decisions from [[GRILL-ME-storage-upload-auth-2026-07-11]]:

1. **Record-after → mint-first.** The upload grill chose record-*after* ("no pending phantom", `database.tsx:73`). Once ingest exists, record-after **cannot hold** "no object without a record": the dominant orphan is client-abandonment (PUT succeeds, `finalizeUpload` never runs) — an event **no server code witnesses**. The only fix is a record that *predates* the object → mint-first. The `"pending"` row isn't a phantom; it's the breadcrumb that makes cleanup a Firestore reap instead of a bucket walk.
2. **Accept-leak + reconciliation-sweep → pending + stale-reap.** The upload grill's Q5 explicitly rejected "a resurrected `pending` record (undoes Q2)" and chose a full-bucket reconcile-later. This session reverses it: the pending-reap is strictly cheaper than reconciling record-less orphans, and one write/upload buys it.

**Net:** the shipped code (`database.tsx`, record-after) now diverges from the agreed design (mint-first). Deferred — design-only, no build clock.

---

## Doc / code debt surfaced

- **`finalizeUpload` size-mismatch path throws with no record written** → record-less orphan in Storage, no breadcrumb. The design fixes this (write `failed`); code unchanged (deferred).
- `[[(C) Architecture]]` — stale ~1 month; missing Firebase Storage; still lists Express (now retired in the design).
- Auto-memory `upload-auth-grill-open` — Q2/Q5 now superseded by this session's mint-first reversal.
- `(C) AI Layer Backend Language (DECISION)` — ADR still marked pending; resolved here: Python/FastAPI internal, **Express retired**, two containers.

---

## Related

- [[(C) Architecture]] · [[(C) Two-Store Data Layer]] · [[(C) Doculyze MVP Scope]] · [[(C) Google SWE Offer Roadmap]] · [[GRILL-ME-document-storage-2026-06-24]] · [[GRILL-ME-storage-upload-auth-2026-07-11]]
