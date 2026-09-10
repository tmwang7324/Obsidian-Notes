---
project: Google Interview Prep
tags:
  - trees
  - traversal
---
# Inorder Traversal - O(n)
Performs operations on the deepest former direction nodes first. For example, if *root.left* is called first as a parameter, then the deepest left nodes are processed first.
The nodes in the latter direction, using this example, *root.right*, are processed top to bottom though.

![[inorder.gif]]

Left subtree -> root -> Right subtree
**IMPORTANT:** When applied to a Binary Search Tree, it ensures that nodes are visited in ascending, sorted order.
```python
def inorder(root):
	if not root:
		return
	inorder(root.left)
	print(root.val)
	inorder(root.right)
	
```

## Iterative Algorithm
```python
def iterative_inorder(self, root):
	if not root:
		return
	stack, parent_stack, res = [root], [], []
	l = 0
	while stack:
		node = stack.pop()
		# need counter as well
		if node.right and node.left:
			parent_stack.append(node)
			stack.append(node.right)
			stack.append(node.left)
		elif node.right:
			res.append(node)
			stack.append(node.right)
		elif node.left:
			stack.append(node.left)
			parent_stack.append(node)
		else:
			res.append(node)
		if not node.right and not node.left:
			if parent_stack:
				res.append(parent_stack.pop())
		## There is a major issue where the original stack runs out of nodes before the parent_stack does. This only leaves the option to iteratively drain the parent_stack onto res.
		## This however, will end up prioritizing the deeper elements. Inorder traversal prioritizes the root after the left subtree is traversed. Thus, if there are any right nodes in the stack, the order will be wrong.
		
		
		# Solution? Add all elements from left subtree to the primary stack before popping.
		
def iterative_dive_inorder(self, root)
		if not root:
			return []
		
		stack, res, curr = [root], [], root
		while stack 
			while curr:
				if curr.left:
					curr = curr.left
					stack.append(curr)
			node = stack.pop()
			if node.right:
				curr = node.right
			res.append(node)	
	return res
	
```
