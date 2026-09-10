# Overview
Chunking is a key step in the retrieval process of a Retrieval Augmented Generation application. It invokes breaking a document into pieces that each satisfy the context limit of **embedding models.**
A key ***challenge*** to chunking is splitting the text in a way that does not break ideas apart.

## Fixed-Size Chunking
Splits text into uniform blocks of a **set token or character** count. It is simple and fast, but it can cut sentences in half and ruin context.
A simple fix can be to use the ***Sliding Window Chunking*** strategy to generate heavily overlapping segments.

## Recursive Character Chunking
Tests a hierarchy of natural separators --- such as paragraphs (`\n\n`), headers in markdown `#`, `##`, `###`


## Token Count Chunking

## Semantic Chunking