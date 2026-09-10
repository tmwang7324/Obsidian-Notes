---
project: Google Interview Prep
difficulty: Medium
leetcode: 133
solved: 2026-07-02
solve_time: 49m 33s
---

# (C) Clone Graph — LC 133

Got tripped up by a typo that cost ~10 minutes.

## My approach
_TODO: write up the DFS/BFS clone with a `{original: copy}` visited map to handle cycles._

## Solution
```python

```

## Complexity

## Master-check
A `{original: copy}` hashmap serves as both the visited set and the clone registry. When you encounter a node already in the map, return the existing copy — this handles cycles without infinite recursion.
