---
type: concept
aliases: [API Design]
tags: [system-design, building-block, interview-prep]
updated: 2026-08-28
sources: 0
---

# (C) API Design

The contract between client and server. Getting this right early in a system design answer shows clarity of thought.

## REST vs GraphQL vs gRPC

| Dimension               | REST                                                     | GraphQL                                                   | gRPC |
| ----------------------- | -------------------------------------------------------- | --------------------------------------------------------- | ---- |
| **Structure**           | Resource-based URLs (`/users/123`)                       | Single endpoint, query language                           |      |
| **Data fetching**       | Fixed response shape per endpoint                        | Client specifies exactly what fields it needs             |      |
| **Over/under-fetching** | Common problem (multiple endpoints or bloated responses) | Solved by design                                          |      |
| **Caching**             | HTTP caching works naturally (GET is cacheable)          | Harder — POST-based, needs application-level caching      |      |
| **Best for**            | CRUD apps, public APIs, simple data models               | Complex/nested data, mobile clients (bandwidth-sensitive) |      |

**In interviews:** default to REST unless the question involves deeply nested data or mobile clients with bandwidth constraints.


## Key Tradeoffs

| Decision | Tradeoff |
|---|---|
| REST vs GraphQL | Simplicity + caching vs flexibility + efficiency |
| Offset vs cursor pagination | Random access vs stability under writes |
| Strict rate limits vs generous | Protection vs developer experience |

## When It Comes Up
- The first thing to define after clarifying requirements. "What APIs does this system expose?"
- URL shortener, notification system, any client-facing system.

## Study Checklist
- [ ] Design a REST API for a given system (URL shortener, chat) with endpoints and HTTP methods
- [ ] Explain cursor vs offset pagination with tradeoffs
- [ ] Explain idempotency and why it matters for POST
- [ ] Explain rate limiting at the API layer
