---
tags: [sliding-window, medium]
status: Not started
leetcode: 713
difficulty: Medium
companies: [Google, Meta, Amazon, Apple]
---

# (C) Subarray Product Less Than K (M) — LC 713

## Problem
Given an array of positive integers `nums` and an integer `k`, return the number of contiguous subarrays where the product of all elements is strictly less than `k`.

## Target complexity
O(n) time, O(1) space using sliding window. Since all elements are positive, the product is monotonically increasing as the window expands — shrink from the left when product ≥ k. Each valid window of length L contributes L new subarrays (those ending at the right pointer).

## My approach
_Re-derive the pattern here before reading the solution._

## Solution
```python

```

## Complexity
- **Time:**
- **Space:**

## Master-check
Why does each position of the right pointer contribute exactly `right - left + 1` new subarrays? Why does this sliding window work here but NOT for Subarray Sum Equals K (LC 560)?
