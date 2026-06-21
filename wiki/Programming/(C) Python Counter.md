---
type: concept
aliases: ["Python Counter", "collections.Counter"]
tags: [python, stdlib, data-structures, concept]
updated: 2026-06-13
sources: 1
---

# Python Counter

`Counter` is a class in Python's `collections` module that counts how many times each item appears in an iterable and returns the counts as a dictionary-like object (it subclasses `dict`, mapping each element → its count).

```python
from collections import Counter

c = Counter("banana")          # Counter({'a': 3, 'n': 2, 'b': 1})
c = Counter(["a", "b", "a"])   # Counter({'a': 2, 'b': 1})
```

## Useful methods

- `c.most_common(n)` — the `n` highest-count items as `(item, count)` pairs.
- `c[item]` — the count of `item`; missing items return `0` (no `KeyError`).
- `c.update(iterable)` — add more counts; `c.subtract(iterable)` — remove counts.
- Supports arithmetic: `c1 + c2`, `c1 - c2`, `c1 & c2` (min), `c1 | c2` (max).

Handy for frequency analysis — word/character counts, tallying events, finding the most common element.

## Time & space complexity

For `n` items in the input iterable:

| Operation | Time | Space |
| --- | --- | --- |
| `Counter(nums)` (build) | O(n) | O(n) |
| `most_common()` (all, sorted) | O(n log n) | — |
| `most_common(1)` (just the top) | O(n) | — |
| `most_common(k)` | O(n log k) | — |

The full `most_common()` sorts every distinct key, so it costs O(n log n); asking for a fixed `k` uses a heap and drops to O(n log k), and the single most-common is a linear scan. This is the same trade-off that shows up in top-k-frequency problems — see also [[(C) Python Iteration Helpers|Python Iteration Helpers]].

## Related

- Source: `raw/notes/Counter.md`
