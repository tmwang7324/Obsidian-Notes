# Overview
A priority queue is an Abstract Data Type (ADT) that operates similar to a normal queue except that **each element has a certain priority.** The priority of the elements in hte priority queue determine the order in which elements are removed from the priority queue.

***NOTE:*** Priority queues only support **comparable data,** meaning the data inserted into the priority queue must be able to be ordered in some way. If the data cannot be compared, then relative priorities cannot be assigned.


## When and Where are Priority Queues used
* Used in certain implementations of Dijkstra's Shortest Path algorithm.
* Anytime you need to dynamically fetch the **'next best'** or **'next worst'** element.
* Used in Huffman coding (which is often used for lossless data compression).
* Best First Search (BFS) algorithms such as A* use Priority Queues to continuously grab the next most promising node.
* Used by Minimum Spanning Tree (MST) algorithms.

## Complexity Priority Queue with Binary Heap

| Operation                                     | Time      |
| --------------------------------------------- | --------- |
| Binary Heap Construction                      | O(n)      |
| Polling                                       | O(log(n)) |
| Peeking                                       | O(1)      |
| Adding                                        | O(log(n)) |
| Naive Removing                                | O(n)      |
| Advanced removing with help from a hash table | O(log(n)) |
| Naive contains                                | O(n)      |
| Contains check with help of a hash table *    | O(1)      |
|                                               |           |
