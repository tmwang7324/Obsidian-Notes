---
type: next-step
project: Google Interview Prep
status: open
goal: "[[]]"
effort: L
tags: [next-step, google-interview-prep]
---

# (C) Dynamic Programming — Core Pattern Grind

Only Coin Change covered. 9 remaining questions spanning the core DP archetypes.

## Questions (ordered by archetype → difficulty)

### 1D DP — foundations
- [ ] 70 Climbing Stairs (54.2%, 50%) — basic recurrence
- [ ] 509 Fibonacci Number (74.3%, 50%) — pure recurrence
- [ ] 198 House Robber (53.4%, 50%) — skip/take pattern
- [ ] 55 Jump Game (41.2%, 50%) — greedy/DP hybrid
- [ ] 152 Maximum Product Subarray (36.7%, 50%) — track min and max

### Subsequence DP
- [ ] 300 Longest Increasing Subsequence (59.7%, 50%) — O(n²) → O(n log n) with binary search
- [ ] 5 Longest Palindromic Substring (38.2%, 62.5%) — expand around center or DP table

### String DP
- [ ] 72 Edit Distance (60.9%, 37.5%) — classic 2D table

### Stock DP
- [ ] 121 Best Time to Buy and Sell Stock (57.0%, 62.5%) — already have sliding window write-up, add DP perspective

### Forum-scraped additions (Aug 2026)

From [[(C) Google Coding Questions — Forum Scrape]] and [[(C) TikTok ByteDance Coding Questions — Forum Scrape]]:

**String DP — Google high-frequency gaps:**
- [ ] 139 Word Break — trie/set + DP, appears in every Google compilation
- [ ] 91 Decode Ways — string DP, Google + TikTok high frequency
- [ ] 647 Palindromic Substrings — expand-around-center or DP table, Google

**Stock DP — TikTok OA confirmed:**
- [ ] 309 Best Time to Buy and Sell Stock with Cooldown — state machine DP, confirmed TikTok OA 2026

**Hard — TikTok OA + stretch:**
- [ ] 639 Decode Ways II (with Wildcards) — builds on 91, confirmed TikTok OA 2026
- [ ] 329 Longest Increasing Path in a Matrix — DFS + memoization, TikTok hard
- [ ] 63 Unique Paths with Obstacles — 2D DP, confirmed TikTok OA 2026
- [ ] 10 Regular Expression Matching — 2D string DP, TikTok hard

> Priority order: Word Break (139) → Decode Ways (91) → Cooldown (309) → Unique Paths (63) → the rest. The first two are Google's most-asked DP problems you haven't done.

## Pattern notes to internalize
1. **Top-down vs bottom-up:** solve recursively first with memoization, then convert to tabulation
2. **State definition:** what information do I need to make a decision at step i?
3. **Transition:** how does the answer at i relate to previous answers?
4. **Base cases:** what are the trivially solvable subproblems?
5. **Space optimization:** most 1D DP can be solved with O(1) space using rolling variables

## Write-ups to create
Create a problem write-up under `Leetcode/Dynamic Programming/Problems/` for each question completed.
