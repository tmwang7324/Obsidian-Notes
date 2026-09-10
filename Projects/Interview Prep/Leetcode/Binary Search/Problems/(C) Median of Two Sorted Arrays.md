---
project: Google Interview Prep
difficulty: Hard
leetcode: 4
solved: 2026-08-22
solve_time: 1hr+
---

# (C) Median of Two Sorted Arrays — LC 4

## My approach
#### Naive Solution
This approach involves merging the two sorted arrays iteratively, then finding the median of the merged array. The issue with it is that it costs O(m + n), not O(log(m + n)). Could be better!

***IMPORTANT:*** Here lies the realization that it is impossible (very difficult) to recreate a completely sorted array using binary search alone. The objective that leads to the optimal approach is partitioning both arrays into the elements that are less than the median and elements greater than the median. 

#### Dual Binary Search across both sorted arrays
I then tried to implement this strategy by running a binary search across both arrays under one iterative loop. My reasoning was to isolate the elements in each array that were obviously less than the elements in the other array. 

Once I identified partitions in both arrays whose lengths add up to half of the combined lengths of `nums1`and `nums2`, I knew that the median was either the greater final element of the two partitions (***if combined length is odd***), or the average of the minimum value of the elements outside of the partitions and the maximum value of the final element inside the partitions of `nums1` and `nums2` (***if combined length is even***).

This strategy may work, but it does not maintain that the partition is half the combined lengths of `nums1` and `nums2`
#### Single Binary Search + Smart Indexing
**IMPORTANT: Our main goal is to find an index *i* such that *nums1[:i] and nums2[:tj]* hold all of the elements less than the median.**

To fix this lack of consistent partition length, instead of running two dependent binary searches, run one binary search on the shorter array. The resulting `m` will be the hypothetical *i*. Now, update the partition index of the longer array using the formula: `tj = combined_len//2 - (mid + 1) - 1`. 
* `combined_len//2`  = half of the combined length
* `mid + 1` = length of the partition in the shorter array
* `-1` = account for 0-indexed

This ensures that `len(nums[:i]) + len(nums[:tj]) = half`

It is imperative that the binary search be run on the shorter array in order to simplify edge cases. So, switch `nums1` and `nums2` around if `len(nums2) < len(nums1)`

***MAIN CONDITION:*** The way to see if our index is correct is to compare the greatest element of the partition in `nums1`, `nums1[m]` with the least element outside of the partition in `nums2`, `nums2[tj+1].` If `nums1[m] > nums2[tj+1],` then `m` is too large, so set `r = m -1.`

Otherwise, if the greatest element within the partition of `nums2` is greater than the least element outside of the partition of `nums1,` then set `l = m + 1`  

## Solution
```python
class Solution:
	def findMedianSortedArrays(self, nums1: List[int], nums2[int]):
	
```

## Complexity

## Master-check
