---
project: Google Interview Prep
difficulty: Medium
leetcode: 417
solved: 2026-08-28
solve_time: 1hr+
---

# (C) Pacific Atlantic Water Flow — LC 417

## My approach
_TODO_

## Solution
```python

```

## Complexity

## Master-check
Reverse the flow: instead of flowing downhill from every cell (O((mn)²)), start at ocean borders and flow **uphill**. Multi-source DFS/BFS from Pacific edges → `pac` set, from Atlantic edges → `atl` set. Answer = `pac ∩ atl`.
