---
type: decision
project: Obsidian Configs
date: 2026-06-17
status: accepted
aliases: ["Daily Note Frontmatter"]
tags: [decision, obsidian-configs]
sources: 2
supersedes:
superseded-by:
---

# (C) Daily Note Frontmatter

**Status:** accepted · **Date:** 2026-06-17 · Marked `(DECISION)` in the source note.

## Context

Daily journal notes were **isolated** from the rest of the vault — aside from feeding `Progress/` as narrative, they linked to little else and were awkward to navigate day-to-day. There was also friction bouncing between the day's journal and the day's daily-plan file (two separate notes for the same day).

## Decision

Every daily note is created from a **Daily Note Template** with structured YAML frontmatter and a fixed body skeleton:

- **Frontmatter fields:** `date`, `tags` (what the day covered), `mood`, `productivity`, `goals`.
- **Prev/next navigation arrows** in the body linking yesterday ↔ today ↔ tomorrow, e.g. `<< [[{{yesterday}}|yesterday]] | [[{{date}}|today]] | [[{{tomorrow}}|tomorrow]] >>`.
- **Embed the current day's daily-plan file** under an `## Agenda` section (`![[…daily plan…]]`) so the plan is visible *inside* the journal but still edited in its own file.
- Wired via **Settings → Daily notes → Template file location**, pointing at the template note.

## Rationale

- **Connect the daily notes into the graph** — frontmatter tags + nav arrows turn isolated logs into a navigable, linked spine, fixing the "islands" problem.
- **Kill the journal ↔ plan context-switch** — embedding the plan in the journal removes the back-and-forth, while keeping the plan in its own file preserves the editing rule and the same-date plan↔progress diff.
- `mood` / `productivity` / `goals` make the day's accountability data queryable rather than buried in prose.

## Alternatives rejected

- **Plain unstructured journals** (status quo) — rejected: stayed isolated and hard to navigate.
- **Merging the daily plan into the journal as a section** — rejected: would break the editing rule (the plan is a `(C)`-owned file) and the clean same-date plan/progress mirror; embedding gets the visibility without the merge. (Consistent with the `/daily-plan` design — see [[(C) Obsidian Configs|Obsidian Configs]].)

## Consequences

- An `## Agenda` embed only resolves on days a real daily-plan file exists; on days without one the block is omitted (don't embed a dead link).
- Adds a small per-day authoring surface (filling mood/productivity/tags) — accepted for the navigability and queryability gain.

## Sources

- [[Daily Note Frontmatter (DECISION)]] — the decision + rationale (linked daily notes; embed the editable daily plan).
- [[Daily Note Template]] — the concrete template (frontmatter fields, nav arrows, `## Journal` / `## Agenda` skeleton).
