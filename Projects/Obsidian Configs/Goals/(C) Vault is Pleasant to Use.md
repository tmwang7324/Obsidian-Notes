---
type: goal
project: Obsidian Configs
status: active
aliases: [Vault is Pleasant to Use]
tags: [goal, obsidian-configs]
updated: 2026-06-04
---

# (C) Vault is Pleasant to Use

> **Proposed goal — adopt, rename, or replace.** I created this so the theming work has something to build toward and the linkage pattern is demonstrable. Make it yours.

The vault should be visually pleasant and fast to navigate, so the second brain is somewhere you *want* to open every day — clear theme, distinguishable folders, readable code and notes.

## Progress toward this goal

```dataview
TABLE WITHOUT ID file.link AS Entry, date AS Date
FROM #progress
WHERE contains(goals, [[(C) Vault is Pleasant to Use]])
SORT date DESC
```

## Open next steps

```dataview
TABLE WITHOUT ID file.link AS "Next step", effort AS Effort
FROM #next-step
WHERE goal = [[(C) Vault is Pleasant to Use]] AND status = "open"
SORT effort DESC
```
