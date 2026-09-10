---
type: next-step
project: Google Interview Prep
status: open
goal: "[[]]"
effort: L
tags: [next-step, google-interview-prep]
---

# (C) Binary Search — Core Pattern Grind

Zero coverage on the Google EC SWE high-frequency list. 10 questions across Easy → Hard.

## Questions (ordered by difficulty → frequency)

### Easy — build the muscle memory
- [ ] 704 Binary Search (61.1%, 50%)
- [x] 69 Sqrt(x) (42.1%, 50%)
- [ ] 35 Search Insert Position (51.7%, 50%)
- [ ] 278 First Bad Version (47.3%, 37.5%)

### Medium — the interview standard
- [ ] 33 Search in Rotated Sorted Array (45.2%, 50%)
- [ ] 34 Find First and Last Position of Element in Sorted Array (49.3%, 50%)
- [ ] 162 Find Peak Element (47.1%, 50%)
- [ ] 540 Single Element in a Sorted Array (59.3%, 50%)
- [ ] 875 Koko Eating Bananas (50.2%, 62.5%)

### Hard — expect one of these
- [ ] 4 Median of Two Sorted Arrays (47.0%, 62.5%)
- [ ] 410 Split Array Largest Sum (60.9%, 50%)

### Forum-scraped additions (Aug 2026)

From [[(C) Google Coding Questions — Forum Scrape]] and [[(C) TikTok ByteDance Coding Questions — Forum Scrape]]:

**Medium — confirmed TikTok OA + Google high-frequency:**
- [ ] 1901 Find a Peak Element II — 2D binary search, confirmed TikTok OA 2026
- [ ] 973 K Closest Points to Origin — min-heap or quickselect, confirmed TikTok OA
- [ ] 215 Kth Largest Element in an Array — quickselect or heap, Google + TikTok high frequency

**Hard — Google + TikTok stretch:**
- [ ] 295 Find Median from Data Stream — two-heap pattern, Google high frequency

> These overlap with heap territory but the underlying technique is binary-search-adjacent (quickselect, search-on-answer). Practice them here or in Heaps — just don't skip them.

## Pattern notes to internalize
1. **Standard template:** `lo, hi = 0, len(arr)-1` with `while lo <= hi`
2. **Boundary search:** `while lo < hi` — converges to a single answer
3. **Search space on answer:** Koko, Split Array — binary search on the answer value, not an index
4. **Rotated array:** identify which half is sorted, then decide which side to search

## Write-ups to create
Create a problem write-up under `Leetcode/Binary Search/Problems/` for each question completed.
