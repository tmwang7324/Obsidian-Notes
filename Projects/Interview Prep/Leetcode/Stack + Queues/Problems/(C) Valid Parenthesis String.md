---
tags: [stack, medium]
status: Not started
leetcode: 678
difficulty: Medium
companies: [Google, Meta, Amazon, Apple, Bloomberg]
---

# (C) Valid Parenthesis String (M) — LC 678

## Problem
Given a string `s` containing only `(`, `)`, and `*`, determine if it's valid. `*` can be treated as `(`, `)`, or an empty string.

## Target complexity
O(n) time, O(1) space using greedy with low/high counter tracking. Track the range [lo, hi] of possible open-paren counts. `(` increments both, `)` decrements both, `*` decrements lo and increments hi. Clamp lo ≥ 0. If hi < 0 at any point, invalid. Valid iff lo == 0 at end.

## My approach
_Re-derive the pattern here before reading the solution._

## Solution
```python

```

## Complexity
- **Time:**
- **Space:**

## Master-check
Why do you need a range [lo, hi] instead of a single counter? What does it mean when lo goes negative and you clamp it to 0?
