---
type: concept
aliases: ["cssclasses Containment", "cssclasses", "Scoped Note Styling"]
tags: [obsidian, css, dashboard, theming, concept]
updated: 2026-06-11
sources: 1
---

# cssclasses Containment

`cssclasses` is a **reserved Obsidian frontmatter key** that scopes CSS to a single note. When Obsidian renders a note that declares it, each value is applied as a literal CSS class on the note's **root view container** — not on any individual block. That one class becomes the anchor every descendant selector hangs off, so styling written for it can't leak to other notes.

## How it works

Frontmatter:

```yaml
---
cssclasses: dashboard
---
```

Obsidian renders the note roughly as (reading view):

```html
<div class="markdown-preview-view ... dashboard">   ← class lands HERE
   <div class="block-language-dataviewjs"> … .dash-clock … </div>
   <div class="callout" data-callout="multi-column"> … </div>
   <div class="block-language-base"> … </div>
</div>
```

(In Live Preview the wrapper is `.markdown-source-view` instead; Obsidian adds the class to **both**, so styling holds in either view.)

## Why it scopes cleanly — the descendant combinator

Selectors use a **space** (the descendant combinator) to reach inside the branded wrapper:

```css
.dashboard .callout[data-callout="multi-column"] .callout[data-callout*="blank"] { … }
```

The space between `.dashboard` and `.callout` means *"any `.callout` nested anywhere inside an element that has the `.dashboard` class."* The callout itself never needs the class — it just needs to **live inside** the element that does. This is a containment relationship: `cssclasses: dashboard` brands the whole note's wrapper, and every widget inside is reachable as a descendant.

That's also why the styling is **scoped**: those exact selectors can't match callouts in any other note, because no other note's wrapper carries `.dashboard`.

> **Quick check:** open the note, hit `Ctrl+Shift+I` (devtools), and inspect the outer note `<div>` — you'll see `dashboard` in its class list alongside Obsidian's own classes.

## Distinction

`cssclasses` is **note-level** (brands the whole note). For **per-block** targeting inside that note, pair it with [[(C) Callout Metadata|callout metadata]] — a different layer. The [[(C) MCL Multi-Column Layout|MCL multi-column]] snippets rely on both together.

## Related

- [[(C) Callout Metadata|Callout Metadata]] — per-block CSS targeting (the other half).
- [[(C) MCL Multi-Column Layout|MCL Multi-Column Layout]] — uses `cssclasses` + callout metadata to build columns.
- [[(C) Dashboard v1 Design|Dashboard v1 Design]] — the decision that put this to use.
- Source: `Projects/Obsidian Configs/Ideas/Theme/Dashboard/Frontmatter Styling (NOTE).md`.
