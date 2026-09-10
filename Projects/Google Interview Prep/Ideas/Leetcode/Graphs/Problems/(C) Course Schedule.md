---
tags: [graphs, medium]
status: Not started
leetcode: 207
difficulty: Medium
solved:
---

# (C) Course Schedule (M) — LC 207

Given `numCourses` and `prerequisites` where `[a, b]` means "take `b` before `a`", return
whether you can finish all courses. Constraints: `numCourses ≤ 2000`, `prerequisites.length ≤ 5000`.

## Target complexity
`V ≤ 2000` nodes, `E ≤ 5000` edges. The real question is **"does this directed dependency
graph contain a cycle?"** — a cycle means two courses each wait on the other. A cycle check
touches each node and edge a constant number of times → **O(V + E)**. Re-exploring shared
prerequisite chains is the trap.

## My approach
_Re-derive the pattern here before re-reading the solution._



## Reasoning to the approach
Each course = node; each prerequisite `[a, b]` = directed edge `b → a` ("b unlocks a"). You can
finish all courses **iff the graph is a DAG** (no cycle).

Naive instinct: for each course, chase its prerequisites down and see if you loop back. Works,
but re-walks the same deep chains once per starting course. Insight: a node's cycle-status is a
property of the node, not of who asked — so **mark nodes as you resolve them** and never re-walk
a finished node. Two standard implementations:

- **DFS with 3 colors** (white = unvisited, gray = on current recursion path, black = fully
  done). A cycle is exactly "an edge into a gray node."
- **Kahn's algorithm (BFS topo sort)**: repeatedly remove in-degree-0 nodes; if you can't remove
  all of them, a cycle remains.

## Naive solution — and why it fails
For each course, DFS the prerequisite chain looking for a return to the start, with **no memory**
of chains already proven safe:

```python
def canFinish(numCourses, prerequisites):
    graph = {i: [] for i in range(numCourses)}
    for a, b in prerequisites:
        graph[b].append(a)          # b -> a

    def leads_back(node, target, path):
        for nxt in graph[node]:
            if nxt == target:
                return True          # cycle back to target
            if nxt not in path:
                path.add(nxt)
                if leads_back(nxt, target, path):
                    return True
        return False

    for course in range(numCourses):
        if leads_back(course, course, {course}):
            return False
    return True
```

**Why it fails:** restarts the traversal from all `V` courses, re-exploring shared sub-chains.
Degrades toward **O(V · (V + E))** ≈ 2000 × 7000 in the mild case, and toward exponential on
adversarial branching depth. It throws away the key fact — **a node proven acyclic once is
acyclic forever** — and pays for it repeatedly.

## Common pitfalls

**1. One `visited` set instead of two states → false cycle.**
```python
# WRONG
visited = set()
def dfs(node):
    if node in visited:
        return False          # treats a legit re-visit as a cycle
    visited.add(node)
    ...
```
On a diamond `0→1, 0→2, 1→3, 2→3` (no cycle), node `3` is reached twice legitimately and this
reports a cycle. **Fix:** distinguish *"on current path"* (gray) from *"finished, safe"* (black).
Only re-hitting **gray** is a cycle; re-hitting **black** is fine — skip it.

**2. Edge direction backwards.** `[a, b]` means `b` before `a` → edge `b → a`. Writing
`graph[a].append(b)` still detects cycles (reversed cycle is a cycle), but breaks Course
Schedule II (order comes out reversed). Lock the direction now.

**3. Forgetting disconnected components.** Prereq graph is usually a forest — DFS from **every**
unvisited course, not just course 0, or you miss cycles in unentered components.

## Optimal solution
Build adjacency (`b → a`). State per node `{0: white, 1: gray, 2: black}`. DFS each white node;
cycle = edge into a **gray** node. After a subtree is clean, paint the node **black** so no
future DFS re-walks it.

```python
def canFinish(numCourses, prerequisites):
    graph = {i: [] for i in range(numCourses)}
    for a, b in prerequisites:
        graph[b].append(a)                  # b must come before a

    state = [0] * numCourses                 # 0=white, 1=gray, 2=black

    def dfs(node):
        if state[node] == 1:                 # back-edge to current path -> cycle
            return False
        if state[node] == 2:                 # already proven acyclic -> skip
            return True
        state[node] = 1                      # gray: on current path
        for nxt in graph[node]:
            if not dfs(nxt):
                return False
        state[node] = 2                      # done: safe, paint black
        return True

    return all(dfs(c) for c in range(numCourses))
```

Each node goes white → gray → black once, each edge examined once (black nodes short-circuit).
The `state` array is the memory the naive version lacked.

*Kahn's alternative (BFS):* compute in-degrees, queue all in-degree-0 nodes, pop and decrement
neighbors, count pops. If count `< numCourses`, a cycle remains → `False`. Same O(V+E), no
recursion-depth risk.

## Complexity
- **Time:** O(V + E) — every node painted once, every edge traversed once; black nodes short-circuit.
- **Space:** O(V + E) — adjacency list, plus O(V) state and up to O(V) recursion stack.

## Master-check
Why does a **single** `visited` set give false positives on a DAG, but three states
(white/gray/black) do not — what exactly does "gray" encode that "visited" cannot?
