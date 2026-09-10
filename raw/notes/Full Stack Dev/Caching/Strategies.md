# Overview
Redis caching strategies define how my application interacts with the Redis server to read, write, and manage cached data. Choosing the right pattern directly impacts my **system's latency**, **scaling capacity**, and **data consistency**.

## 1. Cache-Aside (Lazy Loading)
**How it works:** The application first checks the Redis cache. If the data exists *(cache hit)*, it is returned. If not *(cache miss)*, the app fetches the data from the primary database, writes it to the cache, and then retunrs it to the client.

## 2. 



