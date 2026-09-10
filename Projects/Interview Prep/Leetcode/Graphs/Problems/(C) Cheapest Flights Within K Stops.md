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

## Solution
```python

```

## Complexity

## Master-check
Shortest path with an **edge-count constraint** → Bellman-Ford limited to `k+1` rounds. Each round = one more allowed flight. Copy the distance array each round so you don't chain edges from the same round (which would use more edges than allowed).
