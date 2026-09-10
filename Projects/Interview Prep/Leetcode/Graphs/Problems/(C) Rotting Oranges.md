---
project: Google Interview Prep
difficulty: Medium
leetcode: 994
solved: 2026-08-25
solve_time: ~1hr
---

# (C) Rotting Oranges — LC 994

## My approach
##### Keep Track of Fresh Oranges and Whether an Orange has Rotted
Instead of traversing the grid to find if any orange is still fresh, I keep track of the number of fresh oranges every minute with variable `fresh`.
```python
return time if fresh == 0 else -1
```

Also, I must ensure that `time` is only incremented if at least 1 fresh orange rots. To do this, I initialize a boolean variable `changed = False` at the beginning of every multi-source **BFS** loop. Then, in the **BFS** propagation step, if a fresh orange rots, I switch the boolean to `True`


## Solution
```python

```

## Complexity
* **Time Complexity:**
* **Space Complexity:* 
## Master-check
Simultaneous spread = **multi-source BFS**. Enqueue all initial rotten oranges at time 0; each BFS level = one minute. Track the fresh count upfront and decrement as oranges rot — no second scan needed.
