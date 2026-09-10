---
project: Google Interview Prep
tags:
  - trees
  - traversal
  - BFS
---
# BFS Level Traversal 
Processes all nodes from top to bottom, popping one layer at a time.
root -> left children -> right children
**IMPORTANT:** Keep track of the amount of nodes added to the `queue` after each `popleft()`

```python
from collections import deque
def bfs_level_traversal(self, root):
	### Proper Simplified
	if not root:
		return []
		
	queue, res = deque([root]), []
	while queue:
		levels = []
		for _ in range(len(queue)):
			node = queue.popleft()
			
			if node.left:
				queue.append(node.left)
			if node.right:
				queue.append(node.right)
			levels.append(node)
		res.append(levels)
	return res
	
	### My approach, also correct
	if not root:
		return []
	
	
	queue, res = deque([root]), []
	l = 1 #num of nodes in layer
	while queue:
		nodes_popped = 0
		level = []
		for i in range(l):
			if len(queue) == 0:
				break
			node = queue.popleft()
			
			if node.left:
				queue.append(node.left)
				nodes_popped+=1
			if node.right:
				queue.append(node.right)
				nodes_popped+=1
			level.append(node)
		res.append(level)
		l = nodes_popped
	return res
	
```
