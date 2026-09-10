---
project: Google Interview Prep
difficulty: Easy
leetcode: 278
solved:
solve_time:
---

# (C) First Bad Version — LC 278

## My approach

#### Array Traversal from Left to Right 
The naive approach to this question is to iterate through the array from left to right. The first element which causes `isBadVersion(ele) == true,` return that element's index.

The worst case runtime will be O(n).
#### Binary Search 
Since every subsequent product is **bad** after the first **bad product,** I can partition the array into separate parts with a simple condition.

***KEY CONDITION:*** If `isBadVersion(products[m]) == true` then I know that the first bad version is either before or at`m`. So, move `r = m -1`. Otherwise, I need to move `l = m + 1` to find where the bad version chain starts.

To* reduce the time complexity to O(log n), I implement the binary search over the 

## Solution
```python

```

## Complexity
* **Time Complexity:** O(log n)
* **Space Complexity:** O(1)
## Master-check
