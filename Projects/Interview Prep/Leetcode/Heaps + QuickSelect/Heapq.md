# Overview
A heap is a **tree** based data structure that satisfies the **heap invariant** (*aka heap property*). If A is a parent node of B, then A is ordered with respect to B in the same way for all nodes in the heap. 

So, if the heap is a min heap and A is the parent of B, A is less than B.
**![[Pasted image 20260821230154.png]]


See [[Heap queue or heapq in Python]]
**VERY IMPORTANT:** A heap is not a sorted list in Python. It just follows parent <= children. So, heap[-4, -2, -3, -1] is possible.
## Tuples
Tuples are sorted first based on their first element, then if there is a tie, their second element.

## Max Heap
```python
ele = 50
heap = []
heapq.heapify(heap)
heapq.heappush(heap,-ele)

```
# Strategies
1. Use `heapq.heapify()` if possible over lists instead of `heapq.heappush()`. 
	* Heapify -> O(2n) 
	* Heappush -> O(n log n)
2. Use `n_smallest` and `n_largest` for top K retrieval. Very time efficient O(log k).
3. Create a Max Heap by negating the values to be inputted into the heap.