---
type: concept
aliases: [Chat System]
tags: [system-design, classic-question, interview-prep]
updated: 2026-08-28
sources: 0
---

# (C) Design a Chat System

Tests real-time communication, message queues, presence, and fanout. One of the most commonly asked questions.

## Requirements to Clarify
- **Functional:** 1-on-1 chat, group chat?, read receipts?, online/offline status?, message history?, media support?
- **Non-functional:** low latency (<100ms delivery), message ordering, at-least-once delivery, high availability.
- **Scale:** ~50M daily active users, ~1B messages/day.

## High-Level Design

```
Client ←→ WebSocket Server ←→ Message Queue → Chat Service → Database
                                                    ↓
                                              Presence Service
                                                    ↓
                                              Push Notification
```

## Key Decisions

### Real-Time Communication
- **WebSockets** — persistent bidirectional connection. The standard for chat. Client connects once, messages flow both ways.
- **Long polling** — fallback for environments that don't support WebSockets. Client holds a request open until the server has data.
- **Server-Sent Events (SSE)** — server-to-client only. Not suitable for chat (need bidirectional).

### Message Flow (1-on-1)
1. User A sends message via WebSocket to their connected server.
2. Server publishes message to a message queue (Kafka/RabbitMQ).
3. Chat service routes message to User B's connected server.
4. If User B is online → deliver via WebSocket. If offline → push notification.

### Group Chat Fanout
- **Small groups (<100)** — write the message once, fan out on read (each member queries for new messages). Simple.
- **Large groups** — fan out on write (copy message to each member's inbox). Higher write cost but faster reads.

### Message Storage
- **Schema:** `message_id, sender_id, channel_id, content, timestamp, status`.
- **Ordering:** use a time-based ID (Snowflake ID or ULID) for global ordering.
- **Database:** wide-column store (Cassandra/HBase) — optimized for write-heavy, time-series-like access.

### Presence (Online/Offline)
- Heartbeat-based: client sends a heartbeat every N seconds.
- If no heartbeat for 30s → mark offline.
- Store in Redis with TTL. Pub/sub to notify friends of status changes.
- At scale, presence updates are expensive — batch and rate-limit them.

## Deep Dive: Message Ordering & Delivery
- **Ordering:** Snowflake ID embeds timestamp + machine ID + sequence number → globally sortable.
- **Delivery guarantee:** at-least-once. Client acknowledges receipt; server retries if no ack. Client deduplicates by message ID.
- **Read receipts:** store `last_read_message_id` per user per channel. Update on client scroll.

## Building Blocks Used
- [[(C) Message Queues]] — decouple message producers from consumers
- [[(C) Databases]] — wide-column for message storage, Redis for presence
- [[(C) Caching]] — recent messages cache for active conversations
- [[(C) Load Balancing]] — consistent hashing to pin users to WebSocket servers
- [[(C) Consistency and Availability]] — AP for chat (eventual consistency is acceptable)

## Study Checklist
- [ ] Explain WebSockets vs long polling vs SSE
- [ ] Draw the full architecture for 1-on-1 and group chat
- [ ] Explain fanout-on-write vs fanout-on-read for group messages
- [ ] Explain presence detection with heartbeats
- [ ] Explain message ordering with Snowflake IDs
- [ ] Explain offline message delivery via push notifications
