---
title: "Enrichments: NER / summary / sentiment, precompute + fallback"
github: https://github.com/tmwang7324/DocuLyze/issues/7
issue: 7
type: ticket
status: open
labels: [ready-for-agent]
parent: "[[0001-SPEC-data-architecture]]"
blocked_by: ["[[0005-embed-chroma-gateway]]"]
project: Doculyze
---

# 07 — Enrichments: NER / summary / sentiment

**Parent:** [[0001-SPEC-data-architecture]]

**What to build:** Once a document is ready, its owner sees a summary, named entities, and sentiment. Enrichments are precomputed at ingest — the worker already holds the parsed text, so they run in the same pass — and stored durably in Firestore keyed by docId (not Redis: enrichment of an immutable document is compute-once-forever). Enrichment failure never blocks the product: the document is still `ready` with the field `null`, and reads go through a `getEnrichment(docId)` seam that computes on demand and backfills Firestore. The seam is also where a read accelerator could later slot in without touching callers.

**Blocked by:** 05 — Embed + Chroma tenant gateway (`ready` semantics and worker pipeline).

**Status:** ready-for-agent

- [ ] Ingest computes summary, NER, and sentiment in the same worker pass and stores them in Firestore keyed by docId.
- [ ] An enrichment step failing leaves the document `ready` with that field `null`; only embed failure means `failed`.
- [ ] Reading a `null` enrichment through `getEnrichment(docId)` computes it on demand and backfills Firestore; the second read hits the stored value.
- [ ] All enrichment reads go through the `getEnrichment` seam — no caller reads the Firestore fields directly.
- [ ] Enrichments surfaced on the document view for `ready` documents.
- [ ] Tests at the worker job-entry seam: enrichment-failure injection → `ready` + `null`; fallback path verified through the seam.
