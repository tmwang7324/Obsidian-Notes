---
project: Google Interview Prep
difficulty: Medium
leetcode: 1254
solved: 2026-08-24
solve_time: 1hr+
---

# (C) Number of Closed Islands — LC 1254

## My approach

#### DFS + Detect when 0 is on the boundary of the graph
I apply a flood fill **DFS** algorithm with a twist. If the cell that I am visiting is outside of the boundaries of `grid,` then I know that the previous cell/node is at the boundary. Thus, I return `False`

If the visited cell is a *water* cell, then my **DFS** run should still be valid, but I must not propagate through this cell. Return `True.`

Furthermore, if the visited cell is in `visited,` my **DFS** run is still valid, but I must not propagate through this cell. Return `True`

To indicate when a **DFS** run has touched the boundary, I apply a conditional to propagate a boolean variable up to the top of the stack. This idea is borrowed from the topological sort **DFS** implementation.

***KEY REALIZATION:*** Just returning `False` if a **DFS** iteraiton returns `False` is faulty. It causes the entire run to terminate early, leaving land cells apart of non-closed islands that are not flood-filled. 

The solution is to initialize a boolean variable `closed = True` before traversing through the land cell neighbors. If a **DFS** call comes back as `False,` then set `closed = False`. There is no way for `closed` to be swapped back, so it is okay to vreturn `closed` after all neighbors are traversed.
``` python

```


## Solution
```python
class Solution:
	
```

## Complexity

## Master-check
Flood-Fill **DFS** on all land cells `0s.` Return `False` if one of the land cells is at the boundary of the grid.

