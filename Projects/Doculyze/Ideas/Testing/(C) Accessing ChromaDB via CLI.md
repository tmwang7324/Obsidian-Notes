# Overview
ChromaDB stores document embeddings inside the ingest-worker container. You can inspect collections, peek at documents, and run similarity queries directly from the CLI without touching the app.

## Connect to the running container
```bash
docker exec -it ingest-worker bash
```

## Open a Python REPL and connect to Chroma
```python
import chromadb

client = chromadb.HttpClient(host="localhost", port=8000)

# If Chroma is running as an embedded DB (no separate server), use:
# client = chromadb.PersistentClient(path="/path/to/chroma-data")
```

## List all collections
```python
client.list_collections()
```

## Get a collection and inspect it
```python
col = client.get_collection("documents")  # replace with your collection name

col.count()          # total documents stored
col.peek()           # sample of first 10 records (ids, embeddings, metadatas, documents)
```

## Query by ID
```python
col.get(ids=["doc-abc-123"])                           # single doc
col.get(ids=["doc-abc-123"], include=["documents", "metadatas"])  # with full text + metadata
```

## Similarity search
```python
results = col.query(
    query_texts=["your search phrase"],
    n_results=5,
    include=["documents", "distances", "metadatas"]
)
print(results)
```

## Filter by metadata
```python
col.get(
    where={"user_id": "some-uid"},
    include=["documents", "metadatas"]
)
```

## Delete records (use carefully)
```python
col.delete(ids=["doc-abc-123"])
```

## Quick one-liner from host (no interactive shell)
```bash
docker exec ingest-worker python -c "
import chromadb; c = chromadb.HttpClient(); print([col.name for col in c.list_collections()])
"
```
