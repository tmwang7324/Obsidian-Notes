---
type: decision
project: Obsidian Configs
date: 2026-06-09
status: accepted
aliases: ["Pomodoro Timer Placement"]
tags: [decision, obsidian-configs, dashboard, pomodoro]
sources: 1
supersedes:
superseded-by:
---

# (C) Pomodoro Timer Placement

**Status:** accepted · **Date:** 2026-06-09 · Deferred out of the Dashboard v1 grill into its own session.

## Context

A pomodoro timer needs **stateful `dataviewjs`** to track elapsed time. But a `dataviewjs` block re-executes on every render and its `setInterval` only ticks while its pane is the displayed note — so embedding the timer in the dashboard means it **stops the moment you navigate the main editor away** (see [[(C) Dataviewjs State Persistence|Dataviewjs State Persistence]]). Where should the timer live so it keeps running while you work?

## Decision

**The pomodoro lives in a pinned `(C) Timer.md` note in the right sidebar (Reading view) — not embedded in the dashboard.** State persists in `localStorage` (reusing the KomoreBi `komo-pomo-*` keys). This also establishes a **vault-wide state-tier rule**:

> *Throwaway widget state* (a timer's remaining seconds) may live in `localStorage`. *Durable brain-data* (focus project, journal wake-time) must be written to **vault markdown** so Dataview / `synthesize` / git can see it. `localStorage` is device-local and invisible to the second-brain pipeline.

## Rationale

- A **sidebar leaf stays rendered independently** of the main editor, so its `setInterval` keeps ticking while you work in the main pane — exactly what an embedded dashboard widget can't do.
- The pinned-note approach gets ~the same result as a custom plugin **for free**, staying within the CLAUDE.md "no infrastructure rabbit holes" rule.

## Alternatives rejected

- **Embed in the dashboard grid** — the timer dies on every note switch.
- **A true persistent widget via a custom `registerView` plugin** — that's plugin development, a rabbit hole against the no-infrastructure rule.
- **In-memory-only timer** — resets on note close; `localStorage` gives persistence just as cheaply.
- **Persisting timer state into a vault file** — needless file-write churn; `localStorage` is the right tier for throwaway state.

## Consequences

- Implementation backlog: [[(C) Pomodoro Timer Sidebar Note|Pomodoro Timer Sidebar Note]] — port the KomoreBi block (`Resources/Dashboard-Komorebi.md` lines 772–955).
- Two open caveats to settle at build: **wall-clock behavior** (freeze-on-away vs. reconcile elapsed time) and **completion alerts** (in-app `Notice` + sound now; OS `Notification` deferred to v1.1). A no-note-switch-loss variant (end-timestamp + `window` interval) is documented in [[(C) Pomodoro Timer (DataviewJS)|Pomodoro Timer (DataviewJS)]].
- `localStorage` is **per-device** — the timer's state/count does not sync via Obsidian Sync.

## Sources

- [[(C) Pomodoro Timer Approach]] — the deferred-session chat capturing the decision + caveats.
