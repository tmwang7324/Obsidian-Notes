---
type: overview
aliases: ["Obsidian Configs Architecture"]
tags: [architecture, obsidian-configs, meta]
updated: 2026-06-19
sources: 6
---

# Obsidian Configs — Architecture

The **current-state** map of how the vault's knowledge system works. Mutable: overwrite it as the system changes. The *why* behind each choice lives as frozen records in `Decisions/` — this page links down to them. See [[(C) Decisions in the Wiki]] for why this split exists.

## The three layers (current state)

- **Source** — `raw/notes/`, `01 Journals/`, project `Chats/` + `Ideas/`. Immutable; read-only to every skill. **One narrow exception:** [[(C) Archive Not Delete|archiving]] may *relocate* (never edit) a fully-processed `Ideas/` note into `Ideas/Archive/`.
- **Wiki** — domain folders (`Full Stack Development/`, `Golf/`, …) hold **shared concept pages**; `wiki/Projects/<Project>/` holds **project-specific depth**: `(C) <Project>.md` (identity & purpose), `(C) Architecture.md` (this kind of page), and `Decisions/` (immutable ADRs). The wiki holds **no dated changelog** — only identity, concepts, and durable decisions + rationale.
- **Schema** — root `CLAUDE.md` + per-project `CLAUDE.md`s.

## The skills that maintain it

| Skill             | Owns                     | Writes to                               |
| ----------------- | ------------------------ | --------------------------------------- |
| `synthesize`      | the wiki + decision ADRs | `wiki/`, `index.md`, `log.md`, manifest |
| `record-progress` | the dated changelog      | `Progress/`, `Iteration Logs/`          |
| `daily-plan`      | the day's plan           | `Plans/`                                |
| `weekly-update`   | weekly focus + intensity | `GOALS.md`                              |

## Capture flow (current state)

Markers in source notes drive everything: `**Important**` (force-synthesize), `**Decision**` **or** `(DECISION)` (force-author an ADR — case-insensitive; the `(DECISION)` tag is the user's own convention, e.g. a header suffix `## Approach (DECISION)`), `(DONE)` / `(INCOMPLETE)` (route to changelog vs backlog). The decision path: a `**Decision**` / `(DECISION)` marker → `synthesize` authors the immutable ADR in `Decisions/` and updates this Architecture page → `record-progress` logs the dated line and links up to the ADR. Detail in [[(C) Decision Capture Pipeline]].

## The dashboard (current state)

A landing surface, **designed and being built** as the vault's morning-glance home: a single `cssclasses: dashboard` note built on [[(C) MCL Multi-Column Layout|MCL multi-column]] callouts (static layout) + `dataviewjs` (live clock, focus project), with a [[(C) Bases Launcher|Bases launcher]] for projects. The pomodoro timer is **not** on the dashboard — it lives in a pinned sidebar note. Full design in [[(C) Dashboard v1 Design]].

## Daily notes (current state)

Daily journal notes are generated from a **Daily Note Template** (Settings → Daily notes): structured frontmatter (`date`, `tags`, `mood`, `productivity`, `goals`), prev/next nav arrows, and an `## Agenda` embed of the day's daily-plan file (visible in the journal, edited in its own file). Wired into the [[(C) MCL Multi-Column Layout|dashboard]]/[[(C) Dashboard v1 Design|Progress loop]] as the narrative source. Design + rationale: [[(C) Daily Note Frontmatter]].

## Decisions

- [[(C) Decisions in the Wiki]] — decisions + rationale are durable wiki content; per-project folders; ADR shape.
- [[(C) Daily Note Frontmatter]] — structured daily-note template (frontmatter + nav arrows + embedded editable daily plan).
- [[(C) Decision Capture Pipeline]] — the `**Decision**` / `(DECISION)` marker, `synthesize` as sole ADR author, `record-progress` links up.
- [[(C) Archive Not Delete]] — never delete source notes; archive fully-processed ones to `Ideas/Archive/`.
- [[(C) Dashboard v1 Design]] — substrate (MCL + `dataviewjs`), v1 widget set, layout, Bases launcher.
- [[(C) Pomodoro Timer Placement]] — pinned sidebar note, not the dashboard; `localStorage` state tier rule.
- [[(C) Recent Files Widget Scope]] — the Recently-modified widget excludes `(C)` files.
