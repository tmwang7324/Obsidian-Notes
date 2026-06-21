---
type: concept
aliases: ["Python List Methods"]
tags: [python, list, methods, dsa, reference]
updated: 2026-06-19
sources: 1
---

# Python List Methods

Quick-reference for the list mutators that show up constantly in interview code, with the complexity that matters when you reason about an algorithm's cost.

| Method | What it does | Time |
|---|---|---|
| `lst.append(x)` | Add a single element (which may itself be a list) to the end | **O(1)** amortized |
| `lst.extend(it)` | Append **each** element of any iterable individually | **O(k)** in the iterable's length |
| `lst.pop()` | Remove & return the last element (the stack pop) | **O(1)** |
| `lst.pop(i)` | Remove & return the element at index `i` | O(n) — shifts the tail |
| `lst.clear()` | Remove all elements | O(n) |

## The append-vs-extend gotcha

The distinction that trips people up:

```python
a = [1, 2]
a.append([3, 4])   # → [1, 2, [3, 4]]   (one nested element)
a = [1, 2]
a.extend([3, 4])   # → [1, 2, 3, 4]     (flattened in)
```

`append` adds its argument as **one** element; `extend` iterates the argument and adds each item. `extend` accepts any iterable, not just a list.

## Related

- [[(C) Python Dictionaries|Python Dictionaries]] · [[(C) Python Counter|Python Counter]] · [[(C) Python Iteration Helpers|Python Iteration Helpers]]
- `pop()`/`append()` are the stack primitives — see [[(C) Stack and Monotonic Stack|Stack & Monotonic Stack]].

## Sources

- [[Very Important Methods]] — list-method cheat sheet (extend/append/clear/pop).
