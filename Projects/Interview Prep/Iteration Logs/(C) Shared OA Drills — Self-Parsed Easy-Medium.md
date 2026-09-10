---
type: next-step
project: Interview Prep
status: open
goal: "[[(C) Google SWE Offer Roadmap]]"
effort: M
tags: [next-step, interview-prep, leetcode]
updated: 2026-08-08
---

# (C) Shared OA Drills — Self-Parsed Easy-Medium

The firm-agnostic residue of the BlackRock OA drill set, carried up to shared prep when
that pipeline stalled (see [[(C) OA — Timed Easy-Medium Drills]] and
[[(C) Land BlackRock Aladdin Offer]]). These problems weren't BlackRock's — they're the
standard Easy–Medium OA surface any company screens on.

**The OA-specific muscle:** solve each **reading input from stdin yourself**, under a
timer. Most OAs hand you a raw string array, not a pre-filled stub — parsing is where
the clock quietly disappears.

**Done when:** I can take a cold Easy–Medium problem, parse its input, solve it, and
format the output inside a realistic time budget, twice in a row without a harness bug.

---

## Untracked — this file owns these

Nothing else in the vault is driving these:

- [ ] **Evaluate Reverse Polish Notation** — LC 150 (M) — stack as an evaluator → `Leetcode/Stack + Queues/`
- [ ] **Evaluate Division** — LC 399 (M) — weighted graph, DFS for the product of edges → `Leetcode/Graphs/`
- [ ] **Maximum Subarray (Kadane)** — LC 53 (M) — running-window DP hybrid → `Leetcode/Arrays/`
- [ ] **Climbing Stairs** — LC 70 (E) — 1D DP warm-up → `Leetcode/Dynamic Programming/`
- [ ] **House Robber** — LC 198 (M) — 1D DP with a skip constraint → `Leetcode/Dynamic Programming/`
- [ ] **Longest Common Subsequence** — LC 1143 (M) — 2D DP grid → `Leetcode/Dynamic Programming/`

> **Suggested order:** Climbing Stairs → House Robber → LCS builds the DP ladder in one
> sitting; Evaluate Division and RPN are one-offs. **Evaluate Division is worth doing
> regardless** — the currency-conversion framing recurs across firms' OAs.

## Already tracked elsewhere — don't double-work

These were on the BlackRock list but a live backlog item already owns them. Work them
there, not here:

| Problem | Owned by |
|---|---|
| Valid Parentheses — LC 20 (E) | [[(C) Warmup - Stack]] · note exists: [[(C) Valid Parentheses]] |
| Min Stack — LC 155 (M) | [[(C) Warmup - Stack]] · note exists: [[(C) Min Stack]] |
| Number of Islands — LC 200 (M) | [[(C) Graphs - Grid Matrix Traversal]] |
| Longest Substring Without Repeating Characters — LC 3 (M) | [[(C) Warmup - Sliding Window]] · note exists |
| Coin Change — LC 322 (M) | [[Coin Change]] — already `status: in-progress` |

## Already done (from the BlackRock set)

Clone Graph (133), Two Sum (1), Group Anagrams (49), Top K Frequent (347),
Product of Array Except Self (238), Valid Palindrome (125).

## Sources
- [[(C) OA — Timed Easy-Medium Drills]] — the original BlackRock drill set this was lifted from
