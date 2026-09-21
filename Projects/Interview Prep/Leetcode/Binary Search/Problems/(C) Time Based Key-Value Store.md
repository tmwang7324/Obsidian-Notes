---
tags:
  - binary-search
  - medium
status: Not started
leetcode: 981
difficulty: Medium
companies:
  - Google
  - Apple
  - Netflix
  - Citadel
  - Uber
runtime_beats: 73.67%
memory_beats: 69.06%
solved_time: 45m+
---


# (C) Time Based Key-Value Store (M) — LC 981

## Problem
Design a time-based key-value store that can store multiple values for the same key at different timestamps and retrieve the value at a given timestamp (the value with the largest timestamp ≤ the given timestamp).

## Target complexity
O(log n) per get using binary search on timestamps (which are strictly increasing per key), O(1) per set. A linear scan per get would be O(n) per call.

## My approach
### Naive
When I first read the problem, I thought for sure that the optimal solution was to **keep track of data by pointing** `(key, timestamp)` to its specified `value.`
`entries: dict((key, timestamp)) -> value`

My reasoning was ensuring that `set()` operations with the same key, yet different `timestamp` and `value` are stored separately. ***For example:***
```python
set("foo", "bar", 1)
set("foo", "bar2", 3)
```
should both be recorded in my map.

To implement `get(self, key, timestamp),` retrieve all keys that have `key == key` and `timestamp <= timestamp.` **Maintain a polling `maximum_timestamp`** while iterating through. 
Return the `value` of `entries[(key, maximum_timestamp)]`

***Time Complexity*** of `get() becomes $O(n)$
`set()` still is $O(1)$






### Slightly improved
Now, for my implementation of `get,`I honestly thought I needed a **heap** at first, but this is unnecessary as the problem states ***All timestamps `timestamp` of `set` are strictly increasing.***
## Solution
```python

```

## Complexity
- **Time:** 
- **Space:**

## Master-check
Why is binary search valid here (timestamps are set in strictly increasing order), and what do you return when no timestamp ≤ the query exists?
