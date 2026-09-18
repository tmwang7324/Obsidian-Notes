---
project: Interview Prep
difficulty: Medium
leetcode:
solved:
solve_time:
source: OA (seen frequently)
---

# (C) Garden Sprinkler

## Problem

A garden is laid out along a single straight path. Each flowerbed sits at its own distinct integer coordinate; you're given these coordinates, sorted in increasing order, as an array of integers `flowerbeds`.

You have exactly **one sprinkler** to install at any integer coordinate along the path (even directly on top of an existing flowerbed). Once installed at coordinate `c`, the sprinkler waters every flowerbed within `radius` units on either side — i.e. coordinates in `[c - radius, c + radius]`.

Determine the coordinate to install the sprinkler at so that it waters the **maximal number** of flowerbeds. If multiple coordinates water the same maximal number, return the **smallest** such coordinate.

**Implement:** `solution(flowerbeds, radius)`

## My approach
_TODO_

## Solution
```python
n = len(flowerbeds)
l = 0
for r in range(n):
	while flowerbeds[r] - flowerbeds[l] > radius * 2:
	
```

## Complexity
**Time Complexity** 
## Master-check
Sorted input + fixed-width window → sliding window over the sorted `flowerbeds` array. The window covers all flowerbeds reachable within diameter `2 * radius`. For each right pointer expansion, slide the left pointer until `flowerbeds[right] - flowerbeds[left] <= 2 * radius`. The optimal sprinkler coordinate for a given window is `flowerbeds[left] + radius` (leftmost `c` that still reaches `flowerbeds[right]`).
