---
type: concept
aliases: ["Python Counter", "collections.Counter"]
tags: [python, stdlib, data-structures, concept]
updated: 2026-06-02
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

## Related

- Source: `raw/notes/Counter.md`
