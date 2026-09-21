---
name: weekly-update
description: Interview the user to update all context files across the vault (root CLAUDE.md, 02 Chess Moves (Long-Term Planning)/(C) Chess Moves.md, and each project's CLAUDE.md). Use for a weekly update, weekly review, or any request to refresh/update the vault's context and project statuses.
---

# Skill: Weekly Update

Interview the user to update all context files across the vault — the root CLAUDE.md, 02 Chess Moves (Long-Term Planning)/(C) Chess Moves.md, and each project's CLAUDE.md. Keeps everything current so Claude always has accurate context.

## When to Use

- User says "weekly update", "let's do a weekly review", "update my vault", or similar
- It's been a week or more since the last update (check the "Last updated" date in the Weekly Update section)

## How It Works

1. Scan all context files to understand current state
2. Interview the user at the meta level (big picture, goals, weekly pulse)
3. Walk through each project for status updates
4. Update all files
5. Optionally create a weekly review note

---

## Phase 1: Scan Current State

Read everything before asking a single question:

```bash
# Find all project folders
ls -d "03 Projects"/*/ 2>&1 || echo "No projects yet"
```

**Read these files:**
- `CLAUDE.md` — focus on the **Weekly Update** section (what was there last time), **My Goals & Current Progress**, and **My Current Projects & Overviews**
- `02 Chess Moves (Long-Term Planning)/(C) Chess Moves.md` — if it exists, scan the whole thing for sections with numbers, dates, or progress that might need updating
- Each project's `CLAUDE.md` — specifically the **Current Status** section at the bottom

**What you're building:** A mental map of what was true last time, so you can ask targeted questions about what changed — not make the user repeat everything from scratch.

---

## Phase 2: Meta-Level Interview

This covers the root CLAUDE.md and 02 Chess Moves (Long-Term Planning)/(C) Chess Moves.md. Ask conversationally, referencing what you read in Phase 1 so the user knows you're caught up.

### Weekly Pulse

Show the user what the Weekly Update section currently says (or note that it's blank), then ask:

- **What's working right now?**
- **What's not working?**
- **What are you sitting on or need to decide?**
- **What are you feeling pulled toward?**
- **Any deadlines or time-sensitive things coming up?**

These map directly to the Weekly Update section fields. If a field hasn't changed, the user can say "same" and you keep what was there.

### Goals Check-In

Reference the current state from **My Goals & Current Progress** in CLAUDE.md and anything in 02 Chess Moves (Long-Term Planning)/(C) Chess Moves.md. Then ask:

- **Any progress on your main goal since last time?** (New numbers, milestones hit, setbacks)
- **Has the plan changed at all?** (New strategy, dropped something, added something)
- **Anything new on the risk/runway front?**

**Keep this tight.** If nothing changed, move on. Don't make them re-justify their existing goals every week.

### Re-rank the Priority List (the important one)

`02 Chess Moves (Long-Term Planning)/(C) Chess Moves.md` holds an **ordered `## Priority List`** — P1, P2, P3… plus a `—— below the line ——` section that gets zero scheduled hours. The weekly update is the **designated place to reorder it**; `daily-plan` only reads it and refuses to re-rank mid-week. Do this after the project walkthrough in Phase 3, once you know what actually moved.

Show the current order with the `> **Re-ranked:**` date, then ask:

> "Here's the current order — [list]. What moves? Anything that should drop below the line, or come up from it?"

Rules when applying the answer:

- **Keep it strictly ordered.** No ties, no tiers. If the user says two things are equally important, make them pick which goes second — that choice is the whole point of the list.
- **Ask for the reason on any move**, one line each, and write it into the list entry. A rank with no stated reason is a mood, and it won't survive contact with a hard week.
- **Below the line is a real commitment.** If something's been sitting at P4+ untouched for weeks, say so and ask whether it belongs below the line. Don't let the list become a to-do pile.
- **Push back on churn.** If the order changed substantially last week too, name that pattern — constant re-ranking is procrastination wearing a planning costume, and it's a documented failure mode in `02 Chess Moves (Long-Term Planning)/(C) Chess Moves.md`.
- Stamp a new `> **Re-ranked:** YYYY-MM-DD` date whenever the order or reasons change.
- Also confirm the `**Intensity:**` dial for the coming week while you're here.

### 02 Chess Moves (Long-Term Planning)/(C) Chess Moves.md Specifics

If 02 Chess Moves (Long-Term Planning)/(C) Chess Moves.md exists and has trackable items (income numbers, milestone dates, skill targets, etc.), briefly surface anything that looks like it might need updating:

> "Your 02 Chess Moves (Long-Term Planning)/(C) Chess Moves.md shows [X]. Still accurate, or should I update that?"

If 02 Chess Moves (Long-Term Planning)/(C) Chess Moves.md doesn't exist, skip this — don't create one here.

---

## Phase 3: Project Updates

Walk through **each project folder** found in Phase 1. For each one:

1. **Show them the current status** from that project's CLAUDE.md (the Current Status section)
2. Ask: **"What's the update on [Project Name]? Any status change or progress this week?"**
3. If nothing changed, they can say "no change" and you move on

**Keep this fast.** One question per project, maybe a quick follow-up if something big happened. This is a check-in, not a deep dive.

**If a project's CLAUDE.md doesn't have a Current Status section**, ask for a quick status anyway and note that you'll add the section when you update the file.

---

## Phase 4: Update All Files

After the interview, make all the edits. Show the user a summary of what you're changing before writing.

### Root CLAUDE.md — update these sections:

**Weekly Update section:**
```markdown
## Weekly Update

> **Last updated:** [today's date]

- What's working: [from interview]
- What's not working: [from interview]
- What I'm sitting on / need to decide: [from interview]
- What I'm feeling pulled toward: [from interview]
- Any deadlines or time-sensitive things: [from interview]
```

**My Goals & Current Progress** — only update if something actually changed. Don't touch it if the user said "no change."

**My Current Projects & Overviews** — update the **Status** line and overview paragraph for any project whose status changed. Leave unchanged projects alone.

### 02 Chess Moves (Long-Term Planning)/(C) Chess Moves.md — if it exists, update any specific numbers/dates/milestones the user called out. Don't restructure it.

### Each project's CLAUDE.md — update the **Current Status** section:

```markdown
## Current Status

> **Last updated:** [today's date]
> **Status:** [updated status from interview]

[Any additional context the user provided about what happened this week]
```

**Critical rule:** Only edit sections related to status and progress. Never rewrite a project's CLAUDE.md structure, process, rules, or other sections during a weekly update.

---

## Phase 5: Weekly Review Note (Optional)

After all files are updated, ask the user:

> "Want me to create a weekly review note in your reviews folder? If so, where do you keep them and how do you like them structured?"

**If yes:** Create a dated note in whatever folder/format they describe. Use the interview answers as the content — you already have everything you need.

**If no:** Skip it. Don't push.

**If they have an existing format** (a template, past review notes you can reference): Match their style. Read a previous review note if one exists to understand the format before writing.

---

## Summary of What Gets Updated

| File | What changes |
|------|-------------|
| Root `CLAUDE.md` → Weekly Update | All five pulse fields + date |
| Root `CLAUDE.md` → Goals & Progress | Only if numbers/plan/risks changed |
| Root `CLAUDE.md` → Projects & Overviews | Status line + overview for changed projects |
| `02 Chess Moves (Long-Term Planning)/(C) Chess Moves.md` → Priority List | Re-ranked order + one-line reason per entry + `Re-ranked:` date |
| `02 Chess Moves (Long-Term Planning)/(C) Chess Moves.md` → Intensity | Dial for the coming week |
| `02 Chess Moves (Long-Term Planning)/(C) Chess Moves.md` | Any other trackable items that changed |
| Each project `CLAUDE.md` → Current Status | Status + date + what happened |
| Weekly review note | Optional — user's choice and format |
