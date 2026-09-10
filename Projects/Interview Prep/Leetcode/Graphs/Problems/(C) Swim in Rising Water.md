---
project: Google Interview Prep
difficulty: Hard
leetcode: 778
solved:
solve_time:
---

# (C) Swim in Rising Water — LC 778

## My approach
_TODO_

## Solution
```python

```

## Complexity

## Master-check
This is a **minimax path** problem — minimize the maximum elevation along the path. Modified Dijkstra where the heap key is `max(current_max, neighbor_elevation)` instead of a sum. When you pop the destination, that bottleneck is minimal across all paths.
