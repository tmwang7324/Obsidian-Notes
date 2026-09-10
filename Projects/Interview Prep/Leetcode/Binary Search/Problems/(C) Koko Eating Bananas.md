---
project: Google Interview Prep
difficulty: Medium
leetcode: 875
solved: 2026-08-22
solve_time: ~35m
---

# (C) Koko Eating Bananas — LC 875

## My approach
#### Sort + Simulate
I at first thought of this approach in order to limit the domain of the greedy algorithm to the smallest or second smallest elements. However, information of the least element does nothing to improve the search for minimum viable `k`.
Let's take `pile = [3, 6, 7, 11]` with `h = 15`. Koko can afford to take an eating rate of 2 < 3 and still finish.

#### Naive Greedy
Trying to find clues to optimize the algorithm, I start with finding the naive solution. I am not able to compile my haze of thoughts and end up taking a peek at AI. It suggests trying every ascending`k` until one works. 

The first `k` that satisfies Koko's eating time equation with parameter `k` is less than or equal to `h` should be the answer. 
#### Binary Search Greedy
Instead of iterating through every `k`, let's use binary search to find the optimal `k`. I instantly realize this solution and grasp my binary search algorithm condition. If `time > h` , move `r = m - 1` else move `l = m + 1` 
## Solution
```python

```

## Complexity

## Master-check
**Formula:** 
```python
for pile in piles:
	time += Math.ceil(pile/k)
```