Breadth-First Search is another foundational graph traversal algorithm that travels by nearest neighbor, but does so layer-by-layer. Every adjacent node to the current node is traversed before the algorithm visits a neighbor.

**IMPORTANT:** Make sure each node traversed is added to the *visited* set upon **enqueue**, not **dequeue.** If an element is added upon dequeue, then two elements adjacent to another element can add the same element multiple times to the queue.

```python
from collections import deque
def BFS(root):
	res = [] #graph[(0, 0)]graph[]
	 # Use a queue to keep track of nodes by level
	# adjacency_list = [(0, 1), (1, 0), (-1, 0), (0, -1)]
	visited = set()
	queue = deque([root])
	visited.add(root)
	while queue:
		node = queue.popleft()
		res.append(node)
		for n in node.neighbors:
			if n not in visited:
				queue.append(n)
				visited.add(node)
		# res.append(graph[node[0]][node[1]])
		# for i, tj in adjacency_list:
		# 	if (node+i, node+tj) not in visited: 
		# 		queue.append((node+i, node+tj)			
	return res
	
			
```

### Common Problems