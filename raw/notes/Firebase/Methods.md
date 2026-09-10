# Overview
There are a lot of important methods and techniques to cover:


## Stream 
The Firestore Python SDK `stream()` method fetches all documents matching a query or collection reference as an iterator. This retrieves data efficiently in chunks rather than pulling the entire dataset into memory all at once.

Choose `stream()` over `get()` for large databases.


