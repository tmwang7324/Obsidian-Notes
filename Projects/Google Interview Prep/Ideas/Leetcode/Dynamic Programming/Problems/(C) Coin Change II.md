---
project: Google Interview Prep
type: idea
tags: [google-prep, dp, leetcode, coin-change, unbounded-knapsack, medium]
difficulty: Medium
leetcode: 518
status: solved
solved: 2026-07-15
---

# (C) Coin Change II (M) — LC 518

Given coin denominations (**unlimited supply** of each) and a target `amount`, return the number
of **combinations** that sum to `amount`. Order does **not** matter — `1+2` and `2+1` are the
**same** way. Constraints: `coins.length ≤ 300`, `coins[i] ≤ 5000`, all distinct, `amount ≤ 5000`.

**The crux:** it counts *combinations, not permutations*. Every wrong turn below traces back to
accidentally counting orderings.

## Target complexity
`amount ≤ 5000` and `n ≤ 300` → an `n × amount` table is 1.5M cells, trivially fine. Anything
exponential (enumerating actual combinations) is dead on arrival. Target **O(n · amount)**.

## My approach
**Classify first: this is an unbounded knapsack** (unlimited supply), *counting* variant. Standard
unbounded knapsack maximizes value; this counts ways to hit an exact target — same state, same
skeleton, different thing accumulated in the cell. Spotting "unlimited supply" tells you
immediately that **`i` must not advance when you take a coin**. Flip stay-put → advance and you
have 0/1 knapsack.

State: `dp(i, rem)` = ways to make `rem` using **only `coins[i:]`**. Standing in front of
`coins[i]`, exactly two choices:
- **Skip this coin forever** → advance to `i+1`, `rem` unchanged.
- **Take one copy** (unlimited supply → *stay put* on `i`) → `rem` shrinks by `coins[i]`.

Total = the two branches added. Because skipping only moves **forward** and never steps back to an
earlier coin, `2 then 1` is unbuildable — **the phantom dies by construction, no flag needed.**

## Reasoning to the approach
The instinct is a single-argument state `dp(rem)` that loops over all coins. It's wrong, and it's
wrong *structurally* (see below) — no base case or guard rescues it. The missing piece isn't a flag or a patch, it's **an extra piece of state: a position in the coin list.** That index is
what enforces a canonical build order (non-decreasing coin index), so each combination is
generated exactly once.

Two equivalent correct forms:
- **Loop form** — at each state, loop `for tj in range(i, len(coins))` and take one copy of
  `coins[tj]`, recursing with the index pinned to the coin just picked. The lower bound `i` on
  that range is what forbids reaching backwards.
- **Two-branch form** — skip / take-one, as above. Strictly better; see Complexity.

They're the same tree, re-bracketed. Write out the loop for two neighbouring states:
```
dp(i,   rem) = dp(i, rem-coins[i]) + dp(i+1, rem-coins[i+1]) + dp(i+2, rem-coins[i+2]) + ...
dp(i+1, rem) =                       dp(i+1, rem-coins[i+1]) + dp(i+2, rem-coins[i+2]) + ...
```
Every term after the first is identical, so `dp(i, rem) = dp(i, rem-coins[i]) + dp(i+1, rem)` —
the two-branch recurrence falls out of the loop algebraically. **The tail of the summation is
itself a state.** Call it once instead of rebuilding it.

## Naive solution — and why it fails
Unusually, the naive attempt here fails by **wrong answer**, not by TLE:

```python
def change(amount, coins):
    memo = {}
    def dp(rem):
        if rem == 0: return 1
        if rem < 0: return 0
        if rem in memo: return memo[rem]
        memo[rem] = sum(dp(rem - c) for c in coins)   # <-- counts orderings
        return memo[rem]
    return dp(amount)
```

**Why it fails:** it counts *permutations*. Trace `coins=[1,2], amount=3`:
`dp(0)=1, dp(1)=1, dp(2)=2, dp(3)=3`. True answer is **2** (`1+1+1`, `1+2`); the phantom third is
`2+1` = `1+2` reversed. The state has no memory of which coins are still legal, so nothing stops a
path that took a `2` from later reaching back for a `1`. **No amount of tracing fixes this — the
recurrence itself is wrong.** (This exact code, with the loop starting at `0` instead of `i`, is
the correct solution to a *different* problem: Combination Sum IV, which wants permutations.)

