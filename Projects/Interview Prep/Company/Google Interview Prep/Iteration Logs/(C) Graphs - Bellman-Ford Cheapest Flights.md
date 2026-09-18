---
type: next-step
project: Google Interview Prep
status: open
goal: "[[(C) Google SWE Offer Roadmap]]"
effort: M
aliases: [Graphs - Bellman-Ford Cheapest Flights]
tags: [next-step, google-prep]
updated: 2026-09-14
---

# (C) Graphs - Bellman-Ford Cheapest Flights

**Next step.** Solve [[(C) Cheapest Flights Within K Stops|Cheapest Flights Within K Stops]] (LC 787). New pattern: **Bellman-Ford** limited to `k+1` relaxation rounds. Key gotcha — copy the distance array each round so you don't chain edges from the same iteration (which would exceed the stop limit). Compare with Dijkstra's from Network Delay Time: Dijkstra fails here because the edge-count constraint means the greedy shortest-first order can skip valid cheaper paths with more hops.

- **Advances:** [[(C) Google SWE Offer Roadmap|Google SWE Offer Roadmap]]
- **Effort:** M — new algorithm (Bellman-Ford), but the relaxation loop is straightforward once you see why Dijkstra doesn't work.
- **Prereqs:** Dijkstra's ([[(C) Network Delay Time|Network Delay Time]]), shortest-path intuition.

When done, flip `status: done` and note the resolving progress entry.
