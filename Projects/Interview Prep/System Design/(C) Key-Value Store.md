---
type: concept
aliases: [Key-Value Store]
tags: [system-design, classic-question, interview-prep]
updated: 2026-08-28
sources: 0
---

# (C) Design a Key-Value Store

Tests distributed systems fundamentals — consistent hashing, replication, conflict resolution, and failure detection. The most theory-heavy classic question.

## Requirements to Clarify
- **Functional:** `put(key, value)`, `get(key)`. Tunable consistency. High availability.
- **Non-functional:** low latency (<10ms), partition-tolerant, horizontally scalable, durable.
- **Scale:** millions of operations per second, petabytes of storage.

## High-Level Design

```
Client → Coordinator Node → Consistent Hash Ring → Replica Nodes
                                                        ↓
                                                  Local Storage
                                                  (LSM Tree / SSTables)
```

## Key Decisions

### Data Partitioning: Consistent Hashing
- Hash both keys and nodes onto a ring (0 to 2^128).
- A key is stored on the first N nodes clockwise from its hash position.
- **Virtual nodes:** each physical node maps to multiple positions on the ring → better load distribution.
- Adding/removing a node only affects its immediate neighbors → minimal data movement.

### Replication
- Each key is replicated to N nodes (e.g., N=3).
- Replicas are chosen as the next N distinct physical nodes on the ring.
- **Consistency tuning:** client specifies W (write quorum) and R (read quorum).
  - W=1, R=1 → fast but weak consistency.
  - W=2, R=2 (with N=3) → strong consistency (W + R > N).
  - W=1, R=3 → fast writes, strong reads.

### Write Path (LSM Tree)
1. Write to an in-memory **memtable** (sorted tree).
2. Also append to a **write-ahead log (WAL)** for durability.
3. When memtable exceeds threshold → flush to disk as an immutable **SSTable** (Sorted String Table).
4. Background compaction merges SSTables to reduce read amplification.

### Read Path
1. Check memtable first (most recent writes).
2. Check SSTables from newest to oldest.
3. **Bloom filter** per SSTable to skip SSTables that definitely don't contain the key.

### Conflict Resolution
- With multiple replicas accepting writes, conflicts arise.
- **Vector clocks** — each node maintains a version vector. Detects whether writes are causally related or concurrent.
  - Causally related → take the later one.
  - Concurrent → surface both to the application for resolution.
- **Last-write-wins (LWW)** — simpler but loses data. Acceptable for some use cases (session stores).
- See [[(C) Consistency and Availability]] for deeper treatment.

### Failure Detection: Gossip Protocol
- Each node periodically pings random other nodes and shares its membership list.
- If a node fails to respond after multiple rounds → marked as suspected down.
- Eventually all nodes converge on the same view of cluster membership.
- No single point of failure (unlike a centralized health checker).

### Failure Handling
- **Hinted handoff** — if a replica is temporarily down, another node stores the write with a "hint." When the node recovers, the hint is replayed.
- **Anti-entropy (Merkle trees)** — nodes compare hash trees of their data ranges to detect and repair inconsistencies.

## Deep Dive: Consistency Tuning

| Configuration | Behavior | Use Case |
|---|---|---|
| W=1, R=N | Fast writes, slow reads, strong consistency | Write-heavy, read-rare |
| W=N, R=1 | Slow writes, fast reads, strong consistency | Read-heavy, write-rare |
| W=⌈N/2⌉+1, R=⌈N/2⌉+1 | Balanced, strong consistency | General purpose |
| W=1, R=1 | Fastest, eventual consistency | Session stores, caches |

## Real-World Systems
- **DynamoDB** — AWS managed. Consistent hashing, tunable consistency.
- **Cassandra** — open source. Consistent hashing, tunable W/R, gossip protocol.
- **Riak** — CRDTs for automatic conflict resolution.

## Building Blocks Used
- [[(C) Consistency and Availability]] — CAP tradeoffs, quorum, conflict resolution
- [[(C) Databases]] — LSM trees, SSTables, replication
- [[(C) Load Balancing]] — consistent hashing for key distribution

## Study Checklist
- [ ] Explain consistent hashing with virtual nodes
- [ ] Explain the write path (memtable → WAL → SSTable → compaction)
- [ ] Explain the read path with Bloom filter optimization
- [ ] Explain vector clocks vs LWW for conflict resolution
- [ ] Explain gossip protocol for failure detection
- [ ] Explain hinted handoff and Merkle tree anti-entropy
- [ ] Tune W/R/N for different consistency requirements
