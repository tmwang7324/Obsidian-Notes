---
type: concept
aliases: [File Storage Service]
tags: [system-design, classic-question, interview-prep]
updated: 2026-08-28
sources: 0
---

# (C) Design a File Storage Service

Think Dropbox or Google Drive. Tests blob storage, chunking, sync conflicts, metadata management, and CDN.

## Requirements to Clarify
- **Functional:** upload/download files, sync across devices, file versioning, sharing (public/private links).
- **Non-functional:** strong consistency for metadata, eventual consistency for file sync, resumable uploads, low latency downloads.
- **Scale:** ~500M users, ~100M daily active, average file size 500KB, 10M uploads/day.

## High-Level Design

```
Client (Sync Agent) → API Gateway → Upload Service → Chunk Server → Blob Store (S3)
                                          ↓                              ↑
                                    Metadata Service ───────────→ Metadata DB
                                          ↓
                                    Notification Service → Other Devices
```

## Key Decisions

### File Chunking
- Split files into fixed-size chunks (e.g., 4MB blocks).
- **Why:** resumable uploads (retry one chunk, not the whole file), deduplication (identical chunks stored once), parallel transfers.
- Each chunk gets a content hash (SHA-256) as its ID → automatic dedup.
- Metadata DB maps `file_id → [chunk_hash_1, chunk_hash_2, ...]`.

### Storage Layer
- Chunks stored in blob storage (S3) keyed by content hash.
- S3 handles durability (11 9s), replication, and tiering.
- Metadata DB (PostgreSQL/MySQL) stores file tree, ownership, permissions, chunk lists, versions.

### Sync Protocol
1. Client detects local file change.
2. Client computes chunk hashes, sends diff (only changed chunks) to upload service.
3. Upload service stores new chunks in S3, updates metadata.
4. Notification service (WebSocket or long poll) tells other devices about the change.
5. Other devices fetch only the changed chunks.

### Conflict Resolution
- **Last-write-wins** — simple but loses data.
- **Better: conflict branches** — save both versions, let the user resolve (Dropbox approach).
- Detect conflicts: if a client pushes a change based on version N, but the server is already at version N+1 → conflict.

### File Versioning
- Each file has a version history (linked list of chunk lists).
- Old versions are retained for N days or M versions.
- Storage optimization: only the changed chunks differ between versions.

### Download Optimization
- Hot files served via CDN (edge-cached).
- Parallel chunk downloads for large files.
- Range requests (`Content-Range` header) for partial downloads.

## Deep Dive: Deduplication
- Content-addressable storage: chunk hash = storage key.
- If two users upload the same file → same chunks → stored once, referenced twice.
- Saves massive storage at scale (documents, shared files across an organization).

## Building Blocks Used
- [[(C) Storage]] — S3 for chunks, CDN for hot files
- [[(C) Databases]] — metadata DB (file tree, versions, permissions)
- [[(C) Caching]] — metadata cache in Redis for active files
- [[(C) Message Queues]] — notify other devices of sync events
- [[(C) Consistency and Availability]] — strong consistency for metadata, eventual for sync

## Study Checklist
- [ ] Explain file chunking with content-hash dedup
- [ ] Draw the full architecture (upload, download, sync flows)
- [ ] Explain the sync protocol (delta sync, only changed chunks)
- [ ] Explain conflict resolution (conflict branches vs LWW)
- [ ] Explain file versioning as a linked list of chunk lists
- [ ] Calculate storage: 500M users × 1GB avg = 500PB. With dedup → significantly less.
