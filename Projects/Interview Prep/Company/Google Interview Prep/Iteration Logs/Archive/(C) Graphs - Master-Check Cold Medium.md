---
type: next-step
project: Google Interview Prep
status: done
goal: "[[(C) Google SWE Offer Roadmap]]"
effort: S
aliases: [Graphs - Master-Check Cold Medium]
tags: [next-step, google-prep]
updated: 2026-07-12
---

# (C) Graphs - Master-Check Cold Medium

**Next step.** The gate that closes the graph block (~Jul 1): pick an *unseen* graph medium, set a 30-min timer, solve it out loud start to finish. Graphs don't get marked "done" on feel — feel is exactly what failed in the previous Google interview. Pass = recognize the graph framing, pick the right traversal, code it clean, hit the clock. Miss = the block extends, it does not close.

- **Advances:** [[(C) Google SWE Offer Roadmap|Google SWE Offer Roadmap]]
- **Effort:** S — one timed sitting, but it's the *blocking* checkpoint for moving to DP.
- **Surfaced by:** 2026-06-19 roadmap reorder — stricter master-check on the front-loaded weak spot.

When done, flip `status: done` and note the resolving progress entry.

---

**PASSED — graded cold 2026-07-12.** All 5 parts correct (BFS/DFS code, `visited` invariant, `O(V+E)`/`O(V)` complexity, Union-Find by rank + inverse-Ackermann, and the BFS/Union-Find/DFS judgement scenarios). Answers in [[Master-Check]]. The `visited`-on-enqueue timing that failed the previous real interview is now airtight. **Graphs certified.** Two open growth edges carried forward (not blocking): (1) cycle detection needs the undirected *parent-exclusion* vs. directed *recursion-stack* distinction; (2) rank is an upper bound on height (not exact) once path compression runs. Next block: **Dynamic Programming**.
