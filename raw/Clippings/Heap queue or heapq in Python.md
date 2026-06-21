---
title: "Heap queue or heapq in Python"
source: "https://www.geeksforgeeks.org/python/heap-queue-or-heapq-in-python/"
author:
  - "[[GeeksforGeeks]]"
published: 2016-09-27
created: 2026-06-13
description: "Your All-in-One Learning Portal: GeeksforGeeks is a comprehensive educational platform that empowers learners across domains-spanning computer science and programming, school education, upskilling, commerce, software tools, competitive exams, and more."
tags:
  - "clippings"
---
A heap queue (also called a priority queue) is a data structure that allows quick access to the smallest (min-heap) or largest (max-heap) element.

- By default, heaps are implemented as min-heaps.
- Smallest element is always at the root and largest element is located among the leaf nodes of the heap.
- Python provides a built-in module called heapq that allows to create and work with heap queues

****Example:**** Converting a normal list into a heap using heapify().
```python
import heapq

li = [25, 20, 15, 30, 40]
heapq.heapify(li)
print("Heap queue:", li)
```
**Output**
```
Heap queue: [15, 20, 25, 30, 40]
```

****Explanation:**** heapq.heapify(li) rearranges the list into a heap where the smallest element is at the root. It does not fully sort the list.

> ****Note:**** The output above is *coincidentally* fully sorted — a sorted ascending list also happens to satisfy the min-heap property. heapify only guarantees the heap property (every parent ≤ its children), **not** a sorted order. The next example makes this obvious.

****Example:**** A heapify() call whose result is a valid heap but is **not** fully sorted.
```python
import heapq

li = [10, 30, 15, 40, 20]
heapq.heapify(li)
print("Heap queue:", li)
```
**Output**
```
Heap queue: [10, 20, 15, 40, 30]
```

****Explanation:**** The result is a valid min-heap — parent `10` ≤ its children `20` and `15`, and parent `20` ≤ its children `40` and `30` — yet the list is clearly not sorted (`15` comes after `20`). This is what "DOES NOT SORT ENTIRE LIST" means: heapify only enforces the parent-child ordering, not a global sort.

## Why do we need Heap queue?

1. Provides an efficient way to implement priority queues and maintain elements in heap order with minimal code and high performance.
2. Useful in algorithms like Dijkstra's, Huffman encoding or any task requiring quick access to smallest element.
3. Ideal for managing sorted data dynamically without full sorting after each operation.

## Key Operations of a Heap

Heaps support several essential operations that help manage data efficiently while maintaining heap property.

| Operation    | Function            | Description                                                                 | Time Complexity |
| ------------ | ------------------- | --------------------------------------------------------------------------- | --------------- |
| Create       | heapq.heapify()     | Converts a regular list into a valid min-heap **DOES NOT SORT ENTIRE LIST** | O(n)            |
| Push         | heapq.heappush()    | Adds a new element to the heap while maintaining the heap property          | O(log n)        |
| Pop          | heapq.heappop()     | Removes and returns the smallest element from the heap                      | O(log n)        |
| Peek         | heap\[0\]           | Accesses the smallest element without removing it                           | O(1)            |
| Push and Pop | heapq.heappushpop() | Pushes a new element and removes the smallest element in one step           | O(log n)        |
| Replace      | heapq.heapreplace() | Removes the smallest element and inserts a new element in one operation     | O(log n)        |

## Using Heap as a Max-Heap

By default, Python's heapq implements a min-heap. To create a max-heap simply invert the values (store negative numbers).

****Example:**** Below example, convert a list into a max-heap by storing negative numbers and then retrieve the largest element:
```python
import heapq

li = [20, 15, 30, 40, 25]
li = [-x for x in li]      # invert values to simulate a max-heap
heapq.heapify(li)
print("Largest element:", -li[0])
```
**Output**
```
Largest element: 40
```

****Explanation:**** We store negative values so that the smallest (negative largest) is treated as root. When retrieving values, we multiply by -1 again to restore the original numbers.

## Appending and Popping Elements

Elements can be inserted and removed while maintaining the heap property:

