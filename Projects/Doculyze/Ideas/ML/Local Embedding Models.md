# Local Embedding Models — Future Migration from Voyage (In Progress)

When Voyage API credits run out, switch to a locally deployed embedding model. **Re-embedding everything is required** — you can't mix embeddings from different models in the same vector store.

## Feasible Models

| Model                 | Notes                                                                                        |
| --------------------- | -------------------------------------------------------------------------------------------- |
| **BGE-M3**            | Top pick. Multi-granularity (dense + sparse hybrid retrieval). Strong for document analysis. |
| **BGE**               | Solid general-purpose embedding. Good needle-in-a-haystack retrieval.                        |
| **Nomic Embed**       | Open-source, competitive quality, long context support.                                      |
| **all-MiniLM-L6-v2**  | Lightweight and fast. Already included as Chroma's default model.                            |
| **mxbai-embed-large** | Mixedbread AI's large embedding model. Strong benchmark performance.                         |
| **Qwen Embed**        | Alibaba's embedding model. Multilingual, competitive with BGE.                               |

## Migration Notes
- Swap out the embedding call in the ingest pipeline, re-embed all chunks
- Need a GPU for reasonable speed (or accept slower CPU inference)
- `sentence-transformers` makes local model loading straightforward
- Quality is a step below Voyage-3 on most English benchmarks, but free
