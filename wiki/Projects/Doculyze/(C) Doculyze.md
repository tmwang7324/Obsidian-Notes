---
type: overview
aliases: ["Doculyze"]
tags: [project, doculyze, fullstack, ai]
updated: 2026-06-16
sources: 3
---

# Doculyze

A personal **AI Document Analysis** web app: users register, sign in, upload documents, and get AI analysis back. This is the wiki-level overview — read it first; drill into the project directory only if you need working detail it doesn't cover.

**Stack:** [[(C) Next.js|Next.js]] (App Router, Zustand) frontend · [[(C) Express|Express]] + [[(C) Firebase Admin SDK|Firebase Admin SDK]] backend · [[(C) Firebase|Firebase]] client auth.

**Central design:** authentication is split into two systems that never cross-talk — Firebase `onAuthStateChanged` drives the UI, a backend [[(C) Session Cookies|session cookie]] drives route protection. Full system map: [[(C) Architecture|Architecture]].

**Scope:** a behavioral STAR-story project, deliberately scoped to a barebones naive→improved-RAG demo — see [[(C) Doculyze MVP Scope|Doculyze MVP Scope]]. The data layer is two stores (Firestore + ChromaDB): [[(C) Two-Store Data Layer|Two-Store Data Layer]].

## Where the detail lives

- **Current-state map:** [[(C) Architecture|Architecture]] — the live system shape + open threads.
- **Decisions (ADRs):** [[(C) Two-Store Data Layer|Two-Store Data Layer]] · [[(C) Doculyze MVP Scope|Doculyze MVP Scope]].
- **Synthesis pages** (durable): [[(C) Auth Architecture|Auth Architecture]], [[(C) Technology Architecture|Technology Architecture]], [[(C) Data Layer|Data Layer]], and the cross-cutting concept pages in `wiki/`.
- **Working material** (ideas, progress, iteration logs): `Projects/Doculyze/` — read this directly only when the wiki above isn't comprehensive enough.
- **Project home:** [[CLAUDE|Doculyze CLAUDE.md]] (role, process, rules, current status).
