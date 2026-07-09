In Python, a queue is a linear data structure that follows the **First-In, First-Out (FIFO)** principle. This means that the first element added is the first one removed.

There are three ways to implement a queue:
# For General Performance (Single Threaded): 
`collections.deque`
The double-ended queue object from the built-in **collections module** is the most efficient choice for a standard, single-threaded queue. It provides fast O(1) time complexity for both insertions and deletions.
