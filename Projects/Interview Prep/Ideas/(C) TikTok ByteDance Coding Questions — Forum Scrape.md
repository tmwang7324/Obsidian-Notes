# (C) TikTok / ByteDance Coding Questions — Forum Scrape

> Compiled 2026-08-21 from 1Point3Acres, LeetCode Discuss (blocked), Lodely, Jobright, and CodingInterview.com. Most primary sources (LeetCode, 1point3acres thread details) blocked direct scraping or require login; this draws from search-indexed summaries and accessible aggregator pages.

## Interview Structure (2026)

- **Platform change:** switched from HackerRank to **CodeSignal** for OA
- **OA format:** 4 coding problems, 1 hour 10 min (no more multiple choice)
  - Q1–Q2: Easy, Q3–Q4: Medium
- **Phone screen:** 45 min, 2 medium-to-hard problems
- **Onsite:** up to 6 rounds (some candidates report "6 intensive rounds")
- **New trend:** AI-assisted coding interviews for some teams (e-commerce, ads)
- **Framing shift:** wrapping problems in engineering scenarios (file systems, server infra, data pipelines) rather than pure abstract puzzles

## 1Point3Acres — Recent ByteDance/TikTok Threads (Aug 2026)

From the public index (53 hot questions, 145 pages total):

| Date | Position | Round | Problem Hint |
|------|----------|-------|-------------|
| 8/21 | Intern SWE | Phone Screen | 2027 Summer internship |
| 8/20 | FT SWE | Phone Screen | Coding interview |
| 8/18 | FT SWE | Onsite | System design guidance |
| 8/17 | FT Eng | Video | TikTok engineering |
| 8/17 | FT SWE | Onsite | 6 intensive rounds |
| 8/16 | FT SWE | Phone Screen | TikTok Advertising team |
| 8/13 | FT Fullstack | Phone Screen | React + nested JSON challenge |
| 8/8 | FT SWE | Phone Screen | DFS challenge |
| 8/6 | ML Eng | Phone Screen | Short video store |
| 8/6 | FT SWE | AI-Assisted | E-commerce role |
| 8/6 | MLE | Phone Screen | TikTok MLE Monetization |

## Online Assessment — Confirmed Problems (Lodely, 2026)

| Problem | LC # | Difficulty | Topics |
|---------|------|-----------|--------|
| Minimum Operations to Make Array Increasing | 1827 | Easy | Greedy, Array |
| Merge Intervals (with constraints) | 56 | Medium | Sorting, Greedy |
| Unique Paths in Grid with Obstacles | 63 | Medium | DP |
| Minimum Swaps to Sort Array | — | Medium | Graph, Cycles |
| Find Peak in 2D Matrix | 1901 | Medium | Binary Search |
| Decode Ways II (with Wildcards) | 639 | Hard | DP, Combinatorics |
| Maximize Score of Merged Intervals | — | Medium | DP, Binary Search |
| Longest Subarray with Sum K | 325 | Medium | Prefix Sum, HashMap |
| Remove K Digits to Get Smallest Number | 402 | Medium | Monotonic Stack |
| Best Time to Buy and Sell Stock with Cooldown | 309 | Medium | State Machine DP |
| Sliding Window Maximum | 239 | Hard | Deque, Sliding Window |
| Shortest Substring with All Characters | 76 | Hard | Two Pointers, HashMap |
| Reconstruct Itinerary | 332 | Medium | DFS, Lexical Sort |
| K Closest Points to Origin | 973 | Medium | Min-Heap |

**Emerging 2026 OA patterns:** server investment (greedy + DP), round-robin load balancing (simulation + queue), longest OR subarray (bit manipulation), maximum XOR suffix (trie + bit manipulation).

## Frequently Asked Problems — Compiled from Multiple Sources

### Core LC Problems (Jobright, with LC #)

| Problem | LC # | Difficulty | Topics |
|---------|------|-----------|--------|
| Two Sum | 1 | Easy | Arrays |
| Reverse Linked List | 206 | Easy | Linked Lists |
| Valid Parentheses | 20 | Easy | Stacks |
| Merge Two Sorted Lists | 21 | Easy | Linked Lists |
| Happy Number | 202 | Easy | Math |
| Longest Substring Without Repeating Characters | 3 | Medium | Sliding Window |
| Shortest Path in Binary Matrix | 1293 | Medium | BFS |
| Number of Islands | 200 | Medium | DFS |
| LRU Cache | 146 | Medium | Design |
| Daily Temperatures | 739 | Medium | Monotonic Stack |
| Kth Largest Element in an Array | 215 | Medium | Heaps |
| Binary Tree Maximum Path Sum | 124 | Hard | Trees/DFS |

