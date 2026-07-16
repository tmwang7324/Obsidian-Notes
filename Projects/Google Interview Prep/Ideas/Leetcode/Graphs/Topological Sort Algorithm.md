 # Overview
A **topological ordering** is an ordering of the nodes in a Directed Acyclic Graph **DAG** where for each directed edge from node A to node B, node A appears before node B in ordering. 
Able to find a way to align all nodes in a straight line with all directed edges pointing to the right.
**IMPORTANT:** There can be multiple valid topological orderings. However, a cyclic directed graph has **NO** topological orderings.




# Kahn's Algorithm
Kahn's Algorithm is a simple [[Breadth-First Search (BFS)]]-based topological sort algorithm that can find a topological sort and detect cycles in $O(V+E)$ time and $O(V)$ space ($O(V+E)$ if including the adjacency list).

**IMPORTANT:** The reason why Kahn's Algorithm takes $O(V+E)$ time is because each node is added and popped off the queue. Each edge is processed by decrementing the indegree array.

**IMPORTANT:** 


First, create an indegree array or map that keeps track of how many edges point towards a specific node. *Note: There can be an early termination in this portion if bfs or dfs detects any cycle.* 
Then, enqueue all nodes with an indegree of 0. While the queue is not empty, `popleft()` the `queue`, retrieving the first appended node, let's call it `ele`, and its neighbors. Record the node in `ordered.`
For each neighboring node visited, decrement its indegree by 1. If its indegree reaches 0, append it to the `queue`.
Repeat until the `queue` becomes empty. **IMPORTANT:** Since I already checked for a cycle earlier when creating the indegree map, there is no need for any cycle detection.

```python

from collections import defaultdict, deque
def khans_algorithm(graph) -> List[node]:
	queue, ordering = deque([]), []
	indegree = defaultdict(int)
	for i in graph:
		for n in i.neighbors:
			indegree[n] += 1
		
	for n in graph:
		if indegree[n] == 0:
			queue.append(n)
	while queue:
		#for _ in len(queue):
		ele = queue.popleft()
		ordering.append(ele)
		for n in ele.neighbors:
			indegree[n] -=1
			if indegree[n] == 0:
				queue.append(n)
	
	return ordering if len(ordering) == len(graph) else ["cycle detected"]
	
			
```

# DFS Topological Sort Algorithm
The depth-first search topological sort algorithm finds a valid topological sort and detects cycles if present in $O(V + E)$ time


```python
def topological_sort_with_dfs(graph): # Assuming graph is based on an adjacency list
	# one pass subgraph dfs with two-state cycle detection
	N = len(graph)
	visited, on_path = set(), set()
	res = []
	
	def dfs(start):
		if start in on_path:
			return False # "cycle found"
		if start in visited:
			return True # "prev path found"
		visited.add(start)
		on_path.add(start)
		for n in start.neighbors:
			if not dfs(n):
				return False
		on_path.discard(start)
		res.append(start) 
		return True #"keep going"
	
	for node in graph:
		if node not in visited:
			# on_path.clear()
			if not dfs(node):
				return []
			
	
	return res[::-1] # reverse the arry for the topological ordering
	
def topo_sort_with_dfs_william_fest(graph):
	N = len(graph)
	visited = [false] * N
	ordering = [0] * N
	i = N-1
	
	def dfs(start, idx, ordering):
		if visited[start]
			return idx
		if on_path[idx]:
			return -1
		visited[idx] = true
		for n in graph[start]:
			idx = dfs(n, idx, ordering)
		ordering[idx] = start	
		return idx-1
	for tj in range(N):
		if not visited[tj]:
			on_path.clear()
			i = dfs(tj, i, ordering)
			# ordering[i] = 
	return ordering
```


