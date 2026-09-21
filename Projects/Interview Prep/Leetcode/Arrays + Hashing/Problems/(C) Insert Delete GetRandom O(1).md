---
tags: [arrays-hashing, medium]
status: Not started
leetcode: 380
difficulty: Medium
companies: [Google, Apple, Amazon, Bloomberg, Uber]
---

# (C) Insert Delete GetRandom O(1) (M) — LC 380

## Problem
Implement a data structure that supports `insert`, `remove`, and `getRandom` — each in average O(1) time. `getRandom` should return a random element with each element having equal probability.

## Target complexity
O(1) average for all three operations. Use a list (for O(1) random index access) + hashmap (for O(1) lookup). The trick for O(1) removal: swap the element to remove with the last element, then pop from the end.

## My approach
_Re-derive the pattern here before reading the solution._

## Solution
```python

```

## Complexity
- **Time:**
- **Space:**

## Master-check
Why can't a hashmap alone support O(1) getRandom? Walk through the swap-with-last trick for remove and explain why it preserves O(1) for all operations.
