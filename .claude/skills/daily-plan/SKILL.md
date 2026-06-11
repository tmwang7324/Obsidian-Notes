---
name: daily-plan
description: Generate today's daily plan — a project-anchored, project-heavy checklist for the day, written to Plans/Week of <Mon>/(C) YYYY-MM-DD.md. Use whenever the user says "daily plan", "/daily-plan", "plan my day", "what should I do today", "give me today's plan", or asks for a plan/checklist for the day's work. Defaults to this week's focus project from GOALS.md (overridable), asks how many hours they have, formulates two original daily goals from the project's longer-term goal, supplements them with 2–3 open next-steps from the project's Iteration Logs, and sizes the day to fit. Trigger this proactively at the start of a work day even if the user doesn't name the skill.
---

# Skill: Daily Plan

Generate the user's plan for **today** — a short, project-heavy checklist sized to the hours they actually have. The plan has two halves: **two original daily goals you formulate** that push the project's longer-term goal forward, plus **2–3 items pulled from the real backlog** (`Iteration Logs/`). This is the morning generator half of the Progress loop in the root `CLAUDE.md`; the evening reckoning (planned-vs-done, sidetrack call-out) is **not** this skill's job — that lives in the daily Progress synthesis. Keep this skill a clean morning tool.

The whole point is to fight the user's documented failure modes: disorganized priorities, trivial tasks ballooning to eat the day, and getting sidetracked. So the plan is deliberately **short, project-weighted, and honest about time** — a plan you can actually finish beats an ambitious one you abandon. The two original goals exist so the plan is driven by where the project *should* go, not just by whatever happens to be sitting in the backlog.

## When to Use

- User says "daily plan", "/daily-plan", "plan my day", "give me today's plan", "what should I work on today".
- The start of a work day, when the user wants direction — trigger proactively even without the exact phrase.

Optional argument: a **project name** to override this week's default focus (e.g. `/daily-plan Golf`).

## Core principles (why this skill is shaped the way it is)

- **Generative, not just consumptive.** The backbone of the plan is **two original daily goals you formulate** from the project's highest-priority longer-term goal — concrete moves toward it that are *not* already written down in the backlog. The backlog (2–3 items) supplements these; it does not lead. This is the deliberate fix to the old behavior, where the plan was nothing but a backlog-priority queue and never asked "what's the right next move toward the goal?"
- **Project-anchored, whole-day, but project-heavy.** The plan advances *one* project (honoring the "one project per week" operating principle) and reserves only a thin slice for the daily non-negotiables. Too many non-negotiables become their own distraction — the user said this explicitly.
- **Time-budget fit only.** Tasks are sized by effort and packed into the hours available. There is deliberately **no automatic "you finished X% yesterday, so shrink today" scaling.** That was considered and rejected: unseen life circumstances (not capacity) leave plans undone, and a rate-based algorithm misreads that as low capacity → permanently pessimistic plans, a death spiral. Intensity is a **manual dial** the user controls.
- **One round-trip.** Draft the whole plan, show it, let the user accept or swap an item or two, then write. Mornings need to be fast; a multi-turn interrogation kills the habit. Approving the plan *is* the commitment to it.

## Procedure

### 1. Resolve the focus project

