---
source: claude-code
date: 2026-06-04
updated: 2026-06-05
project: C:\Users\jw300
tags: [claude-archive]
---

# Grilling the Daily Plan Skill

> A `/grill-me` session stress-testing the stub spec in `Goals/Give Me Today's Daily Plan Skill.md` for missing functionality. Walked the design tree one fork at a time. **Completed 2026-06-05** — every branch resolved. Settled: scope (project-anchored, project-heavy whole-day), focus resolution (default declared weekly focus, overridable), schedule input (ask at invocation), output (`Plans/` dated file, `type: plan`), backlog wiring (focus project's `Iteration Logs/`, fall back to `Goals/`), achievability (time-budget fit only + a manual weekly-surveyed intensity dial — *no* auto completion-rate scaling, to avoid a pessimism spiral), granularity (≥3 project tasks; faith the only fixed non-negotiable, rest as a reminder line), interaction (one-shot + single confirm/swap), loop closure (handled by daily Progress synthesis), and name (`/daily-plan`). Final design + downstream-wiring checklist at the bottom.

---

## Context

The skill spec is a one-paragraph stub: takes a project name, returns a markdown checklist of short goals "measured to be achievable by previous day progress" that flow into the project's Goals. The root `CLAUDE.md` already references this skill as `/create-daily-plan` — "reads open next-steps + goal priorities to generate the day's plan." Grounding read before grilling: the Goals → Progress → Iteration Logs loop, `type: next-step` backlog (`effort` S/M/L, `goal`, `status`), the "one project per week" operating principle, and the `synthesize` skill as a format reference.

---

## Decisions settled

### Q1 — Scope: focus project only, or whole day? → **(B) project-anchored, whole-day**
The bulk of the plan advances this week's focus project, but it also reserves slots for the daily non-negotiables (faith/prayer, a LeetCode rep, physical/sport, rest). Honors "one project per week" (no sprawl) while respecting the prime directive's two guardrails — faith and focus. Pure project-only would let a heads-down coding day silently starve the things `CLAUDE.md` says to guard; fully holistic would reopen the multi-project rabbit hole.

### Q2 — How does the skill know this week's focus project? → **(B) default to current week's project, overridable by parameter**
"One project per week" implies a single current answer; re-typing it daily is friction and a chance to silently switch mid-week. Skill defaults to the declared weekly focus and only accepts a parameter to override.

### Q3 — Where does the weekly-focus field live? → **(A) `**This week:**` field in `GOALS.md`, convention documented in root `CLAUDE.md`**
`GOALS.md` is the single global file already in context every session, and sits beside the "one project per week" principle. Downstream edits that follow (no separate questions):
- `weekly-update` skill should **set** `**This week:**`.
- Root `CLAUDE.md` Progress-loop section should **document** it as the source of truth `/daily-plan` reads.

---

## Decisions settled (resumed 2026-06-05)

### Q4 — Where does "my rough schedule" come from? → **(A) ask at invocation**
Biggest input to "achievable" sizing — a 2hr day vs a 10hr day produce different plans, and there's no schedule source in the vault yet. The skill runs at the start of day when the journal is usually empty, so a one-line "hours + fixed commitments?" prompt is the lowest-friction *accurate* input (guards the "trivial tasks balloon" failure mode). Upgrade to journal-read / weekday templates later once habits stabilize.

### Q5 — Output location & naming → **top-level `Plans/Week of <Mon>/(C) YYYY-MM-DD.md`, `type: plan`**
The plan is whole-day and cross-project, so it belongs at a vault-level daily home, not inside one rotating project. A separate `(C)` file (not a section in the hand-typed journal — protects the editing rule) keeps it Dataview-queryable as a clean per-file table. **Key clarification:** Dataview queries by metadata/folder, not location — so any folder works; what matters is that each plan is its *own* file with `type: plan`, not a `##` section inside a journal note. Chosen to mirror the `Progress/` structure so the end-of-day plan↔progress diff is a same-date lookup.

### Q6 — Pulling the backlog → **focus project's `Iteration Logs/` only; fall back to `Goals/` when empty**
Reads open `type: next-step` files from the focus project alone (honors one-project-per-week; non-negotiables come from the guardrails, not the backlog). On an empty backlog, derives 1–2 candidate steps from that project's `Goals/` and flags it — degrades gracefully instead of dead-ending or interrogating.

### Q7 — Achievability calibration → **time-budget fit only + manual intensity dial (no auto-scaling)**
Effort `S/M/L` → hour estimates, fill `available hours × intensity`. **Auto completion-rate scaling was rejected:** unseen life circumstances (not capacity) leave plans undone, which a rate-based algorithm misreads as low capacity → permanently shrinking, overly pessimistic plans (a death spiral). Instead, intensity is a **manual dial** (`**Intensity:**` in `GOALS.md`, low/normal/high → multiplier) that the skill **surveys weekly at week start** ("scale up/down/keep?"); the user stays the authority on whether misses were "too much" or "life happened." Conservative default before any history.

### Q8 — Checklist granularity → **≥3 project tasks (body); faith the only fixed non-negotiable**
Project-heavy by deliberate choice — *too many non-negotiables become their own distraction*. Body is ≥3 focus-project next-steps used as-written (no decomposition), hard cap ~5–6 items. **Faith** is the only guaranteed non-negotiable checklist item (prime-directive guardrail; "focus" is already served by the project tasks). LeetCode/sport/rest collapse into a single condensed reminder line, not separate checkboxes.

### Q9 — Interaction model → **one-shot + single confirm/swap**
Drafts the full plan, shows it, user accepts or swaps an item or two, then it writes the file. One round-trip — catches bad task selection cheaply while staying fast enough for a morning habit; approving is itself the commitment.

### Q10 — Loop closure → **handled by the daily Progress synthesis, not `/daily-plan`**
`/daily-plan` stays a morning generator. The evening Progress flow reads the same-date plan + journal, records planned-vs-done, and emits a blunt sidetrack call-out (satisfies the root `CLAUDE.md` accountability mandate). Reuses existing machinery; each skill keeps one job. (No longer a hard dependency for achievability, since auto-calibration was dropped — this is now purely for accountability.)

### Q11 — Name clash → **`/daily-plan`**
Shorter, what gets typed daily; `create-` is redundant (generation-only skill, no review sibling). Rename the `/create-daily-plan` reference in root `CLAUDE.md`.

---

## Final design (consolidated)

**Identity** — `/daily-plan`; project-anchored, whole-day, **project-heavy**.

**Inputs (at invocation)** — focus project defaults to `**This week:**` in `GOALS.md` (overridable by parameter); prompts for *hours + fixed commitments today*; reads `**Intensity:**` from `GOALS.md`.

**Task selection** — open `type: next-step` from the focus project's `Iteration Logs/` (fall back to `Goals/`, flag if empty); sizing by time-budget fit only (`effort → hours`, fill `hours × intensity`); intensity is a manual dial surveyed weekly.

**Output** — `Plans/Week of <Mon>/(C) YYYY-MM-DD.md`, `type: plan`. Body = ≥3 focus-project tasks; faith the one fixed non-negotiable; LeetCode/sport/rest as a single reminder line; cap ~5–6. One-shot draft → confirm/swap → write.

**Loop closure** — daily Progress synthesis reads the plan, writes planned-vs-done + accountability call-out.

## Downstream wiring this design requires

- [ ] `GOALS.md` — add `**This week:**` + `**Intensity:**` fields.
- [ ] Root `CLAUDE.md` — document both fields as source of truth; rename `/create-daily-plan` → `/daily-plan`; register `type: plan` + the top-level `Plans/` folder in the schema (frontmatter rule + Dataview note).
- [ ] `weekly-update` skill — set `**This week:**` + `**Intensity:**`; own the weekly intensity survey.
- [ ] Daily Progress synthesis — extend to read the same-date plan file and emit planned-vs-done + sidetrack call-out.
- [ ] Build the `/daily-plan` skill itself.

## Next action
Design is locked. Begin the downstream wiring above — natural order: `GOALS.md` fields → root `CLAUDE.md` schema/rename → build `/daily-plan` → extend Progress synthesis → update `weekly-update`.
