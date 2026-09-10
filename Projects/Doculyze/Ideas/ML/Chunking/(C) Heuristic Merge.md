---
type: idea
project: Doculyze
status: incomplete
aliases: [Heuristic Merge]
tags: [chunking, doculyze]
updated: 2026-08-10
---

# (C) Heuristic Merge

**Status:** Reverted to original size-based merge. Algorithm and thresholds exist only in conversation context; helper functions were removed from the codebase.

## Problem

`merged_chunks` in `ingest-worker/src/ingest/parsercomparison.py` merges adjacent undersized chunks (below `min_tokens=64`) into their neighbor as long as the combined size fits within `max_tokens=1024`. This is purely size-based with no semantic awareness. It buries small high-signal sections inside unrelated prose — e.g., a 21-token "Contact" section (just investor email addresses) gets merged into a 442-token "About Non-GAAP Financial Measures" boilerplate disclaimer. A retrieval query like "investor relations email" has to match against a chunk whose embedding is 95% legal prose.

## Proposed approach

Replace the blind size-based merge with a `_should_merge()` predicate using three cheap, non-embedding signals:

1. **Heading-level gate** — sibling H2 headings raise the bar for merging (require stronger evidence of relatedness).
2. **Vocabulary overlap (Jaccard)** — `|A intersect B| / |A union B|` on lowercased word sets with stopwords removed; threshold ~0.15.
3. **Size-ratio guard** — `smaller / larger`; threshold ~0.15 (blocks a 21-token chunk merging into a 442-token one).

Merge rule: for sibling H2 headings, require *both* Jaccard and size-ratio to pass. For non-siblings, require *either*.

## Why it failed

### Bug: heading-level detection

`_heading_level()` checked metadata keys in order (`title` -> `section_title` -> `subsection_title`) and returned on the first match. Every chunk carries the document-level `title` key ("Alphabet Announces First Quarter 2026 Results"), so it always returned level 1 — making every pair look like "sibling H1s" and requiring both signals to pass (too strict).

### Thresholds too aggressive even after the bug fix

Sections that *should* merge ("Q1 Supplemental Info" 25 tokens + "Revenues, TAC" 233 tokens) have Jaccard=0.038 and size-ratio=0.107 — both below 0.15. Meanwhile the Contact section we want to *block* has Jaccard=0.000 and ratio=0.048.

### Core tension

Contact (21 tokens) and stub headings like "Q1 Supplemental Info" (25 tokens) look numerically similar — both tiny, both low vocab overlap. But Contact is a complete standalone section with retrievable info (emails), while the stub is an empty parent heading whose body was split into a table chunk. Distinguishing them without embeddings would likely need:

- **Content-shape detection** — is the chunk just a heading, or does it have body text?
- **Two-pass merge** — try forward then backward, pick better match.
- **Much lower thresholds** — risks re-merging Contact into unrelated prose.

## Open questions

- Can content-shape detection (heading-only vs. heading + body) reliably separate stub headings from small standalone sections?
- Would an embedding-aware merge (cosine similarity between adjacent chunks) be worth the cost at ingest time?
- Is a two-pass directional merge (forward then backward, pick best) enough to fix the stub-heading problem without embeddings?
