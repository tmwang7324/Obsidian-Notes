---
type: concept
aliases: ["Python Iteration Helpers", "zip", "enumerate"]
tags: [python, stdlib, iteration, builtins, concept]
updated: 2026-06-13
sources: 1
---

# Python Iteration Helpers

Two built-ins that replace hand-managed loops: **`zip`** (iterate several iterables in lockstep) and **`enumerate`** (iterate with the index alongside the value). Both are **lazy** (return one-pass iterators) and both kill a common LeetCode anti-pattern — manually indexing with `range(len(...))`.

## `zip` — iterate in lockstep

Pairs elements position-by-position, yielding tuples until the **shortest** iterable runs out.

```python
names = ["a", "b", "c"]
freqs = [5, 3, 8]
for name, freq in zip(names, freqs):
    print(name, freq)          # a 5 / b 3 / c 8
```

The four uses that recur in interviews:

```python
# 1. Build a dict from two lists (common right after a Counter)
dict(zip(names, freqs))        # {'a':5, 'b':3, 'c':8}

# 2. Unzip — same function with * splits pairs apart (yields tuples)
keys, vals = zip(*[('a',5), ('b',3)])   # ('a','b'), (5,3)

# 3. Adjacent-pair iteration (sliding window of 2)
for cur, nxt in zip(arr, arr[1:]):      # compare each to its next
    ...

# 4. Transpose a matrix / grid (columns of a grid)
list(zip(*[[1,2,3],[4,5,6]]))           # [(1,4),(2,5),(3,6)]
```

**Gotchas**
- Stops at the **shortest** iterable *silently* — mismatched lengths lose data with no error. Use `itertools.zip_longest` to pad instead.
- Yields **tuples**, not lists (matters when unzipping).
- One-pass iterator — consume it once; `list(...)` to materialize.

## `enumerate` — index + value together

```python
for i, word in enumerate(words):            # i = 0,1,2…  word = words[i]
    ...
for i, word in enumerate(words, start=1):   # start the count anywhere
    ...
```

**The anti-pattern it kills:** `for i in range(len(words)): word = words[i]`. If you need *both* position and item, reach for `enumerate`.

## Related

- [[(C) Python Dictionaries|Python Dictionaries]] — `dict(zip(keys, values))` is the canonical paired-iterable constructor.
- [[(C) Python Counter|Python Counter]] — frequency dict often feeds straight into `zip`/`dict`.
- Source: chat during [[(C) Google Interview Prep|Google Interview Prep]] array/hashmap/sliding-window calibration sweep (2026-06-13).
