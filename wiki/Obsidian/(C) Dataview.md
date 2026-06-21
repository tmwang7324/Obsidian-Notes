---
type: concept
aliases: ["Dataview", "DQL"]
tags: [obsidian, dataview, dql, plugin]
updated: 2026-06-16
sources: 1
---

# Dataview

A community plugin that turns the vault into a **live index and query engine** over your notes. You add **frontmatter metadata** to notes and query it with the **Dataview Query Language (DQL)** in a fenced ` ```dataview ` block — the results re-evaluate every time the note renders, so tables stay current as notes change. This is the engine behind the vault's per-project Progress Logs and the [[(C) Bases Launcher|dashboard launchers]].

## The two query types used here

**`LIST`** — a bullet list of links, optionally grouped:

````
```dataview
LIST FROM #project
```
````

**`TABLE`** — columns pulled from frontmatter fields, the workhorse for changelogs and indexes:

````
```dataview
TABLE WITHOUT ID file.link AS Entry, date AS Date, summary AS Summary, goals AS Advances
FROM #progress
WHERE project = "Doculyze"
SORT date DESC
```
````

Key pieces: `FROM #tag` (or `"folder"`) selects the source set; `WHERE` filters; `SORT … DESC` orders; `WITHOUT ID` drops the default file-link first column so you control every column; `AS` renames a column header. Fields like `file.link`, `file.ctime`, `date`, `summary` come from each note's frontmatter or Obsidian's implicit `file` object.

## The progress-rollup pattern

The recurring vault use: one row per `#progress` note, newest first — which is why every progress file now carries a `summary:` field (pulled as `summary AS Summary`). A grouped variant collapses to the most-recent entries **per project** with `GROUP BY project` + `FLATTEN`, surfacing the latest progress at a glance on the dashboard.

## Block references (Obsidian, not Dataview)

A **block** is a unit of text — a paragraph, list item, or quote. Link directly to one with `[[Note#^id]]`: type a caret `^` at the end of a link and Obsidian suggests block IDs, so you don't hand-write the identifier. Useful for citing a specific line rather than a whole note.

## Related

- [[(C) Bases Launcher|Bases Launcher]] — Obsidian Bases as an alternative live-query surface for the dashboard.
- [[(C) Dataviewjs Render State|Dataviewjs Render State]] · [[(C) Dataviewjs State Persistence|Dataviewjs State Persistence]] — the `dataviewjs` (JavaScript) side of the plugin.

## Sources

- [[Overview|Dataview/Overview]] — what Dataview is, LIST/TABLE basics, and the progress-rollup query drafts.
