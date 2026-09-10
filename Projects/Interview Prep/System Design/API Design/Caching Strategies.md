# Overview
***Caching Strategies*** is one of the target areas for optimizing API endpoints — reducing repeated round-trips to slow-moving data by storing it closer to (or bypassing) the origin server.

## In-Memory Data Caching
- Store frequently accessed, slow-changing data in **Redis** or **Memcached**, sitting between the app server and the database.
- Lets the API bypass the database entirely for repeated reads of the same data.
- See [[(C) Caching]] for write strategies (write-through / write-back / write-around) and eviction policies (LRU/LFU/TTL) — this is the same layer, viewed from the API's perspective.

## HTTP / Gateway Caching
- Use standard HTTP headers so browsers, clients, and reverse proxies can cache responses without hitting the origin:
  - **`Cache-Control`** — directives like `max-age`, `no-cache`, `private`/`public`.
  - **`ETag`** — a content fingerprint; client sends `If-None-Match`, server replies `304 Not Modified` if unchanged (saves payload, not the round-trip).
- Works naturally for `GET` requests (idempotent, cacheable by default); harder for `POST`-based APIs like GraphQL.
- **In interviews:** mention `ETag` + conditional requests as the "free" caching win before reaching for Redis.

## Edge Caching via CDNs
- Cache static or semi-static API responses at geographically distributed edge nodes (CloudFront, Cloudflare, Fastly).
- Minimizes latency by serving from a location close to the user instead of the origin region.
- Best for public, cacheable, low-personalization responses (e.g. public read APIs, catalog data) — not for per-user or highly dynamic data.

## Key Tradeoffs

| Decision | Tradeoff |
|---|---|
| In-memory cache vs HTTP/CDN cache | Fine-grained invalidation control vs near-zero infra cost |
| Long TTL vs short TTL | Higher hit ratio vs staler data |
| Caching at the edge vs at the app layer | Lowest latency vs easiest invalidation |

## When It Comes Up
- Any read-heavy API question, or a follow-up after the interviewer asks "how would you make this faster?"
- Pairs with [[Database & Query Tuning]] — caching is usually the first lever before touching the query layer.
