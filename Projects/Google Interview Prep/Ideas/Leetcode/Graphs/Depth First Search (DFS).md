Depth-First-Search is a foundational graph traversal algorithm that travels by nearest neighbor, but moves in one direction until it reaches a node with no unvisited neighbors left.

```python
class GraphTraversal:
	def __init__(self, nodes: List[List[int]]):
		self.graph = nodes
	
```
**IMPORTANT:** The key to DFS is to create an accurate adjacency list. An adjacency list is consists of a data structure that defines relationships between the different nodes in a graph. For example, in a 2D matrix, an adjacency list would contain directions to a cell's 1 unit neighboring cells: 
```python
adjacency_list = [(0, 1), (1, 0), (-1, 0), (0, -1)] # no diagonals allowed
```

## Recursive
**IMPORTANT:** Make sure to add elements to the *visited* set upon entry into the DFS recursive algorithm. This is to include the starting node into the visited set.
```python
from collections import deque
def dfs_result(graph):
	res = []
	visited = set()
	def DFS(root):
		if root in visited:
			return
		if not root:
			return
		visited.add(root) # This ensures that the root element (first element traversed by the DFS algorithm) is included inside visited
		res.append(root)
		# res.append(root+i, root+tj) # 2-D Matrix		
		for n in node.neighbors: # general DFS Case
			if n not in visited:			
				DFS(n)
		# adjacency_list = [(0, 1), (1, 0), (-1, 0), (0, -1)]
		# for i, tj in adjacency_list: # 2-D Matrix
		# 	if (root+i, root+tj) not in visited:
		# 		visited.add((root+i, root+tj))
		# 		DFS(root+i, root+tj)
		return
	DFS(graph[0])
	return res

```

## Iterative Version
```python
def iterative_dfs(self, root):
	stack, visited, curr = [root], {root}, root
	res = []
	while stack:
		if curr in visited:
			return "cycle detected"
		for i in range(len(curr.neighbors)):
			while curr.neighbors:
				res.append(curr)
				stack.append(curr)
				visited.add(curr)
				curr = curr.neighbors[i]
			if not curr.neighbors:
				node = stack.pop()
				last_visited = node
			peek = stack[-1]
			if peek.neighbors[-1] == last_visited:
				last_visited = stack.pop()
			else:
				curr = peek.neighbors[i+1]					
```

### Common Problems
