---
type: decision
project: Obsidian Configs
date: 2026-06-08
status: accepted
aliases: ["Decision Capture Pipeline"]
tags: [decision, obsidian-configs]
sources: 2
supersedes:
superseded-by:
---

# (C) Decision Capture Pipeline

**Status:** accepted · **Date:** 2026-06-08 · Builds on [[(C) Decisions in the Wiki]].

## Context

Once decisions + rationale belong in the wiki (see [[(C) Decisions in the Wiki]]), *which skill captures them, and how does a decision get detected?* The [[Should Progress be Included in Wiki (DONE)]] note said to **edit `/record-progress`** to record decisions. But the wiki is `synthesize`'s exclusive territory — `record-progress` is contractually forbidden from writing wiki pages (it writes only inside `Progress/` and `Iteration Logs/`). Letting `record-progress` author wiki ADRs would collapse the clean "one author per layer" boundary.

## Decision

**A `**Decision**` marker hands off to `synthesize` as the sole ADR author; `record-progress` only links up.**

1. **New `**Decision**` marker** — a sibling to the existing `**Important**` override. You flag a decision + its rationale in an `Ideas/` or journal note with `**Decision**`, the same muscle memory as `**Important**` and `(DONE)`. The marker is the **guaranteed** trigger.

2. **`synthesize` authors the ADR.** On its sweep, when it sees `**Decision**`, it writes the immutable `type: decision` record into `wiki/Projects/<Project>/Decisions/` and updates that project's `Architecture.md`. A decision is just a high-stakes case of its existing **significant-topic test**.

3. **Marker first, inference as fallback.** The `**Decision**` marker guarantees capture. If a note contains a clear decision + rationale that *wasn't* marked, `synthesize` may still infer and author an ADR — reported, like a significant topic — as a safety net. Marker = never miss; inference = catch the unmarked.

4. **`record-progress` stays in its lane.** Seeing the same `**Decision**` marker, it writes the dated "Decided X today" line in `Progress/` and **links up** to the ADR by name. Obsidian wikilinks resolve by filename even if `synthesize` hasn't run yet — the link lights up when the page appears. One author per layer: `synthesize` owns the rationale (the *what/why*), `record-progress` owns the *when*.

## Alternatives rejected

- **Edit `/record-progress` to write the wiki records** (as the source note literally said). Rejected — two skills writing the wiki breaks the boundary; `record-progress`'s hard constraint is `Progress/` + `Iteration Logs/` only.
- **Pure inference, no marker.** Rejected — nothing new to remember, but it misses real decisions and invents false ones. The user wants decisions *guaranteed* captured ("under no circumstance should the wiki be missing this info"), so an explicit marker is the floor.
- **Pure marker, no inference.** Rejected as the final design — too brittle; an unmarked decision would vanish. Inference backstops it.

## Consequences

- `synthesize` gains: recognize `**Decision**` (force-author an ADR, like the `**Important**` override), plus inference fallback; author `type: decision` pages + update `Architecture.md`. (Done.)
- `record-progress` needs a follow-up edit: on `**Decision**`, emit the dated line and an up-link to the ADR by name. **(Not yet done — remaining work.)**
- Root `CLAUDE.md` registers the `**Decision**` marker alongside `**Important**` and `(DONE)`/`(INCOMPLETE)`.

## Sources

- [[Should Progress be Included in Wiki (DONE)]] — "edit /record-progress to record key decisions + justification"; the SIGNIFICANT DECISIONS folder.
- [[Track Daily Progress Ideas (IN PROGRESS)]] — the ingest-from-Journals-and-Ideas + `(DONE)`/`(INCOMPLETE)` marker context.
