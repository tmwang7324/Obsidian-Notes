---
type: overview
aliases: ["Obsidian Configs"]
tags: [project, vault, meta, infrastructure]
updated: 2026-06-19
sources: 14
---

# Obsidian Configs

The meta-project for the vault itself: configuring and maintaining this Obsidian second brain — the [[(C) LLM Wiki Pattern|LLM Wiki Pattern]] structure, the `(C)` convention, folder schema, plugins/CSS, and the ingest/query/lint workflows. This is the wiki-level overview — read it first; drill into the project directory only for working detail it doesn't cover.

**Scope:** vault structure & conventions · the `.claude/skills/` skills (`new-project`, `weekly-update`, `brain-setup`) · per-project `CLAUDE.md` / `COMMANDS.md` · keeping `index.md` and the root `CLAUDE.md` consistent.

**Status (2026-06-06):** Vault running the LLM Wiki Pattern (set up 2026-06-02); this project now tracks ongoing maintenance. Recent work: defined the Progress-loop file types, settled the `Ideas/` vs `Chats/` split, **locked the `/daily-plan` design and built the skill**, and applied theme customization. **Next focus shift:** after the vault dashboard is done, the user is rotating focus to **Google Interview Prep (heavy LeetCode)** — he was notified he's still in consideration for an open Google role and wants to lock in. (Source: `01 Journals/.../2026-06-05.md`.)

## Conventions settled

- **`Ideas/` vs `Chats/` split** — hand-typed notes live in `Ideas/`; AI-generated idea files (prefixed `(C)`) live in `Chats/`. Chosen for clean separation by file type and to encourage less reliance on AI. (Source: `Ideas/Project Ideas Structure (DONE).md`.)
- **Progress vs Iteration Logs** — two different axes, not competitors: `Progress/` is the backward-looking changelog ("what I did, when"); `Iteration Logs/` is the forward-looking fix/improve backlog ("what to do differently"). A daily `type: progress` file synthesizes the journal **+** that day's working notes (journal alone is too thin — narrative without the concrete what-changed); cite both. Frontmatter earns its keep by powering a Dataview changelog table (`TABLE date, file.link FROM #progress SORT date DESC`). Goal-less work is still valid to log — don't manufacture a retroactive Goal. (Source: `Chats/Designing the Daily Progress File.md`.) See [[(C) LLM Wiki Pattern|LLM Wiki Pattern]].
- **`(DONE)` / `(INCOMPLETE)` status markers in `Ideas/`** — a hand-typed idea/feature note carries its status in the **filename suffix** (`… (DONE).md`, `… (IN PROGRESS).md`). This lets `/record-progress` and `/synthesize` sort by completion without parsing the body: finished items feed the day's `Done` section; incomplete ones stay in the backlog. Source notes are still sorted by **last-modified date** to find what's new. (Source: `Ideas/Track Daily Progress Ideas (IN PROGRESS).md`.)

> **Open question (unresolved):** whether to keep `raw/notes/` and project `Ideas/` as separate layers or merge them — they overlap (both record meaningful project material; both have a resources sibling). The working distinction the user is drawing: `raw/notes/` = explanations of complex topics, key implementations, significant tips; `Ideas/` = his own reasoning, design decisions, and debate points against the AI. Not yet decided — do not treat as settled. (Source: `Ideas/Raw Notes vs Project Ideas (In Progress).md`.)

## The `/daily-plan` skill (design locked)

The grill is **complete** — every branch resolved (Q1–Q11), design locked, skill built. (Source: `Chats/Grilling the Daily Plan Skill.md`, completed 2026-06-05.)

