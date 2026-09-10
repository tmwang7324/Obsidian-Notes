---
type: adr
project: Doculyze
status: accepted
adr: 4
aliases: ["ADR-0004", "Pluggable Embedding Provider"]
tags: [doculyze, adr, rag, embeddings]
updated: 2026-07-21
related: ["[[ADR-0003 Separate Codebases Shared Vectorstore Package]]", "[[(C) Embed + Chroma Tenant Gateway]]"]
---

# ADR-0004: Pluggable embedding provider (Voyage default, local fallback)

**Status:** Accepted (2026-07-21) — recorded in the vault per maintainer ruling.

## Context

The default embedder is **hosted Voyage** (`voyage-3.5` @ 1024-dim). The maintainer wants a **local SentenceTransformer** fallback (`all-MiniLM-L6-v2`) for when the free Voyage token budget is exhausted. Chroma also offers *automatic* local embedding — but using it would move embedding out of our control and split the write path.

## Decision

Model the embedding provider as a **swappable backend behind `embed_texts`** in `doculyze_vectorstore/embeddings.py`: `VoyageEmbedder` (default now), a later `LocalEmbedder`; the **pin is derived from whichever backend is active.**

- The gateway **always supplies explicit vectors** — the Chroma collection is created with `embedding_function=None`. Even the local path runs SentenceTransformers *inside* `embed_texts` and passes vectors in; we never delegate to Chroma's auto-embed.
- The local backend is an **optional / extra dependency** (SentenceTransformers drags in `torch` — heavy), installed only when actually used.
- Nothing is built for the local backend now — the design just doesn't foreclose it.

## Consequences

Switching Voyage → local is **not a drop-in failover** — it is a corpus-wide migration:

1. **Dimension break.** `voyage-3.5` = 1024-dim, `all-MiniLM-L6-v2` = 384-dim. Chroma pins the dimension at first insert → a switch needs a **new collection + full re-embed of the corpus**, not just new documents.
2. **Global, not per-doc.** The query side ([[(C) Sync Query Path|#6]]) must embed questions with the same backend as the chunks, so the provider choice is corpus-wide.
3. **The pin makes the mismatch *detectable*, not *free*.** The `(model, dim)` stamped on each chunk flags stale-model vectors, but resolving them still means re-embedding.

Keeping the write path single (explicit vectors, `embedding_function=None`) preserves the pin's meaning and keeps one place responsible for embedding.
