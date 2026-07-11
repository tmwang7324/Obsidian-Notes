---
project: Google Interview Prep
difficulty: Medium
leetcode: 235
solved:
solve_time:
runtime_beats:
memory_beats:
---

# (C) Lowest Common Ancestor of a BST — LC 235

## Problem
Given a BST and two nodes `p` and `q`, return their lowest common ancestor (LCA) — the deepest node that has both `p` and `q` as descendants (a node can be a descendant of itself).

## Key insight
_The BST ordering is the whole trick: at any node, compare `p.val` and `q.val` against `node.val`._
- Both smaller than `node.val` → LCA is in the **left** subtree.
- Both larger → LCA is in the **right** subtree.
- Otherwise (they split, or one equals `node.val`) → **this node is the LCA**.

## Complexity
- Time: O(h) — one root-to-node walk, `h` = tree height (O(log n) balanced, O(n) worst).
- Space: O(1) iterative / O(h) recursive.

## My approach
_TODO: write up the walk-down comparison (iterative loop vs. recursion) and why the BST property lets you avoid a full search._'

At first, I tried to work out a solution involving a traversal algorithm such as *inorder* or *postorder* to find both target nodes. When both are found, propagate a boolean up to its LCA. 

For a standard binary tree, this is the optimal solution. However, for a binary search tree, I do not have to search through all of the nodes. 

**DECISION**: Instead, I can compare the current node's value to both of the target nodes' values:
* If the current node's value is greater than both target nodes' values, then I know I have to move the current node left.
* If the current node's value is less than both target nodes' values, then I know I have to mvoe the current node right.

**IMPORTANT**: Now, contrary to first impression, once the current node's value is between the target nodes' values (inclusive), there is no need to traverse further. The **lowest** common ancestor is this node.

### Recursive VS Iterative (IMPORTANT)
I made the silly mistake of disregarding the tradeoffs between *recursion* and *iteration* in this problem. The time complexity of both algorithms remain the same at $O(h)$ where $h$ is the height of the tree, but the space heavily favors *iteration.* 

The reason why the time complexity of this algorithm is $O(h)$ is because I am traversing down one side of each subtree until I reach my result, essentially halving a full lookup.

*Iterative* approach has a space complexity of $O(1)$ since I am just moving a node pointer across the tree.
*Recursive* approach has a complexity of $O(h)$ since every traversal invokes another call to the method onto the stack.

## Solution
### Recursive Solution
```python
def lowestCommonAncestor(self, root: TreeNode, p: TreeNode, q: TreeNode):
    if not root:
        return None
    if root.val > p.val and root.val > q.val:
        return self.lowestCommonAncestor(root.left, p, q)
    elif root.val < p.val and root.val < q.val:
        return self.lowestCommonAncestor(root.right, p, q)
    else:
        return root
```

### Iterative Version
```python
def lowestCommonAncestor(self, root: TreeNode, p: TreeNode, q: TreeNode):
	while root:
		if root.val > p.val and root.val > q.val:
			root = root.left
		elif root.val < p.val and root.val < q.val:
			root = root.right
		else:
			return root
```


