# Big O and Time Complexity

## What Big O Actually Means

Big O describes an **upper bound** on growth rate — formally, it's about **worst case**. But in practice people use it loosely for average case too.

When someone says "quicksort is O(n log n)," they mean average case, even though worst case is O(n^2).

### The Precise Notation

| Symbol | Meaning | Describes |
| ------ | ----------- | ---------- |
| O(f(n)) | Upper bound | Worst case |
| Θ(f(n)) | Tight bound | Average / exact growth |
| Ω(f(n)) | Lower bound | Best case |

In interviews and casual conversation, Big O is used for all three — context tells you which. If someone asks "what's the time complexity," they usually want **worst case** unless they specifically say average.

## Amortized Time

Amortized time is a different lens — it's the **average cost per operation over a sequence of operations**, not the cost of any single call.

| Type | What it measures |
| ------------ | -------------------------------------------------- |
| Worst case | The single most expensive call |
| Average case | Expected cost assuming random input |
| Amortized | Total cost of n operations / n, **guaranteed** (no probability) |

The key: amortized is a **guarantee**, not a probabilistic expectation. You're spreading cost honestly across a sequence.

### Union-Find (Path Compression + Union by Rank)

The classic amortized example. A single `find()` can be expensive (walking up a tall tree), but that same call **flattens the path** for every future call.

- Single operation worst case: O(log n)
- Amortized cost per operation: **O(α(n))** — inverse Ackermann, effectively constant (≤4 for any realistic n)

The expensive call pays forward by making future calls cheaper.

### Dynamic Array (ArrayList / vector)

Another intuitive example. Doubling the array costs O(n) when it triggers a resize, but that happens so rarely that the amortized cost per append is **O(1)**.

Reasoning: after a doubling to size 2k, the next doubling won't happen for another 2k inserts. Total cost of all doublings up to n inserts = 1 + 2 + 4 + ... + n = 2n. Divided by n operations = O(1) amortized.

### Mental Model

Expensive operations **pay forward** by making future operations cheaper. You're spreading the cost across the sequence, not hoping for favorable input.