### 1Point3Acres Problem Bank (behind paywall, metadata visible)

- **39 coding problems** with frequency tags
- Topics: DFS, BFS, DP, linked lists, trees, graphs, sliding windows, strings, arrays, heaps, stacks, union-find, ML/transformers, distributed systems
- One public problem: **Basic Calculator** (Hard, 60 min) — implement string calculator with +, -, *, /, parentheses variants

### Medium-Difficulty Focus (CodingInterview.com)

| Problem | Topics |
|---------|--------|
| Group Anagrams | Hash Tables, Sorting |
| Binary Tree Level Order Traversal | BFS |
| Validate BST | Trees, Recursion |
| Coin Change | DP |
| Product of Array Except Self | Prefix Sums |
| Clone Graph | Graphs, Hash Tables |
| Rotate Image | Matrix |
| Find All Permutations | Backtracking |
| Merge Intervals | Sorting |
| Design Hit Counter | Queues, Design |
| Course Schedule | Topological Sort |
| Decode Ways | DP |

### Hard Problems

| Problem | Topics |
|---------|--------|
| Median of Two Sorted Arrays | Binary Search |
| Serialize/Deserialize Binary Tree | Trees, Design |
| Word Ladder | BFS |
| Longest Increasing Path in Matrix | DP, DFS, Memoization |
| Trapping Rain Water | Two Pointers |
| Minimum Window Substring | Sliding Window |
| Design Search Autocomplete | Tries |
| Alien Dictionary | Topological Sort |
| Regular Expression Matching | DP |

### Fresh 2026 Scenario-Based Questions (CodingInterview.com)

These wrap classic algorithms in TikTok product scenarios:

| Problem | Underlying Pattern | Difficulty |
|---------|-------------------|-----------|
| Video chunk scheduler | Topological sort + critical path | Hard |
| Engagement score calculator | Sliding window + weighted averages | Medium |
| Comment tree flattening | Tree traversal + custom ordering | Medium |
| Hashtag trend detector | Streaming algorithms + hash tables | Medium |
| Video deduplication | Locality-sensitive hashing | Hard |
| Feed position optimizer | Weighted job scheduling | Hard |
| Live viewer count | HyperLogLog / probabilistic counting | Medium |
| Content moderation queue | Dynamic priority queue | Medium |
| Creator network clustering | Graph clustering | Hard |
| Adaptive bitrate selector | Quality optimization | Hard |

## Key Takeaways

1. **DP is king** — appears in OA, phone screen, and onsite at higher frequency than Google
2. **Scenario wrapping** — expect real-world framing (file systems, video pipelines, ad serving), need to identify the underlying pattern
3. **AI-assisted coding** is a new interview format for some teams
4. **6-round onsites** — more rounds than Google, test stamina
5. **CodeSignal OA** — 4 problems, 70 min, no multiple choice

## Sources

- [1Point3Acres ByteDance Interview Index](https://www.1point3acres.com/interview/company/bytedance) — 53 hot questions, 145 pages
- [1Point3Acres ByteDance Problems](https://www.1point3acres.com/interview/problems/company/bytedance) — 333 OJ practice problems
- [Lodely — TikTok OA 2026 Breakdown](https://www.lodely.com/blog/tiktok-online-assessment-2025) — 14 confirmed OA problems with LC numbers
- [Jobright — ByteDance Technical Interview 2026](https://jobright.ai/blog/bytedance-technical-interview-questions-complete-2026-guide/) — 12 core problems with LC numbers
- [CodingInterview.com — Top 50 TikTok Questions](https://www.codinginterview.com/guide/tiktok-coding-interview-questions/) — 50 questions by difficulty + 10 fresh 2026 scenario problems
- [Ophyai — TikTok Interview Process 2026](https://ophyai.com/blog/company-guides/tiktok-interview-guide) — format and timeline
