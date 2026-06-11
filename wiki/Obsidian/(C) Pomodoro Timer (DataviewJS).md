---
type: synthesis
aliases: ["Pomodoro Timer (DataviewJS)", "Dataviewjs Pomodoro", "Persistent Dataviewjs Timer"]
tags: [obsidian, dataview, dataviewjs, pomodoro, timer, pattern]
updated: 2026-06-11
sources: 1
---

# Pomodoro Timer (DataviewJS)

A countdown timer built in a single `dataviewjs` block that **survives note switches** and **alerts you even when you're on a different note or have Obsidian minimized**. It's the canonical application of [[(C) Dataviewjs State Persistence\|Dataviewjs State Persistence]].

## Two design principles that make it work

1. **Store the *end timestamp*, not the *remaining seconds*.** Because every render is stateless (see [[(C) Dataviewjs State Persistence\|state persistence]]), counting down an in-memory variable loses everything on a note switch. Instead persist the absolute wall-clock time the timer hits zero in `localStorage`, and on every render compute `remaining = endTime − now`. The block becomes self-healing: leave for 3 minutes, return, and it shows the correctly-reduced time (or "done") because it's derived from the clock, not from memory.
2. **The `setInterval` is just a repaint heartbeat, not the source of truth.** Stash its ID on `window` and clear it before starting a new one each render, or you leak intervals that fire on detached DOM. Because it lives on `window`, it keeps ticking while you're on other notes — which is what lets the alert fire in the background.

## Full block

````javascript
```dataviewjs
const KEY = "pomodoro-v1";                 // change per-note for separate timers
const WORK = 25 * 60, BREAK = 5 * 60;      // seconds

// ---- state helpers (localStorage = survives note switch AND app restart) ----
const load = () => Object.assign(
  { endTime: null, remaining: WORK, running: false, mode: "work" },
  JSON.parse(localStorage.getItem(KEY) || "{}")
);
const save = (s) => localStorage.setItem(KEY, JSON.stringify(s));

// ---- kill any interval from a previous render (prevents leaks) ----
if (window._pomoInt) { clearInterval(window._pomoInt); window._pomoInt = null; }

const root = dv.container;
root.empty?.();
const display = root.createEl("div", { cls: "pomo-display" });
display.style.cssText = "font-size:3em;font-family:monospace;text-align:center;margin:.3em 0";
const label = root.createEl("div", { text: "", attr: { style: "text-align:center;opacity:.7" } });
const btns = root.createEl("div", { attr: { style: "display:flex;gap:.5em;justify-content:center;margin-top:.5em" } });

const fmt = (sec) => {
  sec = Math.max(0, Math.round(sec));
  const m = String(Math.floor(sec / 60)).padStart(2, "0");
  const s = String(sec % 60).padStart(2, "0");
  return `${m}:${s}`;
};

function secondsLeft() {
  const s = load();
  if (s.running && s.endTime) return (s.endTime - Date.now()) / 1000;
  return s.remaining;
}

function fireAlert(mode) {
  const msg = `⏰ ${mode.toUpperCase()} session complete!`;
  new Notice(msg, 10000);                       // 1. in-app banner
  try {                                         // 2. OS notification (shows when unfocused/minimized)
    if (Notification.permission === "granted") new Notification("Pomodoro", { body: msg });
    else if (Notification.permission !== "denied")
      Notification.requestPermission().then(p => { if (p === "granted") new Notification("Pomodoro", { body: msg }); });
  } catch (e) {}
  try {                                         // 3. synthesized beep, no file needed
    const ctx = new (window.AudioContext || window.webkitAudioContext)();
    const o = ctx.createOscillator(), g = ctx.createGain();
    o.connect(g); g.connect(ctx.destination);
    o.type = "sine"; o.frequency.value = 880;
    g.gain.setValueAtTime(0.25, ctx.currentTime);
    g.gain.exponentialRampToValueAtTime(0.0001, ctx.currentTime + 1.2);
    o.start(); o.stop(ctx.currentTime + 1.2);
  } catch (e) {}
}

function paint() {
  const s = load();
  const left = secondsLeft();
  display.setText(fmt(left));
  label.setText(`${s.mode.toUpperCase()} • ${s.running ? "running" : "paused"}`);
  if (s.running && left <= 0) {                 // rolled to zero (possibly while away)
    const next = s.mode === "work" ? "break" : "work";
    save({ endTime: null, remaining: next === "work" ? WORK : BREAK, running: false, mode: next });
    if (window._pomoInt) { clearInterval(window._pomoInt); window._pomoInt = null; }
    fireAlert(s.mode);
    paint();
  }
}

function startTicking() {
  if (window._pomoInt) clearInterval(window._pomoInt);
  window._pomoInt = setInterval(paint, 250);    // 250ms = smooth + cheap
}

const mkBtn = (txt, fn) => { const b = btns.createEl("button", { text: txt }); b.onclick = fn; return b; };

mkBtn("Start", () => {
  try { if (Notification.permission === "default") Notification.requestPermission(); } catch (e) {}
  const s = load();
  if (s.running) return;
  s.endTime = Date.now() + s.remaining * 1000;  // anchor to wall clock
  s.running = true;
  save(s); startTicking(); paint();
});

mkBtn("Pause", () => {
  const s = load();
  if (!s.running) return;
  s.remaining = Math.max(0, (s.endTime - Date.now()) / 1000);
  s.running = false; s.endTime = null;
  save(s);
  if (window._pomoInt) { clearInterval(window._pomoInt); window._pomoInt = null; }
  paint();
});

mkBtn("Reset", () => {
  const s = load();
  save({ endTime: null, remaining: s.mode === "work" ? WORK : BREAK, running: false, mode: s.mode });
  if (window._pomoInt) { clearInterval(window._pomoInt); window._pomoInt = null; }
  paint();
});

// ---- on every render: rehydrate, resume ticking if it was running ----
if (load().running) startTicking();
paint();
```
````

