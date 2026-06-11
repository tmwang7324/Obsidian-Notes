# Doculyze

A personal **AI Document Analysis** web app: users register, sign in, upload documents, and get AI analysis back. This file is the entry point — read it first. Doculyze is one project inside the larger second-brain vault, which follows the [[(C) LLM Wiki Pattern|LLM Wiki Pattern]].

## Claude's Role

Claude is the architecture-and-synthesis partner for Doculyze. Concretely it:

- Designs and documents the app's systems (auth, data layer, rendering) as `(C)` synthesis pages here, and compiles reusable concepts (Firebase, Next.js, JWT, cookies…) into the shared `../../wiki/`.
- Keeps the **Project Snapshot** and **Current Status** below accurate as decisions are made.
- Answers implementation/design questions with citations back to `raw/notes/` sources and existing wiki pages.

**Prime directive:** If a session is drifting without moving toward a shippable Doculyze app (working auth → data layer → upload/analysis flow), nudge me back: "Is this getting us closer to a user uploading a document and getting analysis, or is it a side quest?"

## Project Snapshot

**Stack**
- **Frontend:** [[(C) Next.js|Next.js]] (App Router) with Zustand for state.
- **Backend:** [[(C) Express|Express]] + [[(C) Firebase Admin SDK|Firebase Admin SDK]] for session verification.
- **Identity:** [[(C) Firebase|Firebase]] client auth for sign-in / registration.

**Central insight** — authentication is split into **two systems that never cross-talk** (full design in [[(C) Auth Architecture|Auth Architecture]]):

| System | Drives |
|---|---|
| [[(C) Firebase\|Firebase]] `onAuthStateChanged` | Client UI (navbar, avatar, page visibility) |
| Backend [[(C) Session Cookies\|session cookie]] | Route protection + data access |

The browser cannot read the HTTP-only session cookie, so the frontend uses Firebase state for fast UI and asks the backend when it needs the authoritative answer.

**Related wiki concepts:** [[(C) Authentication vs Authorization|Authentication vs Authorization]] · [[(C) Tokens|Tokens]] · [[(C) JWT|JWT]] · [[(C) Firebase ID Token|Firebase ID Token]] · [[(C) CSRF Protection|CSRF Protection]] · [[(C) Server vs Client Components|Server vs Client Components]] · [[(C) Rendering Strategies|Rendering Strategies]] · [[(C) React Context Providers|React Context Providers]]

## Process

How work flows from idea to shipped feature in Doculyze. Project **steps and notes live in the wiki**, not in per-project process folders.

1. **Source** — Drop reference material (docs, screenshots, exports) into `../../raw/`. It's immutable; Claude reads, never edits.
2. **Synthesize** — Claude compiles the source into pages: project-specific design → `(C)` synthesis pages here in `Projects/Doculyze/`; reusable concepts/tools → `../../wiki/`.
3. **Decide** — Architecture decisions get captured in the relevant synthesis page (with the rejected alternatives noted, e.g. the refresh/access-token split).
4. **Build** — Implement against the documented design in the actual Doculyze codebase (outside the vault).
5. **Index & log** — Update `../../index.md` and append to `../../log.md` so the work compounds.

## Folder Structure

```
Vault/
├── CLAUDE.md                          ← Vault schema — how the whole second brain works
├── index.md                           ← Catalog of all wiki pages
├── log.md                             ← Append-only timeline of ingests / queries / lints
├── raw/
│   ├── notes/                         ← Your immutable source notes (incl. Doculyze sources)
│   └── assets/                        ← Images, screenshots, PDFs
├── wiki/                              ← LLM-maintained concept & tool pages (cross-project)
└── Projects/
    └── Doculyze/                      ← You are here
        ├── CLAUDE.md                  ← This file — project home, role, process, status
        ├── COMMANDS.md               ← Skills & commands available in this project
        ├── (C) Auth Architecture.md   ← Synthesis: the two-system auth design
        ├── (C) Technology Architecture.md  ← Planned frontend / backend shape
        ├── Ideas/                     ← Input: raw ideas / features to consider
        ├── In Progress/              ← Process: work actively being built
        ├── Done/                      ← Output: shipped / completed items
        ├── Goals/                     ← Short- and long-term project goals
        ├── Chats/                     ← Archived, summarized Claude sessions
        ├── Skills/                    ← Reusable scripts / automations (markdown, not Claude Code skills)
        ├── Resources/                 ← Links, references, docs
        ├── Progress/                  ← Weekly folders of daily progress reports + a weekly summary
        ├── Iteration Logs/            ← Notes on what to improve
        └── System/                    ← Scripts, config, reusable processes
```

Doculyze-specific synthesis lives here; reusable concepts (Firebase, Next.js, JWT, cookies…) live in `../../wiki/`; source notes live in `../../raw/notes/`. Durable synthesis still belongs in `../../wiki/`; the folders above hold the project's working material.

## Key People

Just me (solo project).

## Rules & Conventions

- **`(C)` prefix** — Every file the LLM creates is prefixed with `(C)` so AI-generated content is obvious in the file tree. **Exempt:** fixed-name system files whose names tooling depends on — `CLAUDE.md`, `COMMANDS.md`, `index.md`, `log.md`.
- **Clean links** — link `(C)` files with a display alias, e.g. `[[(C) Firebase|Firebase]]`, so the tree shows authorship while prose stays readable. Each `(C)` page also declares an `aliases:` entry with its clean name.
- **Ownership by location** — `raw/` is yours and immutable (the LLM reads, never edits). `wiki/` and project synthesis files are LLM-owned and -maintained.
- **Editing rule** — Before editing any file *you* authored (anything in `raw/`, or any non-`(C)` file), the LLM asks permission first.
- **Skills** — Reusable scripts / automations are saved as markdown files (see `COMMANDS.md`), **not** as Claude Code skills.
- **Cite sources** — synthesis pages cite the `raw/notes/` files they were compiled from.
- **Represented in the wiki** — this project's working folders are the staging area; durable content flows up into [[(C) Doculyze|the project's wiki overview]] and the relevant concept pages. Read project content from the wiki first; drill into these folders directly only when the wiki isn't comprehensive enough.
- **Progress loop** — follows the vault-wide **Progress** workflow in the root `CLAUDE.md`: `Goals/` set direction; daily `(C) YYYY-MM-DD.md` files under `Progress/Week of <Mon date>/` (`type: progress`) record work and link the goal they advance; `Iteration Logs/` holds `type: next-step` files (the backlog feeding `/create-daily-plan`). For this project, `project: Doculyze`, tag `doculyze`.

## Current Status

> **Last updated:** 2026-06-03
> **Status:** Auth architecture fully designed (see [[(C) Auth Architecture|Auth Architecture]]); implementation checklist not yet started. Database layer (Firestore) and navbar UI not yet built.

**Open threads**
- Session cookie split into refresh/access tokens — considered and **rejected**; Firebase ID tokens already serve as short-lived access tokens (see [[(C) Firebase ID Token|Firebase ID Token]]).
- "Learn what hydration means fully" — open learning task (see [[(C) Rendering Strategies|Rendering Strategies]]).
- Backend language for the AI/document layer undecided (ChromaDB↔FastAPI / LangChain↔Python).
