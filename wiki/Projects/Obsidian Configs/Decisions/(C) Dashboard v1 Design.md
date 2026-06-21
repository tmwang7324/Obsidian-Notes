---
type: decision
project: Obsidian Configs
date: 2026-06-11
status: accepted
aliases: ["Dashboard v1 Design"]
tags: [decision, obsidian-configs, dashboard]
sources: 4
supersedes:
superseded-by:
---

# (C) Dashboard v1 Design

**Status:** accepted · **Date:** 2026-06-11 · Grilled 2026-06-09, finalized 2026-06-11 · design refinements 2026-06-16 (additive — see Refinements).

## Context

The vault needed a landing **dashboard** — a morning-glance surface for time, the day's plan, the journal, and a jump-off into projects. The open questions: what substrate to build it on, which widgets ship in v1, and how to lay them out. Reference implementation studied: the **KomoreBi** dashboard (`Resources/Dashboard-Komorebi.md`).

## Decision

1. **Substrate — one self-contained note: MCL callouts for static layout + `dataviewjs` for dynamic widgets.** Static structure uses [[(C) MCL Multi-Column Layout|MCL multi-column]] callouts; dynamic, interactive widgets (live clock, focus project) are `dataviewjs`. The note is branded with [[(C) cssclasses Containment|`cssclasses: dashboard`]] so all styling scopes to it.
2. **v1 widget set:** full-width live **Time + Date** banner, **Today's Plan** (embedded checklist), **Journal** opener (creates today's note if missing) + **Recent files**, and a full-width **Projects** [[(C) Bases Launcher|Bases launcher]]. **Deferred:** the pomodoro timer (own sidebar note — see [[(C) Pomodoro Timer Placement|Pomodoro Timer Placement]]), a year-long GitHub-style contribution chart (needs the **Contribution Graph** plugin), and a sleep tracker.
3. **Layout (top → bottom):** the clock banner as the centered focal element → Plan (wide left column) + Journal/Recent (narrower right column) as a two-column MCL callout → Projects launcher full-width at the bottom.
4. **Projects launcher:** inline `base` codeblock, filter `type == "overview"` scoped to `wiki/Projects/`, columns = name (link) + `updated`.

## Rationale

- **Dynamic features need `dataviewjs`.** The clock, focus-project editor, and timer require live updates and user interaction; static wikilinks can't deliver that seamless feel. Static structure stays in cheap MCL callouts.
- **MCL gives responsive columns for free** once the snippet is enabled — no custom layout code.
- **One note keeps it self-contained** — nothing extra to track; the inline Base codeblock follows the same principle.
- **Morning-glance priority order** drove the layout: *what time/day is it → what do I do today → jump into work.* The clock owns the top; the Plan gets the most width (it's the day's action surface); Journal + Recent stack as one-click jumps; Projects is a launcher row that wants horizontal room.

## Alternatives rejected

- **Pomodoro embedded in the dashboard grid** — rejected; a `dataviewjs` `setInterval` only ticks while its pane is shown. Split to a sidebar note (see [[(C) Pomodoro Timer Placement]]).
- **`.base` file via `![[x.base]]`** — rejected in favor of the inline `base` codeblock to keep the dashboard a single file. (Two stray `Untitled.base` experiments to be deleted separately.)
- **Filtering the launcher by folder alone** — rejected; it drags in `Architecture.md` + decision pages. Filter by `type == "overview"`.
- **Canvas cards for each section** — set aside; unclear how to render canvases inline.

## Consequences

- Built on the four Obsidian concept pages: [[(C) MCL Multi-Column Layout]], [[(C) cssclasses Containment]], [[(C) Callout Metadata]], [[(C) Bases Launcher]].
- Two decisions peeled off into focused ADRs: [[(C) Pomodoro Timer Placement]] and [[(C) Recent Files Widget Scope]].
- The contribution chart is a future add (plugin dependency); deferred, not rejected.
- Build tracked in `Iteration Logs/(C) Dashboard.md`.

## Refinements (2026-06-16)

Additive design clarifications made before build — the substrate and rationale above are unchanged:

- **Projects widget → project *progress*, not just links.** The launcher should surface the **top ~2 most recent Progress Log entries per project** (newest-first), so the morning glance shows *where each project stands*, not just its name. Driven by a `dataview` `#progress` rollup (`GROUP BY project` + `FLATTEN`) — see [[(C) Dataview|Dataview]].
- **Bounded embeds.** Embedded widgets (progress entries, today's journal) are height-capped with a CSS snippet (`.markdown-embed * { max-height: 200px }`), which also adds an internal scrollbar — keeps an embedded note from blowing out the grid.
- **Daily contribution graph** (the deferred GitHub-style chart) confirmed to use the **Contribution Graph** plugin (by vran), colored by **characters written** in the daily journal + Ideas. Still a post-v1 add (plugin dependency).
- **Pin the dashboard as the default home** on app start so it's the landing surface.

## Sources

- [[Creating a Dashboard (IN PROGRESS)]] — widget plan + the substrate/approach `(DECISION)`; the project-progress widget, contribution graph, and pin-as-home refinements.
- [[Finalizing V1 of Dashboard (DONE)]] — grill Q8–Q11 (placement, recent-files scope, Bases launcher, layout).
- [[Reducing Embedded Content (NOTE)]] — the embed-height CSS cap + scrollbar mechanism.
- [[Overview|Dataview/Overview]] — the progress-rollup query feeding the Projects widget.
