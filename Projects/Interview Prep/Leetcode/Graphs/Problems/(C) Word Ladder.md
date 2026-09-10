---
project: Google Interview Prep
difficulty: Hard
leetcode: 127
solved: 2026-08-26
solve_time: 1hr+
---

# (C) Word Ladder — LC 127

## My approach

#### (Naive #1) Build a Differ-by-1-Character Adjacency Graph
The first approach I took to building this adjacency graph was to compare all word pairs and check character differences. This took $O(N^2 * L)$ time complexity, driving the efficiency of my algorithm down.

#### (Naive) DFS with DP
I briefly thought of this approach while trying to think of the naive solution. **BFS** is known for being the optimal algorithm for determining the shortest path, so I believed the naive solution to use **DFS,** which presented the problem of certain paths being re-traveled. This allowed dynamic programming to reduce the time complexity drastically 


#### BFS with Token Mapping

## Solution
```python

```

## Complexity

## Master-check
Shortest path in an unweighted implicit graph → **BFS**. The efficiency insight: find neighbors via **wildcard patterns** (`"hot"` → `"*ot"`, `"h*t"`, `"ho*"`) mapped to word lists, not by comparing every pair. Return the node count (sequence length), not edge count (transformations).
