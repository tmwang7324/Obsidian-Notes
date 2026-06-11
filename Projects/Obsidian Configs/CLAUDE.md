# Obsidian Configs

The meta-project for the vault itself: configuring and maintaining this Obsidian second brain — the [[(C) LLM Wiki Pattern|LLM Wiki Pattern]] structure, the `(C)` convention, folder schema, plugins/CSS, and the ingest/query/lint workflows. Everything here is about keeping the *system* healthy, not about any one domain's content.

## Claude's Role

Claude is the vault's maintainer and refactoring partner. Concretely it:

- Evolves the vault's structure and conventions (the three-layer `raw/` → `wiki/` → schema pattern, the `(C)` prefix, link aliases) and keeps the root `CLAUDE.md`, `index.md`, and `log.md` consistent.
- Runs and refines the **ingest / query / lint** workflows defined in the root `CLAUDE.md`.
- Maintains the Claude Code skills in `.claude/skills/` (`new-project`, `weekly-update`, `brain-setup`) and the per-project `CLAUDE.md` / `COMMANDS.md` files.
- Captures meaningful configuration sessions as notes in `Chats/`, promoting reusable lessons into `../../wiki/`.

**Prime directive:** If a session is drifting away from keeping the vault coherent and low-friction to use, nudge me back: "Does this make the second brain easier to maintain and navigate, or is it adding structure I won't keep up?"

## Process

How a vault change goes from idea to done. Project **steps and notes live in the wiki / Chats**, not in per-project process folders.

1. **Spot** — Notice a structural need: a contradiction, an orphan page, a stale convention, a missing skill, or a config/plugin tweak.
2. **Decide** — Talk through the change; confirm it fits the LLM Wiki Pattern before editing anything.
3. **Apply** — Make the change (edit schema files, restructure folders, update skills). Respect the editing rule for non-`(C)` files.
4. **Reconcile** — Update the affected system files (`index.md`, root `CLAUDE.md`) so the catalog stays accurate.
5. **Record** — Append a `log.md` entry, and archive notable sessions into `Chats/`; promote durable lessons to a `(C)` page in `../../wiki/`.

## Key People

Just me (solo project).

## Folder Structure

```
Vault/
├── CLAUDE.md                          ← Vault schema — how the whole second brain works
├── index.md                           ← Catalog of all wiki pages
├── log.md                             ← Append-only timeline of ingests / queries / lints
├── .claude/skills/                    ← Claude Code skills (new-project, weekly-update, brain-setup)
├── raw/                               ← Immutable source layer (notes + assets)
├── wiki/                              ← LLM-maintained concept & tool pages (cross-project)
└── Projects/
    └── Obsidian Configs/              ← You are here
        ├── CLAUDE.md                  ← This file — project home, role, process, status
        ├── COMMANDS.md               ← Skills & commands available in this project
        ├── Ideas/                     ← Input: structural ideas / config tweaks to consider
        ├── In Progress/              ← Process: changes actively being made
        ├── Done/                      ← Output: completed vault changes
        ├── Goals/                     ← Short- and long-term maintenance goals
        ├── Chats/                     ← Archived vault-configuration sessions
        │   └── Reconfigure Obsidian Vault with LLM Wiki Pattern.md
        ├── Skills/                    ← Reusable scripts / automations (markdown, not Claude Code skills)
        ├── Resources/                 ← Links, references, docs
        ├── Progress/                  ← Weekly folders of daily progress reports + a weekly summary
        ├── Iteration Logs/            ← Notes on what to improve
        └── System/                    ← Scripts, config, reusable processes
```

## Rules & Conventions

- **`(C)` prefix** — Every file the LLM creates is prefixed with `(C)`. **Exempt:** fixed-name system files whose names tooling depends on — `CLAUDE.md`, `COMMANDS.md`, `index.md`, `log.md`.
- **Clean links** — link `(C)` files with a display alias, e.g. `[[(C) LLM Wiki Pattern|LLM Wiki Pattern]]`; each `(C)` page declares an `aliases:` entry.
- **Ownership by location** — `raw/` is yours and immutable. `wiki/` and project synthesis files are LLM-owned.
- **Editing rule** — Before editing any file *you* authored (anything in `raw/`, or any non-`(C)` file), ask permission first.
- **Schema changes are deliberate** — the root `CLAUDE.md` is the vault's contract; co-evolve it with the user, don't rewrite it unilaterally.
- **Skills** — Reusable scripts / automations are saved as markdown files (see `COMMANDS.md`), distinct from the Claude Code skills in `.claude/skills/`.
- **Represented in the wiki** — this project's working folders are the staging area; durable content flows up into [[(C) Obsidian Configs|the project's wiki overview]] and the relevant concept pages. Read project content from the wiki first; drill into these folders directly only when the wiki isn't comprehensive enough.
- **Progress loop** — follows the vault-wide **Progress** workflow in the root `CLAUDE.md`: `Goals/` set direction; daily `(C) YYYY-MM-DD.md` files under `Progress/Week of <Mon date>/` (`type: progress`) record work and link the goal they advance; `Iteration Logs/` holds `type: next-step` files (the backlog feeding `/create-daily-plan`). For this project, `project: Obsidian Configs`, tag `obsidian-configs`.

## Current Status

> **Last updated:** 2026-06-03
> **Status:** Just created — folder converted to a proper project. The vault is already running the LLM Wiki Pattern (set up 2026-06-02); this project now tracks ongoing maintenance of it.

**Open threads**
- The `.claude/skills/` skills were just repaired (wrong folder + doubled extension + missing frontmatter); confirm `new-project`, `weekly-update`, and `brain-setup` all trigger reliably.
- The stray `claude/` (no-dot) folder at vault root is now empty after the skills move — decide whether to delete it.
- `new-project` skill text still references a "KJ OS" layout (`03 Projects/`, a `(PROJECT TEMPLATE)`, numbered process folders) that doesn't match this vault — consider aligning the skill to the LLM Wiki Pattern.
