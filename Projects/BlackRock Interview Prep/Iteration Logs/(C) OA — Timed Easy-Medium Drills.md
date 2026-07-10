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

4. More reported OA questions (小红书 / Xiaohongshu screenshots, imported 2026-07-10):

**"blackrock OA搞定，先解决代码再给思路！" — Corporate Ladder** (tree/graph): read a list of `employee/manager` pairs, build the org hierarchy, and count how many levels exist between any two given names (they may sit in different subtrees — LCA-style traversal, not a direct managerial line).
![[blackrock OA搞定，先解决代码再给思路！_1_mathitdd教育_来自小红书网页版.jpg]]

**"blackrock OA搞定，先解决代码再给思路！" — Happy Numbers** (simulation + cycle detection): for each integer N from stdin, repeatedly replace it with the sum of the squares of its digits; print `1` if it reaches 1, else `0` (detect the loop with a seen-set / Floyd).
![[blackrock OA搞定，先解决代码再给思路！_2_mathitdd教育_来自小红书网页版.jpg]]

**"BlackRock OA+三轮Onsite，难度比较高" — two Java questions:** Q1 **Reverse Spell** (string): reverse the input, lower-case it, hyphen-separate each alphanumeric char, ignore all other chars (`Hip, hip, hooray!` → `y-a-r-o-o-h-p-i-h-p-i-h`). Q2 **Cash Register** (greedy, OOP): given fixed note/coin denominations, read `PP;CH` lines and print the change using the fewest notes/coins — `Zero` if exact, `ERROR` if `CH < PP`.
![[BlackRock OA+三轮Onsite，难度比较高_4_数据Gold矿工咨询_来自小红书网页版 (2).jpg]]

**"BlackRock OA+三轮Onsite，难度比较高" — Currency Arbitrage** (math / weighted cycle, akin to **Evaluate Division**): three directional quotes USD/EUR, EUR/GBP, GBP/USD. Starting from $100,000 USD, convert USD→EUR→GBP→USD; if the round-trip yields a gain, print the arbitrage profit truncated to whole dollars, else `0`. Input: first line `N` = number of quotes, then `N` lines of three space-separated floats; the function receives the lines as a string array (parse them yourself).
![[BlackRock OA+三轮Onsite，难度比较高_2_数据Gold矿工咨询_来自小红书网页版 (1).jpg]]

**"BlackRock OA+三轮Onsite，难度比较高" — Portfolio Manager** (tree DP = **House Robber III**, LC 337): given a binary tree serialized in level-order with `#` as a null/path-terminator (`1 2 3 # # 4 # # 5`), each node's int = investable cash. Pick nodes maximizing total cash such that no two *directly-related* (parent–child) nodes are both chosen; print the max. Parse the serialized string into a tree first, then post-order DP returning `(rob, skip)` per node.
![[BlackRock OA+三轮Onsite，难度比较高_3_数据Gold矿工咨询_来自小红书网页版 (1).jpg]]

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