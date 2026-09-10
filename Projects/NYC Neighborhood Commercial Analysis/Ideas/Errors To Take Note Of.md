# VoyageAI Input Type
The newer embedding models of Voyage are **asymmetric,** which means that they allow different models (heavier for documents, lighter for user queries) to map specific text types to the same exact coordinate system.
```python
import voyageai
vo = voyageai.Client()
documents_embeddings = vo.embed(
	documents, model='voyage-4-large', input_type="document"
	).embeddings
```
`embed` has the parameter `input_type` that specifies whether the string to be embedded is a *query* or a *document.*

On the other hand, OpenAI and SentenceTransformers ignore this option, and thus `input_type` is rendered as **No-op.** 


