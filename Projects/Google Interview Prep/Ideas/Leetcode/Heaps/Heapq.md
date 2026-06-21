See [[Heap queue or heapq in Python]]
**VERY IMPORTANT:** A heap is not a sorted list in Python. It just follows parent <= children. So, heap[-4, -2, -3, -1] is possible.

## Tuples
Tuples are sorted first based on their first element, then if there is a tie, their second element.
# Strategies
1. Use `heapq.heapify()` if possible over lists instead of `heapq.heappush()`. 
	* Heapify -> O(2n) 
	* Heappush -> O(n log n)
2. Use `n_smallest` and `n_largest` for top K retrieval. Very time efficient O(log k).
