# NYC Neighborhood Recommendation Platform — Interview Scoping & HyDE

Study note capturing two decisions/insights for the resume project: (1) how to honestly scope the project to interviewers, and (2) whether Hypothetical Document Embeddings (HyDE) would help retrieval.

**What the app actually is:** ranks 71 NYC neighborhoods by how well-suited each is to a user's prospective business, over 72 features (demographics, business density, shooting incidents, transportation). Next.js frontend (Vercel) + FastAPI/Python backend (Railway). Two ranking signals: semantic relevance (embeddings) between a neighborhood profile and the user's business description, and a **competitive-saturation score** — a ratio of category storefronts to total business density. An Anthropic Claude agent generates natural-language rationale.

---

## 1. Scoping the project honestly to interviewers

The failure word is **"predict."** Saying the app "predicts business success" promises a trained predictive model. It isn't one — it's a **transparent heuristic ranking engine**. If I say "predict," a sharp interviewer asks *"predict against what ground truth? what's your accuracy?"* and I have no answer, because there's no labeled outcome data.

**Rule:** never say "predict." Say **rank / score / surface / recommend**.

**Decision:** Position the product as a decision-support **ranking** tool, not a predictive model — never describe it (resume, pitch, or UI) with the verb "predict."
**Why:** There is no labeled outcome data, so any "success predictor" claim would be fabricated accuracy and would collapse under an interviewer's "predict against what ground truth?" question. Ranking is honest and defensible.
**How to apply:** Use rank/score/surface/recommend everywhere. If asked to validate, state plainly it is decision-support checked by face validity, not an accuracy metric.

### 30-second honest pitch
> "It's a decision-support tool, not a predictive model. It ranks neighborhoods on two transparent signals: semantic relevance between a neighborhood's profile and the user's business description, computed with embeddings; and a competitive-saturation score — a ratio of category storefronts to overall business density. It surfaces promising neighborhoods and explains *why*; it doesn't claim to forecast revenue."

### The reframe that turns "primitive" into a strength
> "I deliberately used an interpretable heuristic instead of a supervised model because I had **no ground-truth outcome labels** — no dataset of businesses that succeeded or failed by neighborhood. Training a 'success predictor' without labels would have been fabricated accuracy. So I chose transparent, defensible signals a user can actually reason about."

Knowing when **not** to reach for ML is a senior instinct. This demonstrates more ML judgment than a black-box model would.

**Decision:** Rank with a transparent, interpretable heuristic — semantic relevance (embeddings) plus a competitive-saturation ratio — instead of a supervised ML model.
**Why:** No ground-truth outcome labels exist (no dataset of businesses that succeeded/failed by neighborhood), so a supervised "success predictor" would be untrainable and any reported accuracy fabricated. Interpretable signals are honest, debuggable, and user-explainable; a labeled supervised model is the documented future path once outcome data exists.
**How to apply:** Keep the two-signal heuristic as the baseline. If outcome data is later acquired, frame the ML version as supervised learning over these same signals as features, with the heuristic as the baseline to beat.

### Be ready for the two obvious follow-ups
- *"How did you validate it?"* → "Face validity and qualitative spot-checks, not an accuracy metric — I was upfront that there's no labeled test set."
- *"How would you make it a real predictive model?"* → "Acquire outcome data — business survival/revenue by location over time — then frame it as supervised learning with those signals as features. The current heuristic becomes my baseline."

---

## 2. Would HyDE (Hypothetical Document Embeddings) improve retrieval?

**Yes — good fit, but for *relevance quality*, not retrieval scale.**

### The problem HyDE solves: query–document asymmetry
Currently I embed a user's *business description* ("specialty coffee shop for young professionals") and match it against *neighborhood profiles* (demographics, density, transit...). Those are written in different "languages" — different vocabulary, length, style — so their embeddings sit in slightly different regions even when they're a great real-world match. Query→document cosine similarity is systematically noisier than document→document similarity. That asymmetry is exactly what HyDE fixes.

### How HyDE maps onto this pipeline
Instead of embedding the raw business query, ask an LLM (Claude is already wired in) to generate a **hypothetical ideal neighborhood profile** for that business — "the perfect neighborhood for this coffee shop would have high foot traffic, a young median age, moderate existing café density, strong transit..." Then embed *that* and retrieve the real neighborhoods closest to it. This transforms the query into document-space, so it becomes a document-to-document comparison. The "mock profile" **is** the hypothetical document in HyDE.

### Caveat for this scale — relevance boost, not a retrieval one
With **71 neighborhoods**, retrieval scale is a non-issue — brute-force cosine over all 71 is instant; there's no ANN index to improve. So don't pitch HyDE as "improving retrieval performance." Its value here is **better semantic matching quality** on the relevance half of the score. Frame it precisely or it's overclaiming again.

### Three real costs to weigh
- **Latency + cost:** one extra LLM call per query before embedding. On 71 docs the overhead may not be worth marginal ranking gains.
- **Hallucination risk:** the LLM can invent plausible-but-wrong "ideal" features and bias the match — the overclaiming trap in a new spot.
- **Only touches semantic relevance**, not the competitive-saturation ratio (that half is a real business-density computation HyDE can't help).

### How to know if it helped (ties to the no-labels honesty)
Build a tiny manual eval: pick ~10 business queries, generate top-5 neighborhoods *with* and *without* HyDE, human-rate which list is more sensible. That's a poor-man's relevance-judgment set, honest about there being no ground truth.

### Interview bonus
Being able to say *"I identified query–document asymmetry in my embedding retrieval and considered HyDE to bridge it, but at 71 documents the LLM-call overhead outweighed the marginal gain"* is a strong signal — knowing the technique **and** when not to use it.

**Next step:** implement HyDE behind a flag and run the 10-query with/without manual A/B before committing.

---

Related: [[Doculyze MVP]] also lists Hypothetical Document Embeddings as a RAG improvement to explore.
