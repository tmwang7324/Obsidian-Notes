---
type: concept
aliases: [Consistency and Availability, CAP Theorem]
tags: [system-design, building-block, interview-prep]
updated: 2026-08-28
sources: 0
---

# (C) Consistency and Availability

The most important theoretical framework for distributed system design decisions.

## CAP Theorem
In a distributed system experiencing a **network partition** (P), you must choose between:
- **Consistency (C)** — every read returns the most recent write or an error.
- **Availability (A)** — every request receives a response (no errors), but the data may be stale.

**Key insight:** CAP is about behavior *during* a partition. When the network is healthy, you can have both C and A. The real question is: what does your system do when nodes can't talk to each other?

- **CP systems** — reject requests rather than serve stale data. Examples: HBase, MongoDB (in certain configs), ZooKeeper.
- **AP systems** — always respond, even if data is stale. Examples: Cassandra, DynamoDB, CouchDB.
- **CA** — not practically achievable in distributed systems (no partition tolerance = single node).

## Consistency Models

| Model | Guarantee | Example |
|---|---|---|
| **Strong (linearizable)** | Reads always see the latest write | Single-leader DB with sync replication |
| **Sequential** | All nodes see operations in the same order (may lag behind real-time) | ZooKeeper |
| **Causal** | Causally related operations are seen in order; concurrent ops may differ | CRDT-based systems |
| **Eventual** | All replicas converge *eventually*; reads may be stale temporarily | Cassandra, DynamoDB, DNS |

## Quorum Reads/Writes
- With N replicas, require W writes and R reads where **W + R > N** for strong consistency.
- Example: N=3, W=2, R=2 → at least one node in any read quorum has the latest write.
- Tunable: lower W or R for better performance at the cost of consistency.

## Conflict Resolution
When concurrent writes happen (especially in AP/leaderless systems):
- **Last-write-wins (LWW)** — timestamp-based. Simple but loses data.
- **Vector clocks** — track causal history. Detect conflicts but don't resolve them (app must merge).
- **CRDTs (Conflict-free Replicated Data Types)** — data structures that merge automatically without conflicts. Examples: counters, sets, registers.

## Key Tradeoffs

| Decision | Tradeoff |
|---|---|
| CP vs AP | Correctness vs uptime during partitions |
| Strong vs eventual consistency | Latency vs data freshness guarantees |
| Quorum size | Consistency vs read/write latency |
| LWW vs CRDTs | Simplicity vs data preservation |

## When It Comes Up
- Every system design question implicitly. The interviewer wants to hear you reason about this.
- "What happens if this node goes down?" → availability vs consistency choice.
- Chat systems (eventual is fine for messages), payment systems (strong consistency required).

## Study Checklist
- [ ] Explain CAP theorem — what it actually says (partition behavior, not a three-way pick)
- [ ] Give examples of CP vs AP systems and why they made that choice
- [ ] Explain quorum reads/writes with N=3, W=2, R=2
- [ ] Explain eventual consistency with a real scenario (DNS propagation, social media likes)
- [ ] Explain CRDTs at a high level (what problem they solve, one example)
