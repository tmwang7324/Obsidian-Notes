---
project: Google Interview Prep
type: idea
tags: [google-prep, dp, leetcode, coin-change, unbounded-knapsack, medium]
difficulty: Medium
leetcode: 322
status: in-progress
solved:
---

# Coin Change (M) — LC 322

Given coin denominations (**unlimited supply** of each) and a target `amount`, return the
**fewest number of coins** needed to make up `amount`. If it cannot be made at all, return `-1`.
Constraints: `coins.length ≤ 12`, `coins[i] ≤ 2^31 − 1`, `0 ≤ amount ≤ 10^4`.

**The crux:** unlike [[(C) Coin Change II|Coin Change II]], this is a **minimisation**, not a
count — and "impossible" is a real, representable outcome that must survive all the way out.

## Target complexity
`amount ≤ 10^4`, `n ≤ 12` → an `n × amount` table is ~120k cells; even `O(n · amount)` with a
constant factor is nothing. Enumerating actual coin sets is exponential and dead on arrival.
Target **O(n · amount)**.

## My approach
_Re-derive before reading anything else. Original session notes preserved below._

### Top Down using Memoization

**IMPORTANT:** Each remaining change need only be solved once. For each coin, decrease the
remaining change by the value of the coin until the change reaches 0 or goes past.

Record the min depth of the different paths every layer in a memoization **dictionary (not
list).** *NOTE:* a list cannot differentiate between not solved and impossible to solve. Both are
marked as `float('-inf')`.

> **Worth noticing:** that dict-vs-list note *is* the sentinel principle — "a sentinel a real
> answer can equal is not a sentinel." You had it here first, then hit the same bug twice in
> Coin Change II with `> 0` on a count table. Same principle, different problem. Store the
> principle, not the fact.

## Reasoning to the approach
_Open questions to answer yourself — these are the whole problem:_

1. **Does this need the `(i, rem)` two-argument state that Coin Change II needed, or does a
   single-argument `dp(rem)` work here?** The permutation over-count that killed the
   one-argument state in II — does it actually hurt you when the accumulator is a `min` instead
   of a `sum`? Answer this first; it determines everything below.
2. **What does `dp(rem)` return, and what are the base cases?** `rem == 0` → ? · `rem < 0` → ?
3. **How do you represent "impossible"** so that (a) it survives a `min`, (b) it survives a `+1`,
   and (c) it's distinguishable from "not yet computed"? That's three separate constraints on
   one value.
4. Where does the final `-1` get produced — inside the recursion, or once at the very end?

## Naive solution — and why it fails
_TODO: write the version you'd reach for first, then prove what breaks at `amount = 10^4`._

## Common pitfalls
_TODO: fill in as you hit them. Log them the moment they bite — that's what made the II note useful._

## Optimal solution
```python
# TODO — mine to derive.
```

## Complexity
- **Time:** _TODO_
- **Space:** _TODO_

## Master-check
1. Why does Coin Change **II** need an index in the state while Coin Change **I** (does / doesn't
   — you decide) — what property of the accumulator is responsible?
2. What breaks if you initialise the memo to `0` instead of your sentinel?

## Related
- [[(C) Coin Change II|Coin Change II]] — count combinations (unbounded knapsack, counting variant)
- [[(C) Dynamic Programming|Dynamic Programming]] — unbounded vs 0/1 knapsack lives here
