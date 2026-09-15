---
type: concept
aliases: [Message Queues]
tags: [system-design, building-block, interview-prep]
updated: 2026-08-28
sources: 0
---

# (C) Message Queues

Decouple producers from consumers by buffering messages in a queue. Enables async processing, load leveling, and fault tolerance.

## Patterns

### Point-to-Point
- One producer, one consumer per message.
- Message is removed from the queue once consumed.
- Use case: task/job queues (e.g., image processing pipeline).

### Pub/Sub (Publish-Subscribe)
- One producer, many consumers (each gets a copy).
- Consumers subscribe to topics/channels.
- Use case: notifications, event broadcasting, news feed fanout.

## Key Systems

| System | Model | Strength |
|---|---|---|
| **RabbitMQ** | Traditional message broker | Flexible routing, acknowledgments, dead-letter queues |
| **Kafka** | Distributed commit log | High throughput, replay, ordered partitions, event streaming |
| **SQS** | Managed queue (AWS) | Zero ops, auto-scaling, visibility timeout |

## Delivery Guarantees
- **At-most-once** — fire and forget. Fast but messages can be lost.
- **At-least-once** — retry until acknowledged. Messages may be delivered multiple times (consumers must be idempotent).
- **Exactly-once** — hardest to achieve. Kafka supports it via idempotent producers + transactional consumers.

## Key Concepts
- **Dead-letter queue (DLQ)** — failed messages are moved here after max retries for later inspection.
- **Backpressure** — when consumers can't keep up, the queue grows. Handle via rate limiting, scaling consumers, or rejecting new messages.
- **Ordering** — Kafka guarantees order within a partition. RabbitMQ guarantees order per queue (single consumer).
- **Consumer groups** — multiple consumers split partitions among themselves for parallel processing (Kafka pattern).

## Key Tradeoffs

| Decision | Tradeoff |
|---|---|
| RabbitMQ vs Kafka | Flexible routing vs high-throughput ordered streaming |
| At-least-once vs exactly-once | Simplicity vs complexity + overhead |
| Queue depth vs latency | Buffering smooths bursts but adds delay |

## When It Comes Up
- Chat systems, notification systems, any async processing pipeline.
- "How do you handle spikes in traffic?" → queue + workers.

## Existing Knowledge
- Hands-on experience with RabbitMQ — routing, acknowledgments, delivery patterns.

## Study Checklist
- [ ] Compare RabbitMQ vs Kafka — architecture and when to pick each
- [ ] Explain delivery guarantees with examples
- [ ] Explain dead-letter queues and backpressure handling
- [ ] Draw a producer → queue → consumer group diagram
