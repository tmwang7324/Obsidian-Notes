---
type: concept
aliases: ["Heaps", "heapq", "Heap"]
tags: [dsa, heap, heapq, priority-queue, top-k, python]
updated: 2026-06-19
sources: 3
---

# Heaps

A **heap** is a binary tree that maintains the **heap invariant** — every parent compares ≤ (min-heap) or ≥ (max-heap) its children — so the extreme element is always at the root and retrievable in O(1). Python's `heapq` is a **min-heap** implemented on a plain `list`, with the root at index 0. The interview value is **top-K / k-th-element** problems and anything needing a running min/max.

## The one misconception to kill

> **A heap is NOT a sorted list.** It only guarantees `parent <= children`. Siblings have no order.

So `heap = [-4, -2, -3, -1]` is a perfectly valid min-heap: `-4` is the root (smallest), and `-2`/`-3`/`-1` need no order among themselves. Reading the list left-to-right tells you nothing about sorted order — only `heap[0]` is meaningful without popping.

## How tuples order in a heap

`heapq` compares tuples **lexicographically: first element, then the second on a tie, then the third, …** — same as Python's default tuple comparison. This is the lever behind most heap problems:

- Push `(priority, payload)` and the heap orders by `priority`, breaking ties by `payload`.
- **The negate trick** — a min-heap becomes a max-heap by negating the sort key. To rank words by **descending frequency** while keeping **ascending alphabetical** tiebreaks, push `(-frequency, word)`: `-frequency` makes the most frequent sort *smallest* (so it's the min-heap's root), and `word` stays positive so ties resolve A→Z. (See [[(C) Python Counter|Counter]] for producing the frequencies.)

## Core API & complexity

| Operation | Cost | Note |
|---|---|---|
| `heapq.heapify(lst)` | **O(n)** | In-place; turns any list into a heap. Prefer this over pushing one-by-one. |
| `heapq.heappush(h, x)` | O(log n) | n pushes in a loop ⇒ **O(n log n)** total. |
| `heapq.heappop(h)` | O(log n) | Pops the smallest (root). |
| `heapq.nsmallest(k, h)` / `nlargest(k, h)` | **O(n log k)** | The top-K workhorse — far better than sorting when `k ≪ n`. |

**Rule of thumb:** if you can build the data all at once, `heapify` (O(n)) beats a push-loop (O(n log n)). For "top K of n", `nsmallest`/`nlargest` (O(n log k)) beats a full sort (O(n log n)).

## Pattern: Top K Frequent

The canonical heap drill — count frequencies, then extract the K extremes.

**Top K Frequent Elements** — when you only need the K most common and order among them doesn't matter, skip the heap entirely:

```python
from collections import Counter
def topKFrequent(nums, k):
    return [v for v, _ in Counter(nums).most_common(k)]   # most_common(k) → O(n log k)
```

**Top K Frequent Words** — needs the tuple trick because ties break **alphabetically**:

```python
import heapq
from collections import Counter
def topKFrequent(words, k):
    counts = Counter(words)
    heap = [(-f, w) for w, f in counts.items()]   # negate freq; word ascending on ties
    heapq.heapify(heap)                            # O(n)
    return [w for _, w in heapq.nsmallest(k, heap)]  # O(n log k)
```

**Three ways, three complexities** (worth being able to recite in an interview):

| Approach | Complexity |
|---|---|
| `heappush` each tuple in a loop, then pop k | O(n log n) |
| `heapify` the full list + `nsmallest(k, …)` | **O(n log k)** ✅ |
| `words.sort()` + `Counter(...).most_common(k)` | O(n log n) |

The `heapify` + `nsmallest` path wins whenever `k ≪ n`.

## Related

- [[(C) Python Counter|Python Counter]] — produces the frequency map these patterns consume.
- [[(C) Python Dictionaries|Python Dictionaries]] · [[(C) Dynamic Programming|Dynamic Programming]] · [[(C) Trie|Trie]]

## Sources

- [[Heapq|Heaps/Heapq]] — heap-is-not-sorted, tuple ordering, heapify-vs-heappush, nsmallest strategy.
- [[Top K Frequent Words]] — the `(-frequency, word)` negate trick + `nsmallest` solution and complexity comparison.
- [[Top K Frequent Elements]] — the `Counter.most_common(k)` shortcut.
