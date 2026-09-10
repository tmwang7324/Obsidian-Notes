---
project: Google Interview Prep
difficulty: Medium
leetcode: 399
solved:
solve_time:
---

# (C) Evaluate Division — LC 399

## My approach
_TODO_

## Solution
```python

```

## Complexity

## Master-check
Division is transitive multiplication along a **weighted directed graph**. `a/b = v` creates edges `a→b` (weight `v`) and `b→a` (weight `1/v`). Evaluating a query = BFS/DFS from dividend to divisor, multiplying edge weights along the path.
