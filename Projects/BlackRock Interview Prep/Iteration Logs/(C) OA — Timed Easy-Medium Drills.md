---
type: next-step
project: BlackRock Interview Prep
status: open
goal: "[[(C) Land BlackRock Aladdin Offer]]"
effort: M
tags: [next-step, blackrock-prep]
updated: 2026-07-06
---

# (C) OA — Timed Easy-Medium Drills

Solve Easy–Medium problems under time pressure, **including self-parsing the input**,
to mimic assessment conditions. Hints-before-answers per project rules.

**Done when:** I can take a cold Easy–Medium problem, parse its input, solve it, and
format output within a realistic time budget, twice in a row without a harness bug.


### Problems To Do
1. Question very similar to **Valid Parenthesis:**![[Pasted image 20260706185351.png]]

2.  Graph problem involves exchanging currency rate and finding the exchange that will give me the max rate. Similar to **Evaluate Division.** ![[Pasted image 20260706185830.png]]

3. More reported OA questions (小红书 / Xiaohongshu screenshots, imported 2026-07-08):

**"最新通过 BlackRock OA 两题" (latest — passed both OA questions):**
![[最新通过BlackRock OA 两题_1_bug克星_来自小红书网页版.jpg]]
![[最新通过BlackRock OA 两题_2_bug克星_来自小红书网页版.jpg]]

**"BlakRock OA 简直白给！不要太简单了" (OA is a giveaway):**
![[BlakRock OA简直白给！不要太简单了_1_AC客_来自小红书网页版.jpg]]
![[BlakRock OA简直白给！不要太简单了_2_AC客_来自小红书网页版.jpg]]

**"2027 BlackRock 贝莱德 VI+Coding 真题":**
![[2027 BlackRock 贝莱德 VI+Coding真题_5_加布职研社 _ Gabu Career Lab_来自小红书网页版.jpg]]

---

### Recommended Drill Set — Python, easy → medium
Practice **reading input from stdin yourself** on each one (that's the OA-specific muscle).
Order matters: A and B match the two problems above — do those first.

**Priority A — Stacks & Strings** (your Q1 / Valid Parentheses pattern)
- [ ] Valid Parentheses — LC 20 (E) — the core stack-matching pattern
- [ ] Min Stack — LC 155 (M) — auxiliary-stack invariant
- [ ] Evaluate Reverse Polish Notation — LC 150 (M) — stack as an evaluator

**Priority B — Graphs** (your Q2 / Evaluate Division pattern)
- [ ] Evaluate Division — LC 399 (M) — **literally your Q2**: weighted graph, DFS for product of edges
- [ ] Number of Islands — LC 200 (M) — DFS/BFS on a grid, the bread-and-butter traversal
- [x] Clone Graph — LC 133 (M) — traversal + hash-map bookkeeping (optional stretch)

**Priority C — Arrays & Hashing** (BlackRock's biggest bucket)
- [x] Two Sum — LC 1 (E) — hash-map pair matching
- [x] Group Anagrams — LC 49 (M) — hashing by canonical key
- [x] Top K Frequent Elements — LC 347 (M) — frequency count + bucket/heap
- [x] Product of Array Except Self — LC 238 (M) — prefix/suffix passes

**Priority D — Two Pointers / Sliding Window**
- [x] Valid Palindrome — LC 125 (E) — two-pointer warm-up
- [ ] Longest Substring Without Repeating Characters — LC 3 (M) — the canonical sliding window
- [ ] Maximum Subarray (Kadane) — LC 53 (M) — running-window DP hybrid

**Priority E — Dynamic Programming** (the most likely *medium* slot)
- [ ] Climbing Stairs — LC 70 (E) — 1D DP warm-up
- [ ] House Robber — LC 198 (M) — 1D DP with a skip constraint
- [ ] Coin Change — LC 322 (M) — knapsack-style, minimize count
- [ ] Longest Common Subsequence — LC 1143 (M) — 2D DP grid

> **How to use:** do A + B cold first (they mirror the real questions). Then one from each of
> C/D/E under a timer, parsing input yourself. Ask for **hints, not solutions** when stuck.