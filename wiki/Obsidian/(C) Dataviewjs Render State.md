---
type: concept
aliases: ["Dataviewjs Render State", "Dataview p is not a function", "Dataviewjs Render Gotcha"]
tags: [obsidian, dataview, dataviewjs, debugging, concept]
updated: 2026-06-10
sources: 1
---

# Dataviewjs Render State

A debugging lesson from the `(C) Dashboard.md` build: **all Dataview queries share one render instance, so a single throwing block can break every query in the session.** The symptom is `TypeError: p is not a function`.

## The symptom

A Dataview query (DQL or `dataviewjs`) stops rendering and the console shows:

```
Evaluation Error: TypeError: p is not a function
  at b$1.RawMarkdown [as constructor]   (plugin:dataview:15243:5)
  at b$1.B$2 [as render]                (plugin:dataview:15192:…)
  at L$1 / P$1  (recursive)             (plugin:dataview:15192:…)
```

Often **every** Dataview block in the vault stops rendering at once — not just the edited one.

## What it is NOT

It is *not* a leaked global variable clobbering Dataview's internals. It's tempting to think a bare `p = dv.paragraph(...)` (no `let`/`const`) in a `dataviewjs` block overwrites `window.p` and breaks Dataview's `p`. **It can't:** Dataview's `main.js` opens with `'use strict';` and is a CommonJS module, so its internal identifiers — including the `p` at `main.js:15243` (Preact's `useEffect` hook) — are **module-scoped**. User `dataviewjs` code runs in a separate scope and cannot reach in to overwrite them.

## What actually breaks it

Dataview renders every query block through a **single shared Preact instance**. Preact keeps an internal "currently-rendering component" pointer that must be set on entry and cleared on exit of each render.

When one block **throws during render**, that pointer is left dangling — the clean-up never runs. From that moment, the next Dataview render calls a hook accessor (the `p(…)`/`useEffect` on line 15243) that now resolves against corrupted state → `p is not a function`. Because the Preact instance is shared, the corruption cascades to **all** Dataview rendering for the rest of the session.

Crucially, this state lives **in memory**. Fixing the offending note does **not** clear it.

## The fix: reload

`Ctrl+P` → **"Reload app without saving"** (or `Ctrl+R`). This re-initializes the Dataview plugin and its Preact instance, clearing the stuck pointer. After reload, every query renders again — provided the note that threw has been corrected.

## Prevention

- **Declare with `let`/`const`** in `dataviewjs`. A bare assignment leaks to `window`; even though it isn't what caused the cascade here, it's still global pollution that can collide with other plugins. (See `(C) Dashboard.md` Plan widget: `let p = dv.paragraph(...)`.)
- **Don't render `Link` objects through `dv.list()` / `dv.paragraph()` if that path is throwing.** Build the list with direct DOM and Obsidian's link handling — it bypasses Dataview's `RawMarkdown` renderer entirely and can't trigger the cascade:

  ```js
  const ul = dv.container.createEl("ul");
  for (const pg of recent) {
    const a = ul.createEl("li").createEl("a", { text: pg.file.name, cls: "internal-link" });
    a.onclick = (e) => { e.preventDefault(); app.workspace.openLinkText(pg.file.path, "", false); };
  }
  ```

- **After any `dataviewjs` error, reload before trusting that "every query is broken."** The first fix you try may already be correct — the stale in-memory state is what's still showing the error.

## Related

- Applied in `(C) Dashboard.md` (the Recent / Plan / Journal widgets).
- Source: dashboard debugging session, 2026-06-10.
