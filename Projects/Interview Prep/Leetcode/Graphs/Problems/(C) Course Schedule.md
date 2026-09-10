---
project: Google Interview Prep
difficulty: Medium
leetcode: 207
solved:
solve_time:
---

# (C) Course Schedule — LC 207

## My approach

#### Topological Sort with Map

## Solution
```python

```

## Complexity

## Master-check
"Can you finish all courses?" = "Is the prerequisite graph a DAG?" = "Does it contain a cycle?" DFS with 3 states (white/gray/black) — a cycle exists iff you hit a gray node (on the current recursion path). A single `visited` set conflates "on current path" with "fully resolved" and gives false positives on diamonds.
