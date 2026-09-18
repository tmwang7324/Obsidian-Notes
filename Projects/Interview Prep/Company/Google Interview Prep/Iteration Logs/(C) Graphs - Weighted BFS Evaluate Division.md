---
type: next-step
project: Google Interview Prep
status: open
goal: "[[(C) Google SWE Offer Roadmap]]"
effort: M
aliases: [Graphs - Weighted BFS Evaluate Division]
tags: [next-step, google-prep]
updated: 2026-09-14
---

# (C) Graphs - Weighted BFS Evaluate Division

**Next step.** Solve [[(C) Evaluate Division|Evaluate Division]] (LC 399). The core insight: division is transitive multiplication along a **weighted directed graph**. Build the graph from the equations, then BFS/DFS from dividend to divisor multiplying edge weights. This stretches graph modeling — the hard part isn't traversal, it's recognizing that the input encodes a graph at all.

- **Advances:** [[(C) Google SWE Offer Roadmap|Google SWE Offer Roadmap]]
- **Effort:** M — new pattern (weighted graph construction from implicit relationships).
- **Prereqs:** BFS/DFS foundations, adjacency-list construction.

When done, flip `status: done` and note the resolving progress entry.
