---
project: Google Interview Prep
tags:
  - trees
  - traversal
---
# Postorder Traversal - O(n)
Performs operations on the deepest nodes first no matter their direction.

![[postorder.gif]]

Left Subtree -> Right subtree -> Root
**IMPORTANT:*** It is highly effective for bottom-up tasks, such as deleting trees or calculating directory sizes. It is also very efficient at evaluating reverse polish notation.
```python
def postorder(root):
	if not root:
		return
	postorder(root.left)
	postorder(root.right)
	print(root.val)
```

## Iterative Algorithm
```python
# use last_visited to keep track of which nodes are appended (processed) to determine which parents have had all their children processed
def new_and_updated_iterative_dive_postorder(self, root):
	if not root:
		return []
	stack, curr, res = [root], root, []
	last_visited = root
	while stack:
		print(f"curr = {curr.val} with last_visited = {last_visited.val}")
		while curr.left:
			curr = curr.left
			stack.append(curr)
		peek = stack[-1]
		if not peek.right or last_visited == peek.right:
			last_visited = stack.pop() # 4
			res.append(last_visited.val)
		else:
			curr = peek.right
			stack.append(curr)
	return res
```


## Broken Attempts
```python
# descend and pop one at a time - count children in order to determine when the parent can be popped
def iterative_postorder(self, root):

	if not root
		return
	stack, recently_popped, res = [root], [], [], []
	children = 0
	while stack:
		
		l = 1 # keep track of how many leaf nodes there are
		node = stack.pop()
		
		# Need a counter if node.right and node.left both exist
		if not node.left and not node.right:
			res.append(node)
			if recently_popped and l == children:
				res.append(recently_popped.pop())
			l+=1
		if node.left or node.right:
			recently_popped.append(node)
		if node.left and node.right:
			stack.append(node.left, node.right)
			children = 2
		elif node.right:
			stack.append(node.right)
			children = 1
		elif node.left:
			stack.append(node.left)
			children = 1
		
	return res
# first try in using last_visited. The idea was to keep track of parent nodes with a left subtree. These should be processed after every other node.
def iterative_dive_postorder(self, root):
	if not root:
		return []
	stack, curr, res = [root], root, []
	last_visited = root
	
	while stack or curr:
		while curr.left and last_visited.left == stack[-1]: 
			last_visited = curr
			curr = curr.left
			stack.append(curr)
		if curr.right:
			stack.append(curr.right)
			curr = curr.right
		else:
			while not stack[-1] == last_visited:
				res.append(stack.pop())
				
			curr = stack[-1]
	return res
```
