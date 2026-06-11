---
type: concept
aliases: ["MCL Multi-Column Layout", "Multi-Column Callout", "Modular CSS Layout"]
tags: [obsidian, css, callouts, layout, dashboard, concept]
updated: 2026-06-11
sources: 2
---

# MCL Multi-Column Layout

**MCL (Modular CSS Layout)** is a CSS-snippet library that turns Obsidian callouts into a responsive **column layout** — items placed under a `[!multi-column]` callout flow into columns that dynamically fit the page. It's the static-layout substrate for the vault dashboard (the dynamic widgets are `dataviewjs`; see [[(C) Dashboard v1 Design|Dashboard v1 Design]]).

- **Source library:** [efemkay/obsidian-modular-css-layout](https://github.com/efemkay/obsidian-modular-css-layout)

## How to use it

1. **Install the snippet** — drop the MCL `.css` files into `.obsidian/snippets/` and enable them under **Settings → Appearance → CSS Snippets**.
2. **Declare a multi-column section** with the wrapper callout:

   ```markdown
   > [!multi-column]
   >
   > > [!info]
   > > Left column
   >
   > > [!warning]
   > > Right column
   ```

3. **Use child callouts** (`[!info]`, `[!warning]`, `[!blank]`, …) as the individual columns. Each nested callout becomes a column that auto-fits.

## Controlling column width

Column proportions come from [[(C) Callout Metadata|callout metadata]] — e.g. `[!blank|wide-1]`, `[!blank|wide-2]` → the snippet's `data-callout-metadata*="wide-2"` selector sets `flex-grow`. A **Wide Views** MCL variant gives full-width tables room (used for the dashboard's Projects launcher row).

## What it relies on

The MCL snippets are pure CSS attribute selectors, so they depend on the two Obsidian mechanisms:

- [[(C) cssclasses Containment|cssclasses]] — scopes the styling to the dashboard note (`cssclasses: dashboard`).
- [[(C) Callout Metadata|callout metadata]] — the per-column width hooks.

The main learning curve is just **which callouts the snippet defines** and what each does.

## Related

- [[(C) Callout Metadata|Callout Metadata]] · [[(C) cssclasses Containment|cssclasses Containment]] — the CSS mechanisms underneath.
- [[(C) Bases Launcher|Bases Launcher]] — the full-width Projects row sits in an MCL Wide View.
- [[(C) Dashboard v1 Design|Dashboard v1 Design]] — the decision to build the dashboard on MCL + `dataviewjs`.
- Sources: `Projects/Obsidian Configs/Ideas/Theme/Dashboard/Creating a Dashboard (IN PROGRESS).md`; `… /Callout Metadata Styling (NOTE).md`.
