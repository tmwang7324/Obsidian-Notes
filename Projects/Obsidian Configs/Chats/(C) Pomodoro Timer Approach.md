---
type: chat
project: Obsidian Configs
date: 2026-06-09
tags: [chat, obsidian-configs, dashboard, pomodoro]
sources: 2
---

# (C) Pomodoro Timer Approach

Deferred out of the **Dashboard v1** grill (2026-06-09) to its own future session. This note captures the conclusions already reached so the next session resumes from decisions, not a blank page. v1 ships the cheap static widgets + Time/Date only; the timer comes later.

## Reference implementation
The pattern to copy is the **KomoreBi** pomodoro: `Projects/Obsidian Configs/Resources/Dashboard-Komorebi.md`, lines **772–955** (the `// ── POMODORO TIMER ──` block).

## Decisions reached (in the grill)

- **State storage = browser `localStorage`, not in-memory, not a vault file.** KomoreBi keys: `komo-pomo-time` (work min, default 25), `komo-pomo-break` (5), `komo-pomo-count` (today's completed), `komo-pomo-state` (`idle|running|paused|break`), `komo-pomo-remaining` (seconds). It writes `remaining` every tick and **auto-resumes** if `state === 'running'` on load (lines 950–952). `clearInterval` is called on pause/reset/complete, so interval-leak hygiene is handled.
- **Rule established (applies vault-wide):** *throwaway widget state* (timer) may live in `localStorage`; *durable brain-data* (focus project, journal wake-time, etc.) must be written to **vault markdown** so Dataview / `synthesize` / git can see it. `localStorage` is device-local and invisible to the second-brain pipeline.
- **Home = a pinned-sidebar `(C) Timer.md` note in Reading view — NOT embedded in the dashboard grid.** Reason: a `dataviewjs` `setInterval` only ticks while its pane is the displayed note; navigating the main editor away destroys the block and stops the countdown. A **sidebar leaf stays rendered independently**, so the timer keeps ticking while you work in the main pane. Reuse the same `komo-pomo-*` keys.
- **Completion warnings:** in-app `new Notice(...)` toast (already in KomoreBi) + optional sound (`new Audio(path).play()`) — free, take it. **OS-level desktop notification** via the Electron web `Notification` API (fires even when Obsidian is unfocused) is possible but needs a permission grant and is flaky cross-OS — **deferred to a v1.1 of the timer.**

## Rejected
- **True persistent sidebar widget via a custom `registerView` plugin** — that's plugin development, a rabbit hole against the CLAUDE.md "no infrastructure rabbit holes" rule. The pinned-note approach gets ~the same result for free.
- **In-memory-only timer (resets on note close)** — `localStorage` gives persistence just as cheaply.
- **Persisting timer state into a vault file** — needless file-write churn; `localStorage` is the right tier for throwaway state.

## Open caveats to handle next session
- **No wall-clock reconciliation:** resume restores the last *saved* `remaining`, and only ticks while the leaf is alive — close with 10:00 left, reopen an hour later, it resumes at 10:00. Acceptable for a focus timer (it freezes when you're away), but confirm that's the desired behavior vs. true elapsed-time.
- **Collapsed sidebar may be throttled:** Electron can throttle timers in a hidden/occluded renderer to ~1/min. Fine while the panel is open; don't rely on it while collapsed.
- **Cross-device:** `localStorage` does not sync via Obsidian Sync — the timer's state/count is per-device.

## Next session: starting point
1. Create `(C) Timer.md`, port the KomoreBi pomodoro block (lines 772–955), pin it to the right sidebar in Reading view.
2. Decide: in-app Notice + sound only, or add OS-level `Notification`.
3. Decide wall-clock behavior (freeze-on-away vs. reconcile elapsed).

**Source:** `Resources/Dashboard-Komorebi.md` (lines 772–955); grill session 2026-06-09 (Dashboard v1).
