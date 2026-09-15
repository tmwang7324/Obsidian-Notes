---
type: concept
aliases: [Web Crawler]
tags: [system-design, classic-question, interview-prep]
updated: 2026-08-28
sources: 0
---

# (C) Design a Web Crawler

Tests BFS traversal at scale, distributed queuing, deduplication, and politeness. A graph-traversal problem disguised as a system design question.

## Requirements to Clarify
- **Functional:** crawl the web starting from seed URLs, extract and store page content, discover new URLs to crawl.
- **Non-functional:** politeness (don't overload sites), scalable to billions of pages, handle duplicates, respect robots.txt.
- **Scale:** crawl 1B pages/month → ~400 pages/sec sustained.

## High-Level Design

```
Seed URLs → URL Frontier (Priority Queue) → Fetcher Workers → HTML Parser
                    ↑                                              ↓
              URL Filter ←──── Dedup (Bloom Filter) ←──── URL Extractor
                                                               ↓
                                                        Content Storage
                                                               ↓
                                                        Search Indexer
```

## Key Decisions

### URL Frontier
- A priority queue that determines what to crawl next.
- **Priority:** important/fresh pages (news sites, popular domains) get higher priority.
- **Politeness queue:** separate per-host queues so one slow/large site doesn't block others. Each host queue has a crawl delay.
- **Freshness:** re-crawl pages based on change frequency (news = hourly, static docs = weekly).

### Fetcher Workers
- Distributed pool of workers pulling URLs from the frontier.
- Each worker: fetch page → check HTTP status → download content → pass to parser.
- Respect `robots.txt` — fetch and cache it per domain before crawling.
- Handle: redirects, timeouts, retries, malformed HTML.

### Deduplication

#### URL Dedup
- **Bloom filter** — probabilistic data structure. O(1) membership check, small memory footprint.
- False positives (skip a URL we haven't seen) are acceptable. False negatives (recrawl) are not.
- At 1B URLs with 0.1% false positive rate → ~1.2GB memory.

#### Content Dedup
- Compute a content fingerprint (SimHash or MinHash) to detect near-duplicate pages.
- Avoids storing multiple copies of syndicated/mirrored content.

### Content Storage
- Raw HTML stored in blob storage (S3) or a distributed file system (HDFS).
- Metadata (URL, crawl timestamp, status code, content hash) in a database.
- Parsed/extracted content feeds into the search indexer (see [[(C) Search]]).

### Politeness
- **Crawl delay:** wait N seconds between requests to the same host (from `robots.txt` or default 1s).
- **User-Agent:** identify as a crawler.
- **robots.txt compliance:** respect `Disallow` directives. Cache `robots.txt` per domain with TTL.

## Deep Dive: Bloom Filter
- A bit array of size M with K hash functions.
- To add: hash the URL with K functions, set those K bits.
- To check: hash the URL, check if all K bits are set. If yes → probably seen. If no → definitely not seen.
- No deletions (use counting Bloom filter if needed).
- Space-efficient alternative to storing billions of URLs in a hash set.

## Building Blocks Used
- [[(C) Message Queues]] — URL frontier as a distributed priority queue
- [[(C) Storage]] — blob storage for raw HTML content
- [[(C) Databases]] — crawl metadata, robots.txt cache
- [[(C) Search]] — feed crawled content into the search index

## Study Checklist
- [ ] Draw the full crawl loop (frontier → fetch → parse → extract → dedup → frontier)
- [ ] Explain the URL frontier with priority + politeness queues
- [ ] Explain Bloom filters — how they work, false positive rate, memory calculation
- [ ] Explain content dedup with SimHash/MinHash
- [ ] Explain robots.txt compliance
- [ ] Calculate throughput: 1B pages/month = ~400 pages/sec
