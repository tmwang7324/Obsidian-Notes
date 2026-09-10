## BFS
```python
from collections import deque
def BFS(start):
	queue, visited = deque([start]), {start}
	res = []
	while queue:
		node = queue.popleft()
		res.append(node)
		for n in node.neighbors:
			if n not in visited:
				visited.add(n)
				queue.append(n)
	return res
```

## DFS
```python
def dfs_result(graph):
	res = []
	visited = set()
	def DFS(node):
		if node in visited:
			return
		if node is None:
			return
		res.append(node)
		visited.add(node)
		for n in node.neighbors:
			DFS(n)
		return
	DFS(graph[0])
	return res
```

# 2. Invariant
The errors in my previous attempt to write BFS and DFS were when I added elements into the *visited set*. 
When I tackled writing BFS from scratch, I accidentally added elements upon dequeue, which resulted in duplicate elements appearing in *res* and *queue.* This is because elements with shared adjacent elements all append the same elements.
**Solution:** Add elements to *visited* upon enqueue.

When I tackled DFS from scratch, I forgot to add the root element into *visited,* which would result in a duplicate root in *res* if there was any element in the graph that points back to the root. 
**Solution:** Add elements to *visited* upon every recursive call. Furthermore, upon every recursive call, terminate if current *node* is in *visited.* 

# 3. Derive the Complexity

| Algorithm | Time Complexity | Space Complexity |
| --------- | --------------- | ---------------- |
| BFS       | $O(V + E)$      | $O(V)$           |
| DFS       | $O(V + E)$      | $O(V)$           |
BFS only has a space complexity of $O(V)$ because the queue only stores distinct nodes.

On the other hand, DFS is invoked every time there is an unvisited node. So, both share the same space complexity.

Both algorithms take O(V + E) time because both traverse through every node's adjacency list.
**Per Vertex:** Both algorithms visit every node and process it by appending to a list.
**Per Edge:** Both algorithms traverse through every edge to go to the next node. If that node is in *visited*, then it must be skipped.


**$O(V + E)$ instead of $O(V^2)$.** An adjacency-list graph simplifies traversal algorithms to $O(V+E)$ because it specifies which nodes connect to another. If every node connects with every other node, then the algorithms would have to traverse $V^2$ times.

# 4. Union-Find
```python
def find(n1):
	res = n1
	while res != par[res]:
		par[res] = par[par[res]]
		res = par[res]
	return res

```

```python
def union(n1, n2):
	p1, p2 = find(n1), find(n2)
	
	if p1 == p2:
		return 0
	if rank[p1] > rank[p2]:
		par[p2] = p1
	elif rank[p2] > rank[p1]:
		par[p1] = p2
	
	if rank[p2] == rank[p1]:
		par[p1] = p2
		rank[p2] += 1
	return 1
```

### Parent + Rank Invariants
`par[x]` represents the parent of the node *x*
`rank[x]` represents the **rank** of the parent node *x.* **Rank** is how deep the tree goes of connected nodes

### Time + Space Complexity

| Algorithm | Time Complexity          | Space Complexity |
| --------- | ------------------------ | ---------------- |
| Find      | $O(\alpha(n))$ amortized | $O(1)$           |
| Union     | $O(\alpha(n))$ amortized | $O(1)$           |
**Path Compression** is the algorithm that bounds `find` to $O(\alpha(n))$ amortized time, where $\alpha$ is the inverse Ackermann function. It does this by halving the path to the root parent (first element of the current set).

**Ranking** simplifies `find()` greatly because it ensures that shorter trees are to be connected to taller trees. This enables find to use fewer path compressions to reach the absolute root parents. 
Since `union` relies on `find`, this optimization gives `union` the same $O(\alpha(n))$ amortized bound.

#### Ackermann Function

The **Ackermann function** $A(m, n)$ is defined recursively:

$$
A(m, n) =
\begin{cases}
n + 1 & \text{if } m = 0 \\
A(m - 1,\ 1) & \text{if } m > 0 \text{ and } n = 0 \\
A(m - 1,\ A(m,\ n - 1)) & \text{if } m > 0 \text{ and } n > 0
\end{cases}
$$

Its outputs explode astronomically, so its inverse grows astronomically *slowly*: $\alpha(n) \leq 4$ for every measurable $n$ in the observable universe.

**Inverse Ackermann function:**

$$\alpha(n) = \min\{\, k : A(k, k) \geq n \,\}$$

$\alpha(n)$ grows even more slowly than the iterated logarithm $\log^* n$.




# 5. Judgement
(a) BFS due to the fact that the shortest path should be whenever B is found. Cheaper than DFS
(b) Union-Find because connected components are disjoint sets.
(c)  DFS is the best algorithm to use because one can compare the current node's neighbors to the visited set. If one adds a visited node into the current node's adjacency list, then one will have created an edge leading to a cycle.