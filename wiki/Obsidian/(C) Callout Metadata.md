---
type: concept
aliases: ["Callout Metadata", "data-callout-metadata", "Callout Metadata Styling"]
tags: [obsidian, css, callouts, dashboard, concept]
updated: 2026-06-11
sources: 1
---

# Callout Metadata

Callout metadata is an **arbitrary string you place after a pipe in a callout header** — Obsidian emits it as a CSS-targetable HTML attribute. It's the hook that lets a stylesheet style individual callouts without touching their content, and it's the mechanism the [[(C) MCL Multi-Column Layout|MCL]] column snippets key off.

## Syntax

```markdown
> [!TYPE|METADATA] Optional Title
```

Example:

```markdown
> [!blank|wide-1]
```

Here `blank` is the type and `wide-1` is the metadata — **not** YAML, just a post-pipe tag.

## What Obsidian renders

```html
<div class="callout" data-callout="blank" data-callout-metadata="wide-1">
```

- The **type** (after `!`, lowercased) becomes the `data-callout` attribute.
- **Everything after the `|`** becomes the `data-callout-metadata` attribute.

## How CSS targets it

A plain attribute selector — `*=` means "contains":

```css
div[data-callout="multi-column"].callout > .callout-content
  > div[data-callout-metadata*="wide-2"] { flex-grow: 2; }
```

(This is the actual selector from `MCL Multi Column.css:166`.)

You can **stack** values with more spaces/pipes:

```markdown
> [!blank|wide-2 center]
```

→ `data-callout-metadata="wide-2 center"`, and **both** `*="wide-2"` and `*="center"` selectors match.

## Distinction

Two different layers, often confused:

- **Frontmatter** = note-level YAML (e.g. [[(C) cssclasses Containment|cssclasses]]) → brands the whole note.
- **Callout metadata** = a post-pipe tag on one callout → becomes a CSS-targetable attribute on that block.

## Related

- [[(C) cssclasses Containment|cssclasses Containment]] — the note-level scoping it pairs with.
- [[(C) MCL Multi-Column Layout|MCL Multi-Column Layout]] — uses `wide-1`/`wide-2` metadata to size columns.
- Source: `Projects/Obsidian Configs/Ideas/Theme/Dashboard/Callout Metadata Styling (NOTE).md`.
