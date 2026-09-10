# Overview




## Firestore Minting

^e3e169

**`ready` = chunks in Chroma (RAG works), nothing more:** 
* Embed-fail → `failed` (no product). 
* Enrichment-fail → **still `ready`**, field `null`. 
* Null reads use **cache-with-fallback**: compute-on-demand, backfill **Firestore** (durable — enrichment of an immutable doc is compute-once-forever).