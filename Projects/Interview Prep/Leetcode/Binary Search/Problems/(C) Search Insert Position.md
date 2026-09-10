---
project: Google Interview Prep
difficulty: Easy
leetcode: 35
solved:
solve_time:
---

# (C) Search Insert Position — LC 35

## My approach
#### Default Binary Search algorithm
I apply the default binary search algorithm on a sorted array of integers `nums`. Return *l* instead of *r* as *l* points to the first value greater than `target.`

## Solution
```python
class Solution:
	def searchInsert(self, nums: List[int], target: int) -> int:
		l = 0
		r = len(nums) - 1
		while l <= r:
			m = (l + r)//2
			if nums[m] == target:
				return m
			elif nums[m] < target:
				l = m + 1
			else:
				r = m - 1
		return l 
```

## Complexity
**Time Complexity:** O(log(n))
**Space Complexity:** O(1)

## Master-check