## Alerting when the timer ends and you're not on the note

`new Notice()` only shows **inside** Obsidian's window, so `fireAlert()` fires three channels: the in-app banner, an OS-level `Notification` (visible when Obsidian is minimized/unfocused), and a WebAudio beep. Because `window._pomoInt` keeps ticking after the note's DOM detaches, the zero-crossing is detected and `fireAlert()` runs even while you're on a different note.

| Scenario | Alert fires? |
|---|---|
| Sitting on the timer note | ✅ all three channels |
| On another note, Obsidian focused | ✅ — global interval still ticks |
| Obsidian minimized / backgrounded | ✅ OS notification + beep (timers throttle to ~1s in background, so up to ~1s late — irrelevant for pomodoro) |
| Reopened note after it expired during an app reload | ✅ retroactively — `paint()` detects `left <= 0` on render |
| Obsidian fully **closed** | ❌ impossible without an OS scheduler (e.g. Windows Task Scheduler) |

## Hard limits & the one gap to close

- **Obsidian closed = no alert.** DataviewJS is not a background service; it only runs while Obsidian is open. True closed-app alerts require an external scheduler (Windows Task Scheduler firing a `schtasks` notification) — overkill for pomodoro.
- **The block must have rendered at least once this session** to register the `window` interval. If you never opened the timer note, nothing ticks in the background. Close that gap by either (a) keeping the timer note pinned in a sidebar tab, or (b) arming the timer at startup via the **Templater** startup template or the **CustomJS** plugin, independent of visiting the note.
- **It runs on wall-clock time** by design: start a 25:00 timer, close Obsidian for 25 minutes, and you return to "done" (correct pomodoro behavior). A *freeze-when-hidden* variant — accumulating elapsed time only while rendered — is a different design.

## Related

- [[(C) Dataviewjs State Persistence\|Dataviewjs State Persistence]] — the underlying concept this is built on.
- [[(C) Dataviewjs Render State\|Dataviewjs Render State]] — render-lifecycle crash gotcha to avoid in any dataviewjs block.
- Source: conversation on dataviewjs state + pomodoro implementation, 2026-06-11.
