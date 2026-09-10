---
type: concept
aliases: [Rate Limiter]
tags: [system-design, classic-question, interview-prep]
updated: 2026-08-28
sources: 0
---

# (C) Design a Rate Limiter

Tests algorithm knowledge, distributed counting, and middleware/gateway design. Clean, self-contained question.

## Requirements to Clarify
- **Functional:** limit requests per user/IP/API key within a time window. Return 429 Too Many Requests when exceeded.
- **Non-functional:** low latency (must not add significant overhead), accurate counting, distributed (works across multiple servers).
- **Placement:** API gateway (before app servers) vs application-level middleware.

## High-Level Design

```
Client → API Gateway / Rate Limiter → App Server
                  ↓
            Redis (counters)
```

## Algorithms

### Token Bucket
- A bucket holds up to N tokens. Refills at a fixed rate (e.g., 10 tokens/sec).
- Each request consumes 1 token. If bucket is empty → reject.
- **Pros:** allows short bursts (up to bucket size), smooth over time.
- **Cons:** two parameters to tune (bucket size, refill rate).
- **Used by:** AWS API Gateway, Stripe.

### Leaky Bucket
- Requests enter a FIFO queue. Queue is processed at a fixed rate.
- If queue is full → reject.
- **Pros:** perfectly smooth output rate.
- **Cons:** doesn't handle bursts well; recent requests may wait behind old ones.

### Fixed Window Counter
- Divide time into fixed windows (e.g., 1-minute windows). Count requests per window.
- If count exceeds threshold → reject.
- **Pros:** simple, memory-efficient.
- **Cons:** boundary problem — burst at window edge (e.g., 59:30–60:30) can allow 2× the limit.

### Sliding Window Log
- Store the timestamp of every request. Count requests within the trailing window.
- **Pros:** exact, no boundary problem.
- **Cons:** memory-intensive (stores every timestamp).

### Sliding Window Counter (Best for Interviews)
- Combines fixed window + weighting. Take the current window's count + (previous window's count × overlap percentage).
- **Pros:** memory-efficient, smooths the boundary problem.
- **Cons:** approximate (but close enough for production).

## Distributed Rate Limiting
- **Problem:** with multiple app servers, each server's local counter is incomplete.
- **Solution:** centralized counter in Redis.
  - `INCR user:123:minute:1630000` with `EXPIRE` TTL.
  - Atomic increment → no race conditions.
- **Race condition risk:** INCR + EXPIRE must be atomic (use Lua scripts or `SET NX EX`).
- **Tradeoff:** Redis adds a network hop per request (~1ms). Worth it for accuracy.

## Response Headers
- `X-RateLimit-Limit: 100` — max requests allowed.
- `X-RateLimit-Remaining: 23` — requests left in current window.
- `X-RateLimit-Retry-After: 37` — seconds until the limit resets.

## Building Blocks Used
- [[(C) Caching]] — Redis as the distributed counter store
- [[(C) API Design]] — rate limiting is a core API gateway concern
- [[(C) Load Balancing]] — rate limiter sits between LB and app servers

## Study Checklist
- [ ] Explain all 5 algorithms with tradeoffs
- [ ] Recommend sliding window counter and justify why
- [ ] Explain distributed rate limiting with Redis (atomic INCR)
- [ ] Draw the architecture (where the rate limiter sits)
- [ ] Explain rate limit response headers
- [ ] Discuss what to do when Redis is down (fail open vs fail closed)
