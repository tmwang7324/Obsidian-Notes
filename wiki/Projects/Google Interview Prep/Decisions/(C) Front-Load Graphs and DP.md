---
type: decision
project: Google Interview Prep
date: 2026-06-19
status: accepted
aliases: ["Front-Load Graphs and DP"]
tags: [decision, google-prep, interview-prep]
sources: 1
supersedes:
superseded-by:
---

# (C) Front-Load Graphs and DP

**Status:** accepted · **Date:** 2026-06-19 · Refines (does not supersede) [[(C) Curriculum Strategy|Curriculum Strategy]] — same NeetCode-150 spine, re-sequenced.

## Context

The original [[(C) Curriculum Strategy|curriculum]] set the allocations (DP ~2 weeks, graphs a full week, comfort zones compressed) but ran the calendar roughly easy→hard in topic order, with the hard blocks landing in the *back half*. Two facts forced a reorder: (1) a **graph question sank a previous Google interview** — graphs are an *evidenced* weakness, not a hypothetical one; and (2) the candidate's known failure mode (root `CLAUDE.md`) is retreating into comfortable busy-work under stress, and a calendar that front-loads comfortable topics feeds exactly that relapse.

## Decision

- **Front-load the two hardest, highest-yield blocks into the peak-energy middle:** **Graphs Jun 22–Jul 1**, then **DP Jul 2–16** — the prime hours go to the wound and the boss fight, not to warm-up.
- **Demote the comfortable topics** (arrays/hashing, two pointers, sliding window, trees, heaps, BST, linked lists) from dedicated study to **timed confirmation sweeps + ~30 min/day spaced review** — *prove* they're airtight, don't re-grind them.
- **Master-check gates get *stricter*** for the front-loaded topics, not looser — because "feel" lied on graphs last time, the graph block ends with a **cold, timed** medium, no "done on feel."
- **Keep a short Trees wrap (now–Jun 21)** — only because tree recursion is the DP on-ramp (recursion → memo → table), not because trees need more time.
- **The Doculyze MVP track** loses its daytime window and lives in **weekday-evening margins only**, with a **hard pause during DP (Jul 2–16)** — DSA's daily block always comes first.

## Rationale

- Spend peak cognitive energy on the topics that are both **high-frequency** and **the candidate's weak spots** — that's where hours convert to offer-probability. Comfortable topics have low marginal return per hour.
- Graphs is the one topic with **direct evidence** of failure in a real Google loop; weighting by evidenced risk beats weighting by syllabus order.
- Front-loading the hard work is the structural cure for the busy-work relapse: if the comfortable topics aren't on the calendar as "study," there's nothing to hide in.
- Spaced review keeps the known material warm without burning a dedicated week — capturing most of the retention benefit at a fraction of the time cost.

## Alternatives rejected

- **Keep the easy→hard ordering** (hard blocks in the back half) — rejected: it both delays the evidenced weakness and invites the comfort-work relapse in the high-energy early weeks.
- **Cut comfortable topics entirely** — rejected: they decay without contact; ~30 min/day spaced review is the cheap insurance.
- **Expand the Doculyze build with the freed daytime hours** — rejected: it's a behavioral talking point with low marginal return; the extra hours go to DP, and the build is *cut, not extended*, if it bleeds into the DP block.

## Consequences

- The dated week-by-week calendar lives in `Goals/(C) Google SWE Offer Roadmap.md` (planning, not wiki); this record captures the *why*.
- Comfortable topics are now a known **under-confirmation risk** ("moderately versed" quietly becoming "under-confirmed") — mitigated by stricter master-check gates and the timed sweeps.
- If DP clicks early and time frees up, re-weighting is a *new* decision that supersedes this one, not an edit.

## Sources

- [[(C) Google SWE Offer Roadmap]] — the 2026-06-19 roadmap reorder (front-loaded graphs + DP; comfortable topics → confirmation sweeps + spaced review).
