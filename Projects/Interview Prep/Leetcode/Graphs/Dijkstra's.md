# Overview
***Dijkstra's algorithm*** is a **Single Source Shortest Path** algoirthm for graphs with **non-negative edge weights.**

Depending on how the algorithm is implemented and what data structures are used the time complexity is typically $O(E * log(V))$
which is prettry competitive against other shortest path algorithms.

## Algorithm Prerequisites
One constraint for Dijkstra's algorithm is that the graph msut only contain **non-negative edge weights.** This constraint is imposed to enable the *greedy* search the algorithm performs to process the next node with the shortest path. 
Furthermore, the constraint enusres that once a node has been visited, its optimal distance **cannot be improved.**

## Quick Algoirhtm Overview
* Maintain a `dist` array / map where the distance to every node is ***positive infinity*** `float('inf').` Mark the distance of the start node `src` as 0.

* Maintain a priority queue containing key-value pairs (**distance, node index**) that tells me which node to visite next based on sorted min *distance.* Use `heapq` to implement that priority queue.
* Insert `(0, src)` into the heap and while heap is not empty, pop out the next node with the shortest distance. `cur_dist, node = heapq.heappop(heap)`
* Iterate through all edges outwards from the current node using a `graph` *hashmap*. Afterwards, instead of checking if the neighbor has been **visited already**, check if ***the distance to the neighbor + distance to the popped node*** is less than the distance recorded in `dist` for that neighbor node.
* If so, update `dist` with `cur_dist + n_dist.` Then push the newly discovered *shortest distance node* to the heap. This relaxes each edge attached to the popped node.
