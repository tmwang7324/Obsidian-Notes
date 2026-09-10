---
type: idea
project: Doculyze
date: 2026-06-20
aliases: [AI Layer Backend Language Decision]
tags: [doculyze, decision, backend, langchain]
---

# (C) AI Layer Backend Language (DECISION)

**Decision.** The Doculyze **AI / document layer (LangChain + RAG) will be built in Python** — LangChain Python running in a **small FastAPI service** alongside the existing Express backend. This resolves the open backend-language fork (chose **Option B**, the Python/FastAPI service, over Option A all-Node).

**Rationale.**
- LangChain's **Python ecosystem is the mature one** for RAG (loaders, splitters, retrievers, Ragas eval) — JS lags.
- Python is the **ML/AI muscle the user is deliberately growing**; building the AI layer here compounds with that goal rather than fighting it.
- The user's earlier notes already leaned Python; this aligns the stack with intent.

**Accepted cost.** A **second process** to run, wire (Express ↔ FastAPI boundary), and deploy. Acceptable: the learning value outweighs the MVP-speed hit, and the boundary is a thin internal API.

**Shape this implies.**
- Express stays the auth/session + Firestore-ownership gateway.
- A FastAPI service owns chunk → embed → store (ChromaDB) → retrieve → cited answer.
- Express calls FastAPI for the AI/document operations.

**Supersedes** the MVP recommendation in [[(C) Doculyze MVP Scope|Doculyze MVP Scope]] / [[(C) Architecture|Architecture]] that favored all-Node for the first ship.
