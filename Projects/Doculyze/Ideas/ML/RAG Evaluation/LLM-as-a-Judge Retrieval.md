# Retrieval Evaluation

Traditional RAG systems comprise two stages: **Retrieval** and **Generation.** Retrieval involves minimizing cosine similarity distances between a user's query and the stored corpus to surface the most relevant chunks. Generation then feeds those chunks to an LLM to produce an answer.

Evaluating retrieval separately from generation isolates the foundation — garbage retrieval means garbage generation regardless of the LLM's capability. A retrieval eval pipeline has **three necessary parts.**

---

## Part 1 — Eval Dataset

A fixed set of **(document, question, ground truth answer)** triples. The ground truth answer is what a perfect retrieval + generation would produce — it tells the metrics what "correct" looks like.

**Schema per sample:**

| Field | Type | Purpose |
|---|---|---|
| `question` | str | The user query |
| `ground_truth` | str | The reference answer a perfect system would give |
| `ground_truth_contexts` | list[str] | The specific chunk texts that contain the answer |

**How to build it (hybrid approach):**
1. **Synthetic generation** — feed your chunks to an LLM with a prompt like *"Given this passage, write a question that can only be answered using this passage, and provide the answer."* This produces volume quickly.
2. **Manual curation** — review each generated pair. Remove trivial questions ("What is the title of this document?"), fix incorrect answers, and tag the specific chunks that support each answer. This is where quality comes from.

The dataset must cover the diversity of your real queries: factual lookups, multi-hop reasoning across chunks, and questions where the answer spans metadata (author, date) not just text.

---

## Part 2 — Retrieval Strategy

The retriever being measured. It takes a `question` and returns a ranked list of chunks. To compare improvements, each variant is a **swappable strategy** with the same interface:

```
retrieve(query: str, top_k: int) → list[ChunkResult]
```

**Baseline:** vanilla cosine similarity search against ChromaDB — the current Doculyze retriever via `queryUserChunks`.

**Improved variants to benchmark against baseline:**

| Strategy | What it does | Expected improvement |
|---|---|---|
| **Reranking** | Initial retrieval (top 20) → cross-encoder reranker → return top k. The reranker scores query-chunk relevance with full attention, not just embedding distance. | Context Precision (pushes relevant chunks to the top) |
| **HyDE** | LLM generates a hypothetical answer to the query → embed *that* instead of the raw query → retrieve. The hypothetical document is closer in embedding space to the actual answer chunks. | Context Recall (retrieves chunks the raw query embedding would miss) |
| **Entity Recognition tagging** | NER at ingest tags chunks with recognized entities → at query time, extract entities from the query and add a metadata `where` filter before retrieval. | Context Precision (narrows the search space, reduces noise) |

Keeping the baseline strategy unchanged and running all variants against the same eval dataset on the same corpus is what makes the comparison valid.

---

## Part 3 — Metrics (RAGAS)

[RAGAS](https://docs.ragas.io/) provides two retrieval-specific metrics. Both use an **LLM-as-judge** — they are not purely algorithmic, so they require an LLM API key and have slight run-to-run variance.

### Context Precision

*Did the retriever rank relevant chunks above irrelevant ones?*

**How it works:**
1. For each retrieved chunk at rank *k*, an LLM judges: "Is this chunk relevant to producing the ground truth answer?" → binary **yes/no**. 
This **yes/no** is represented as a binary label $v_k ∈ {0, 1}$.
2. Compute precision\@k at each relevant position: `cumulative_relevant_so_far / k`.
$\text{Precision@k} = \frac{\text{relevant chunks among ranks }1...k}{k}$
3. Average those precision\@k values across all relevant positions.
$\text{Context Precision@K} =\frac{\sum_{k=1}^{K} \left(\text{Precision@k} \times v_k\right)}{\sum_{k=1}^{K} v_k}$ 
**Score interpretation:** 1.0 = every relevant chunk was ranked at the top with no noise above it. Low scores mean the retriever buries relevant chunks under irrelevant ones.

**What improves it:** reranking, entity-based pre-filtering — anything that reduces noise or reorders results.

### Context Recall

*Did the retriever fetch everything needed to answer the question?*

**How it works:**
1. An LLM decomposes the ground truth answer into atomic claims (e.g., "The API rate limit is 100 req/s", "Rate limits reset every minute").
2. For each claim, the LLM checks: "Can this claim be attributed to at least one retrieved chunk?" → binary.
3. Recall = (attributable claims) / (total claims).

**Score interpretation:** 1.0 = every claim in the ground truth is supported by at least one retrieved chunk. Low scores mean the retriever missed chunks containing part of the answer.

**What improves it:** HyDE (retrieves chunks the raw query embedding misses), larger top_k, hybrid search (dense + sparse).

### Non Context Recall



### Implementation

```python
from ragas.metrics import context_precision, context_recall
from ragas import evaluate
from datasets import Dataset

# Each field is a list — one entry per eval sample
data = {
    "question":      ["What is the rate limit for the API?", ...],
    "answer":        ["The rate limit is 100 req/s...", ...],   # LLM-generated answer
    "contexts":      [["chunk1 text", "chunk2 text"], ...],     # retrieved chunks
    "ground_truth":  ["The API rate limit is 100 req/s...", ...]  # reference answer
}

dataset = Dataset.from_dict(data)
results = evaluate(dataset, metrics=[LLMContextPrecisionWithReference(), LLM, NonLLMContextRecall()])
print(results)  # {'context_precision': 0.87, 'context_recall': 0.72}
```

**Note:** `answer` is the LLM-generated answer from your RAG pipeline (not the ground truth). Context Precision uses it alongside the ground truth; Context Recall uses only the ground truth and retrieved contexts.

---

## Putting It Together

```
                    ┌─────────────────┐
                    │   Eval Dataset   │
                    │ (Q, GT, chunks) │
                    └────────┬────────┘
                             │
              ┌──────────────┼──────────────┐
              ▼              ▼              ▼
        ┌──────────┐  ┌──────────┐  ┌──────────┐
        │ Baseline │  │ Reranked │  │   HyDE   │  ... strategies
        └────┬─────┘  └────┬─────┘  └────┬─────┘
             │              │              │
             ▼              ▼              ▼
        ┌──────────────────────────────────────┐
        │         RAGAS Metrics                │
        │  Context Precision + Context Recall  │
        └──────────────────┬───────────────────┘
                           │
                           ▼
                    ┌──────────────┐
                    │  Comparison  │
                    │    Table     │
                    └──────────────┘
```

Run every strategy against the same dataset in one pass. The comparison table shows which strategy improved which metric — and critically, which *queries* improved or regressed, not just the aggregate score.
