# Overview
***Database & Query Tuning*** is one of the target areas for optimizing API endpoints — most slow API response times trace back to the database layer, not the application code.

## Optimize Queries and Indexing
- Slow, unindexed queries are the **primary cause** of poor API response times — profile before guessing.
- Ensure tables are properly indexed on columns used in `WHERE`, `JOIN`, and `ORDER BY` clauses.
- Eliminate unnecessary joins; denormalize where read patterns justify it (see [[(C) Databases]]).
- Watch for N+1 query patterns — one query per item in a list instead of one batched query.

## Connection Pooling
- Opening/closing a DB connection per request is expensive (TCP handshake, auth, session setup).
- Maintain a pre-allocated pool of reusable connections shared across requests.
- Drastically lowers response times under heavy concurrent load; pool size needs tuning against DB max-connections limits.

## Key Tradeoffs

| Decision | Tradeoff |
|---|---|
| Add an index | Faster reads vs slower writes + storage overhead |
| Denormalize | Faster reads vs data duplication + harder consistency |
| Larger connection pool | More concurrency vs risk of exhausting DB connection limits |

## When It Comes Up
- Any "the API is slow, how do you debug it?" follow-up — start here before caching or infra.
- Pairs with [[Caching Strategies]] — caching hides a slow query, tuning fixes it.
