# Overview
***Architectural & Execution Flow*** is one of the target areas for optimizing API endpoints — restructuring *when* and *where* work happens during a request, rather than making any single step faster.

## Asynchronous Processing
- Offload heavy, long-running work (emails, report generation, video processing) to background tasks via a message broker (RabbitMQ, Kafka).
- Return an immediate `202 Accepted` to the client and process out-of-band; client polls or receives a webhook/callback on completion.
- Turns a slow synchronous request into a fast one — the work still happens, just not on the client's clock.

## Asynchronous Logging
- Don't write log entries to disk synchronously inside the request thread — disk I/O latency leaks into response time.
- Send log data to an in-memory buffer and flush periodically (or to a separate logging service).
- Same principle as async processing, applied to observability instead of business logic.

## Batch Requests
- Let clients combine multiple related requests into a single network round-trip.
- Eliminates the latency penalty of N round-trips for N related operations (e.g. GraphQL's single query for nested data, or a `/batch` endpoint accepting an array of operations).
- Tradeoff: batch endpoints are harder to cache and to reason about partial failure (what happens if item 3 of 10 fails?).

## Key Tradeoffs

| Decision | Tradeoff |
|---|---|
| Sync vs async processing | Simplicity + immediate result vs fast response + eventual completion |
| Async logging | Lower request latency vs risk of losing recent logs on crash |
| Batching requests | Fewer round-trips vs harder partial-failure semantics |

## When It Comes Up
- "This endpoint does a lot of work — how do you keep it fast?" — the answer is usually "don't do it all synchronously."
- Notification systems, file processing, report generation — see [[(C) Notification System]], [[(C) Message Queues]].
