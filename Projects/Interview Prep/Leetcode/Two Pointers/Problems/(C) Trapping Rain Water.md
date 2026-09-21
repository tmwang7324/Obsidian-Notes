---
tags:
  - two-pointers
  - hard
status: Not started
leetcode: 42
difficulty: Hard
companies:
  - Google
  - Meta
  - Amazon
  - Goldman Sachs
  - Bloomberg
date: 2026-09-19
runtime_beats: 41.95%
memory_beats: 50.09%
---

# (C) Trapping Rain Water (H) — LC 42

## Problem
Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it can trap after raining.

## Target complexity
O(n) time, O(1) space with two pointers. O(n) with stack or DP using precomputed left/right max arrays is also accepted. The brute force O(n²) approach of scanning left and right for every bar is too slow.

## My approach
### Naive
Iterate through `heights.` For each elevation on the map, `height[i]` scan **all** elevations to the left and the right of it for the *maximum elevation on the left* and *maximum elevation on the right.* This will be used to determine how the **depth** of the rainwater trapped.

### Suboptimal: Two Pointer with depth
The naive solution involves a lot of repeated operation to find both directional maximums due to its *center-to-edge traversal pattern*. **Reverse this pattern and traverse from edge to center.** 
1. Initialize a left pointer and right pointer at the **start** and **end** of the `height` array respectively. Also, initialize `max_left` and `max_right` variables, which will hold the maximum elevations found so far on the left and right of the map.
2. I traced this traversal out extensively using Leetcode comments: Create a **while** loop with condition`l <= r` so that every elevation is traversed. 
3. Next, I was torn between comparing `height[l] <= max_right` or `height[l] <= height[r]` to decide when to increment `l`. Both would imply that `max_left <= max_right`
4. However, I stuck with the safest option. Computing `max_left,` `max_right`, and `depth = min(max_right, max_left)`  at the **start** **of each iteration**.
5. Then, whenever `height[l] <= height[r],` I **increment** `l` otherwise **decrement** `r`.
6. If `height[l] < depth` or `height[r] < depth`, then we know that rainwater was trapped in that space. Use the formula `depth - height[l]`

## Solution
```python

```

## Complexity
- **Time:** O(n) because each index in `height` is visited once.
- **Space:** O(1) because only pointers are instantiated.

## Master-check
Can you explain why `water[i] = min(max_left[i], max_right[i]) - height[i]` is correct, and how two pointers eliminate the need for the precomputed arrays?
