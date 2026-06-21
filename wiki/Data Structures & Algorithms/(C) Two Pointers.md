---
type: concept
aliases: ["Two Pointers"]
tags: [dsa, two-pointers, arrays, sorting, python]
updated: 2026-06-19
sources: 1
---

# Two Pointers

A pattern for **sorted** arrays: keep two indices and move them toward each other (or in lockstep), letting the sort prune the search so you avoid the brute-force nested loop. Converts many O(n²) hash approaches into O(n) or O(n²)→O(n²) *with O(1) space*.

## The core move (from Two Sum II)

On a **sorted** array, to find a pair summing to `target`, start `l` at the left and `r` at the right:

- `nums[l] + nums[r] > target` → the sum is too big → **decrement `r`** (shrink the larger end).
- `nums[l] + nums[r] < target` → too small → **increment `l`** (grow the smaller end).
- equal → found it.

The sort is what makes this directional logic valid — each comparison eliminates a whole row/column of the brute-force grid.

## 3Sum — two pointers nested in a loop

3Sum (find all **unique** triplets summing to 0) is the canonical extension: **sort first**, then fix one element `l` and run the two-pointer scan (`tj`, `r`) on the remainder for `target = -nums[l]`.

```python
def threeSum(nums):
    nums.sort()                          # O(n log n) — required for the pattern
    res = []
    l = 0
    while l < len(nums) - 2:
        temp = nums[l]
        tj, r = l + 1, len(nums) - 1
        while tj < r:
            s = nums[l] + nums[tj] + nums[r]
            if s < 0:   tj += 1
            elif s > 0: r -= 1
            else:
                res.append([nums[l], nums[tj], nums[r]])
                temp_tj = nums[tj]
                while tj < r and nums[tj] == temp_tj:   # skip duplicate middles
                    tj += 1
        while l < len(nums) - 2 and nums[l] == temp:    # skip duplicate anchors
            l += 1
    return res
```

- **Complexity:** O(n²) time (outer anchor × inner two-pointer), **O(1)** extra space (just pointers; output excluded). Sorting at O(n log n) is dominated by the O(n²) scan, so it's free in the budget.
- **Why two pointers beats a hash set here:** the hashmap approach is still ≥ O(n²) because you must re-traverse to find each complement `(0 - i - j)`, and dedup is messier — so two pointers wins on both time constant and space.

> **The recurring trap: duplicates.** The problem wants *unique* triplets. Because the array is sorted, all duplicates are adjacent — so after recording a hit, **skip past equal values** for both the anchor `l` and the moving pointer `tj` (snapshot the value, advance while it matches). Forgetting either skip is the classic 3Sum bug.

## When to reach for it

- Sorted (or sortable) array + "find a pair/triplet/window meeting a sum/condition."
- You want **O(1) space** and the array can be mutated/sorted.
- Variants: opposite-ends (Two Sum II, container-with-most-water, valid palindrome), and fixed-anchor + inner scan (3Sum, 4Sum).

## Related

- [[(C) Python Dictionaries|Python Dictionaries]] — the hashmap alternative this pattern often beats on sorted input.
- [[(C) Tree Traversal|Tree Traversal]] · [[(C) Heaps|Heaps]] — other NeetCode-150 pattern pages.

## Sources

- [[ThreeSum]] — sorted two-pointer derivation, the both-pointers duplicate-skip, and the hashmap-vs-two-pointer complexity argument (builds on [[Two Sum II]]).
