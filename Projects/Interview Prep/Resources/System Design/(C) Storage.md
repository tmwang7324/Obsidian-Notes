---
type: concept
aliases: [Storage]
tags: [system-design, building-block, interview-prep]
updated: 2026-08-28
sources: 0
---

# (C) Storage

How to store and serve large files, media, and static assets at scale.

## Blob / Object Storage
- **What:** stores unstructured data (images, videos, documents) as objects with metadata and a unique key.
- **Examples:** AWS S3, Google Cloud Storage, Azure Blob Storage.
- **Key properties:** highly durable (11 9s), horizontally scalable, cheap for large volumes.
- **Access pattern:** write once, read many. Not suitable for frequent updates to the same object.

## Chunking
- Split large files into fixed-size chunks (e.g., 4MB blocks).
- **Why:** enables parallel uploads/downloads, resumable transfers, deduplication.
- **Metadata DB** tracks which chunks belong to which file and their order.
- Used in: Dropbox, Google Drive, any file storage system.

## CDN (Content Delivery Network)
- Geographically distributed edge servers that cache static content close to users.
- **Pull-based** — CDN fetches from origin on first request, then caches. Simple setup.
- **Push-based** — origin pushes content to CDN proactively. Better for predictable, large content.
- Reduces latency and origin server load.

## Hot / Cold / Archive Tiering
- **Hot** — frequently accessed. Standard storage (S3 Standard). High cost, low latency.
- **Cold** — infrequently accessed. Cheaper storage (S3 Infrequent Access). Higher retrieval cost.
- **Archive** — rarely accessed. Cheapest (S3 Glacier). Minutes-to-hours retrieval time.
- Pattern: lifecycle policies automatically move objects between tiers based on age or access frequency.

## Key Tradeoffs

| Decision | Tradeoff |
|---|---|
| Blob store vs file system | Scalability + durability vs POSIX semantics |
| Chunk size | Smaller = better dedup + resumability, larger = less metadata overhead |
| Pull CDN vs push CDN | Simplicity vs control over cache warming |
| Hot vs cold tiering | Access speed vs storage cost |

## When It Comes Up
- File storage (Dropbox/Google Drive), image hosting, video streaming, any system serving media.

## Study Checklist
- [ ] Explain how S3-style object storage works (keys, buckets, metadata)
- [ ] Explain file chunking for large uploads with a metadata DB diagram
- [ ] Explain pull vs push CDN with tradeoffs
- [ ] Explain storage tiering and lifecycle policies