- **Identity & scope** — `/daily-plan` (not `/create-daily-plan`; `create-` was redundant for a generation-only skill). Project-anchored, **whole-day, project-heavy**: the bulk advances the week's focus project, with slots reserved for the daily non-negotiables.
- **Focus project** — defaults to `**This week:**` in `GOALS.md` (overridable by parameter); `weekly-update` sets the field.
- **Inputs at invocation** — prompts for *hours + fixed commitments today* (the schedule lives nowhere in the vault yet, so ask); reads `**Intensity:**` from `GOALS.md`.
- **Task selection** — open `type: next-step` files from the focus project's `Iteration Logs/`; falls back to deriving 1–2 from `Goals/` (and flags it) when the backlog is empty.
- **Achievability** — **time-budget fit only** (`effort S/M/L → hours`, fill `available hours × intensity`) **plus a manual intensity dial**. Auto completion-rate scaling was **rejected**: undone plans usually mean *life happened*, not low capacity, so a rate-based algorithm would misread misses and shrink plans into a pessimism death-spiral. Intensity is instead a manual `low/normal/high` dial surveyed weekly at week start.
- **Granularity** — ≥3 focus-project tasks (used as-written, no decomposition), cap ~5–6. **Faith is the only fixed non-negotiable checkbox** (too many non-negotiables become their own distraction; "focus" is already served by the project tasks); LeetCode/sport/rest collapse into one condensed reminder line.
- **Output** — `Plans/Week of <Mon>/(C) YYYY-MM-DD.md`, `type: plan` — a vault-level daily home (whole-day, cross-project), its own file (not a journal section, protecting the editing rule), mirroring `Progress/` so the end-of-day plan↔progress diff is a same-date lookup.
- **Interaction & loop closure** — one-shot draft → single confirm/swap → write. End-of-day accountability (planned-vs-done + a blunt sidetrack call-out) is handled by the **daily Progress synthesis**, not `/daily-plan`.

**Downstream wiring this requires:** `GOALS.md` gains `**This week:**` + `**Intensity:**`; root `CLAUDE.md` documents both as source of truth, renames `/create-daily-plan` → `/daily-plan`, and registers `type: plan` + the top-level `Plans/` folder; `weekly-update` sets the two fields and owns the weekly intensity survey; the daily Progress synthesis reads the same-date plan.

## Theme & appearance

- **Style Settings plugin** installed — the control surface for theme tweaks. **Themes the user rates highly:** **AnuPpucin**, **Minimal**, and **Obsidianite** (the last for its code color scheme and horizontal rules). (Source: `Ideas/Obsidian Notes.md`.)
- **Rainbow folder labels** are on — now **unique across nested child folders too**, not just root folders (the earlier limitation is resolved). Fancy separators / code snippets and folder icons (Iconize) also enabled. (Source: `Ideas/Theme/Theme Customization (NOTE).md`.)
- **Custom horizontal rules via CSS snippets** — drop a `.css` file in `.obsidian/snippets/`, then **Settings → Appearance → CSS Snippets** and toggle it on to apply. (Source: `01 Journals/.../2026-06-05.md`.)
- **Custom background** — enable the AnuPpuccin custom-background snippet, then in **Style Settings → AnuPpuccin Custom Background** toggle "Enable Custom Background" (Colorful Frame off) and point it at an image URL (the user hosts on **catbox.moe**). Adjust brightness/blur/opacity; set Workspace layout to "Border" or "Cards" for a transparent sidebar. (Source: `Ideas/Theme/Theme Customization (NOTE).md`.)
- **Widening the note interface** — toggle **off** "Readable Line Length" under **Editor → Display** so notes stretch sidebar-to-sidebar (used for the dashboard). (Source: `Ideas/Theme/Theme Customization (NOTE).md`.)
- **Dashboard** — design **locked (v1)** and being built: a single `cssclasses: dashboard` note on [[(C) MCL Multi-Column Layout|MCL multi-column]] callouts + `dataviewjs`, with a [[(C) Bases Launcher|Bases]] projects launcher; pomodoro lives in a separate sidebar note. Full design: [[(C) Dashboard v1 Design|Dashboard v1 Design]]. The CSS mechanisms it rests on: [[(C) cssclasses Containment|cssclasses containment]] + [[(C) Callout Metadata|callout metadata]].

## Architecture & decisions

- **Current-state map:** [[(C) Architecture|Obsidian Configs Architecture]] — the three layers, the maintaining skills, the capture flow.
- **Decision records (ADRs):** [[(C) Decisions in the Wiki]] · [[(C) Decision Capture Pipeline]] · [[(C) Archive Not Delete]] — the 2026-06-08 design making decisions+rationale durable wiki content. Dashboard set: [[(C) Dashboard v1 Design]] · [[(C) Pomodoro Timer Placement]] · [[(C) Recent Files Widget Scope]]. Daily notes: [[(C) Daily Note Frontmatter]].

## Where the detail lives

- **Synthesis page** (durable): [[(C) LLM Wiki Pattern|LLM Wiki Pattern]].
- **Working material** (ideas, progress, iteration logs, config sessions): `Projects/Obsidian Configs/` — read this directly only when the wiki above isn't comprehensive enough.
- **Project home:** [[CLAUDE|Obsidian Configs CLAUDE.md]] (role, process, rules, current status).
