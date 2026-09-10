---
type: concept
aliases: [Load Balancing]
tags: [system-design, building-block, interview-prep]
updated: 2026-08-28
sources: 0
---

# (C) Load Balancing

Distributes incoming traffic across multiple servers to prevent any single server from becoming a bottleneck.

## Core Concepts

### Algorithms
- **Round-robin** — requests cycle through servers sequentially. Simple, no state needed. Fails when servers have unequal capacity.
- **Weighted round-robin** — assigns more traffic to stronger servers via weights.
- **Least connections** — routes to the server with fewest active connections. Better for long-lived requests.
- **Consistent hashing** — maps requests to servers via a hash ring. Minimizes redistribution when servers are added/removed. Critical for caching layers and sharded databases.

### L4 vs L7
- **L4 (Transport)** — routes based on IP + port. Faster, no payload inspection. Used for raw TCP/UDP traffic.
- **L7 (Application)** — routes based on HTTP headers, URL path, cookies. Enables content-based routing, sticky sessions, SSL termination.

### Health Checks
- Load balancers ping servers periodically (active) or monitor response codes (passive).
- Unhealthy servers are removed from the pool automatically.

## Key Tradeoffs

| Decision | Tradeoff |
|---|---|
| L4 vs L7 | Throughput vs routing flexibility |
| Sticky sessions | User affinity vs uneven load distribution |
| Single vs multiple LBs | Simplicity vs eliminating single point of failure |

## When It Comes Up
- Any question involving horizontal scaling or high availability.
- Often the first box drawn after the client in a high-level diagram.

## Study Checklist
- [ ] Explain round-robin vs least connections vs consistent hashing
- [ ] Explain L4 vs L7 with examples
- [ ] Draw a diagram with redundant load balancers (active-passive)
- [ ] Explain how health checks work
