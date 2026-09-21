---
tags: [heap, hard]
status: Not started
leetcode: 23
difficulty: Hard
companies: [Google, Meta, Amazon, Apple, Bloomberg]
---

# (C) Merge k Sorted Lists (H) — LC 23

## Problem
Merge `k` sorted linked lists into one sorted linked list and return its head.

## Target complexity
O(N log k) time where N is total number of nodes, using a min-heap of size k. The naive approach of collecting all values and sorting is O(N log N). Merge-sort style pairwise merging also achieves O(N log k).

## My approach
_Re-derive the pattern here before reading the solution._

## Solution
```python

```

## Complexity
- **Time:**
- **Space:**

## Master-check
Why is the heap size always at most k, and how does that give O(N log k) total? How do you handle the comparison when two nodes have equal values (custom comparator or wrapper)?
