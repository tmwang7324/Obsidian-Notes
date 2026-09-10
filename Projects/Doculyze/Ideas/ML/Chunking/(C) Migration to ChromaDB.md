---
type: idea
project: Doculyze
aliases: [Migration to ChromaDB]
tags: [chunking, chromadb, doculyze]
updated: 2026-08-10
---

# (C) Migration to ChromaDB

## How chunk content flows into ChromaDB

End-to-end path through `ingest-worker/src/ingest/`:

### 1. Extraction (`job.py`)

`run_ingest_job` parses the uploaded file to markdown, then calls `chunk_markdown(text)` (`chunker.py`), which returns a list of `Chunk` objects. Each chunk's markdown text lives in its `.content` attribute, set in `Chunk.__init__` from the split segment.

### 2. Handoff (`job.py` → `vector_store.py`)

`job.py` calls `write_user_chunks(chroma_client(), create_embedder(), uid, doc_id, chunks)`. Only `vector_store.py` touches ChromaDB — it's the tenant gateway.

### 3. Storage (`vector_store.py`)

Inside `write_user_chunks`:

```python
contents = [c.content for c in chunks]
embeddings = embed_fn(contents, input_type="document")

# delete-then-add for replay safety (not upsert)
coll.add(
    ids=[f"{uid}/{doc_id}/{i}" for i, _ in enumerate(chunks)],
    embeddings=embeddings,
    documents=contents,
    metadatas=...
)
```

- Position `i` of `documents` pairs with embedding `i` and id `"{uid}/{doc_id}/{i}"`.
- Chunk text is stored **verbatim** — no truncation.
- Queries retrieve it via `include=["documents", ...]`; the gateway returns it as the `"content"` key of each result dict.

### Metadata handling

The chunk's `.metadata` dict is **not** copied into ChromaDB — it can contain lists, which Chroma metadata rejects. Only these fields go into `metadatas`:

- `c.breadcrumb()` (flattened string)
- `userId`
- `docId`
- `chunk_index`
- `token_count`
- `embedding_model`

### Replay safety

Idempotency uses delete-then-add, not upsert semantics. Before `coll.add`, a `$and`-filtered delete removes any existing entries for the same `uid`/`doc_id` pair.
