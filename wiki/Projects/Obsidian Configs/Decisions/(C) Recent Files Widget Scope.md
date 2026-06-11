---
type: decision
project: Obsidian Configs
date: 2026-06-09
status: accepted
aliases: ["Recent Files Widget Scope"]
tags: [decision, obsidian-configs, dashboard]
sources: 1
supersedes:
superseded-by:
---

# (C) Recent Files Widget Scope

**Status:** accepted · **Date:** 2026-06-09 · Dashboard v1 grill (Q9).

## Context

The dashboard's **Recently-modified** widget lists the most recently edited notes as a shortcut back into work. Should it include AI-generated `(C)` files (synthesized wiki pages, progress files)?

## Decision

**Exclude `(C)` files from the Recently-modified widget**, along with the `wiki/`, `Progress/`, and `Plans/` folders and the `index`/`log` system files. The widget shows only hand-authored idea/source notes. The Dataview query:

```dataview
LIST WITHOUT ID file.link
WHERE !startswith(file.name, "(C)")
WHERE !startswith(file.folder, "wiki")
WHERE !contains(file.folder, "Progress")
WHERE !startswith(file.folder, "Plans")
WHERE file.name != "index" AND file.name != "log"
SORT file.mtime DESC
LIMIT 7
```

## Rationale

- Including `(C)` files would flood the widget with **synthesized output** every time `synthesize`/`record-progress` runs.
- The synthesis files already track what was learned and decided — that's their job.
- The widget's purpose is a **shortcut back into idea/source files**, so AI-generated artifacts are noise against that goal.

## Alternatives rejected

- **Include everything** — the list fills with wiki/progress churn and loses its value as a jump-back into source notes.

## Consequences

- The same exclusion predicate is reusable anywhere a "my notes, not the machine's" view is wanted.
- Part of [[(C) Dashboard v1 Design|Dashboard v1 Design]].

## Sources

- [[Finalizing V1 of Dashboard (DONE)]] — Q9.
