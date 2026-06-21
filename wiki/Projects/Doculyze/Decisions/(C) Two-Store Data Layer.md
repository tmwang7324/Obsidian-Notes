---
type: decision
project: Doculyze
date: 2026-06-15
status: accepted
aliases: ["Two-Store Data Layer"]
tags: [decision, doculyze, firestore, chromadb, rag]
sources: 1
supersedes:
superseded-by:
---

# (C) Two-Store Data Layer

**Status:** accepted · **Date:** 2026-06-15

## Context

Doculyze's MVP (see [[(C) Doculyze MVP Scope|Doculyze MVP Scope]]) needs to store two different things: the **file records + ownership** that drive the Documents-list UI, and the **semantic index** (chunk vectors) that powers RAG retrieval. The deliverable is a ~2-minute **local** screen recording, not a publicly hosted app — so hosting cost and infra complexity should be near zero.

## Decision

Use **two stores, each doing the one thing it is good at:**

- **Firestore** holds ownership + the Documents-list UI — a `documents/{docId}: { userId, filename, type, uploadedAt, status }` collection. Already in the stack; its security rules give per-user isolation ("a user reads only their own documents") for free, and the session-cookie auth already supplies `userId`.
- **ChromaDB** holds the semantic index — **one collection, chunk-grained**, each entry `{ id: "${docId}:${chunkIndex}", embedding, document: <chunk text>, metadata: { docId, userId, chunkIndex, author, tags, category, source } }`. Cosine distance; pin the embedding model (e.g. OpenAI `text-embedding-3-small` = 1536 dims) so the dimension never shifts.

Chroma stores the chunk text + metadata itself, so there is **no separate Firestore `chunks` collection**. A **citation** is just a retrieved chunk's `docId` + `chunkIndex`, with the filename resolved from Firestore. Tenant isolation in Chroma is a **single collection + `userId` metadata filter**, not per-user collections.

## Rationale

- **ChromaDB fits the constraints exactly.** Free, open-source, local-first, zero account, dead-simple API. Its main downside — hosting a persistent server — never bites because the demo runs locally against a persistent path. Lowest-friction option for "barebones, evenings, don't eat DSA time."
- **Firestore was already chosen** for auth/ownership, and its security rules deliver row-level isolation without extra work — no reason to move file records elsewhere.
- **Separation of concerns:** Firestore = the *file record* (list UI + ownership); Chroma = the *index*. Neither duplicates the other.

## Alternatives rejected

- **A separate Firestore `chunks` collection** — rejected; Chroma already stores chunk text + metadata, so a parallel Firestore copy is redundant.
- **Per-user Chroma collections for isolation** — rejected for the MVP in favor of a single collection with a `userId` `where` filter (simpler to manage).
- **A hosted/managed vector DB (Pinecone, pgvector)** — unnecessary for a local demo; adds account + infra the scoped spec explicitly cut.

## Consequences

- **Chroma enforces no auth.** Tenant isolation is *only* whatever the backend does → **always inject `where: { userId }` on every Chroma query, and never let the client touch Chroma directly.** The backend-mediated design ([[(C) Express|Express]] + session cookie, see [[(C) Auth Architecture|Auth Architecture]]) already fits — just don't break it.
- **Hybrid (dense+sparse/BM25) search is Chroma's weak spot.** The other three Tier-2 "improved RAG" techniques — metadata filtering (native `where`), re-ranking (app-side), HyDE (query-side) — are fully doable. Lean the improved-RAG STAR story on those three; treat BM25 hybrid as optional/last in the cut order.
- **Forces the open backend-language question** (Node-only vs a Python/FastAPI AI service) — see *Open thread* in [[(C) Architecture|Doculyze Architecture]]. Recommendation is all-Node for the MVP, but the call is **left open for explicit confirmation**.

## Related

- [[(C) Doculyze MVP Scope|Doculyze MVP Scope]] · [[(C) Architecture|Doculyze Architecture]] · [[(C) Auth Architecture|Auth Architecture]] · [[(C) Technology Architecture|Technology Architecture]] · [[(C) Firebase|Firebase]]

## Sources

- [[(C) Data Layer|Doculyze Data Layer]] — the two-store split, Chroma constraints, and configuration steps.
