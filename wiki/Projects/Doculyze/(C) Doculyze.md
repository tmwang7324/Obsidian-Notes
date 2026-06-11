---
type: overview
aliases: ["Doculyze"]
tags: [project, doculyze, fullstack, ai]
updated: 2026-06-03
sources: 1
---

# Doculyze

A personal **AI Document Analysis** web app: users register, sign in, upload documents, and get AI analysis back. This is the wiki-level overview — read it first; drill into the project directory only if you need working detail it doesn't cover.

**Stack:** [[(C) Next.js|Next.js]] (App Router, Zustand) frontend · [[(C) Express|Express]] + [[(C) Firebase Admin SDK|Firebase Admin SDK]] backend · [[(C) Firebase|Firebase]] client auth.

**Central design:** authentication is split into two systems that never cross-talk — Firebase `onAuthStateChanged` drives the UI, a backend [[(C) Session Cookies|session cookie]] drives route protection. Full design: [[(C) Auth Architecture|Auth Architecture]] · [[(C) Technology Architecture|Technology Architecture]].

**Status (2026-06-03):** Auth architecture designed; implementation not yet started (data layer + navbar pending).

## Where the detail lives

- **Synthesis pages** (durable): [[(C) Auth Architecture|Auth Architecture]], [[(C) Technology Architecture|Technology Architecture]], and the cross-cutting concept pages in `wiki/`.
- **Working material** (ideas, progress, iteration logs): `Projects/Doculyze/` — read this directly only when the wiki above isn't comprehensive enough.
- **Project home:** [[CLAUDE|Doculyze CLAUDE.md]] (role, process, rules, current status).
