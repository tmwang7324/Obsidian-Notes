---
project: Google Interview Prep
difficulty: Medium
leetcode: 15
solved: 2026-06-15
solve_time: 55m 4s
---
This question is a classic three pointer problem. 
# My Approach
First, I sorted the input array `nums`. This is essential because without sorting, the three pointer solution would not work. Furthermore, since the three pointer solution is $O(n^2)$, a $O(n  log n)$ operation is alright to use.

I wrote in my notebook: A hash table solution would be minimum O(n^2) because one must traverse the list an additional time before using the table to find the complement **(0 - nums[i] - nums[tj]).**

Much like [[Two Sum II]], our solution hinges on specific pointers moving when the sum of the numbers they point to is greater or less than **target = 0.**
Now, let's set *l* = 0,
```python
nums.sort()
res = []
l = 0
```
In our loop, we set *tj* = *l + 1*, and *r = len(nums)-1.* This is because we want *l* to traverse through `nums` left to right in entirety, while *tj* and *r* find the target. They reset everytime *l* increments.
```python 
while i < len(nums)-2: # stop at len(nums)-3 since tj and r cover the remaining 2 elements
	tj = l + 1
	r = len(nums)-1
```

**IMPORTANT:** Now, something very important to note here. We want *l* to skip over any duplicate element after the main logic of the loop has run. ***Why?***
Because the problem wants ***UNIQUE*** triplets. Since *tj* and *r* are finding every triplet that equals 0 that **starts with** *l*, all other triplets that start with *l* will be duplicates.

The logic to skip duplicates is very simple since `nums` is sorted. In fact, it's just setting a temporary variable to *l* and checking if any future *l* equals that temp.
```python
temp = nums[l]
```

For the main loop, I want to increment or decrement *tj* and *r* based on the sum `nums[l] + nums[tj] + nums[r]`. ***How Do I Do This?***
**Recall [[Two Sum II]]**: If the sum of the numbers the two pointers are pointing to is greater than **target,** then the answer is to decrement *r.* If the sum of the numbers is less than **target,** increment *l*.

**IMPORTANT:** Once again, I need to beware of duplicate triplets. If I found a triplet with *l*, *tj*, and *r*, and *tj* remains the same. Then, there will be a duplicate triplet.
**Solution?** Do the same thing as I did with *i*
Same reasoning here:
```python
	while tj < r:
		temp_tj = nums[tj]
		if nums[l] + nums[tj] + nums[r] < 0:
			tj += 1
		elif nums[l] + nums[tj] + nums[r] > 0:
			r -=1
		elif nums[l] + nums[tj] + nums[r] == 0:
			res.append([nums[l], nums[tj], nums[r]])
			while tj < r and nums[tj] == temp_tj:
				tj+=1
```

Increment *i*
```python
	while i < len(nums)-2 and nums[l] == temp:
		l+=1
return res
```

## Time Complexity - O(n^2)
Two loops: One for *l*, and one for *tj* + *r*

## Space Complexity - O(1) 
Pointer variables only.

**O(n^2) if including the output storage.**