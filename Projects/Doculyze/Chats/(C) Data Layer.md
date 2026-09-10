---
type: synthesis
aliases: ["Data Layer"]
tags: [doculyze, architecture, firestore, chromadb, rag]
updated: 2026-06-15
sources: 2
---

# Data Layer

The storage design for [[CLAUDE|Doculyze]]'s document + retrieval layer. Companion to [[(C) Technology Architecture|Technology Architecture]] (frontend/backend shape) and [[(C) Auth Architecture|Auth Architecture]] (identity). Decided 2026-06-15; sized for the barebones MVP in [[(C) Doculyze MVP - Scoped|the scoped spec]].

## The two-store split

The data layer is **two stores, each doing the one thing it's good at**:

| Store | Holds | Why |
|---|---|---|
| **Firestore** | Ownership + the Documents-list UI | Already in the stack; security rules give per-user isolation for free |
| **ChromaDB** | The semantic index (chunk vectors) | Free, open-source, local-first — zero account, no infra to host for a local demo |

**Firestore — `documents` collection**

```
documents/{docId}: { userId, filename, type, uploadedAt, status }
```

The session-cookie auth (see [[(C) Auth Architecture|Auth Architecture]]) already supplies `userId`; Firestore security rules enforce *"a user reads only their own documents."*

**Chroma — one collection, chunk-grained**

```
chunk = {
  id,                       // `${docId}:${chunkIndex}`
  embedding,                // dense vector
  document: <chunk text>,   // the raw chunk, returned on retrieval
  metadata: { docId, userId, chunkIndex,
              author, tags, category, source }   // last four = Tier 2
}
```

**Consequence:** Chroma stores the chunk text + metadata itself, so there is **no separate Firestore `chunks` collection**. Firestore tracks the *file record* (for the list UI + ownership); Chroma is the *index*. A **citation** is just a retrieved chunk's `docId` + `chunkIndex`, with the filename resolved from Firestore.

## Why ChromaDB fits the constraints

The actual deliverable is a **~2-min local screen recording** ([[(C) Google SWE Offer Roadmap|roadmap]]), not a publicly hosted app. So Chroma's main downside — hosting a persistent server — never bites: it runs locally against a persistent path. Free, open-source, no account, dead-simple API → the lowest-friction option for "barebones, evenings, don't eat DSA time."

## Two caveats (both manageable)

1. **No built-in auth / row-level security.** Unlike Firestore rules, Chroma enforces nothing. Tenant isolation is *only* whatever the backend does → **always inject `where: { userId }` on every Chroma query, and never let the client touch Chroma directly.** The backend-mediated design (Express + session cookie) already fits; just don't break it.
2. **Hybrid search is Chroma's weak spot.** Native dense+sparse (BM25) hybrid is thinner than Pinecone/pgvector. The other three Tier-2 "improved RAG" techniques — **metadata filtering** (native `where`), **re-ranking** (app-side), **HyDE** (query-side) — are fully doable. So lean the improved-RAG STAR story on those three; treat BM25 hybrid as optional/last in the cut order.

## Open decision — backend language for the AI/document layer

This **resolves the open thread** in [[(C) Technology Architecture|Technology Architecture]] (*"ChromaDB↔FastAPI / LangChain↔Python"*). Picking Chroma forces the call:

- **Option A — stay all-Node.** Use the `chromadb` JS client + LangChain JS (`@langchain/community`) from the existing Express backend. **No new service** → honors the scoped spec's "no microservices" cut. RAG ergonomics are slightly rougher in JS.
- **Option B — a small Python/FastAPI AI service.** RAG/LangChain are smoothest in Python, and the original notes lean this way. But it's a second backend service — defensible (it's *one* service, not the K8s/RabbitMQ infra the spec cut), yet still more to wire and run.

**Recommendation: Option A for the MVP.** One running process, no cross-service plumbing, fastest path to the frozen flow. Revisit Python only if JS RAG ergonomics genuinely block Tier 2 — and that's a Week-2+ problem, not a today one. *(Decision left open here for explicit confirmation.)*

## "Configure the database" — concrete steps

1. Run Chroma locally with a persistent path: `pip install chromadb && chroma run --path ./chroma-data` (or the `chromadb/chroma` Docker image).
2. Add the client to the Express backend: `npm i chromadb` (or LangChain JS's Chroma vector store).
3. Create the collection with **cosine** distance and a dimension matching the embedding model (e.g. OpenAI `text-embedding-3-small` = 1536) — **pin the model now** so the dimension never shifts under you.
4. **Single collection + `userId` metadata filter** for tenant isolation (simpler than per-user collections for an MVP).
5. Define the Firestore `documents` collection + security rules.

## Related

- [[(C) Doculyze MVP - Scoped|Doculyze MVP — Scoped]] · [[(C) Technology Architecture|Technology Architecture]] · [[(C) Auth Architecture|Auth Architecture]] · [[(C) Firebase|Firebase]]
