---
project: Google Interview Prep
tags:
  - graphs
  - shortest-path
aliases:
  - Bellman-Ford
---
# Bellman-Ford Algorithm — O(V * E)
A **Single Source Shortest Path** algorithm that, unlike [[Dijkstra's]], handles **negative edge weights** and detects **negative-weight cycles**.

## Why V-1 Relaxation Passes?
The longest possible shortest path in a graph with **V** vertices has at most ***V-1 edges*** (a simple path can't revisit a vertex). Each relaxation pass guarantees one more hop of correct distances:

- **After pass 1:** all shortest paths using exactly 1 edge are correct.
- **After pass k:** all shortest paths using up to k edges are correct.
- **After pass V-1:** worst case covered — a path snaking through every vertex.

### Why doesn't one pass suffice?
Unlike Dijkstra's, there's no greedy heap picking the closest finalized node. Edges are relaxed in an arbitrary fixed order, so a later edge's relaxation might depend on an earlier edge's value that wasn't available yet *in the same pass*.

**Example:** `A -> B -> C -> D` (all weight 1), edges processed as `(C->D), (B->C), (A->B)`:

| Pass | (C->D) | (B->C) | (A->B) | New knowledge |
|------|--------|--------|--------|---------------|
| 1 | dist[C]=inf, skip | dist[B]=inf, skip | 0+1 < inf, **dist[B]=1** | B reachable |
| 2 | still skip | 1+1 < inf, **dist[C]=2** | already 1 | C reachable |
| 3 | 2+1 < inf, **dist[D]=3** | already 2 | already 1 | D reachable |

Each pass propagates distances **one hop further**. Dijkstra's heap solves this greedily in one go — Bellman-Ford brute-forces it.

## Negative Cycle Detection
If distances still change on a **V-th pass**, a negative-weight cycle exists — you can keep looping to reduce cost forever, so no finite shortest path exists.

## Algorithm
```python
def bellman_ford(n, edges, src):
	dist = [float('inf')] * n
	dist[src] = 0

	for _ in range(n - 1):
		for u, v, w in edges:
			if dist[u] + w < dist[v]:
				dist[v] = dist[u] + w

	# Negative cycle check
	for u, v, w in edges:
		if dist[u] + w < dist[v]:
			return -1  # negative cycle detected

	return dist
```

## Comparison with Dijkstra's

| | Dijkstra's | Bellman-Ford |
|---|---|---|
| **Time** | O(E log V) | O(V * E) |
| **Negative weights** | No | Yes |
| **Negative cycle detection** | No | Yes |
| **Approach** | Greedy (heap) | Brute-force (V-1 passes) |
| **When to use** | Non-negative weights, need speed | Negative weights or cycle detection |
