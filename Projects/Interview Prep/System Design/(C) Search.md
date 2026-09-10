---
type: concept
aliases: [Search]
tags: [system-design, building-block, interview-prep]
updated: 2026-08-28
sources: 0
---

# (C) Search

How to build fast, relevant full-text search over large datasets.

## Inverted Index
- The foundational data structure for search.
- Maps **terms → list of document IDs** that contain the term.
- Example: `"database" → [doc_3, doc_7, doc_15]`.
- Enables O(1) lookup of which documents match a search term.
- Multi-term queries intersect/union the posting lists.

## Elasticsearch
- Distributed search engine built on Apache Lucene.
- Stores data as JSON documents across shards.
- Near real-time: documents are searchable ~1 second after indexing.
- Handles full-text search, filtering, aggregations, and fuzzy matching.
- **Architecture:** index → shards (distributed) → replicas (fault tolerance).

## Tokenization & Analysis
- **Tokenizer** — splits text into terms. `"Load Balancing 101"` → `["load", "balancing", "101"]`.
- **Lowercasing** — case-insensitive matching.
- **Stemming** — `"running"` → `"run"`. Increases recall at the cost of precision.
- **Stop words** — remove common words (`"the"`, `"is"`, `"a"`) to reduce index size.
- The analysis pipeline runs at both index time and query time.

## Relevance Scoring
- **TF-IDF** — Term Frequency × Inverse Document Frequency. Rewards terms that are frequent in a document but rare across the corpus.
- **BM25** — improved TF-IDF (Elasticsearch default). Better handling of term saturation and document length.
- **Boosting** — manually weight certain fields higher (e.g., title matches > body matches).

## Key Tradeoffs

| Decision | Tradeoff |
|---|---|
| Precision vs recall | Exact matches vs casting a wider net (stemming, fuzzy) |
| Index size vs query speed | More indexing (ngrams, synonyms) = faster/broader queries but larger storage |
| Real-time vs batch indexing | Freshness vs throughput |
| Search DB vs primary DB | Extra infra + sync complexity vs query capability |

## When It Comes Up
- Any system with a search bar: e-commerce, social media, document storage.
- Web crawler (indexing the crawled pages).
- Often paired with: [[(C) Databases]] (primary store) + Elasticsearch (search index) with async sync.

## Study Checklist
- [ ] Explain inverted indexes with an example
- [ ] Explain how Elasticsearch distributes data (shards + replicas)
- [ ] Explain TF-IDF and BM25 at a high level
- [ ] Explain the tokenization pipeline (tokenize → lowercase → stem → remove stop words)