- If a project name was passed as an argument, use it.
- Otherwise read the **`**This week:**`** field in `GOALS.md` (vault root) and use that project.
- If neither exists (the field hasn't been added yet), **ask** the user which project is this week's focus — and gently note that adding a `**This week:**` line to `GOALS.md` would make this automatic next time.

Confirm the project folder exists under `Projects/`.

### 2. Read the intensity dial + check for a new week

- Read the **`**Intensity:**`** field in `GOALS.md` (`low` | `normal` | `high`). If absent, assume `normal`.
- Determine this week's Monday (see the date snippet below) and check whether `Plans/Week of <Mon>/` already contains any plan files.
- **If this is the first plan of a new week** (folder empty or missing), run the **weekly intensity survey**: ask "How's the intensity this week — scale up, down, or keep it at `<current>`?" Apply their answer and, if it changed, update `**Intensity:**` in `GOALS.md` (this is a non-`(C)` file the user authored — editing it here is the skill's job, but mention the change). On any other day of the week, read the dial silently — don't re-ask.

> The survey is intentionally weekly, not daily: daily re-asking invites mood-driven over/under-correction, another of the user's failure modes. The `weekly-update` skill may also set this field; this is the safety net so the dial never goes stale.

### 3. Ask for today's schedule

Prompt once, in one line: **"How many hours do you have for focused work today, and any fixed commitments (class, gym, plans with people)?"**

The journal is usually empty this early, so asking is the lowest-friction accurate input. Use the answer to compute the **available focused hours** for project work (subtract fixed commitments).

### 4. Formulate two original daily goals (the backbone)

Read the focus project's `Goals/` files and pick the **highest-priority longer-term goal** (`type: goal`). If priority is ambiguous, pick the goal this week's work most clearly serves; if there are no `Goals/` files at all, ask the user for the project's current longer-term aim before proceeding.

From that one long-term goal, **formulate two original daily goals** — specific, concrete moves that advance it and that can realistically land *today*. Rules:

- They must be **your own framing**, not copied from an `Iteration Logs/` next-step. Read the backlog (next step) precisely so you can avoid duplicating it.
- Each must be a concrete deliverable for today ("draft the auth-token refresh flow and test the happy path"), not a vague theme ("work on auth").
- Each must visibly ladder up to the chosen long-term goal — name that goal in the plan so the link is explicit.
- Assign each an effort estimate (`S`/`M`/`L`) so step 5 can budget it.

These two are the heart of the plan. The backlog items below fill out the rest of the day around them.

### 4b. Pull 2–3 supplementing backlog items

Read open `type: next-step` files from the focus project's `Iteration Logs/` — i.e. frontmatter `status: open`. Each carries `effort` (`S`/`M`/`L`) and `goal`.

- Rank by **goal priority first** (steps advancing the highest-priority goal win), then by effort.
- Select **2–3** that complement the two original goals (avoid items that just restate them) and fit the remaining time budget (step 5).
- **If the backlog is empty**, that's fine — the plan still stands on the two original goals. Flag to the user that the Iteration Logs backlog is empty and suggest adding `type: next-step` files so future plans have backlog depth. Don't dead-end, and don't interrogate.

### 5. Size the day (time-budget fit)

Convert effort to rough hours, scale the budget by intensity, and select tasks until the budget is filled:

| Effort | Hours |
|---|---|
| S | ~0.5 |
| M | ~1.5 |
| L | ~4 (half-day) |

| Intensity | Budget multiplier |
|---|---|
| low | 0.7 |
| normal | 1.0 |
| high | 1.3 |

`effective budget = available focused hours × intensity multiplier`. Budget the **two original goals first** (they're the backbone), then fill the remaining budget with the top-ranked backlog items whose summed effort-hours fit. Target shape: **2 original goals + 2–3 backlog items** (≈4–5 project tasks). On a short day the two original goals may already consume the budget — then carry **fewer or zero backlog items** rather than overpacking; the originals stay. Hard cap the whole checklist at **~6 items** so it never sprawls.

These numbers are rough on purpose — the dial exists precisely so the user corrects for systematic over/under-estimation rather than the skill pretending to precision it doesn't have.

### 6. Compose the plan

- **Body, in two tiers:**
  - **Today's goals** — the two original daily goals you formulated, each a checkbox, with the long-term goal they advance named once at the top of the section (`**Advances:** [[(C) <Goal>]]`). These have no `Iteration Logs/` link because you invented them; that's expected.
  - **From the backlog** — the 2–3 selected next-steps, each a checkbox linking back to its `Iteration Logs/` next-step file.
- **Non-negotiables:** exactly one fixed checklist item — **faith / prayer** (the prime-directive guardrail; "focus" is already served by the project tasks). Everything else (a LeetCode rep, physical/sport, rest) collapses into **one condensed reminder line**, not separate checkboxes — present but not competing for attention.

### 7. Confirm, then write

Show the drafted plan in chat. Ask: **"Good to go, or want to swap anything?"** Apply any swaps. Then write the file to:

```
Plans/Week of <Mon date>/(C) YYYY-MM-DD.md
```

Create the `Plans/` folder and the week subfolder if they don't exist. The folder naming mirrors the `Progress/` structure exactly so the evening Progress synthesis can find today's plan by the same date.

End with the file path and a one-line "go get it" — and, per the user's standing preference, a suggested next action (usually: start the top task).

## Plan file template

```markdown
---
type: plan
project: <Focus Project>
date: YYYY-MM-DD
intensity: <low|normal|high>
hours: <available focused hours>
tags: [plan, <project-slug>]
---

# (C) YYYY-MM-DD — <one-line headline of the day's focus>

**Focus:** [[(C) <Focus Project>]] · **Budget:** <effective hours>h (<available>h × <intensity>)

## Today's goals
**Advances:** [[(C) <Long-term Goal>]]
- [ ] <original daily goal 1 — concrete deliverable for today> (<effort>)
- [ ] <original daily goal 2 — concrete deliverable for today> (<effort>)

## From the backlog
- [ ] <backlog task 1> — [[(C) <next-step file>]] (<effort>)
- [ ] <backlog task 2> — [[(C) <next-step file>]] (<effort>)

## Non-negotiables
- [ ] 🙏 Faith / prayer

_Reminders: one LeetCode rep · move (sport/gym) · protect rest._
```

The one-line headline keeps the `Plans/` Dataview table readable without opening files:

```dataview
TABLE date, project, file.link FROM #plan SORT date DESC
```

## What this skill does NOT do

- **It does not reconcile the plan at end of day.** Planned-vs-done and the sidetrack call-out are produced by the daily Progress synthesis, which reads the same-date plan file. Keeping generation and review separate keeps each tool one job.
- **It does not pull other projects' backlogs.** One project per week — pulling everything reopens the multi-project sprawl the operating principle exists to kill.
- **It does not auto-shrink based on past completion.** See the death-spiral reasoning above; intensity is manual.

## Date helper

The week folder uses the current week's **Monday**. To compute it on Windows:

```powershell
$today = Get-Date
$monday = $today.AddDays(-(([int]$today.DayOfWeek + 6) % 7))
"Plans/Week of {0}/(C) {1}.md" -f $monday.ToString('yyyy-MM-dd'), $today.ToString('yyyy-MM-dd')
```

## Edge cases

- **No `**This week:**` in GOALS.md** → ask which project; suggest adding the field.
- **No `**Intensity:**`** → assume `normal`.
- **No `Goals/` files** → ask the user for the project's current longer-term aim, then formulate the two original goals from that.
- **Empty Iteration Logs backlog** → the plan still stands on the two original goals; flag the empty backlog and suggest adding `type: next-step` files.
- **Plan already exists for today** → ask whether to regenerate (overwrite) or keep the existing one.
- **Very short day (e.g. <2h)** → the two original goals alone (or one, if even that overflows) are the plan; drop backlog items rather than padding.
