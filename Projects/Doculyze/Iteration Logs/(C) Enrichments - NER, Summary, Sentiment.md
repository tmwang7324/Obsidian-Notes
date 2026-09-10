---
type: next-step
project: Doculyze
status: open
effort: M
aliases:
  - Enrichments - NER, Summary, Sentiment
tags:
  - next-step
  - doculyze
github: https://github.com/tmwang7324/DocuLyze/issues/7
issue: 7
parent: "[[(C) RAG Ingest and Query Data Architecture]]"
blocked_by: ["[[(C) Embed + Chroma Tenant Gateway]]"]
updated: 2026-07-20
---

# (C) Enrichments - NER, Summary, Sentiment

*Precompute at ingest, precompute + fallback on read.*

**Next step.** Once a document is ready, its owner sees a summary, named entities, and sentiment. Enrichments are precomputed at ingest — the worker already holds the parsed text, so they run in the same pass — and stored durably in Firestore keyed by docId (not Redis: enrichment of an immutable document is compute-once-forever). Enrichment failure never blocks the product: the document is still `ready` with the field `null`, and reads go through a `getEnrichment(docId)` seam that computes on demand and backfills Firestore. The seam is also where a read accelerator could later slot in without touching callers.

## Acceptance criteria
- [ ] Ingest computes summary, NER, and sentiment in the same worker pass and stores them in Firestore keyed by docId.
- [ ] An enrichment step failing leaves the document `ready` with that field `null`; only embed failure means `failed`.
- [ ] Reading a `null` enrichment through `getEnrichment(docId)` computes it on demand and backfills Firestore; the second read hits the stored value.
- [ ] All enrichment reads go through the `getEnrichment` seam — no caller reads the Firestore fields directly.
- [ ] Enrichments surfaced on the document view for `ready` documents.
- [ ] Tests at the worker job-entry seam: enrichment-failure injection → `ready` + `null`; fallback path verified through the seam.

- **Effort:** M — extends the existing ingest worker with a new enrichment pass, adds the `getEnrichment` read seam plus Firestore fields and a document-view surface, and needs failure-injection tests; no new service or container.
- **Blocked by:** 05 — Embed + Chroma tenant gateway (`ready` semantics and worker pipeline).
- **Surfaced by:** [[(C) RAG Ingest and Query Data Architecture|the data-architecture SPEC]] · GitHub issue #7
