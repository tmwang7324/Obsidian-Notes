---
tags: [sliding-window, medium]
status: Not started
backlog: "[[(C) Warmup - Sliding Window]]"
leetcode: 424
---

# (C) Longest Repeating Character Replacement (M) — LC 424

## Problem
Longest substring of a single repeating character achievable after replacing at most `k` characters.

## My approach
_Narrate the window's expand/shrink condition out loud before coding, then write it here._

#### Naive Duplicate Count 
My approach first was to use a sliding window approach to expand the window only if the current character was a duplicate of the first character or if I encountered a non-duplicate, k > 0. If k == 0, then move *l* to the first encountered non-duplicate character. However, this approach could not gracefully recalculate the state of the window when *l* points to a different character. (**Hold this thought**)

#### Character Counts
Then, came the realization to keep track of the most frequent character in the window. This led to two approaches:

1. Decrementing k everytime a character that was not the most frequent was found
2. Comparing the window length against the greatest character frequency + k



## Solution
```python
class Solution:
	def longestRepeatingSubstring(self, s: str):
		def get_idx(c: str):
			return ord(c) - ord('A')
		char_freq = [0] * 26
		max_freq, l, longest_substr = 0, 0, 0
		for r in range(len(s)):
			idx = get_idx(s[r])
			char_freq[idx] +=1
			max_freq = max(max_freq, char_freq[idx])
			while (r - l + 1) > max_freq + k:
				l += 1
				char_freq[get_ids[l])]-=1
			longest_substr = max(r - l + 1, longest_substr)
		return longest_substr
```

## Complexity
- **Time:** O(n) only one pass through the array.
- **Space:** O(1) - array of 26 integers + 2 pointers 

## Master-check
- Can you state the window-valid condition (window length − count of most-frequent char ≤ k) before coding?

Window length (*r - l + 1*) must be greater than k + max_freq for *l* to start moving. When this condition occurs, it means that the substring has 1 character that cannot be converted into the dominant character of that substring.
