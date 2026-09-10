---
project: Google Interview Prep
difficulty: Hard
leetcode: 295
solved: 2026-08-24
solve_time: 45m
---

# (C) Find Median from Data Stream — LC 295

Two-heap pattern. Google high frequency.

## My approach

#### Naive Sorted List
I first recognized that the naive approach was to create and update an instance variable `stream_list`. Upon every `findMedian()` call, sort the list and find the median using indicies. If the total length of `stream_list` is even, find the average of the two values in the middle, else return `stream_list[len(stream_list)//2]`

#### Two Heap
I took some inspiration from [(C) Median of Two Sorted Arrays] to come up with maintaining two partitions of the data stream.

* ****Left Partition*:** All elements less than median
* ****Right Partition***: All elements greater than or equal to median

To ensure the correct transfer of data points between the two partitions, it's essential to get the heap configuration correct:
* **Min heap** for right partition
* **Max heap** for left partition.

## Solution
```python

```

## Complexity

## Master-check
