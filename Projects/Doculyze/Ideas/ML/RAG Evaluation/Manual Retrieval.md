# Manual Retrieval Evaluation

Traditional IR (Information Retrieval) metrics for evaluating retrieval quality using **human-assigned relevance scores** rather than an LLM judge. These predate RAGAS and require no API key — you score the chunks yourself, then compute the metric directly.

Use these alongside RAGAS metrics (see [[Retrieval]]) for a fuller picture, or instead of RAGAS when you want full manual control over relevance judgments.

---
## Recall@K

*How many retrieved chunks are relevant?*

The simplest metric to calculate contained here. Ratio of the number of chunks relevant to the query retrieved to the number of chunks relevant to the query.


## nDCG — Normalized Discounted Cumulative Gain

*Are the most relevant chunks ranked highest?*

The only **graded** metric here — you assign each retrieved chunk a relevance score (e.g., 0–3), and nDCG rewards placing higher-scored chunks at higher ranks.

**How it works:**
1. Assign each retrieved chunk a relevance score (e.g., 0 = irrelevant, 1 = marginally relevant, 2 = relevant, 3 = highly relevant).
2. **DCG** sums those scores, discounting by rank position: each score is divided by `log₂(rank + 1)` so lower-ranked results contribute less.
3. **Ideal DCG (iDCG)** is the DCG you'd get if chunks were perfectly sorted by relevance (best first).
4. **nDCG = DCG / iDCG**, normalized to [0, 1].

```
Retrieved chunks:       [okay(2), irrelevant(0), perfect(3), good(1)]

DCG  = 2/log₂(2) + 0/log₂(3) + 3/log₂(4) + 1/log₂(5)
     = 2.0       + 0          + 1.5        + 0.43
     = 3.93

Ideal ranking:          [perfect(3), okay(2), good(1), irrelevant(0)]

iDCG = 3/log₂(2) + 2/log₂(3) + 1/log₂(4) + 0/log₂(5)
     = 3.0       + 1.26       + 0.5        + 0
     = 4.76

nDCG = 3.93 / 4.76 = 0.83
```

A score of 0.83 means the ranking was decent but not perfect — that `perfect(3)` chunk sitting at position 3 instead of position 1 cost you.

**Implementation:**

```python
from sklearn.metrics import ndcg_score
import numpy as np

# Your manual relevance scores for retrieved chunks (in retrieval order)
relevance_scores = [[2, 0, 3, 1]]  # 2D array: one row per query

# Ideal scores (same values, best order)
ideal_scores = [[3, 2, 1, 0]]

ndcg = ndcg_score(ideal_scores, relevance_scores)
# 0.83
```

---

## MAP — Mean Average Precision

*Across all queries, how well does the retriever rank relevant chunks above irrelevant ones?*

Binary (relevant/not) — no graded scores.

**How it works:**
1. For a single query, compute **Average Precision (AP)**: at each position where a relevant chunk appears, calculate precision\@k, then average those values.
2. **MAP** = mean of AP across all queries in the eval set.

```
Retrieved:  [relevant, irrelevant, relevant, irrelevant, relevant]

Precision at relevant positions:
  Position 1: 1/1 = 1.0
  Position 3: 2/3 = 0.67
  Position 5: 3/5 = 0.6

AP = (1.0 + 0.67 + 0.6) / 3 = 0.76
```

If relevant chunks were at positions 1, 2, 3 instead — AP would be 1.0.

**Implementation:**

```python
from sklearn.metrics import average_precision_score
import numpy as np

# Binary relevance labels in retrieval order
y_true = np.array([1, 0, 1, 0, 1])

# Scores that reflect ranking (higher = ranked higher)
# Use reversed rank as score so position 1 gets highest value
y_scores = np.array([5, 4, 3, 2, 1])

ap = average_precision_score(y_true, y_scores)

# For MAP: average AP across all queries
all_aps = [ap_query_1, ap_query_2, ...]
map_score = np.mean(all_aps)
```

---

## MRR — Mean Reciprocal Rank

*How quickly does the retriever find the first relevant chunk?*

The simplest metric. It only cares about **the first relevant result.**

**How it works:**
1. For a single query, find the rank of the first relevant chunk → reciprocal rank = `1/rank`.
2. **MRR** = mean of reciprocal ranks across all queries.

```
Query A: first relevant at position 1 → 1/1 = 1.0
Query B: first relevant at position 3 → 1/3 = 0.33
Query C: first relevant at position 2 → 1/2 = 0.5

MRR = (1.0 + 0.33 + 0.5) / 3 = 0.61
```

**Implementation:**

```python
import numpy as np

def reciprocal_rank(relevance_labels):
    """relevance_labels: list of 0/1 in retrieval order."""
    for i, label in enumerate(relevance_labels, 1):
        if label == 1:
            return 1.0 / i
    return 0.0  # no relevant chunk found

queries = [
    [1, 0, 0, 0, 0],  # first relevant at rank 1
    [0, 0, 1, 0, 0],  # first relevant at rank 3
    [0, 1, 0, 0, 0],  # first relevant at rank 2
]

mrr = np.mean([reciprocal_rank(q) for q in queries])
# 0.61
```

---

## When to Use Which

| Metric   | What it answers                            | Relevance type | Scope            | Best for                                      |
| -------- | ------------------------------------------ | -------------- | ---------------- | --------------------------------------------- |
| **nDCG** | Are the *best* chunks ranked highest?      | Graded (0–3)   | Full ranked list | When chunk quality varies and ranking matters |
| **MAP**  | Are relevant chunks near the top?          | Binary         | Full ranked list | Overall retrieval quality across many queries |
| **MRR**  | How fast do you find *one* relevant chunk? | Binary         | First hit only   | Factual lookups needing one good chunk        |

For Doculyze — where the LLM needs multiple chunks to synthesize an answer — **nDCG and MAP** matter more than MRR. MRR is useful as a quick sanity check ("does the retriever find *anything* relevant quickly?") but doesn't capture whether it found *everything* needed.

### Comparison with RAGAS metrics

| Manual metric | RAGAS equivalent | Key difference |
|---|---|---|
| **MAP / nDCG** | **Context Precision** | RAGAS uses an LLM judge for relevance instead of manual labels |
| *(no direct equivalent)* | **Context Recall** | Measures completeness (did you retrieve everything needed?) — manual metrics don't cover this directly |

The two approaches are complementary: manual metrics give you full control and reproducibility (no LLM variance); RAGAS scales to large eval sets without manual labeling.
