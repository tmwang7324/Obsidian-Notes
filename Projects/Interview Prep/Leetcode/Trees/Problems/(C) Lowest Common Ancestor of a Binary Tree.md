---
project: Google Interview Prep
difficulty: Medium
leetcode: 236
solved:
solve_time:
runtime_beats:
memory_beats:
---

# (C) Lowest Common Ancestor of a Binary Tree — LC 236

## Problem
Given a **binary tree** (no BST ordering) and two nodes `p` and `q`, return their lowest common ancestor — the deepest node that has both `p` and `q` as descendants (a node can be a descendant of itself). Both `p` and `q` are guaranteed to exist in the tree.

## Key insight
_Contrast with [[(C) Lowest Common Ancestor of a BST|LC 235]]: with no ordering, you can't walk down by comparing values — you must actually search the subtrees. Think about what each recursive call should report back to its parent._
- What should a node return if it finds `p` or `q` in its **left** subtree, its **right** subtree, or **neither**?
- What's true about a node when both subtrees come back non-null?

## Complexity
- Target Time: O(n) — you may have to visit every node.
- Target Space: O(h) — recursion stack, `h` = tree height.

## My approach
_TODO: write up the post-order recursion — what each call returns and why the first node to see `p` and `q` split across its two subtrees is the LCA._

**IMPORTANT:** If I want to propagate a static value such as a found node, make sure I set the boolean I return to be the opposite of what I am checking.



## Solution
### Post-order, return-the-node approach
```python
def lowestCommonAncestor(self, root: TreeNode, p: TreeNode, q: TreeNode):
    # Unlike the BST invariant, need to search the entire tree for p and q.
    # Propagate a found node upward: if both subtrees return non-None, this
    # node is the split point (the LCA). Otherwise bubble up whichever side found something.
    if not root:
        return None

    node_left = self.lowestCommonAncestor(root.left, p, q)
    node_right = self.lowestCommonAncestor(root.right, p, q)

    if node_left and node_right:
        return root
    if root == p or root == q:
        return root
    return node_left or node_right
```

### Triplet approach (tracks found-p / found-q / ancestor)
```python
def findCommonAncestor(node, p, q):
    if not node:
        return (False, False, None)

    triplet_left = findCommonAncestor(node.left, p, q)
    triplet_right = findCommonAncestor(node.right, p, q)

    combination = (
        triplet_left[0] or triplet_right[0],
        triplet_left[1] or triplet_right[1],
        triplet_right[2] or triplet_left[2],
    )

    # Mark p / q found at this node.
    if node == p:
        combination = (True, combination[1], combination[2])
    if node == q:
        combination = (combination[0], True, combination[2])

    # Both found for the first time -> this node is the LCA.
    if combination[0] and combination[1]:
        return (False, False, node)

    return combination

# Driver:
# return findCommonAncestor(root, p, q)[2]
```