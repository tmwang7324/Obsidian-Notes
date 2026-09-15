---
type: concept
aliases: [URL Shortener]
tags: [system-design, classic-question, interview-prep]
updated: 2026-08-28
sources: 0
---

# (C) Design a URL Shortener

A classic entry-level system design question. Tests hashing, database choice, caching, and read-heavy scaling.

## Requirements to Clarify
- **Functional:** shorten URL, redirect via short URL, custom aliases?, expiration?, analytics?
- **Non-functional:** read-heavy (100:1 read-to-write ratio typical), low latency redirects, high availability.
- **Scale:** ~100M URLs created/day → ~10B redirects/day (at 100:1).

## High-Level Design

```
Client → Load Balancer → App Server → Cache (Redis) → Database
                              ↓
                        URL Generation Service
```

## Key Decisions

### URL Generation
- **Base62 encoding** — convert an auto-increment ID or counter to `[a-zA-Z0-9]`. 7 characters = 62^7 = ~3.5 trillion unique URLs.
- **MD5/SHA256 hash** — hash the long URL, take first 7 characters. Risk of collisions (check DB on conflict).
- **Pre-generated key store** — generate keys in advance, assign on demand. Avoids collision checking at write time.

### Database Choice
- **SQL (PostgreSQL)** — ACID, simple schema (`short_url, long_url, created_at, expiry`). Works until write throughput demands sharding.
- **NoSQL (DynamoDB/Cassandra)** — key-value lookup is the primary access pattern, which NoSQL handles naturally at scale.
- For interviews, either works — justify the choice.

### Caching
- Read-heavy system → cache is critical.
- Cache the mapping `short_url → long_url` in Redis.
- LRU eviction. Most popular URLs stay hot in cache.
- Cache hit = skip DB entirely → sub-millisecond redirect.

### Redirection
- **301 (Permanent)** — browser caches the redirect. Reduces server load but prevents analytics tracking.
- **302 (Temporary)** — browser always hits the server. Enables click analytics.
- Usually 302 to enable tracking.

## Deep Dive: Scaling

### Sharding
- Shard by hash of short URL key (consistent hashing).
- Each shard handles a subset of the key space.

### Read Replicas
- Write to leader, read from replicas.
- Eventual consistency is fine — a new URL being unavailable for 100ms is acceptable.

## Building Blocks Used
- [[(C) Load Balancing]] — distribute redirect traffic
- [[(C) Caching]] — Redis for hot URL lookups
- [[(C) Databases]] — schema design, sharding for scale
- [[(C) API Design]] — `POST /api/shorten`, `GET /:shortUrl`

## Study Checklist
- [ ] Design the API endpoints
- [ ] Explain Base62 vs hashing for key generation
- [ ] Draw the full architecture diagram
- [ ] Explain caching strategy and eviction
- [ ] Explain sharding approach
- [ ] Calculate storage estimates for 100M URLs/day over 5 years
