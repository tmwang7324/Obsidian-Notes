---
project: Google Interview Prep
difficulty: Medium
leetcode: 787
solved:
solve_time:
---

# (C) Cheapest Flights Within K Stops — LC 787

## My approach
_TODO_

### Naive Dijkstra's With Stops Consideration
I at first used a **single-dimension** `city_cost` array to keep track of the least cost to each city from `src.`

To account for the condition that *there must be at most k stops in a path,* I would simply terminate path traces that resulted in `stops == k`

However, I realized then that this would set false-postitive minimum costs to specific cities. 
Imagine that I can only take at most 1 stop to reach *city A* from *city B.* A direct path to *city C* costs $600 (`City B -> 600 -> City C -> City A`). However, another path's price to *city C* (`city B -> 200 -> city D -> 300 -> city C -> city A`) is $500. Tracing through the latter path would force `dist[C]` to be $500, which cannot be possible with the `k` condition.

### Naive Dijkstra's with Two Dimensional dist 
## Solution
```python

```

## Complexity

## Master-check
Shortest path with an **edge-count constraint** → Bellman-Ford limited to `k+1` rounds. Each round = one more allowed flight. Copy the distance array each round so you don't chain edges from the same round (which would use more edges than allowed).