- [heapq.heappush(heap, item)](https://www.geeksforgeeks.org/python/python-heapq-heappush-method/) adds a new element to the heap.
- [heapq.heappop(heap)](https://www.geeksforgeeks.org/python/python-heapq-heappop-method/) removes and returns the smallest element.

****Example:**** This code demonstrates how to create a heap, append an element and remove the smallest element.
```python
import heapq

h = [10, 20, 15, 30, 40]
heapq.heapify(h)
heapq.heappush(h, 5)
print(h)
print("Smallest:", heapq.heappop(h))
print(h)
```
**Output**
```
[5, 20, 10, 30, 40, 15]
Smallest: 5
[10, 20, 15, 30, 40]
```

****Explanation:****

- heapq.heapify(h) converts the list into a valid min-heap.
- heappush(h, 5) inserts 5 into the heap and reorders it so the smallest element (5) becomes the root.
- heappop(h) removes the smallest element (5) and returns it.
- After popping, next smallest element (10) takes the root position.

### Appending and Popping Simultaneously

[heapq.heappushpop()](https://www.geeksforgeeks.org/python/python-heapq-heappushpop-method/) pushes a new element onto the heap and removes the smallest element in a single operation.

****Example:**** Pushes 5 onto the heap and pops the smallest element in a single step using heappushpop().
```python
import heapq

h = [10, 20, 15, 30, 40]
heapq.heapify(h)
print(heapq.heappushpop(h, 5))
print(h)
```
**Output**
```
5
[10, 20, 15, 30, 40]
```

****Explanation:**** heappushpop(h, 5) first pushes 5 into the heap and immediately pops the smallest element (which is also 5).

## Finding Largest and Smallest Elements

[heapq.nlargest()](https://www.geeksforgeeks.org/python/python-heapq-nlargest-method/) and [heapq.nsmallest()](https://www.geeksforgeeks.org/python/python-heapq-nsmallest-method/) return the required number of largest or smallest elements from an iterable.

****Example:**** Finding the 3 largest and 3 smallest elements using nlargest() and nsmallest()
```python
import heapq

li = [10, 20, 15, 30, 40]
print("3 largest elements:", heapq.nlargest(3, li))
print("3 smallest elements:", heapq.nsmallest(3, li))
```
**Output**
```
3 largest elements: [40, 30, 20]
3 smallest elements: [10, 15, 20]
```

> ****Note:**** The heapq module allows in-place heap operations on lists, making it an efficient and simple way to implement priority queues and similar structures.

## Replace and Merge Operations

[heapq.heapreplace()](https://www.geeksforgeeks.org/python/python-heapq-heapreplace-method/) removes the smallest element and inserts a new one in a single step, returning the removed value. While, [heapq.merge()](https://www.geeksforgeeks.org/python/python-heapq-merge-method/) combines multiple sorted iterables into a single sorted sequence.

****Example:**** This example replaces the smallest element in a heap and then merges it with another sorted list.
```python
import heapq

h = [10, 20, 15, 30, 40]
heapq.heapify(h)

print(heapq.heapreplace(h, 5))   # returns and prints the removed smallest (10)
print(h)
# merge() requires sorted inputs, so sort the heap's contents first
merged = list(heapq.merge(sorted(h), [2, 4, 6, 8]))
print("Merged heap:", merged)
```
**Output**
```
10
[5, 20, 15, 30, 40]
Merged heap: [2, 4, 5, 6, 8, 15, 20, 30, 40]
```

****Explanation:****

- heapreplace() replaces the smallest element (10) with 5 and smallest element is popped and 5 is inserted into the heap.
- heapq.merge() merges sorted iterables into a single sorted sequence, maintaining the heap property. Inputs must be sorted.

### Difference between heapreplace() and heappushpop()

1. ****heapreplace()**** always pops smallest element and then pushes a new one whereas, ****heappushpop()**** pushes new element first, then pops smallest.
2. Use ****heapreplace()**** when you want the new element to be in the heap and ****heappushpop()**** when new element may or may not stay (depending on comparison).

## Advantages vs Disadvantages

| Advantages | Disadvantages |
| --- | --- |
| Fast for insertion and removal with priority. | Not suitable for complex data manipulations |
| Uses less memory than some other data types. | No direct access to middle items. |
| Simple to use with the heapq module. | Can’t fully sort the items automatically. |
| Works in many cases like heaps and priority queues. | Not safe with multiple threads at the same time. |

11 Questions

- A
- B
- C
- D

- A
- B
- C
- D

- A
- B
- C
- D

- A
- B
- C
- D

- A
- B
- C
- D

- A
- B
- C
- D

- A
- B
- C
- D

- A
- B
- C
- D

- A
- B
- C
- D

- A
- B
- C
- D

What will be the output of the following code?

- A
- B
- C
- D

![success](https://media.geeksforgeeks.org/auth-dashboard-uploads/sucess-img.png)

Quiz Completed Successfully

Your Score:0/11

Accuracy:0%

Article Tags:

[Python](https://www.geeksforgeeks.org/category/programming-language/python/)