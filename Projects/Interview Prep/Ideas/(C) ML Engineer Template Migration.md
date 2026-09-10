---
type: idea
project: Interview Prep
aliases: ["ML Engineer Template Migration"]
tags: [interview-prep, cover-letter, machine-learning]
updated: 2026-08-02
sources: 1
---

# (C) ML Engineer Template Migration

Plan for deriving a **Machine Learning Engineer** cover-letter template from the existing [[AI Engineer]] template. Slots into the [[Rotating Cover Letters]] strategy as a new entry in the rotation.

## Diagnosis

The AI Engineer template is an **applied-LLM / infra** pitch, not a modeling pitch. What each paragraph actually proves:

| Paragraph         | Demonstrates                                                      | MLE-relevant?                                                    |
| ----------------- | ----------------------------------------------------------------- | ---------------------------------------------------------------- |
| Barclays          | Model *integration* — Whisper, Qdrant, Llama wired together       | Weakly — models consumed, not built                              |
| Doculyze          | Retrieval tuning + heavy DevOps (Docker/K8s/EKS/RabbitMQ)         | Half — the 50% accuracy lift is real eval work; rest is platform |
| NYC Neighborhoods | Regression, feature engineering across 72 features, scoring model | **Yes** — and it's the weakest-written paragraph                 |

The strongest MLE evidence is buried last and described in one rushed sentence ("Only deployed using Vercel and Railway" reads as an apology). Kubernetes gets more space than the regression. Correct ordering for AI Engineer, backwards for MLE.

**The migration is a re-ranking of evidence, not a rewrite.** Same three projects, inverted priority.

## Plan

1. **Flip the narrative arc.** Current: *"I integrate models into production systems."* MLE: *"I take messy real-world data, build models that produce a number someone can act on, and I can prove the number got better."* That thesis is already written — it's the last line of the NYC paragraph. Promote it to the opening.

2. **Reorder to NYC → Doculyze → Barclays.** NYC leads (only feature engineering + regression work). Doculyze becomes the *evaluation-rigor* story — lead with the 50% accuracy increase and how it was measured, compress HyDE/rerankers/chunking into "systematic ablation of retrieval components," cut K8s/EKS/RabbitMQ to one trailing clause. Barclays shrinks to ~2 sentences: scrappiness-and-ambiguity story, not a modeling story.

3. **Expand NYC where it's thin.** An MLE reader needs: what target the regression predicts and on what data; validation approach (train/test split, CV, error metric); how the 72 features were selected/engineered; how the three signals combine into one score. None of this is currently on the page. Most of the writing effort goes here.

4. **Swap the opening expertise triple.** "RAG pipelines, ML analysis, and DevOps" → something like *feature engineering, model evaluation, and production deployment* — claiming only what the letter then proves.

5. **Fix template mechanics** (bugs, not style — these affect the AI Engineer template too):
   - `[[Insert Company Name]]` — wikilink placeholders spawn junk pages in the graph. Use plain `**Insert Company Name**`.
   - The closing paragraph starts mid-sentence ("the scale of impact...") — Google-specific text got pasted *under* the "Why the Company is Special" scratchpad, so it no longer connects to the `[[Insert Company Name]]` line. Separate the reusable checklist from the Google example.
   - `[Next.js](http://next.js)` is a mangled autolink.
   - Two competing hooks in the opening ("I knew I wasn't signing up to X" / "something I will not miss on") — keep one.

## The open gap

For a true MLE role there's a hole no amount of rewriting closes: **no training, no architecture design, no research reproduction.** Every model in the letter is pretrained and consumed via API. Fundamentals of ML + PyTorch is a course line, not a project.

If the target is real MLE reqs rather than "MLE"-titled jobs that are actually AI-engineer roles, the honest move is one project that trains and evaluates something end-to-end. The NYC regression is the seed — deepening it beats starting over.

Also worth cutting: the "projected to save 200-300 hours per week" Barclays framing. Projected savings that were never measured is the softest claim in the letter, and an MLE interviewer will ask it to be defended.

## Separate flag

The AI Engineer template names Barclays' internal model access and internal tooling. This vault is a git repo under a strict no-Barclays-internals rule — worth reviewing independent of this migration.

## Next step

Draft `Resources/(C) Machine Learning Engineer.md` as a sibling template: reordered, mechanics fixed, NYC paragraph expanded into a fill-in structure that prompts for the metrics above (not invented).

## Sources
- [[AI Engineer]] — the template being migrated
