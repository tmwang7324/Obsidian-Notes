# Overview
See here for a complete article about NME: [[raw/Clippings/Named Entity Recognition|Named Entity Recognition]]] 

### Where embeddings alone work fine:
  - "**How does backpropagation work?**" → high similarity with chunks explaining backpropagation
  - "**Explain the termination clause**" → matches chunks about termination
  - Any query where the user's words are semantically close to the chunk's content

### Where embeddings struggle and concepts would help:
  1. **Vocabulary mismatch**. A chunk discusses "stochastic gradient descent" but the user asks about "SGD" or "how the model updates its weights." Embeddings handle synonyms reasonably well, but acronyms and indirect references can drop similarity below the retrieval threshold. A concept tag stochastic gradient descent with a normalized alias SGD would catch this.
  2. **Diluted signal in long chunks.** A 1024-token chunk spends 900 tokens on data preprocessing and 100 tokens mentioning "backpropagation" in passing. The chunk's embedding is dominated by preprocessing semantics. A concept tag would still flag it.
  3. **Cross-document filtering.** "Compare what my uploaded papers say about attention mechanisms." Without concept metadata, you're running similarity search and hoping the top-k results span multiple documents. With concept tags, you can filter to chunks tagged attention mechanism across all docs, then rank.

