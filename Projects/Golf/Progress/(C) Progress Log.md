---
type: overview
aliases: [Golf Progress Log]
tags: [progress-index, golf]
updated: 2026-06-16
---

# (C) Progress Log — Golf

Rolling changelog of daily progress files (`Week of …/(C) YYYY-MM-DD.md`), newest first, plus the open next-steps backlog. Auto-generated from frontmatter — requires the **Dataview** plugin.

## Daily progress

```dataview
TABLE WITHOUT ID file.link AS Entry, date AS Date, summary AS Summary, goals AS Advances
FROM #progress
WHERE project = "Golf"
SORT date DESC
```

## Open next steps (feeds /create-daily-plan)

```dataview
TABLE WITHOUT ID file.link AS "Next step", goal AS Goal, effort AS Effort
FROM #next-step
WHERE project = "Golf" AND status = "open"
SORT effort DESC
```

> Empty tables? Confirm Dataview is installed; progress files need `type: progress` + `goals:`, next-steps need `type: next-step` + `status: open`.
