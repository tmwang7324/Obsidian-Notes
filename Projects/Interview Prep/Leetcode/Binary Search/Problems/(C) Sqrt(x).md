---
project: Google Interview Prep
difficulty: Easy
leetcode: 69
solved:
solve_time:
---

# (C) Sqrt(x) — LC 69

## My approach
#### Binary search on Ascending stream of numbers leading up to x//2
Instead of performing the search across all numbers less than `x,` I performed the search with the greatest number at `x//2.` Every positive integer's square root with the exception of 1 is less than or equal to it's quotient with 2.

Next, I used a slightly faulted version of the binary search algorithm: the while loop was missing the equal to condition. Because of this, I was skipping the greatest number less than the square root of non-perfect square `x.`

## Solution
```python

```

## Complexity

## Master-check
