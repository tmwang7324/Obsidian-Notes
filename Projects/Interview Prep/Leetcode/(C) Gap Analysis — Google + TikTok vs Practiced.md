# (C) Gap Analysis — Google + TikTok vs. Practiced

> Cross-reference of forum-scraped interview questions against problems in `Leetcode/`. Generated 2026-08-22.

## Already Practiced (22 problems)

These appear in both the scraped question lists AND your Leetcode folders:

| Problem                                        | LC # | Topic Folder        | Companies                                 |
| ---------------------------------------------- | ---- | ------------------- | ----------------------------------------- |
| Two Sum                                        | 1    | Arrays + Hashing    | Google, TikTok                            |
| Product of Array Except Self                   | 238  | Arrays + Hashing    | Google, TikTok                            |
| Container With Most Water                      | 11   | Two Pointers        | Google                                    |
| Longest Substring Without Repeating Characters | 3    | Sliding Window      | Google, TikTok                            |
| Minimum Window Substring                       | 76   | Sliding Window      | Google, TikTok                            |
| Clone Graph                                    | 133  | Graphs              | Google, TikTok                            |
| Course Schedule                                | 207  | Graphs              | Google, TikTok                            |
| Coin Change                                    | 322  | Dynamic Programming | Google, TikTok                            |
| LRU Cache                                      | 146  | Linked List         | Google, TikTok                            |
| Top K Frequent Elements                        | 347  | Heaps               | Google                                    |
| Valid Parentheses                              | 20   | Stack + Queues      | TikTok                                    |
| Daily Temperatures                             | 739  | Stack + Queues      | TikTok                                    |
| Lowest Common Ancestor of a BST                | 235  | Trees               | Google, TikTok                            |
| Invert Binary Tree                             | 226  | Trees               | Google                                    |
| Same Tree                                      | 100  | Trees               | Google                                    |
| Group Anagrams                                 | —    | Arrays + Hashing    | TikTok                                    |
| Best Time to Buy and Sell Stock                | 121  | Sliding Window      | TikTok (basic; cooldown variant is a gap) |

**Coverage: 17 of 44 unique Google problems (39%), 13 of 58 unique TikTok problems (22%)**

---

## GAPS — High Priority (frequently asked, not practiced)

### Arrays & Strings

| Problem | LC # | Difficulty | Asked By | Why Priority |
|---------|------|-----------|----------|-------------|
| Merge Intervals | 56 | Medium | Google, TikTok OA | Appears in every single source |
| Trapping Rain Water | 42 | Hard | Google, TikTok | Classic, very high frequency |
| Valid Anagram | 242 | Easy | Google | Quick win, pairs with Group Anagrams |
| Kadane's / Max Subarray | 53 | Medium | Google | Fundamental DP/greedy pattern |

### Trees & Graphs

| Problem                           | LC # | Difficulty | Asked By       | Why Priority                                                  |
| --------------------------------- | ---- | ---------- | -------------- | ------------------------------------------------------------- |
| Number of Islands                 | 200  | Medium     | Google, TikTok | Highest frequency graph problem                               |
| Binary Tree Level Order Traversal | 102  | Medium     | Google, TikTok | You know BFS traversal but haven't done this specific problem |
| Serialize/Deserialize Binary Tree | 297  | Hard       | Google, TikTok | Design + trees combo                                          |
| Word Ladder                       | 127  | Hard       | Google, TikTok | BFS shortest path, high frequency                             |
| Binary Tree Maximum Path Sum      | 124  | Hard       | TikTok         | Hard tree DFS, frequently asked                               |

### Dynamic Programming

| Problem                        | LC # | Difficulty | Asked By       | Why Priority                                 |
| ------------------------------ | ---- | ---------- | -------------- | -------------------------------------------- |
| Word Break                     | 139  | Medium     | Google         | High frequency, string DP                    |
| Longest Increasing Subsequence | 300  | Medium     | Google         | Classic DP                                   |
| Decode Ways                    | 91   | Medium     | Google, TikTok | String DP, frequently paired with Word Break |
| Edit Distance                  | 72   | Medium     | Google         | 2D DP cornerstone                            |

### Linked Lists

| Problem                | LC # | Difficulty | Asked By       | Why Priority                             |
| ---------------------- | ---- | ---------- | -------------- | ---------------------------------------- |
| Reverse Linked List    | 206  | Easy       | Google, TikTok | Foundational — builds to harder variants |
| Merge Two Sorted Lists | 21   | Easy       | TikTok         | Quick win, prerequisite to Merge K       |
| Merge K Sorted Lists   | 23   | Hard       | Google         | Heap + linked list combo                 |
| Linked List Cycle      | 141  | Easy       | Google         | Floyd's — quick to learn                 |

### Heaps & Search

| Problem | LC # | Difficulty | Asked By | Why Priority |
|---------|------|-----------|----------|-------------|
| Kth Largest Element in an Array | 215 | Medium | Google, TikTok | Quickselect or heap |
| Search in Rotated Sorted Array | 33 | Medium | Google | Modified binary search, very common |
| Find Median from Data Stream | 295 | Hard | Google | Two-heap pattern |
| K Closest Points to Origin | 973 | Medium | TikTok OA | Heap, confirmed OA problem |

