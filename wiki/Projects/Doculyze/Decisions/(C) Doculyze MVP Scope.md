---
type: decision
project: Doculyze
date: 2026-06-15
status: accepted
aliases: ["Doculyze MVP Scope"]
tags: [decision, doculyze, mvp, rag, scope]
sources: 2
supersedes:
superseded-by:
---

# (C) Doculyze MVP Scope

**Status:** accepted · **Date:** 2026-06-15

## Context

Doculyze is a **behavioral talking point**, not offer-critical engineering — the Google interviewer never reads the code; the entire ROI is telling the STAR story well (see [[(C) Google SWE Offer Roadmap|Google SWE Offer Roadmap]]). DSA is the offer-critical path. The original [[Doculyze MVP|Doculyze MVP wishlist]] was ambitious (profile pages, OAuth, microservices, RabbitMQ, fine-tuning). This decision scopes it down to what is buildable in **evenings during Weeks 1–3 only, DSA-first, hard pause in Weeks 4–5** (~15–25 real hours).

## Decision

Scope is **two tiers, hard-gated:**

**Tier 1 — Hard MVP (the frozen line; must run end-to-end).** One flow *is* the MVP, and "done" = screen-recordable: Firebase sign-in → upload one document → naive RAG (chunk → embed → store → retrieve) → **cited answer** over that doc → a single Documents shell (upload button + plain clickable list). Plus a **baseline accuracy measurement** on a small fixed question set — the "before" half of the STAR arc.

**Tier 2 — Improved RAG (KEPT, but GATED).** Hybrid search, metadata labeling, top-K re-ranking, HyDE, measured with **Ragas**. Start Tier-2 work **only if all three gates are open**: (1) Tier 1 runs end-to-end and is recordable, (2) DSA is on track for the current week, (3) it's still Weeks 1–3. Add improvements **one at a time, re-measuring after each** — each measured delta is a story beat.

## Rationale

- **The story, not the code, is the deliverable.** A working naive→improved RAG arc with *numbers* is worth more than a feature-rich app the interviewer never sees. Baseline measurement is non-negotiable because the improved-RAG arc has nothing to prove without a "before."
- **Time must be protected for DP/graphs.** Building Doculyze always *feels* more productive than failing a DP problem — that feeling is the danger, not a signal. Hard tiering + gating keeps the side project from eating the offer-critical path.
- **Improvements are only valuable when measured.** Half-finished improvements with no Ragas numbers are worthless for the story, hence the one-at-a-time-with-re-measurement rule.

## Alternatives rejected

- **The full original wishlist** — profile page, connected accounts (GitHub/LinkedIn/Facebook OAuth), Documents sort/filter/search polish, model fine-tuning, microservices/RabbitMQ/Kubernetes/Jenkins, the polished DocuThinker two-page UI. All parked as post-interview or never.
- **Skipping Tier 2 entirely** — rejected as the default; it's the behavioral gold. But it's the **cut order** when behind: HyDE → re-ranking → hybrid search → metadata labeling → (last resort) Tier 2 entirely, shipping naive + baseline numbers with the honest smaller story. **Tier 1 is never cut**; if Tier 1 is at risk, Doculyze gives, not DSA.

## Consequences

- Cadence: Week 1 scaffold + auth + upload; Week 2 RAG core + baseline; Week 3 finish the clean demo path + layer Tier-2 with Ragas; **Weeks 4–5 hard pause** (DP boss fight); Week 6 record the ~2-min demo and rewrite the "most difficult project" STAR story.
- Drives the [[(C) Two-Store Data Layer|two-store data layer]] sizing (Firestore + local ChromaDB, no hosted infra).
- Reuses the existing [[(C) Auth Architecture|Auth]] design unchanged (sign in, nothing more).

## Related

- [[(C) Two-Store Data Layer|Two-Store Data Layer]] · [[(C) Architecture|Doculyze Architecture]] · [[(C) Google SWE Offer Roadmap|Google SWE Offer Roadmap]] · [[(C) Auth Architecture|Auth Architecture]]

## Sources

- [[(C) Doculyze MVP - Scoped|Doculyze MVP — Scoped]] — the two-tier hard-gated scope, cut order, and parking lot.
- [[Doculyze MVP]] — the original ambitious wishlist this scopes down.
