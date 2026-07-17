---
title: Final Data Architecture — Scope Confrontation and the Ingest Byte Path
date: 2026-07-16
type: grill-me
status: in-progress
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
> **Session outcome so far:** the design is now explicitly **design-only** — a
> post-Barclays exercise, with a possible Fable-coded prototype **after 2026-07-27**.
> Not a build plan. Grill stopped mid-tree at **Q2 (unanswered)**.

> [!warning] Session is unfinished
> Q1 resolved. **Q2 is on the table and unanswered.** Branches Q3–Q8 below are
> untouched. Resume at Q2.

---

## Ground truth found (2026-07-16)

Three drifts between what the docs claim and what the code does. All verified.

| Source | Claims | Reality |
|---|---|---|
| `[[(C) Architecture]]` (updated 06-16) | Express + Firebase Admin backend | Code migrated to **Next.js server actions + DAL** (`app/actions/`, `_lib/data.tsx`). Wiki is ~1 month stale. |
| Auto-memory `upload-auth-grill-open` | record-**first** + pending/confirm | `database.tsx:72` — record written **after** bytes confirmed; status born `"uploaded"`, *"no pending phantom"*. Memory is stale. |
| Proposed dataflow | "send bytes to LangChain backend" | `getPresignedUrl` → browser **PUTs direct to Storage**. Bytes never transit a server, deliberately (`upload_document.tsx:98`). |

**What exists in code:** auth (session cookie → DAL → `requireUid`), presigned upload + `finalizeUpload` metadata cross-check, Firestore doc records, dashboard list.

**What does not exist — zero lines:** `chroma`, `langchain`, `embedding`, `rabbit`, `openai`, `voyage` appear in **four markdown files only** (`CLAUDE.md`, `PLAN.md`, two grill notes). `agents/` is an empty dir. No chat route, no ask route, no chunker, no retriever. **The entire retrieval half of the app is unwritten.**

---

## Decision Log

| # | Question | Decision | Why |
|---|---|---|---|
| **Q1** | Is this design work or avoidance? Asked on the **last day of the DP hard-pause block** (Jul 2–16), with RabbitMQ + Voyage + HyDE proposed while the RAG core has no code. | **Design-only.** Prototype possibly built with Fable **after Jul 27**. No build clock. | `[[(C) Doculyze MVP Scope]]` and `[[(C) Google SWE Offer Roadmap]]` both cut RabbitMQ **by name**. Roadmap rule 3: bleeding into the DP block → *cut, not extended*. Roadmap names this trap in advance: *"building Doculyze will always feel more productive than failing a DP problem — that feeling is the danger, not a signal."* |
| **Q2** | Does the ingest job **receive** bytes or **pull** them? | ⏳ **OPEN** | See below. |

---

## Q2 — the open question (resume here)

**Recommendation given: it pulls. Bytes never touch app servers.**

Keep the presigned PUT as built. The ingest job takes a **`{ uid, docId }` envelope, not a file**, and fetches the object itself via the GCS client at `documentStoragePath(uid, docId)` — the single path formula at `database.tsx:58` whose whole purpose is that *"the signer, the metadata verify, and the Firestore record all call it, so they can't drift."* Ingest becomes the fourth caller.

Why this beats proxying bytes through Python:
- **Trigger becomes obvious** — `finalizeUpload` already runs exactly when bytes are confirmed. That's the enqueue point.
- **Jobs stay tiny and replayable** — a few-byte message retries and dead-letters cleanly; a 5 MB PDF in a message body does neither. Reprocessing pulls the same immutable object → idempotent.
- **Preserves the trust boundary** — Storage stays source of truth for size/contentType (`finalizeUpload` rejects on mismatch). Byte-proxying would force rebuilding that inside the Python service, or losing it.
- **Fixes the ordering bug for free** (→ Q3).

Cost: the Python process needs its own credentialed GCS access. Cheap — it needs Admin creds anyway to write status back to Firestore.

**Counter-question left hanging:** was there a reason to want bytes in-process — e.g. parse *before* anything is persisted?

---

## Untouched branches (the rest of the tree)

- **Q3 — Ordering bug.** Proposed flow embeds *before* Storage upload and *before* minting Firestore. But Chroma chunks are keyed `${docId}:${chunkIndex}` — so what `docId` do chunks carry if the record doesn't exist yet? Job failure ⇒ **orphan chunks with no Firestore record**. Shipped code is already the correct order (Storage → verify → record). Embed comes *after*.
- **Q4 — Does RabbitMQ earn its place at all?** Cut by name in two accepted docs. If kept for the design exercise: which flows genuinely need it?
- **Q5 — Sync RAG query behind a queue.** User waits for the answer; a request/response flow through a broker needs RPC reply-queues or polling. Is the queue buying anything here, or just latency + complexity? (Ingest is the only genuinely async flow.)
- **Q6 — NER/sentiment: on-demand vs at ingest.** On-demand re-fetches and re-parses the doc every call. At ingest the text is already parsed → store in Firestore, serve instantly. Why on-demand?
- **Q7 — Content-type verification placement.** Already validated 3× (client zod → server claim zod → Storage metadata cross-check). A check inside LangChain would be the real **byte sniff** that `fileupload_schema.ts` consciously skipped — arguably its correct home, since parsing opens the file anyway. But "if fail end job" implies it runs before persistence, which collides with Q3's ordering.
- **Q8 — Service topology.** Next server actions + Python/FastAPI + **Express?** `(C) AI Layer Backend Language` resolved to Python/FastAPI alongside Express — but the code has since migrated off Express to server actions. See the open `Retire or Revive the Legacy Express Backend` iteration log. Does Express survive at all?
- **Q9 — Chroma hosting + tenancy.** Where does it live relative to FastAPI? Embedding model pinned (dimension drift)? `where: { userId }` on *every* query — the isolation guarantee from `[[(C) Two-Store Data Layer]]`.

---

## Doc debt surfaced

- `[[(C) Architecture]]` — stale ~1 month; missing Firebase Storage entirely; still lists Express.
- Auto-memory `upload-auth-grill-open` — contradicts shipped code on record-first vs record-after.
- `(C) AI Layer Backend Language (DECISION)` — ADR still marked *pending `synthesize`*.
- `~/.claude/skills/obsidian-vault` — vault path was `/mnt/d/Obsidian Vault/AI Research/`; **fixed → `C:\Obsidian Vault\`**. Its conventions section still describes a flat vault with `*Index*` notes; actual vault is foldered (`wiki/`, `Projects/<name>/…`) with a `(C) ` prefix + typed frontmatter. Not yet rewritten.

---

## Related

- [[(C) Architecture]] · [[(C) Two-Store Data Layer]] · [[(C) Doculyze MVP Scope]] · [[(C) Google SWE Offer Roadmap]] · [[GRILL-ME-document-storage-2026-06-24]] · [[GRILL-ME-storage-upload-auth-2026-07-11]]
