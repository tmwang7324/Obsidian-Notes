---
type: concept
aliases: [Caching]
tags: [system-design, building-block, interview-prep]
updated: 2026-08-28
sources: 0
---

# (C) Caching

Store frequently accessed data closer to the consumer to reduce latency and database load.

## Cache Layers

1. **Client-side** — browser cache, HTTP cache headers (`Cache-Control`, `ETag`).
2. **CDN** — geographically distributed edge caches for static assets (images, JS, CSS). Examples: CloudFront, Cloudflare.
3. **Application-level** — in-memory stores like **Redis** or **Memcached** sitting between the app server and DB.
4. **Database query cache** — DB-native caching of query results (often disabled in production for unpredictable invalidation).

## Write Strategies

| Strategy | How It Works | Pros | Cons |
|---|---|---|---|
| **Write-through** | Write to cache and DB simultaneously | Strong consistency | Higher write latency |
| **Write-back (write-behind)** | Write to cache first, async flush to DB | Low write latency | Risk of data loss if cache crashes |
| **Write-around** | Write directly to DB, cache on read miss | Avoids cache pollution | First read is always a miss |

## Eviction Policies
- **LRU (Least Recently Used)** — evicts the item not accessed for the longest time. Most common default.
- **LFU (Least Frequently Used)** — evicts the item with the fewest accesses. Better for skewed access patterns.
- **TTL (Time to Live)** — entries expire after a set duration regardless of access.

## Cache Invalidation
The hardest problem in caching. Approaches:
- **TTL-based** — simple but stale data until expiry.
- **Event-driven** — invalidate on write. Requires pub/sub or hooks.
- **Versioned keys** — append version number to cache key; new version = automatic miss.

## Key Tradeoffs

| Decision | Tradeoff |
|---|---|
| Cache hit ratio vs freshness | Higher TTL = more hits but staler data |
| Write-through vs write-back | Consistency vs write performance |
| Local cache vs distributed cache | Speed vs consistency across instances |

## When It Comes Up
- Almost every system design question. "Where would you add a cache?" is a standard follow-up.
- URL shortener, news feed, and any read-heavy system.

## Existing Knowledge
- Familiar with caching strategies and invalidation patterns from prior experience.

## Study Checklist
- [ ] Explain write-through vs write-back vs write-around with diagrams
- [ ] Explain LRU vs LFU and when to pick each
- [ ] Describe cache invalidation strategies and their failure modes
- [ ] Explain CDN caching and cache headers
