---
type: next-step
project: Obsidian Configs
status: done
goal: "[[(C) Vault is Pleasant to Use]]"
effort: M
aliases: [Journal Folder Auto-Nesting]
tags: [next-step, obsidian-configs, journals]
updated: 2026-06-15
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

---

## Resolution (2026-06-15) — option (b), extended to week-nesting

Journals were reorganized into **Monday-based week subfolders** (`{MM Month}/Week of {YYYY-MM-DD}/`), a level deeper than this note's original month-only scheme, to match the vault's `Plans/` and `Progress/` convention. Implemented (b) by making the **dashboard journal opener the canonical, create-if-missing creator**:

- **`(C) Dashboard.md`** journal widget now computes `…/{MM Month}/Week of {Mon}/{date}.md` and creates the year → month → week folders on demand.
- **`record-progress` scanner** (`scan_day.ps1`) reads the week-nested path, with a fallback to the flat month path for any un-migrated journal.
- The 9 existing June journals were moved into `Week of 2026-06-01/` and `Week of 2026-06-08/`; manifest + wiki citations repointed.

**Residual caveat (the original limitation persists):** core **daily-notes** / **Calendar** can still only target one fixed `folder`, so it can't auto-nest. It's now pointed at the *current* week folder (`…/06 June/Week of 2026-06-15`) — correct for this week but a **weekly** manual touch-point (worse cadence than the monthly one this note assumed). **Use the dashboard "Create today's journal" button** (self-sustaining) rather than Calendar to avoid it; or disable Calendar-based creation. Reopen if you want this fully automated (e.g. a Templater script or QuickAdd capture computing the nested path).
