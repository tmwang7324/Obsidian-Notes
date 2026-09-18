---
type: next-step
project: Google Interview Prep
status: open
goal: "[[(C) Google SWE Offer Roadmap]]"
effort: L
aliases: [Graphs - Modified Dijkstra Swim in Rising Water]
tags: [next-step, google-prep]
updated: 2026-09-14
---

# (C) Graphs - Modified Dijkstra Swim in Rising Water

**Next step.** Solve [[(C) Swim in Rising Water|Swim in Rising Water]] (LC 778). This is a Hard that combines two ideas: **binary search on the answer** (what's the minimum time `t` such that a path exists?) + **BFS/DFS feasibility check**, or alternatively **modified Dijkstra** where the "distance" to a cell is the max elevation along the path (min-heap on max elevation seen so far). The Dijkstra approach mirrors Network Delay Time but swaps sum-of-weights for max-of-weights — a small twist that tests whether you understand Dijkstra's invariant or just memorized the template.

- **Advances:** [[(C) Google SWE Offer Roadmap|Google SWE Offer Roadmap]]
- **Effort:** L — Hard problem, two viable approaches to understand, builds on Dijkstra's.
- **Prereqs:** Dijkstra's ([[(C) Network Delay Time|Network Delay Time]]), binary search, grid BFS.

When done, flip `status: done` and note the resolving progress entry.