## Improved Solution
Instead of iterating through every coin at each remaining change, I used the **loop form.** 
At each state, traverse through `coins[i:]` using a pointer, *tj*: `for tj in range(i, len(coins))` and add the value returned by my recursive function with parameters *tj* and *rem-coins[tj]* 
This ensures that subtrees with index *i* only contain combinations made with coins in `coins[i:]`

```python

```

## Common pitfalls

**1. Looping from `0` instead of `i`.** The single bug that defines this problem.
```python
for tj in range(0, len(coins)):   # WRONG — rebuilds the 2+1 phantom
for tj in range(i, len(coins)):   # right — backwards reach is impossible
```

**2. A sentinel a real answer can equal.** `if memo[rem][i] > 0` and `if memo[rem][i]:` are the
**identical** condition for a table of non-negative counts. A state whose true answer is `0` —
e.g. `coins=[2], rem=3` — caches `0`, reads as "never computed", and recomputes forever.
```python
memo = [[-1] * n for _ in range(amount + 1)]   # init and sentinel are ONE decision
if memo[rem][i] > -1: return memo[rem][i]      # -1 is unreachable as a true count
```
Note this is a **performance** bug, not a correctness one — answers stay right, the zero-states
just never cache. Name it precisely.

**3. `return -1` on overshoot.** A "negative one way" poisons the `+=` sum. Overshoot built
nothing; the only number meaning nothing-to-add is **`0`**.

**4. A "visited flag" in the memo.** Tempting, and it's the wrong tool — that's *cycle detection*
(graph DFS). Here `rem` strictly decreases every call, so there are no cycles; and returning `0`
on a legitimately-shared subproblem (`dp(1)` feeds both `dp(2)` and `dp(3)`) would destroy the
count. **Memoization caches a result — it does not forbid revisiting.**

## Optimal solution
Two-branch form, `O(1)` work per state:

```python
def change(amount, coins):
    n = len(coins)
    memo = [[-1] * n for _ in range(amount + 1)]

    def dp(i, rem):
        if rem == 0: return 1          # one complete combination
        if rem < 0:  return 0          # overshoot built nothing
        if i == n:   return 0          # out of coins, target unmet
        if memo[rem][i] > -1: return memo[rem][i]
        memo[rem][i] = dp(i, rem - coins[i]) + dp(i + 1, rem)   # take-one (stay put) + skip
        return memo[rem][i]

    return dp(0, amount)
```

Guard order matters: both domain checks fire **before** the memo lookup, or `memo[-1]` silently
returns the last row instead of crashing.

*Bottom-up alternative* — same idea, `O(amount)` space, no recursion:
```python
def change(amount, coins):
    dp = [0] * (amount + 1)
    dp[0] = 1
    for c in coins:                       # coin loop OUTSIDE = combinations
        for a in range(c, amount + 1):
            dp[a] += dp[a - c]
    return dp[amount]
```

## Complexity
- **Time:** **O(n · amount)** — `n · amount` states × O(1) work each.
  The **loop form** is `O(n² · amount)`: same states, but `O(n − i)` work per state re-adding a
  sum the neighbouring cell already cached.
- **Space:** O(n · amount) for the memo + O(n + amount) recursion depth. Bottom-up: **O(amount)**.

## Master-check
1. In the bottom-up version, why must the **coin loop be outside** the amount loop — what exactly
   breaks if you swap them?
2. What single change turns this into **0/1 knapsack**, and why does that change work?

## Meta — the bug pattern to actually fix
Two bugs recurred *after already being solved in this very note*: the `rem < 0 → -1` overshoot
(logged as fixed, checkmarked, came back), and the memo sentinel (told truthiness was broken,
wrote `> 0`, which is the *same condition* — fixed the symptom shown, not the property that made
it wrong).

**Root cause: storing facts ("the answer is 0") instead of principles ("a count is non-negative,
so anything negative is unreachable and therefore a legal sentinel").** Facts decay; principles
don't. Any sentinel a real answer can equal is not a sentinel.

## Related
- [[Coin Change]] — Coin Change I (min coins; note how *that* recurrence differs from this counting one)
- [[(C) Dynamic Programming|Dynamic Programming]] — unbounded vs 0/1 knapsack lives here