### Design

| Problem | LC # | Difficulty | Asked By | Why Priority |
|---------|------|-----------|----------|-------------|
| Implement Trie | 208 | Medium | Google | Foundation for autocomplete |
| Design Search Autocomplete System | 642 | Hard | Google, TikTok | Trie + design, very Google |
| Generate Parentheses | 22 | Medium | Google | Backtracking fundamental |

---

## GAPS — TikTok OA Specific (confirmed 2026 problems)

These are confirmed CodeSignal OA problems you haven't practiced:

| Problem | LC # | Difficulty | Topics |
|---------|------|-----------|--------|
| Unique Paths with Obstacles | 63 | Medium | DP |
| Remove K Digits | 402 | Medium | Monotonic Stack |
| Best Time to Buy/Sell Stock with Cooldown | 309 | Medium | State Machine DP |
| Sliding Window Maximum | 239 | Hard | Deque |
| Reconstruct Itinerary | 332 | Medium | DFS, Euler path |
| Decode Ways II (wildcards) | 639 | Hard | DP |
| Find Peak in 2D Matrix | 1901 | Medium | Binary Search |
| Longest Subarray with Sum K | 325 | Medium | Prefix Sum |
| Min Operations to Make Array Increasing | 1827 | Easy | Greedy |

---

## GAPS — Hard/Stretch (lower frequency but worth knowing)

| Problem | LC # | Difficulty | Asked By |
|---------|------|-----------|----------|
| Median of Two Sorted Arrays | 4 | Hard | TikTok |
| Longest Increasing Path in Matrix | 329 | Hard | TikTok |
| Alien Dictionary | 269 | Hard | TikTok |
| Regular Expression Matching | 10 | Hard | TikTok |
| Copy List with Random Pointer | 138 | Medium | Google |
| Range Sum Query — Mutable | 307 | Medium | Google |
| Count of Range Sum | 327 | Hard | Google |
| Shortest Path in Binary Matrix | 1293 | Medium | TikTok |

---

## Topic Gaps Summary

| Topic | Practiced | Google Asks | TikTok Asks | Biggest Gaps |
|-------|-----------|-------------|-------------|-------------|
| Arrays + Hashing | 4 problems | 9 | 8 | Merge Intervals, Trapping Rain Water |
| Trees | 6 problems | 10 | 6 | Number of Islands, Serialize/Deserialize, Level Order |
| Graphs | 3 problems | (in trees) | 5 | Number of Islands, Word Ladder |
| DP | 2 problems | 6 | 8 | Word Break, LIS, Edit Distance, Decode Ways |
| Linked Lists | 1 problem | 6 | 4 | Reverse LL, Merge K, Cycle Detection |
| Heaps/Search | 3 problems | 5 | 3 | Kth Largest, Median from Stream, Rotated Array |
| Sliding Window | 4 problems | (in arrays) | 3 | Sliding Window Maximum |
| Stack + Queues | 4 problems | 1 | 2 | Remove K Digits |
| Two Pointers | 6 problems | 1 | 2 | ✅ Strongest topic |
| Design/Trie | 0 problems | 3 | 2 | Trie, Autocomplete, Generate Parentheses |

**Weakest areas:** Linked Lists (1 of 6 Google problems), DP (2 of 6 Google), Design/Trie (0 of 3).
**Strongest area:** Two Pointers, Sliding Window, Stack + Queues.

---

## Suggested Practice Order

**Week 1 — Quick wins + foundations (Easy/Medium, high frequency):**
1. Reverse Linked List (206)
2. Linked List Cycle (141)
3. Merge Two Sorted Lists (21)
4. Valid Anagram (242)
5. Number of Islands (200)
6. Merge Intervals (56)
7. Binary Tree Level Order Traversal (102)
8. Generate Parentheses (22)

**Week 2 — Core mediums (all high-frequency Google + TikTok):**
1. Kth Largest Element in an Array (215)
2. Search in Rotated Sorted Array (33)
3. Word Break (139)
4. Decode Ways (91)
5. Longest Increasing Subsequence (300)
6. Kadane's / Max Subarray (53)
7. Implement Trie (208)
8. K Closest Points to Origin (973)

**Week 3 — TikTok OA prep + harder problems:**
1. Unique Paths with Obstacles (63)
2. Remove K Digits (402)
3. Buy/Sell Stock with Cooldown (309)
4. Sliding Window Maximum (239)
5. Edit Distance (72)
6. Merge K Sorted Lists (23)
7. Find Median from Data Stream (295)
8. Trapping Rain Water (42)

**Week 4 — Hard stretch + design:**
1. Serialize/Deserialize Binary Tree (297)
2. Word Ladder (127)
3. Binary Tree Maximum Path Sum (124)
4. Design Search Autocomplete System (642)
5. Reconstruct Itinerary (332)
6. Decode Ways II (639)
7. Copy List with Random Pointer (138)
8. Alien Dictionary (269)
