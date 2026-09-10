---
project: Google Interview Prep
difficulty: Medium
leetcode: 743
solved: 2026-08-29
solve_time: 1hr+
---

# (C) Network Delay Time — LC 743

## My approach
_TODO_

#### (Naive) DFS

#### Lazy Dijkstra's

***KEY MODIFICATION:*** Instead of finding the shortest path to a particular node, return the **maximum** length of all paths.

## Solution
```python

```

## Complexity
**

## Master-check
Textbook **Dijkstra** — single-source shortest path on a weighted graph with non-negative edges. The answer is `max(shortest distance to every node)` because the last node reached is the bottleneck. If any node is unreachable, return `-1`.
