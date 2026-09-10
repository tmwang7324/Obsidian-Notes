---
type: concept
aliases: [Notification System]
tags: [system-design, classic-question, interview-prep]
updated: 2026-08-28
sources: 0
---

# (C) Design a Notification System

Tests message queues, pub/sub, delivery guarantees, and multi-channel routing. Practical and commonly asked.

## Requirements to Clarify
- **Functional:** send push notifications (iOS/Android), SMS, and email. Support scheduling, templates, user preferences.
- **Non-functional:** at-least-once delivery, near-real-time for push/SMS, scalable to billions of notifications/day.
- **Scale:** ~10M daily active users, ~1B notifications/day across all channels.

## High-Level Design

```
Event Producers → Message Queue → Notification Service → Channel Routers
                                        ↓                      ↓
                                  Template Engine      Push / SMS / Email
                                        ↓                 (3rd party)
                                  User Preferences DB
```

## Key Decisions

### Event-Driven Architecture
- Upstream services (order service, social service, etc.) emit events, not notifications.
- The notification system subscribes to events and decides what/how to notify.
- Decouples business logic from notification logic.

### Message Queue
- Central queue (Kafka) buffers all notification requests.
- **Why Kafka:** ordered, durable, replayable. If a downstream channel fails, messages are retained.
- Separate topics per channel (push, SMS, email) for independent scaling.

### Channel Routing
- Each channel has its own worker pool consuming from its Kafka topic.
- **Push:** APNs (Apple) and FCM (Google). Requires device tokens stored per user.
- **SMS:** third-party provider (Twilio). Requires phone number.
- **Email:** third-party provider (SendGrid/SES). Requires email address.

### User Preferences
- Users opt in/out of channels and notification types.
- Preference check happens before enqueuing to a channel topic — don't waste resources.
- Schema: `user_id, channel, notification_type, enabled`.

### Delivery Guarantees
- **At-least-once:** retry on failure. Risk of duplicate notifications.
- **Deduplication:** store a `notification_id` with TTL. Check before sending. Idempotency at the channel layer.
- **DLQ (Dead-Letter Queue):** after max retries, move to DLQ for manual inspection.

### Rate Limiting & Prioritization
- Rate-limit per user (don't spam — max N notifications/hour).
- Priority levels: urgent (security alerts, OTP) > high (social interactions) > low (marketing).
- Urgent bypasses rate limits.

### Template Engine
- Notifications are rendered from templates + variables, not hardcoded strings.
- Enables A/B testing, localization, and reuse across events.

## Deep Dive: Reliability
1. Producer sends event → Kafka persists it (durable).
2. Notification service consumes, checks preferences, renders template, enqueues to channel topic.
3. Channel worker sends via third-party API.
4. On success → mark as delivered. On failure → retry with exponential backoff.
5. After max retries → move to DLQ.
6. Analytics service tracks delivery rates, open rates, click rates.

## Building Blocks Used
- [[(C) Message Queues]] — Kafka for event buffering and channel topics
- [[(C) Databases]] — user preferences, device tokens, delivery logs
- [[(C) API Design]] — rate limiting per user, event schema
- [[(C) Caching]] — cache user preferences and templates in Redis

## Study Checklist
- [ ] Draw the full architecture with event producers, queue, and channel routers
- [ ] Explain why event-driven (not direct send) is the right approach
- [ ] Explain at-least-once delivery with deduplication
- [ ] Explain DLQ and retry with exponential backoff
- [ ] Explain user preferences and rate limiting
- [ ] Discuss what happens if a third-party channel (APNs) goes down
