---
project: Google Interview Prep
tags:
  - trees
  - traversal
---
# Preorder Traversal - O(n)
Performs an operation on each node on the path from **top to bottom** of a tree. Once it hits, a leaf node, it performs the action on the node on the other side of the tree.


![[preordercom-gif-maker.gif]]

Root -> Left subtree -> Right subtree
**IMPORTANT:** Highly useful for creating copies of trees or evaluating prefix expressions.
```python
class TreeTraversal:
	def __init__(self, val, left: TreeTraversal, right:TreeTraversal):
		self.val = val
		self.left = left
		self.right = right

def preorder(self, root):
	if not root:
		return
	print(root.val)
	self.preorder(root.left)
	self.preorder(root.right)
	
```
## Iterative Version (I said I wasn't going to do it but I got some time)
```python
def iterative_preorder(self, root):
	if not root:
		return []
	stack, res = [root], []
	while stack:
		node = stack.pop()
		
		
		if node.right:
			stack.append(node.right)
		if node.left:
			stack.append(node.left)
		res.append(node)
	return res
```
