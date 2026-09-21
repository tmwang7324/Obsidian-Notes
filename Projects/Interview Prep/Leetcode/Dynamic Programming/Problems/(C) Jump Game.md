---
tags: [greedy, medium]
status: Not started
leetcode: 55
difficulty: Medium
companies: [Google, Meta, Amazon, Bloomberg]
---

# (C) Jump Game (M) — LC 55

## Problem
Given an integer array `nums` where each element represents your maximum jump length from that position, determine if you can reach the last index starting from index 0.

## Target complexity
O(n) time, O(1) space using greedy. Track the farthest index reachable so far. At each position i (if i ≤ farthest), update farthest = max(farthest, i + nums[i]). If farthest ≥ last index, return true. DP is O(n²) and unnecessary.

## My approach
_Re-derive the pattern here before reading the solution._

## Solution
```python

```

## Complexity
- **Time:**
- **Space:**

## Master-check
Why does greedy work here but not for Jump Game II (minimum jumps)? What's the key invariant — why is checking `i <= farthest` sufficient to know position i is reachable?
