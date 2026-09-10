---
type: adr
project: Doculyze
status: accepted
adr: 2
aliases: ["ADR-0002", "Embed-Stage Failure Taxonomy"]
tags: [doculyze, adr, ingest, rag]
updated: 2026-07-21
related: ["[[(C) Embed + Chroma Tenant Gateway]]", "[[ADR-0001 RabbitMQ as Ingest Broker]]"]
---

# ADR-0002: Embed-stage failure taxonomy

**Status:** Accepted (2026-07-21) — recorded in the vault per maintainer ruling (ADRs 0002+ live here, not `docs/adr/`).

## Context

Ticket #5's acceptance line said "embed failure → `failed`." Taken literally that would flip a document to `failed` whenever Voyage or Chroma was merely *down* — conflating a **bad document** with a **transient dependency outage**. The domain glossary ([[CONTEXT]]) already fixes `failed` to mean "the document itself cannot be ingested," and reserves the dead-letter path for infrastructure problems. The embed stage must honour that split.

## Decision

Classify embed-stage outcomes by *cause*, not by *which stage raised*:

- **Document-level failure → `failed` + ACK.** The only embed-stage condition that means "bad document" is **empty / whitespace-only extracted text → zero embeddable chunks.** Mark `failed` (object retained, flag-only) and ACK.
- **Infrastructure outage → RAISE → NACK (`requeue=false`) → dead-letter.** Voyage `5xx` / timeout / `429`, or Chroma unreachable. The embedding client does **bounded in-client backoff first**; only a *sustained* outage propagates. The document rests at `processing` (the recoverable resting state) and is replayable from the DLQ.

## Consequences

- `failed` keeps a precise, actionable meaning: bad bytes, parse failure, or no embeddable content — never "a dependency was down."
- A Voyage/Chroma outage never poisons a document; recovery is a DLQ replay, consistent with [[ADR-0001 RabbitMQ as Ingest Broker|ADR-0001]]'s dead-letter design.
- Requires the embedding client to own retry/backoff (bounded) so ordinary `429`s don't reach the DLQ.
- The `processing`/`failed` definitions in [[CONTEXT]] already encode this; no glossary change needed.
