---
type: concept
aliases: [Databases]
tags: [system-design, building-block, interview-prep]
updated: 2026-08-28
sources: 0
---

# (C) Databases

Choosing the right database and scaling strategy is the most consequential decision in most system designs.

## SQL vs NoSQL

| Dimension | SQL (Relational) | NoSQL |
|---|---|---|
| **Data model** | Tables, rows, schemas, joins | Document (MongoDB), key-value (Redis/DynamoDB), wide-column (Cassandra), graph (Neo4j) |
| **Schema** | Fixed, enforced | Flexible, schema-on-read |
| **Consistency** | Strong (ACID transactions) | Often eventual (BASE), but tunable |
| **Scaling** | Vertical first, horizontal via sharding | Horizontal by design |
| **Best for** | Complex queries, relationships, transactions | High throughput, flexible schemas, massive scale |

**Rule of thumb:** start with SQL unless you have a specific reason not to (schema flexibility, extreme write throughput, or a non-relational data model).

## Scaling Strategies

### Replication
- **Leader-follower** — one writable leader, multiple read-only followers. Scales reads. Risk: replication lag → stale reads.
- **Multi-leader** — multiple writable nodes. Higher availability but conflict resolution is hard.
- **Leaderless** — any node accepts reads/writes (Dynamo-style). Uses quorum (W + R > N) for consistency.

### Sharding (Partitioning)
- **Hash-based** — hash a key to determine shard. Even distribution but range queries are expensive.
- **Range-based** — split by key ranges (e.g., A–M, N–Z). Supports range queries but risks hot spots.
- **Consistent hashing** — minimizes data movement when adding/removing shards.

### Read Replicas
- Offload read traffic to replicas. Write to leader only.
- Common pattern: write to primary → async replicate → read from replica.

## Indexing
- **B-tree indexes** — balanced tree structure. Good for range and equality queries. Default in most SQL DBs.
- **Hash indexes** — O(1) lookups. Equality only, no range.
- **Composite indexes** — index on multiple columns. Order matters for query optimization.
- Over-indexing slows writes — every write updates every index.

## Denormalization
- Duplicate data to avoid expensive joins at read time.
- Tradeoff: faster reads, slower/more complex writes, risk of inconsistency.
- Common in read-heavy systems (e.g., pre-computed news feed tables).

## Key Tradeoffs

| Decision | Tradeoff |
|---|---|
| SQL vs NoSQL | Consistency + joins vs flexibility + horizontal scale |
| Normalize vs denormalize | Write simplicity vs read performance |
| Hash shard vs range shard | Even distribution vs range query support |
| Strong vs eventual consistency | Correctness vs latency + availability |

## When It Comes Up
- Every system design question. The DB choice and scaling approach are always discussed.

## Study Checklist
- [ ] Explain SQL vs NoSQL with concrete examples of when to pick each
- [ ] Explain leader-follower vs leaderless replication
- [ ] Explain hash vs range sharding with tradeoffs
- [ ] Explain indexing strategies and when over-indexing hurts
- [ ] Explain denormalization with a real example (news feed)
