---
type: decision
project: Obsidian Configs
date: 2026-06-08
status: accepted
aliases: ["Archive Not Delete"]
tags: [decision, obsidian-configs]
sources: 1
supersedes:
superseded-by:
---

# (C) Archive Not Delete

**Status:** accepted · **Date:** 2026-06-08 · Resolves the "Need More Thinking" item in [[Track Daily Progress Ideas (IN PROGRESS)]].

## Context

[[Track Daily Progress Ideas (IN PROGRESS)]] flagged an open question: *what happens to a raw note once it's been synthesized + progress-recorded?* The instinct in the note was **"delete them based on an LRU cache structure."** The real pain underneath, on grilling: **`Ideas/` folders get cluttered** and finished notes drown the open ones. (Not storage; not reprocessing.)

## Decision

**Never delete. Archive at most — and only fully-processed notes, with confirmation.**

1. **No deletion.** Deleting a source note breaks the citation model (both `synthesize` and `record-progress` cite sources as wikilinks → dangling links), destroys source-of-truth (the wiki is a *lossy* synthesis; the note holds more than was promoted), and answers a non-question (LRU reclaims *space* in a capacity-bounded cache — markdown has no space pressure, and reprocessing is already prevented by `(C) Synthesis Manifest.md`).

2. **Archive instead.** Move a fully-processed note into an `Ideas/Archive/` subfolder inside its project. Wikilinks resolve by *filename*, not path, so every citation survives the move untouched. Both scanners (`synthesize`'s sweep and `record-progress`'s `scan_day.ps1`) **skip any `Archive/` folder**, so archived notes are never re-scanned.

3. **Triple eligibility gate** — a note is archivable only when **all three** hold: it is **`(DONE)`-marked**, **present in the manifest** (actually synthesized), **and** a **`Progress/` entry cites it** (the changelog caught it too). `(DONE)` alone might not be captured; synthesized alone could yank an `(INCOMPLETE)` note mid-work; the progress check guarantees the full loop ran.

4. **The carve-out.** This is the **first and only** time a skill may touch the source layer: `synthesize` may **relocate** a fully-processed source note — **never alter its content** — into `Ideas/Archive/`, and **only with the user's confirmation** (it shows the eligible notes and waits for approval). `synthesize` runs it as a final step because it already holds the manifest.

## Alternatives rejected

- **LRU deletion** (the source note's instinct). Rejected on all three counts above.
- **Archive into the project's existing `Done/` folder.** Rejected — `Done/` is for project deliverables, and not every project has one; `Ideas/Archive/` is uniform and co-located with the active notes.
- **Do nothing** (rely on `(DONE)` markers + manifest). Considered — it solves reprocessing, but not the actual clutter complaint, so archiving wins.
- **Gate on `(DONE)` + synthesized only** (drop the progress check). Rejected by the user in favor of the stricter triple gate, accepting that a `(DONE)` note never warranting a progress entry would never archive (re-clutter risk).

## Consequences

- **Archiving lags by one cycle:** because the gate requires a progress entry, a note synthesized tonight won't archive until a later `synthesize` run *after* `record-progress` has logged it. Archiving is never instant — accepted.
- `synthesize` checks the third condition by scanning `Progress/<week>/` for a wikilink to the note's filename.
- The vault contract's "never edit source files" gains a single narrow exception: **relocate-only, fully-processed, user-confirmed.** Content is never modified.
- `record-progress`'s `scan_day.ps1` needs a follow-up edit to exclude `Archive/`. **(Not yet done — remaining work.)**

## Sources

- [[Track Daily Progress Ideas (IN PROGRESS)]] — the "what to do with already-synthesized notes? delete via LRU" open question.
