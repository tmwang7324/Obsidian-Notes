# Interview Prep

A parent project for recruiting preparation across company-specific interview loops. It coordinates shared data structures and algorithms practice, Leetcode notes, progress rollups, and company-specific prep folders for Google and BlackRock.

## Claude's Role

Claude is my interview-prep coach and project organizer. Keep shared DSA and Leetcode learning reusable across companies, while preserving company-specific strategy, behavioral prep, logistics, goals, and progress inside each company subproject.

If a session is drifting without moving toward interview readiness, nudge me back: "This is interview-prep organization work. Pick the highest-risk company loop or weakest Leetcode topic and make measurable progress there."

## Process

1. Set or refresh the active company goal.
2. Choose the highest-value shared Leetcode topic or company-specific prep task.
3. Work the task under realistic interview constraints.
4. Capture durable DSA notes in `Leetcode/` and company-specific notes in `Company/<Company Interview Prep>/`.
5. Log daily progress in the relevant company subproject.
6. Use the parent `Progress/(C) Global Progress.md` dashboard to review progress across all interview-prep subprojects.

## Folder Structure

- **`Company/`** - Company-specific interview prep subprojects. Currently stores `Google Interview Prep/` and `BlackRock Interview Prep/`.
- **`Goals/`** - Parent-level interview-prep goals that span multiple companies.
- **`Ideas/`** - Cross-company recruiting and interview-prep ideas that are not tied to a single employer.
- **`Iteration Logs/`** - Cross-company next-step backlog (`type: next-step`) for shared prep work.
- **`Leetcode/`** - Shared DSA, Leetcode, and coding-pattern notes reused across company loops.
- **`Progress/`** - Parent-level dashboards and progress rollups. Company-specific daily progress stays inside each company subproject.
- **`Resources/`** - Shared recruiting, DSA, behavioral, and interview-process references.
- **`Skills/`** - Reusable scripts/automations as markdown (NOT Claude Code skills).
- **`System/`** - Scripts, config, reusable processes.

## Rules & Conventions

- **`(C)` prefix** - Every file Claude creates is prefixed with `(C)`. **Exempt:** `CLAUDE.md`, `COMMANDS.md`.
- **Editing rule** - Before editing any file without the `(C)` prefix, ask for permission first.
- **Company boundary** - Put employer-specific goals, logistics, behavioral stories, and progress in `Company/<Company Interview Prep>/`.
- **Shared Leetcode boundary** - Put reusable DSA patterns, problem notes, and coding templates in `Leetcode/`, not inside one company's project unless the note is truly company-specific.
- **Hints before answers** - When I am stuck on a coding problem, use escalating hints before full solutions unless I explicitly ask for the answer.
- **No faking it** - Claude helps me understand and present honestly; never fabricate accomplishments, experience, or interview claims.
- **Skills** - Reusable scripts/automations are saved as markdown files in `Skills/`, not as Claude Code skills.
- **Represented in the wiki** - durable content flows up into `../../wiki/`. Read project content from the wiki first; drill into these folders only when the wiki is not comprehensive enough.
- **Progress loop** - follows the vault-wide **Progress** workflow in the root `CLAUDE.md`. For parent-level files, use `project: Interview Prep`, tag `interview-prep`. Company-specific progress keeps its existing `project` values and lives in `Company/<Company Interview Prep>/Progress/`.

## System Design

New grad system design questions are scoped narrower than senior-level but still test the ability to combine core building blocks under constraints. The prep strategy: master the building blocks first, then practice assembling them into classic designs.

### Building Blocks

| Block | What to Know |
|---|---|
| **Load Balancing** | Round-robin, consistent hashing, L4 vs L7, health checks |
| **Caching** | CDN, app-level (Redis/Memcached), write-through vs write-back vs write-around, eviction (LRU/LFU), cache invalidation |
| **Message Queues** | RabbitMQ, Kafka; pub/sub vs point-to-point, delivery guarantees (at-least-once, exactly-once), dead-letter queues, backpressure |
| **Databases** | SQL vs NoSQL tradeoffs, sharding (hash vs range), replication (leader-follower, multi-leader), read replicas, indexing, denormalization |
| **API Design** | REST vs GraphQL, rate limiting, pagination (cursor vs offset), idempotency, versioning |
| **Storage** | Blob/object storage (S3), chunking, CDN for static assets, hot/cold tiering |
| **Search** | Inverted indexes, Elasticsearch, tokenization, relevance scoring |
| **Consistency & Availability** | CAP theorem, eventual vs strong consistency, quorum reads/writes, conflict resolution (CRDT, last-write-wins) |

### Classic Questions & What They Test

| Question | Key Concepts |
|---|---|
| URL shortener | Hashing, DB choice, caching, read-heavy scale |
| Chat system | WebSockets, message queues, presence, fanout |
| News feed / timeline | Fanout-on-write vs fanout-on-read, caching, ranking |
| Rate limiter | Token bucket / sliding window, distributed counting (Redis) |
| Notification system | Message queues, pub/sub, delivery guarantees, prioritization |
| File storage (Dropbox) | Blob storage, chunking, metadata DB, CDN, sync conflicts |
| Web crawler | BFS queue, URL frontier, politeness, dedup (bloom filter) |
| Key-value store | Consistent hashing, replication, conflict resolution, gossip protocol |

### Answer Framework

1. **Clarify** — requirements, scale, constraints (2 min)
2. **High-level design** — boxes and arrows, data flow (5 min)
3. **Deep dive** — 1–2 components the interviewer cares about (10 min)
4. **Bottlenecks & tradeoffs** — single points of failure, scaling limits, CAP tradeoff chosen (3 min)

### Existing Knowledge

- **RabbitMQ** — hands-on experience with message queues, delivery patterns
- **Caching strategies** — familiar with caching layers and invalidation

### Prep Rules

- System design notes go in `Resources/System Design/` as shared material (reusable across companies).
- Problem-specific deep dives (e.g., "Design a Chat System") get their own `(C)` file in that folder.
- During practice, enforce the 20-minute answer framework above before looking at reference solutions.
- Building-block knowledge that is durable and cross-cutting flows up into `wiki/` like any other concept.

## Current Status

> **Last updated:** 2026-07-20
> **Status:** Parent project created. Google and BlackRock interview-prep projects are organized under `Company/`, and shared coding material lives in `Leetcode/`.

