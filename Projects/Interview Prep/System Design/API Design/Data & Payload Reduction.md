# Overview
***Data & Payload Reduction*** is one of the three target areas for optimizing API endpoints. In this document, I cover the main strategies used to reach the target.
## Pagination

| Strategy         | How It Works              | Pros                                       | Cons                                                         |
| ---------------- | ------------------------- | ------------------------------------------ | ------------------------------------------------------------ |
| **Offset-based** | `?page=3&limit=20`        | Simple to implement, random access         | Skips/duplicates on concurrent inserts, slow at high offsets |
| **Cursor-based** | `?cursor=abc123&limit=20` | Stable under concurrent writes, performant | No random access, opaque cursor                              |

#### Offset-Based Pagination
**Client-Side Parameters:**
* **Limit:** Specifies how many records to fetch per page.
* **Offset:** Indicates where to start fetching data or how many records to skip, defining the initial position within the list
* 
**In interviews:** mention cursor-based for feeds/timelines, offset for admin dashboards.

## Minimize Payload Sizes
- Return only the fields the client actually asked for — avoid over-fetching by default.
- Strip unused nested structures, avoid verbose/redundant JSON keys.
- For internal service-to-service calls, consider binary protocols like **Protocol Buffers** over JSON — smaller payloads, faster (de)serialization.
- Overlaps with the REST vs GraphQL tradeoff in [[(C) API Design]]: GraphQL solves over-fetching by letting the client specify fields; with REST you either version endpoints or add sparse fieldsets (`?fields=id,name`).

## Compress Data
- Apply **GZIP** or **Brotli** compression to shrink text-heavy payloads (JSON, HTML) in transit.
- Brotli generally compresses tighter than GZIP but costs more CPU — GZIP is the safer default under high request volume.
- Client signals support via `Accept-Encoding`; server responds with `Content-Encoding`.
- Biggest win on large, repetitive JSON responses; negligible/negative benefit on already-compressed payloads (images, video).

## Rate Limiting
- Protects services from abuse and ensures fair usage.
- Algorithms: see [[Rate Limiting]] for a deep dive.
- Typically implemented at the API gateway or load balancer layer.

## 



## Idempotency
- A request can be retried safely without side effects.
- GET, PUT, DELETE are naturally idempotent. POST is not.
- Pattern: client sends an idempotency key; server deduplicates.
- Critical for payment systems, order placement — any mutation where retries happen.

## Versioning
- **URL path** — `/v1/users` → `/v2/users`. Simple, explicit.
- **Header-based** — `Accept: application/vnd.api+json;version=2`. Cleaner URLs but less discoverable.
- In interviews, URL path versioning is the safe default.