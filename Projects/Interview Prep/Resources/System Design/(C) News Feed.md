---
type: concept
aliases: [News Feed]
tags: [system-design, classic-question, interview-prep]
updated: 2026-08-28
sources: 0
---

# (C) Design a News Feed

Tests fanout strategies, caching, ranking, and read/write tradeoffs. The canonical social media system design question.

## Requirements to Clarify
- **Functional:** publish posts, view personalized feed, follow/unfollow users, likes/comments?, media?
- **Non-functional:** feed loads in <200ms, near-real-time updates, highly available.
- **Scale:** ~300M daily active users, average user follows 200 people, ~1B feed requests/day.

## High-Level Design

```
Post Service → Fanout Service → Feed Cache (Redis)
                    ↓                    ↓
              Message Queue        Feed Service → Client
                    ↓
           User Feed Storage
```

## Key Decisions

### Fanout Strategy (The Central Question)

| Strategy | How It Works | Pros | Cons |
|---|---|---|---|
| **Fanout-on-write (push)** | When a user posts, copy the post to every follower's feed cache | Fast reads — feed is pre-built | Expensive for users with millions of followers; wasted work for inactive followers |
| **Fanout-on-read (pull)** | When a user opens their feed, fetch posts from all followed users on demand | No wasted writes | Slow reads — must query + merge + rank at request time |
| **Hybrid (the right answer)** | Push for normal users, pull for celebrity users (>100K followers) | Balances write cost and read latency | More complex to implement |

**In interviews:** always propose the hybrid approach and explain why.

### Feed Ranking
- Simple: reverse chronological (newest first).
- Better: ML-based ranking model scoring `relevance = f(affinity, recency, engagement, content_type)`.
- For interviews, mention both and say ML ranking is the production approach but out of scope to design here.

### Feed Cache
- Each user has a pre-computed feed stored in Redis (list of post IDs).
- Feed size capped at ~500 entries (older posts fall off or are fetched from DB).
- On new post, fanout service prepends the post ID to each follower's feed list.

### Post Storage
- **Posts table:** `post_id, author_id, content, media_url, timestamp`.
- **Feed table (materialized):** `user_id, post_id, timestamp` — one row per follower per post.
- SQL for posts (relational, transactions for likes/comments). Feed table can be NoSQL for fast key-based lookups.

## Deep Dive: Fanout Service
1. User publishes a post → Post Service writes to Posts DB.
2. Post Service enqueues a fanout task to the message queue.
3. Fanout workers pull from the queue:
   - Fetch the author's follower list.
   - For each follower (non-celebrity): prepend post ID to their feed in Redis.
   - For celebrity authors: skip fanout; their posts are pulled at read time.
4. On feed request: read user's cached feed from Redis. If user follows celebrities, merge their recent posts in at read time.

## Building Blocks Used
- [[(C) Message Queues]] — async fanout processing
- [[(C) Caching]] — Redis feed cache per user
- [[(C) Databases]] — posts storage, follower graph
- [[(C) Load Balancing]] — distribute feed requests
- [[(C) API Design]] — `POST /posts`, `GET /feed?cursor=...`

## Study Checklist
- [ ] Explain fanout-on-write vs fanout-on-read with tradeoffs
- [ ] Propose the hybrid approach and justify the celebrity threshold
- [ ] Draw the full architecture with fanout workers and feed cache
- [ ] Explain how the feed cache is structured in Redis
- [ ] Discuss ranking (chronological vs ML-based)
- [ ] Calculate fanout cost: 1 post × 200 avg followers = 200 writes
