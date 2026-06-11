---
type: concept
aliases: ["Bases Launcher", "Obsidian Bases", "base codeblock"]
tags: [obsidian, bases, dataview, dashboard, concept]
updated: 2026-06-11
sources: 1
---

# Bases Launcher

**Obsidian Bases** are database/table views over your notes, filtered by frontmatter. Used as a **launcher**, a Base renders a clickable table of pages (e.g. one row per project) — the pattern behind the dashboard's Projects row (see [[(C) Dashboard v1 Design|Dashboard v1 Design]]).

## Two ways to embed a Base

| Form | Where it lives | Embed |
|---|---|---|
| **`base` codeblock** | *inline*, in the note itself | a ```` ```base ```` fenced block |
| **`.base` file** | a *separate* file | `![[x.base]]` |

For a single self-contained dashboard note, the **inline `base` codeblock** keeps everything in one file — nothing extra to track. (A stray `.base` experiment is easy to leave lying around.)

## Selecting the right files — filter by type, not folder

The launcher should list exactly the project **overviews** and nothing else. The robust filter is **by frontmatter type, scoped to a folder**:

- ✅ `type == "overview"` **AND** folder under `wiki/Projects/` → selects precisely the project overview pages.
- ❌ filter by **folder alone** → also drags in `(C) Architecture.md` and `Decisions/*.md` (which are `type: decision`/`overview` but not project launchers). Wrong.

Filtering by `type` is what keeps the launcher clean as the per-project folders fill with architecture and decision pages.

## Launcher columns

Keep it a launcher, not a report: **project name (link) + `updated` date**. Skip tags and status text — noise for a jump-off table.

## Related

- [[(C) MCL Multi-Column Layout|MCL Multi-Column Layout]] — the full-width Wide View the launcher sits in.
- [[(C) Dashboard v1 Design|Dashboard v1 Design]] — the decision selecting the inline codeblock + `type == overview` filter.
- Source: `Projects/Obsidian Configs/Ideas/Theme/Dashboard/Finalizing V1 of Dashboard (DONE).md` (Q10).
