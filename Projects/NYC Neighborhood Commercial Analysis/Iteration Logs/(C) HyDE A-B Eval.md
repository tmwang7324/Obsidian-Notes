---
type: next-step
project: NYC Neighborhood Commercial Analysis
status: open
effort: M
aliases: [HyDE A/B Eval]
tags: [next-step, nyc-neighborhood]
updated: 2026-07-08
---

# (C) HyDE A-B Eval

**Next step.** Implement HyDE (Claude generates a hypothetical ideal neighborhood profile, embed that instead of the raw business query) **behind a flag**, then run a manual 10-query with/without A/B — human-rate which top-5 list is more sensible — before committing. It only touches the semantic-relevance half of the score, so keep the claim to relevance quality, not retrieval scale.

- **Effort:** M — one flagged code path plus a small manual relevance-judgment set.
- **Surfaced by:** [[2026-07-03|2026-07-03 progress]] · [[(C) Interview Scoping & HyDE]]

When done, flip `status: done` and note the resolving progress entry.
