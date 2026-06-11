---
type: concept
aliases: ["Dataviewjs State Persistence", "Dataviewjs Stateless Render", "Does dataviewjs state persist"]
tags: [obsidian, dataview, dataviewjs, state, concept]
updated: 2026-06-11
sources: 1
---

# Dataviewjs State Persistence

**Short answer: no — in-memory state in a `dataviewjs` block does not survive a note switch.** Each block is re-executed from scratch every time it renders, so any local variable, closure, or in-memory data structure is recreated (and therefore lost) on every render.

## The mental model: each render is stateless

A `dataviewjs` block is **not a long-lived program**. It's a script that Obsidian's markdown post-processor runs top-to-bottom every time the block is rendered: Dataview hands your code a fresh container element, the script populates it, and then it's done. There is no event loop holding your variables between runs.

A render happens (and your scope is rebuilt) when you:

- switch away from the note and come back,
- toggle reading / live-preview / edit mode,
- in some cases, scroll the block out of and back into view,
- open the note in a hover-preview or a second pane.

So `let`, `const`, and any computed data inside the block live exactly **one render** and then vanish.

## Where to put state that must survive

If a value needs to outlive a render, **serialize it out and re-hydrate it at the top of the script** on the next run:

| Where | Survives | Notes |
|---|---|---|
| `localStorage` | Note switches **and** app restarts | Best for small UI state. `window.localStorage.getItem/setItem`. |
| `sessionStorage` | Note switches, until app quits | Cleared on restart. |
| A `window.` global | Note switches, until app reload | Hacky but works; survives until the vault reloads. Useful for live handles like `setInterval` IDs. |
| Note frontmatter / file content | Everything (it's on disk) | The "real" persistence; write via the vault API. |
| A separate data file | Everything | For anything non-trivial. |

**Rule of thumb:** treat every `dataviewjs` run as stateless. Store the source of truth outside the block's scope and rebuild the view from it on each render. This is exactly the pattern that makes a [[(C) Pomodoro Timer (DataviewJS)\|persistent pomodoro timer]] possible — it stores an absolute end-timestamp in `localStorage` and re-derives the remaining time on every render, instead of counting down an in-memory variable.

## A subtle exception: `window`-registered timers

While *data* in local scope dies on every render, a side effect registered on `window` — like a `setInterval`/`setTimeout` ID — **keeps running globally** even after its note's DOM detaches, until the app reloads. That's why a background countdown can keep ticking (and fire an alert) while you're looking at a different note. The data is still re-hydrated from `localStorage` on render; the global timer is just the heartbeat. See [[(C) Pomodoro Timer (DataviewJS)\|Pomodoro Timer (DataviewJS)]].

## Related

- [[(C) Pomodoro Timer (DataviewJS)\|Pomodoro Timer (DataviewJS)]] — the canonical applied example of this pattern.
- [[(C) Dataviewjs Render State\|Dataviewjs Render State]] — a separate render-lifecycle gotcha: one throwing block corrupts the shared Preact instance and breaks every query until reload.
- Source: conversation on dataviewjs state + pomodoro implementation, 2026-06-11.
