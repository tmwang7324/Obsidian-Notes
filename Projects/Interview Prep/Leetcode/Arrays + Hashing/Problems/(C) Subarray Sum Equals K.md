---
tags:
  - arrays-hashing
  - medium
status: Not started
leetcode: 560
difficulty: Medium
companies:
  - Google
  - Meta
  - Amazon
  - Apple
  - Bloomberg
solve_time: 43m 58 seconds
runtime_beats: 53.94%
memory_beats: 85.01%
---

# (C) Subarray Sum Equals K (M) — LC 560

## Problem
Given an integer array `nums` and an integer `k`, return the total number of subarrays whose sum equals `k`.

## Target complexity
O(n) time, O(n) space using prefix sum + hashmap. The brute force O(n²) nested loop checking every subarray sum is too slow. The key insight: if `prefix[j] - prefix[i] = k`, then the subarray `[i+1..j]` sums to k — so count how many earlier prefix sums equal `current_prefix - k`.

## My approach
### Naive
I at first confused the problem statement with tasking me to find the number of not necessarily *contiguous* subarrays with sum = `k,` so I believed that the time complexity of the brute force solution was $O(2^n)$


## Solution
```python

```

## Complexity
- **Time:**
- **Space:**

## Master-check
Why can't you use a sliding window here (negative numbers break the monotonicity assumption), and why does the hashmap need to store counts, not just presence?
