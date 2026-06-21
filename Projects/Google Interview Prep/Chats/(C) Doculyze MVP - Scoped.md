# (C) Doculyze MVP — Scoped

> Scoped-down successor to [[Doculyze MVP]]. Decisions made 2026-06-15 (fresh start, Profile dropped, barebones MVP, improved RAG kept but gated). This is the buildable spec; the original is the wishlist.

**Why this exists:** Doculyze is a **behavioral talking point**, not offer-critical engineering — the interviewer never reads the code; the entire ROI is telling the STAR story well (see [[(C) Google SWE Offer Roadmap]]). DSA is the offer-critical path. This spec is sized for **evenings in Weeks 1–3 only, DSA-first, hard pause in Weeks 4–5.** ~15–25 real hours total.

## **Decision** — scope is two tiers, hard-gated

### Tier 1 — Hard MVP (the frozen line; must run end-to-end)
This single flow *is* the MVP. Done = screen-recordable.
- **Auth:** Firebase, reuse the existing [[(C) Auth Architecture|Auth]] design. Sign in, nothing more.
- **Upload:** one document.
- **Naive RAG:** chunk → embed → store in vector DB → retrieve.
- **Cited answer:** LLM answers a question over that doc **with a citation**. ← the demo *and* the story.
- **UI:** one **Documents shell** — upload button + a plain, clickable list. That's it.
- **Baseline measurement:** record naive RAG accuracy on a small fixed question set. *This is the "before" half of the STAR story — skip it and the improved-RAG arc has nothing to prove.*

### Tier 2 — Improved RAG (KEPT — the behavioral gold, but GATED)
The STAR payoff: "measured naive RAG, found it weak, systematically improved retrieval accuracy."
- Hybrid search · vital metadata labeling (author/tags/category/source) · top-K re-ranking · HyDE — see [[Improving RAG accuracy 10 techniques that actually work]].
- **Ragas** for before/after eval.
- **Gate (all three required to start any Tier-2 work):**
  1. Tier 1 runs end-to-end and is recordable.
  2. DSA is on track for the current week (daily block hit first, every day).
  3. It's still Weeks 1–3 (never Weeks 4–5).
- **Add improvements one at a time, re-measuring with Ragas after each** — each measured delta is a story beat. Half-finished improvements with no numbers are worthless here.

## Cut order (when behind — and you will be at some point)
Cut from the bottom up, no deliberation:
1. HyDE → 2. re-ranking → 3. hybrid search → 4. metadata labeling → 5. (last resort) Tier 2 entirely, ship naive + baseline numbers and tell the *honest* smaller story.
**Tier 1 is never cut.** If Tier 1 itself is at risk, Doculyze is the thing that gives, not DSA.

## Parking lot — explicitly NOT now (post-interview, or never)
- ❌ Profile page, connected accounts (GitHub/LinkedIn/Facebook OAuth)
- ❌ Documents-page sort / type filter / search polish
- ❌ Model fine-tuning (LLMs & transformers)
- ❌ Microservices, RabbitMQ, Kubernetes, Jenkins/CI
- ❌ The polished two-page DocuThinker UI / perf overlay

## Cadence (from the roadmap)
- **Warm-up wknd:** this spec (done).
- **Week 1:** scaffold + Firebase auth + doc upload (Tier 1 plumbing).
- **Week 2:** Tier 1 RAG core (chunk/embed/store/retrieve/cited answer) + **baseline measurement**. Begin Tier 2 *only if the gate is open.*
- **Week 3:** finish the one clean demo path; layer Tier 2 improvements with Ragas re-measurement, gate permitting.
- **Weeks 4–5:** 🛑 HARD PAUSE — DP boss fight owns every hour, including the extra ones.
- **Week 6:** record ~2-min demo; rewrite the "most difficult project" STAR story around the naive→improved RAG arc.

## The trap (root `CLAUDE.md`)
Building Doculyze will always *feel* more productive than failing a DP problem. That feeling is the danger, not a signal. When in doubt, the hour goes to DP.
