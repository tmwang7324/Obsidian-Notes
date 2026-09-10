---
tags: [linked-list, medium]
status: Not started
leetcode: 146
difficulty: Medium
solved:
---

# (C) LRU Cache (M) — LC 146

Design a data structure that supports `get(key)` and `put(key, value)` in **O(1)** time, evicting
the least-recently-used entry when capacity is exceeded. Constraints: `capacity ≥ 1`,
`key, value ≤ 10⁵`, at most `2 × 10⁵` calls.

## Target complexity
Every `get` and `put` must be **O(1)**. That immediately rules out any data structure that
requires scanning (array, single linked list without a pointer map). You need O(1) lookup **and**
O(1) reordering of recency — two things, so two structures working together.

## My approach
_Re-derive the pattern here before re-reading the solution._



## Reasoning to the approach
Two requirements drive the design:

1. **O(1) key lookup** → hashmap.
2. **O(1) insert / remove / reorder by recency** → doubly linked list (singly linked can't
   unlink a node without walking from the head to find its predecessor).

Combine them: the **hashmap** maps `key → Node`, and the **doubly linked list** tracks recency
order. Most-recently-used sits right after a dummy `head`; least-recently-used sits right before
a dummy `tail`.

- **`get(key)`** — look up the node in the hashmap. Unlink it from its current position and
  re-insert it right after `head`. Return the value.
- **`put(key, value)`** — if the key exists, update and move to head. If new, create a node,
  insert after head, add to hashmap. If over capacity, remove the node before `tail` (the LRU)
  and delete its hashmap entry.

The dummy `head`/`tail` sentinels eliminate null-checks — every real node always has two valid
neighbors.

## Naive solution — and why it fails
Use an `OrderedDict` or a plain list to track access order:

```python

```

**Why it fails:** `list.remove(key)` is **O(n)** — it scans the list to find and unlink the
element. With `2 × 10⁵` calls, this degrades to **O(n)** per operation. The insight it misses:
a doubly linked list can remove a node in O(1) **if you already have a pointer to it** — and the
hashmap gives you that pointer.

*(Python's `OrderedDict` is a valid shortcut — `move_to_end` and `popitem` are O(1) internally
because it uses a doubly linked list under the hood — but interviewers typically want you to
build the machinery yourself.)*

## Common pitfalls

**1. Node doesn't store its key → can't evict from the hashmap.**
When you evict the LRU node from the tail of the list, you need to `del cache[key]`. If the node
only stores `val`, you'd have to scan the entire hashmap to find which key maps to that node.
**Fix:** store both `key` and `val` in every node.

**2. Forgetting to update an existing key in `put`.**
```python

```
If `key` already exists, you must **remove the old node** first, or you'll have two nodes for the
same key and the capacity count breaks. Always check `if key in self.cache` and unlink before
inserting.

**3. Off-by-one on capacity check.**
Insert first, *then* check `len(self.cache) > self.cap` and evict. Checking before inserting
means you evict prematurely when at exactly capacity.

## Optimal solution
```python

```

Every `get` and `put` does a constant number of hashmap lookups and pointer swaps. The sentinels
mean `_remove` and `_insert_after_head` never branch on null — they always work.

## Complexity
- **Time:** O(1) per `get` and `put` — hashmap lookup + constant pointer operations.
- **Space:** O(capacity) — one hashmap entry and one doubly linked list node per cached key.

## Master-check
Why does the node need to store its own `key` — what breaks if it only stores `val`? Walk through
the four-pointer update in `_insert_after_head` and explain why the order matters.
