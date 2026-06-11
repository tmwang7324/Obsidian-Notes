---
type: decision
project: Obsidian Configs
date: 2026-06-08
status: accepted
aliases: ["Decisions in the Wiki"]
tags: [decision, obsidian-configs]
sources: 3
supersedes:
superseded-by:
---

# (C) Decisions in the Wiki

**Status:** accepted · **Date:** 2026-06-08 · Decided in a `/grill-me` session over [[Wiki Structure (DONE)]], [[Should Progress be Included in Wiki (DONE)]], and [[Track Daily Progress Ideas (IN PROGRESS)]].

## Context

The schema said, emphatically and twice, that the wiki holds a project's **identity and purpose only — never its progress** (progress lives solely in `Progress/`). But the [[Should Progress be Included in Wiki (DONE)]] note argued the opposite: progress files contain **key design decisions + rationale**, and "under no circumstance should the wiki be missing this info." Both can't stand as written. Separately, [[Wiki Structure (DONE)]] worried that organizing the wiki by project makes shared-framework examples (Next.js, Firebase) circular, and proposed an `Architecture.md` per project; [[Should Progress be Included in Wiki (DONE)]] proposed a `SIGNIFICANT DECISIONS` folder per project.

## Decision

**Decisions + rationale are durable wiki content — the "no progress in the wiki" rule is refined, not overturned.**

1. **Two altitudes for one fact.** A decision's *rationale* ("we use Firebase Auth because X, rejected NextAuth because Y") is durable knowledge and belongs in the wiki. The *dated changelog* fact ("on 2026-06-08 I switched auth") is progress and stays in `Progress/`. The rule the wiki enforces is now precisely **"no dated changelog content,"** not "no decisions."

2. **Per-project wiki folders.** Each project expands from a single overview page into a folder: `wiki/Projects/<Project>/` containing `(C) <Project>.md` (overview — identity & purpose, unchanged), `(C) Architecture.md`, and a `Decisions/` subfolder. Applied to **every** project, not lazily promoted. Shared frameworks **stay** as domain pages (`wiki/Full Stack Development/…`) that decision records link *into* — this is what kills the circularity [[Wiki Structure (DONE)]] flagged: domain folders = shared concepts, project folder = this project's specific architecture + decisions.

3. **Decision records are ADRs** (Architecture Decision Records): one immutable file per significant decision, `type: decision`, with Context / Decision / Rationale / Alternatives / Consequences. The **rationale is frozen** — you do not edit it when things change. Reversal is handled by writing a *new* decision and setting the old one's `status: superseded` (+ a `superseded-by` link). The one exception: edit a rationale **only on explicit direction**, e.g. to correct one that was factually wrong.

4. **`Architecture.md` vs `Decisions/` — division of labor.** `Architecture.md` is the **mutable current-state summary** (what the system *is* today; overwrite it as it changes; no history) and links *down* to the decisions. `Decisions/*` are the **immutable point-in-time records** of *why*. This split is the only way to avoid the staleness the Lint workflow hunts for: living summary in one place, frozen history in another.

## Alternatives rejected

- **Copy literal day-by-day progress entries into the wiki.** Rejected — that's the dated changelog the rule rightly banishes; it goes stale and bloats context.
- **Editable "living" decision documents.** Rejected — an editable rationale destroys the one thing that can't be reconstructed later: *why you thought what you thought at the time.* Immutable + supersession preserves it.
- **Lazy promotion (folder only once a project earns depth).** Rejected by the user: treat every project as having depth, full folder from day one. (Accepted cost: thin/empty scaffolding for non-coding projects like Golf — the "structure I won't keep up" risk, chosen with eyes open.)
- **A single growing overview page per project.** Rejected — no home for depth; can't separate frozen history from living summary.

## Consequences

- Decision frontmatter: `type: decision`, `project`, `date`, `status: accepted | superseded`, `aliases`, `tags: [decision, <slug>]`, `sources`, and `supersedes` / `superseded-by` links. Powers a per-project Dataview decision log (`TABLE date, status FROM #decision`).
- The schema's "Conditional progress purge" in `synthesize` **must** be amended to spare `type: decision` pages, or the next sweep deletes them as progress. (Done alongside this decision.)
- Capture of decisions is handled by [[(C) Decision Capture Pipeline]]; folder hygiene by [[(C) Archive Not Delete]].
- Root `CLAUDE.md` and the `synthesize` skill updated to bless the decision layer and register `type: decision` + the per-project folder structure.

## Sources

- [[Should Progress be Included in Wiki (DONE)]] — the "yes, decisions belong in the wiki" argument + the Significant Decisions folder idea.
- [[Wiki Structure (DONE)]] — organize-by-project trade-offs, circularity problem, `Architecture.md` proposal.
- [[Track Daily Progress Ideas (IN PROGRESS)]] — the progress-tracking context this sits inside.
