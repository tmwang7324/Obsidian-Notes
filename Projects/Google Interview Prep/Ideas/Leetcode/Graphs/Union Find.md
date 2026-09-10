**Union-Find** (or Disjoint Set Union) is another fundamental algorithm used to manage and partition a collection of non-overlapping sets, or in the context of graphs, determine how many connected components there are.

# How it works
The way the algorithm achieves its goal is by finding the **root parent** of two elements at a time. If this **parent** is the same for both elements, then they must belong in the same set.


# Implementation
First, I must create a class. Let's call this class: *Union_Find.* This class will have three things:
1. **MAKE:** The class must contain a list property, which will contain the parents of each disjoint set. These parents eventually will represent an entire set.
2. **FIND:** This function should take an element within the State Space, and find its parent using .
3. **UNION:** This function should take two elements within the State Space, and merge their sets together.
#### MAKE
```python
class Union_Find:
	def __init__(self, graph):
		self.parents = [i for i in graph]
		self.rank = [1] * len(self.parents)

```

**IMPORTANT:** In the Find method, it is recommended to implement path compression. This technique ensures that every traversed node points directly to the root of a connected component, essentially flattening the tree.
#### FIND
```python
def find(self, n1):
	res = n1
	
	while res != self.parents[res]:
		self.parents[res] = self.parents[self.parents[res]]
		res = self.parents[res]
	return res
	
```

#### UNION
```python
def union(self, n1, n2):
	p1 = self.find(n1)
	p2 = self.find(n2)
	
	if p1 == p2:
		return 0
	# attach the shorter tree under the taller one
	if self.rank[p1] > self.rank[p2]:
		self.parents[p2] = p1
	elif self.rank[p1] < self.rank[p2]:
		self.parents[p1] = p2
	else:
		# equal ranks: pick one root, and only NOW does height grow
		self.parents[p1] = p2
		self.rank[p2] += 1
	return 1
		
```

# Complexity

The **parents** and **rank** arrays are both O(n) in space.

| Algorithm | Time Complexity | Space Complexity |
| --------- | --------------- | ---------------- |
| Find      | $O(/alpha(n))$  | O(1)             |
| Union     | $O(/alpha(n))$  | O(1)             |
|           |                 |                  |
