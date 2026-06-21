---
type: concept
aliases: ["Tree Traversal", "Preorder", "Inorder", "Postorder", "BFS Level Order"]
tags: [dsa, trees, traversal, dfs, bfs, python]
updated: 2026-06-19
sources: 5
---

# Tree Traversal

The four core ways to visit every node of a binary tree, all **O(n)** time. Three are depth-first (DFS) and differ only in **when the root is processed relative to its subtrees**; the fourth is breadth-first (BFS), level by level. Recognizing which order a problem wants is the whole game.

## The three DFS orders

The name says **where the root is visited** in the recursion:

| Order | Visit sequence | Use it for |
|---|---|---|
| **Preorder** | **Root → Left → Right** | Copying/serializing a tree; evaluating **prefix** expressions |
| **Inorder** | **Left → Root → Right** | A **BST** — yields nodes in **ascending sorted order** |
| **Postorder** | **Left → Right → Root** | **Bottom-up** tasks: deleting a tree, directory sizes, **reverse Polish** evaluation |

The recursive form is three lines — only the position of the "visit" line moves:

```python
def inorder(root):
    if not root:
        return
    inorder(root.left)
    print(root.val)        # preorder: before the recursions; postorder: after both
    inorder(root.right)
```

> **The one fact to anchor:** **inorder on a BST = sorted ascending.** This is the single most-tested traversal property.

## Iterative DFS (the non-obvious part)

Recursive DFS is the interview default; iterative matters when recursion depth could blow the stack (very deep/degenerate trees). 

**Iterative preorder** is easy — a stack, push **right before left** so left pops first:

```python
def iterative_preorder(root):
    if not root: return []
    stack, res = [root], []
    while stack:
        node = stack.pop()
        if node.right: stack.append(node.right)
        if node.left:  stack.append(node.left)
        res.append(node.val)
    return res
```

**Iterative inorder / postorder** are the hard ones. The clean pattern is the **"dive" approach**: walk all the way down the left spine pushing as you go, then pop and turn right.

```python
def iterative_inorder(root):           # Left → Root → Right
    stack, res, curr = [], [], root
    while stack or curr:
        while curr:                    # dive down the left spine
            stack.append(curr)
            curr = curr.left
        node = stack.pop()             # leftmost unvisited
        res.append(node.val)
        curr = node.right              # then go right
    return res
```

**Postorder iteratively** needs a `last_visited` pointer so you only pop a parent once **both** its children are done — peek the top, and if it has no right child or its right child was just visited, pop it; otherwise dive into the right subtree:

```python
def iterative_postorder(root):         # Left → Right → Root
    if not root: return []
    stack, res, curr = [root], [], root
    last_visited = root
    while stack:
        while curr.left:               # dive left
            curr = curr.left
            stack.append(curr)
        peek = stack[-1]
        if not peek.right or last_visited == peek.right:
            last_visited = stack.pop()
            res.append(last_visited.val)
        else:
            curr = peek.right
            stack.append(curr)
    return res
```

> **Takeaway from the working notes:** the naive "count children to know when to pop the parent" attempts break because a plain stack drains the original nodes before the deferred parents, scrambling the order. The `last_visited` sentinel (postorder) and the left-spine dive (inorder) are what actually make it correct — recognize them rather than re-deriving from scratch under pressure.

## BFS — level-order traversal

Top-to-bottom, one layer at a time, with a **queue** (`collections.deque`). The key trick: **snapshot `len(queue)` at the start of each level** so you process exactly the current layer before its children.

```python
from collections import deque
def bfs_level_order(root):
    if not root: return []
    queue, res = deque([root]), []
    while queue:
        level = []
        for _ in range(len(queue)):          # exactly this layer
            node = queue.popleft()
            if node.left:  queue.append(node.left)
            if node.right: queue.append(node.right)
            level.append(node.val)
        res.append(level)
    return res
```

BFS is the tool for **level-grouped** answers (per-level lists, right-side view, min-depth, zigzag) — anything where "which layer" matters.

## Related

- [[(C) Heaps|Heaps]] — also a binary tree, but ordered by the heap invariant, not traversal order.
- [[(C) Dynamic Programming|Dynamic Programming]] — tree recursion (post-order "solve children, combine at parent") is the on-ramp to the recursion→memo→table DP pipeline.

## Sources

- [[Traversal Algorithms]] — index of the four patterns and their use-cases.
- [[Preorder]] · [[Inorder]] · [[Postorder]] — recursive + iterative-dive write-ups (postorder includes the broken attempts and why `last_visited` is needed).
- [[Breadth First Search Level]] — BFS level-order with per-layer `len(queue)` counting.
