---
type: next-step
project: Doculyze
status: done
effort: S
aliases: [Doculyze Backend Language for AI Layer]
tags: [next-step, doculyze]
updated: 2026-06-16
---

# (C) Doculyze Backend Language for AI Layer

**Next step.** Picking ChromaDB forces the open call left in [[(C) Technology Architecture|Technology Architecture]]: **Option A — stay all-Node** (chromadb JS + LangChain JS from the existing Express backend, no new service) vs **Option B — a small Python/FastAPI AI service** (smoother RAG, but a second process to wire/run). Recommendation is **Option A** for the MVP (one running process, fastest path to the frozen flow); revisit Python only if JS RAG ergonomics block Tier 2 — a Week-2+ problem. Confirm explicitly.

- **Effort:** S — a decision to confirm, not build.
- **Surfaced by:** [[2026-06-15|2026-06-15 progress]] · [[(C) Data Layer|Data Layer]]

**Resolved 2026-06-20 → Option B (Python).** AI/document layer (LangChain + RAG) will be a Python/FastAPI service alongside Express. See [[(C) AI Layer Backend Language (DECISION)|the decision]]; ADR to be authored by `synthesize`.
