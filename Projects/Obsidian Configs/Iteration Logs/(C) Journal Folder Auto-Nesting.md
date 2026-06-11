---
type: next-step
project: Obsidian Configs
status: open
goal: "[[(C) Vault is Pleasant to Use]]"
effort: M
aliases: [Journal Folder Auto-Nesting]
tags: [next-step, obsidian-configs, journals]
updated: 2026-06-09
---

# (C) Journal Folder Auto-Nesting

**Next step.** The core **daily-notes** setting (`.obsidian/daily-notes.json`) is hardcoded to a single month folder:

```json
{ "template": "", "folder": "01 Journals/2026 Journals/06 June" }
```

The core daily-notes plugin (and the Calendar plugin, which reads the same config) can only target **one fixed folder** — it can't auto-nest by `{YYYY} Journals/{MM Month}/`. So the nested journal scheme is **manually maintained**: come **July 2026**, either this setting is changed by hand every month or new journals land in the June folder. Surfaced while building the dashboard's journal opener (2026-06-09 grill).

- **Advances:** [[(C) Vault is Pleasant to Use]]
- **Effort:** M — pick one strategy:
  - **(a)** A monthly reminder/automation to update the `folder` field on the 1st.
  - **(b)** Switch journal creation off core daily-notes onto a small **dataviewjs/Templater** opener that computes the nested `{YYYY} Journals/{MM Month}/{date}.md` path and creates folders if missing — the same logic the **dashboard journal widget already uses**, so this could just become the single source of truth.
  - **(c)** Flatten the journal scheme to one folder (reject — loses the year/month browsing structure).
- **Surfaced by:** dashboard grill 2026-06-09 · `.obsidian/daily-notes.json`

**Recommendation:** (b) — reuse the dashboard's create-if-missing path logic so journals and the dashboard share one nesting rule. When done, flip `status: done` and note the resolving progress entry.
