---
type: concept
aliases: ["Reranking", "Reranker", "Cross-Encoder Reranking"]
tags: [rag, retrieval, reranking, ml, concept]
updated: 2026-08-09
sources: 1
---

# Reranking

A second, more accurate relevance-scoring pass over the candidates that vector search already returned. **It runs at query time, after retrieval — never at embedding/index time.** That isn't a convention or an optimization choice; it is structural.

## The bi-encoder / cross-encoder split

This is the whole answer in one distinction.

| | **Embedding (bi-encoder)** | **Reranking (cross-encoder)** |
|---|---|---|
| Input | query **or** document, encoded **separately** | `[query, document]` **together**, one forward pass |
| Output | a vector | a relevance score |
| Precomputable? | **Yes** — doc vectors don't depend on the query | **No** — the score is a function of the pair |
| When it runs | index time (offline, once per doc) | query time (online, once per candidate) |
| Cost | ~free per query (ANN lookup) | one model pass **per candidate** |
| Accuracy | coarse — cosine distance between two independently-built vectors | high — the model sees query↔document interaction directly |

Because a document's embedding is computed without ever seeing the query, it can be stored in the index ahead of time. A cross-encoder has no such artifact to cache: there is no "document vector" to store, only a score that exists relative to a specific query. **At index time there is no query, so there is nothing to compute.** That is why reranking cannot be moved earlier in the pipeline.

## Where it sits

```
INDEX TIME  (offline, once per document)
  chunk → embed (bi-encoder) → store vectors

QUERY TIME  (online, every request)
  embed query → ANN search → top-k candidates (~50–100)
              → RERANK (cross-encoder, k forward passes)
              → top-n (~5–10)
              → LLM context → cited answer
```

## Why two stages exist at all

The cross-encoder is the better judge but costs a full model pass per candidate — running it over millions of chunks per query is impossible. So the pipeline splits the work by what each model is good at:

- **Stage 1 (embeddings)** — cheap, sloppy **recall**. Sweep the whole corpus, return a wide net of ~50 plausible candidates.
- **Stage 2 (reranker)** — expensive, precise **ordering**. Score just those 50 properly and keep the best handful.

## Consequences that actually bite

- **Reranking is on the per-query latency budget, not the ingest budget.** Roughly 50–300 ms for ~50 candidates depending on model and hosting. Embedding is the mirror image: heavy at ingest, ~free at query.
- **A reranker can only fix *ordering*, never *recall*.** If the right chunk isn't in the top-k that vector search returned, the reranker never sees it and cannot rescue it. Retrieve wider than feels necessary (k=50+) and let the reranker cut it down.
- **Swapping rerankers is free; swapping embedding models is a migration.** A reranker change touches only query-time code. Changing the embedding model invalidates every stored vector and forces a full re-embed — dimension drift produces silent retrieval garbage, which is why the embedding model + version gets pinned and recorded (see [[(C) RAG Ingest and Query Data Architecture|RAG Ingest and Query Data Architecture]]).
- **k is the tuning knob that trades latency for quality.** Larger k = better recall into the reranker = more forward passes = slower query.

## Status in Doculyze

Reranking is **explicitly out of scope for the MVP** — the query path is plain embed → `queryUserChunks(uid)` → retrieve → generate, per [[(C) RAG Ingest and Query Data Architecture|the SPEC]]. (The older [[(C) Architecture|Doculyze Architecture]] page still lists HyDE + re-ranking as Tier-2 goals; that contradiction is one of the six flagged for reconciliation.) When it does get picked up, it drops in behind the tenant gateway on the query service only — no ingest-side change, no re-embed.

## Related

- [[(C) RAG Ingest and Query Data Architecture|RAG Ingest and Query Data Architecture]] · [[(C) Architecture|Doculyze Architecture]] · [[(C) Doculyze|Doculyze]]

## Sources

- Query session 2026-08-09 — "does reranking run at the same time as embedding, or at retrieval?"
