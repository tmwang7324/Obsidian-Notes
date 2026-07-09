---
project: Google Interview Prep
difficulty: Medium
leetcode: 739
solved: 2026-06-13
solve_time: ~50m
---

# My Approach 
Decreasing monotonic stack that records the indices of each element in the `temperatures` list.
At first, I thought I was supposed to treat `temperatures` as a stack since a reverse traversal of `temperatures` appealed to me as the easiest way to solve this problem. I hoped this approach would simplify the logic to handling days with temperatures greater than future days. However, it actually requires more complexity than incrementing traversal.

First, I have to create an array to store *the number of days I have to wait after the i-th day to get a warmer temperature.* Furthermore, I need to initialize my stack. Since I will be checking the top of the stack every iteration, I need to add its first element before I start the loop.
**IMPORTANT:** My stack will record both the temperature of the selected day, and its index in `temperatures` in tuples.
```python
res = [0] * len(temperatures)
stack = [(temperatures[-1], len(temperatures)-1)]

```
Next, construct the decrementing loop and implement the key logic: **While the last added element of the stack is less than or equal to the current day's temperature** (when a future day has a lower temperature than the current day), **pop the element from the stack.** 
This ensures that if current day that has a higher temperature than the next few future days, but there exists a future day with a higher temperature, then that future day can be accessed.
```python
for i in range(len(temperatures)-1, -1, -1):
	while temperatures[i] >= stack[-1][0]:
		stack.pop()
```
On the other hand, if the current day's temperature is less than the top of the stack, then that means the day represented by the top of the stack is the future day one must wait to get a warmer temperature. Thus, its time to calculate number of days in between these two days. I can do this by:
```python
if stack and temperatures[i] < stack[-1][0]:
	res = stack[-1][1] - i
```
**IMPORTANT:** I needed to make sure that I check if stack is empty before I make this comparison. This is because the scenario where every future day colder than or as warm as the current day can occur, which results in an empty stack after the while loop I described previously. 

Finally, append each current day's temperature and index into the stack liek this:
```python
stack.append((temperatures[i], i))
```

**Complete Solution:**
```python
class Solution:
	def dailyTemperatures(self, temperatures: List[int]) -> List[int]:
		res = [0] * len(temperatures)
		stack = [(temperatures[-1], len(temperatures)-1)]
		for i in range(len(temperatures)-1, -1, -1):
			while temperatures[i] >= stack[-1][0]:
				stack.pop()
			if stack and temperatures[i] < stack[-1][0]:
				res = stack[-1][1] - i
			stack.append((temperatures[i], i))
		return res
		
```



# Official Solution
Strictly increasing monotonic stack that records the indices of each element in the `temperatures` list.
If 