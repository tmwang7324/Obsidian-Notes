# My Approach
Use `Counter` to create a dictionary that contains all frequencies of words
Initialize empty heap using `heapq`: 
```python 
import heapq
res = []
heapq.heapify(res)
```
Convert the key-value pairs in my `Counter` map into tuples using zip: `zip(word_counts.values(), word_counts)`
***Note:*** Hash map key-value pairs cannot be heapified or pushed.

I specifically wanted **(frequency, word)** pairs because the way heaps sort tuples is first by the first tuple value, then if there's a tie, the second.
Furthermore, the frequency must be sorted descending while words ascending. The most frequent words are the words with the greatest frequency.

Stick with the tuple structure: (-frequency, word)
Push all (-frequency, word) tuples onto the heap using `heapq.heappush(res, (-frequency, word))`
Use `heapq.nsmallest(k, res)` to get k largest tuples and return only their second elements.
## Code
```python

import heapq
from collections import Counter
class Solution:
	def topKFrequent(self, words: List[str], k: int) -> List[str]:
		res = []
		heapq.heapify(res)
		word_count = Counter(words)
		for f, w in list(zip(word_count.values(), word_count)):
			heapq.heappush(res, (-f, w)) # O(n log n)
		return [t[1] for t in heapq.nsmallest(k, res)]
		
```
# Other Interesting Solutions
```python
import heapq
from collections import Counter
class Solution:
	def topKFrequent(self, words: List[str], k: int) -> List[str]:
		words.sort() # O (n log n)
		return [t[1] for t in Counter(words).most_common(k)]
	 
```

Heapifying the list with all tuples inside already. AND THEN JUST TAKING NSMALLEST.  ----> O(n log k)