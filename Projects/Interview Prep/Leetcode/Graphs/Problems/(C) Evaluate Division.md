---
project: Google Interview Prep
difficulty: Medium
leetcode: 399
solved: 2026-09-18
solve_time: 45 m
runtime_beats: 100%
memory_beats: 12.97%
---

# (C) Evaluate Division — LC 399

## My approach
### Naive
Iterate through `queries.` Whenever `queries[i]` does not have two of the same value, or appear in `equations,` scan `equations` for the numerator. Then, solve for denominator of the found pair in `equations`


## Solution
```python

```

## Complexity

## Master-check
Division is transitive multiplication along a **weighted directed graph**. `a/b = v` creates edges `a→b` (weight `v`) and `b→a` (weight `1/v`). Evaluating a query = BFS/DFS from dividend to divisor, multiplying edge weights along the path.
