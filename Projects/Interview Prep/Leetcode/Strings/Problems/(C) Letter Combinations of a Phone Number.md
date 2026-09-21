---
tags: [backtracking, medium]
status: Not started
leetcode: 17
difficulty: Medium
companies: [Google, Meta, Amazon, Bloomberg, LinkedIn]
---

# (C) Letter Combinations of a Phone Number (M) — LC 17

## Problem
Given a string containing digits from 2-9, return all possible letter combinations that the number could represent (phone keypad mapping). Return the answer in any order.

## Target complexity
O(4^n) time and space where n is the number of digits (worst case each digit maps to 4 letters like 7 and 9). This is inherent — you must enumerate all combinations. Use backtracking with a path that grows one character per digit.

## My approach
_Re-derive the pattern here before reading the solution._

## Solution
```python

```

## Complexity
- **Time:**
- **Space:**

## Master-check
Why is the time complexity O(4^n) and not O(3^n)? Can you trace through the backtracking tree for input "23" and explain when you backtrack?
