---
type: concept
aliases: ["Stack & Monotonic Stack", "Stack", "Monotonic Stack"]
tags: [dsa, stack, monotonic-stack, python]
updated: 2026-06-19
sources: 1
---

# Stack & Monotonic Stack

A **stack** is a LIFO (last-in, first-out) list. In Python it's just a list — `append` to push, `pop()` to remove the top, `[-1]` to peek — all **O(1)**.

```python
stack = []
stack.append(x)      # push
top = stack[-1]      # peek
x = stack.pop()      # pop (LIFO)
```

## Monotonic stack

A **monotonic stack** keeps its contents in a strict order (increasing or decreasing) by **evicting elements that violate the order before pushing**. It's the go-to pattern for **"next greater / next smaller element"** problems — anything asking, for each item, about the nearest later element that beats it.

**The mechanic (decreasing stack, for "next greater element"):** for each incoming element, while it is **greater than** the element at the top, **pop** the top (the incoming element *is* that popped element's "next greater") — repeat until the top is larger or the stack is empty — then push the incoming element.

This visits each element at most twice (one push, one pop) → **O(n)** total, beating the O(n²) brute force of scanning forward from every index.

```python
# Daily Temperatures: days until a warmer temperature, for each day.
def dailyTemperatures(temps):
    res = [0] * len(temps)
    stack = []                          # holds indices; temps decreasing down the stack
    for i, t in enumerate(temps):
        while stack and t > temps[stack[-1]]:
            j = stack.pop()             # day i is the warmer day for day j
            res[j] = i - j
        stack.append(i)
    return res
```

> **The pattern signal:** when a problem asks for the *next* (or previous) greater/smaller element, or a span/distance to it, reach for a monotonic stack — push **indices** (not values) when you need distances. Pop direction (increasing vs decreasing) is set by whether you want next-greater or next-smaller.

## Related

- [[(C) Tree Traversal|Tree Traversal]] — iterative DFS uses an explicit stack for the same stack-unwinds-recursion reason.
- [[(C) Two Pointers|Two Pointers]] · [[(C) Heaps|Heaps]] — other NeetCode-150 pattern pages.

## Sources

- [[Stack Overview]] — LIFO API (Python + TypeScript) and the monotonic-stack eviction rule.
