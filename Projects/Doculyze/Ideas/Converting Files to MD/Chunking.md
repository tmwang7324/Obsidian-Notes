# Overview (DECISION)
Instead of chunking the raw text of each type of document, I plan to convert every document (*pdf*, *docx*, *txt*, *code*) into a structured markdown format. This allows LangChain's recursive structure-aware text chunker to create more meaningful chunks.

Furthermore, I will also be constraining the chunk sizes to approximately 500-600 tokens using **tiktoken** (unless there is a text structure containing a lot of characters) to reduce context windows for my Transformer. This enables finer embeddings while maintaining overall context.








