---
type: overview
aliases: [Obsidian Configs Progress Log]
tags: [progress-index, obsidian-configs]
updated: 2026-06-04
---

# (C) Progress Log — Obsidian Configs

Rolling changelog of daily progress files (`Week of …/(C) YYYY-MM-DD.md`), newest first, plus the open next-steps backlog. Auto-generated from frontmatter — requires the **Dataview** plugin.
Create an application on my computer that integrates with an LLM in order to spam me with reminder emails to get ready at a specific time that takes into account transportation time, and my preparation time.
Attach it to the calendar.

## Daily progress

```dataview
TABLE WITHOUT ID file.link AS Entry, date AS Date, summary AS Summary, goals AS Advances
FROM #progress
WHERE project = "Obsidian Configs"
SORT date DESC
```

## Open next steps (feeds /create-daily-plan)

```dataview
TABLE WITHOUT ID file.link AS "Next step", goal AS Goal, effort AS Effort
FROM #next-step
WHERE project = "Obsidian Configs" AND status = "open"
SORT effort DESC
```

> Empty tables? Confirm Dataview is installed; progress files need `type: progress` + `goals:`, next-steps need `type: next-step` + `status: open`.
