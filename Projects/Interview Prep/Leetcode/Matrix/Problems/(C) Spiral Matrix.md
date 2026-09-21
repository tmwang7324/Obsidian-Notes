---
tags:
  - matrix
  - medium
status: Not started
leetcode: 54
difficulty: Medium
companies:
  - Google
  - Meta
  - Amazon
  - Apple
  - Bloomberg
solved_date: 09/21/2026
solved_time: 19m
runtime_beats: 100%
memory_beats: 74.30%
---

# (C) Spiral Matrix (M) — LC 54

## Problem
Given an `m x n` matrix, return all elements of the matrix in spiral order (right → down → left → up, repeating inward).

## Target complexity
O(m×n) time, O(1) extra space (output excluded). Maintain four boundaries (top, bottom, left, right) and shrink them after each directional pass. No need for a visited matrix.

## My approach

### Optimal Solution 
Simulate the spiral movement within `matrix.` There are **4 main chains of operation** *in order*:
1. Iterating left-to-right across the first unvisited row.
2. Traversing top-to-bottom on the last unvisited column.
3. Traversing right-to-left on the last unvisited row.
4. Processing cells bottom-to-top on the first unvisited row.

To keep track of the first, last unvisited rows and columns, let's declare 4 pointers: `left, right, top, bottom`
***KEY TAKEWAY:*** After every loop of these 4 operations, **the top, bottom row indices, and the left, right column indices should be updated to account for the visited cells.**
```python
n = len(matrix)
m = len(matrix[0])
top, bottom, left, right = 0, n-1, 0, m - 1
top -=1
bottom += 1
left +=1 
right -= 1
```
The 4 steps should loop until `len(res) == n * m`
## Solution
```python

```

## Complexity
- **Time:**
- **Space:**

## Master-check
What are the four boundary variables and when does each one update? What's the termination condition that prevents double-visiting in non-square matrices?
