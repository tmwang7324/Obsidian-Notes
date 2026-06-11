# Log

Append-only timeline of what happened in the vault — ingests, queries, lint passes. Each entry starts with `## [YYYY-MM-DD] <type> | <title>` so the log stays greppable:

```
grep "^## \[" log.md | tail -5
```

---

## [2026-06-11] ingest | dashboard design cluster + CSS-mechanism concept pages

Swept the source layers since the 2026-06-06 manifest. Authored four Obsidian concept pages — [[(C) cssclasses Containment|cssclasses Containment]], [[(C) Callout Metadata|Callout Metadata]], [[(C) MCL Multi-Column Layout|MCL Multi-Column Layout]], [[(C) Bases Launcher|Bases Launcher]] — splitting the dashboard's CSS stack into independently-retrievable topics. Authored three Obsidian Configs ADRs from the `(DECISION)`-marked dashboard notes: [[(C) Dashboard v1 Design|Dashboard v1 Design]] (1 main), [[(C) Pomodoro Timer Placement|Pomodoro Timer Placement]] and [[(C) Recent Files Widget Scope|Recent Files Widget Scope]] (2 focused). Updated `(C) Architecture.md` (dashboard current-state, `(DECISION)` in capture flow, new ADRs), folded the theming how-tos (custom background, widened interface) into the `(C) Obsidian Configs` overview, and added the `ar9av/obsidian-wiki` reference to [[(C) LLM Wiki Pattern|LLM Wiki Pattern]] from the 06-07 journal. Confirmed `Wiki Structure (DONE)` / `Should Progress (DONE)` were already captured in the 06-08 [[(C) Decisions in the Wiki]] ADR (manifest re-stamped, not re-synthesized). Skipped empty/narrative sources (Doculyze Firebase note; journals 06-08/06-10/06-11). 30 → 37 pages.

## [2026-06-11] progress | backfilled 2026-06-06 → 06-11 Obsidian Configs progress

Caught up the `Progress/` changelog after several un-recorded days. Wrote `(C) 2026-06-06` (backlog grooming + theme/vocab notes; no journal), `(C) 2026-06-08` (progress-in-wiki decision + two new skill goals), `(C) 2026-06-09` (Dashboard v1 grill, daily-plan done, pomodoro + journal-nesting scoped; no journal), `(C) 2026-06-10` (dashboard CSS targeting mechanism; empty journal), `(C) 2026-06-11` (finalized dashboard v1 + wiki structure decisions). Added two Iteration Logs next-steps: `(C) Pomodoro Timer Sidebar Note`, `(C) record-progress Context Reduction`. Skipped 2026-06-07 (no activity). Open: Doculyze 06-06 (empty note, no journal) and 06-05 existing file pending user calls; `(DECISION)`-marked notes won't trigger synthesize ADRs (uses `**Decision**`).

## [2026-06-11] query | does stateful dataviewjs persist across note switches? + persistent pomodoro

Clarified that a `dataviewjs` block re-executes from scratch on every render, so in-memory state (vars/closures) does **not** survive a note switch, mode toggle, or scroll-out/in — persist via `localStorage`/`sessionStorage`/`window`/frontmatter instead. Filed the concept as [[(C) Dataviewjs State Persistence|Dataviewjs State Persistence]]. Applied it to a pomodoro timer: store the absolute end-timestamp (not remaining seconds) and re-derive on render; keep the `setInterval` on `window` as a heartbeat so it ticks across note switches; alert on completion via `Notice` + OS `Notification` + WebAudio beep so it fires even when on another note or minimized. Hard limit: no alert when Obsidian is fully closed (needs an OS scheduler). Filed [[(C) Pomodoro Timer (DataviewJS)|Pomodoro Timer (DataviewJS)]].

## [2026-06-10] query | why "p is not a function" broke every Dataview query

Debugging the `(C) Dashboard.md` Recent widget. Traced `TypeError: p is not a function` into Dataview's bundle (`main.js:15243`, Preact's `useEffect`). Confirmed the bundle is strict-mode CommonJS — its internals are module-scoped, so a leaked `window.p` from a bare `dataviewjs` assignment is **not** the cause. Real cause: Dataview renders all blocks through one shared Preact instance; a block that throws mid-render leaves Preact's component pointer dangling, cascading to every query for the session. Fix = reload the app. Filed [[(C) Dataviewjs Render State|Dataviewjs Render State]].

## [2026-06-08] design | decisions-in-the-wiki + capture pipeline + archive-not-delete

`/grill-me` session over `Ideas/Structure/Wiki Structure.md`, `Should Progress be Included in Wiki.md`, and `Track Daily Progress Ideas (IN PROGRESS).md`. Resolved the contradiction between "no progress in the wiki" and "decisions belong in the wiki," then wrote it up and updated the schema.

- **Created** the first per-project wiki **folder**: moved `wiki/Projects/(C) Obsidian Configs.md` → `wiki/Projects/Obsidian Configs/`, added [[(C) Architecture|Obsidian Configs Architecture]] and a `Decisions/` subfolder.
- **Authored 3 ADRs** (`type: decision`): [[(C) Decisions in the Wiki]] (decisions+rationale are durable wiki content; per-project folders; immutable ADRs + supersession; Architecture-vs-Decisions split), [[(C) Decision Capture Pipeline]] (the `**Decision**` marker → `synthesize` sole author → `record-progress` links up; marker-then-inference), [[(C) Archive Not Delete]] (never delete source notes; archive fully-processed ones to `Ideas/Archive/` on a `(DONE)`+synthesized+progress-cited gate, relocate-only with confirmation).
- **Edited root `CLAUDE.md`** — refined "no progress" to "no *dated changelog*"; registered per-project wiki folders, `type: decision` frontmatter, the `**Decision**` marker, and the archive carve-out to the editing rule.
- **Edited `synthesize` skill** — blesses the decision layer (authors ADRs + updates Architecture), spares `type: decision` from the conditional purge, skips `Archive/` on scan, and gained a Step 9 archive sweep.
- **Updated** `index.md` (4 new pages; 23 → 27).
- **Remaining (flagged):** the per-project folder migration for Doculyze and Golf is not yet done.

## [2026-06-08] config | wired `record-progress` to the decision/archive pipeline

Follow-up to the design entry above — closed the `record-progress` half of the pipeline.

- **`scan_day.ps1`** — now skips any `Archive/` folder (already-processed notes) and emits a new `has_decision` flag per modified note (detects a `**Decision**` marker or Decision header). Re-ran it against 2026-06-08: parses clean, 1 project, `has_decision` correctly false on the legacy Idea notes.
- **`record-progress` SKILL.md** — added a **Log decisions** step: on `has_decision`, write a dated `**Decided:** … — [[(C) <Decision>]]` line in a new optional `## Decisions` section that links **up** to the ADR `synthesize` authors (rationale never copied into Progress). Documented the `has_decision`/`Archive/` scan behavior and added the section to the template.

## [2026-06-06] ingest | synthesis sweep — /daily-plan design locked + theming + vocab

Sweep processed 6 durable sources; skipped 1 empty file (`Ideas/Give me Today's Daily Plan (DONE).md`) and flagged 1 unresolved debate (`Ideas/Raw Notes vs Project Ideas (In Progress).md`) without synthesizing a settled decision.

- **Updated** [[(C) Obsidian Configs|Obsidian Configs]] — replaced the stale "still grilling" `/daily-plan` section with the **locked design** (Q1–Q11 resolved: name `/daily-plan`, `Plans/` + `type: plan` output, `Iteration Logs/` backlog, time-budget + manual-intensity sizing with auto-scaling rejected, faith the one fixed non-negotiable). Added themes (AnuPpucin/Minimal/Obsidianite via Style Settings), CSS-snippet horizontal rules, the `(DONE)`/`(INCOMPLETE)` filename-suffix convention, the open raw/ vs Ideas/ question, and the next focus shift to Google Interview Prep. From `Chats/Grilling the Daily Plan Skill.md`, `Ideas/Notes.md`, `Ideas/Theme Customization.md`, `Ideas/Track Daily Progress Ideas (IN PROGRESS).md`, `01 Journals/.../2026-06-05.md`.
- **Updated** [[(C) LLM Wiki Pattern|LLM Wiki Pattern]] — added `Plans/` (`type: plan`) to the per-project loop, noted `/daily-plan` + `/record-progress` now drive it, and documented the `(DONE)`/`(IN PROGRESS)` status-marker convention.
- **Updated** [[(C) Vocabulary|Vocabulary]] — added **Backlog** and **Derived Task**.

## [2026-06-05] ingest | synthesis sweep — Golf irons + Obsidian Configs conventions

Sweep processed 5 durable sources; skipped 4 empty/journal-only files and re-stamped 2 moved `(C)` synthesis pages.

- **Created** [[(C) Iron Swing|Iron Swing]] (irons technique cues) and [[(C) Golf|Golf]] project overview — from `Projects/Golf/Ideas/Iron Swing.md`.
- **Updated** [[(C) Obsidian Configs|Obsidian Configs]] with the `Ideas/`-vs-`Chats/` split, Progress-vs-Iteration-Logs convention, the in-progress `/daily-plan` design, and theme/appearance notes — from `Chats/Designing the Daily Progress File.md`, `Chats/Grilling the Daily Plan Skill.md`, `Ideas/Project Ideas Structure (DONE).md`, `Ideas/Theme Customization.md`.
- **Updated** [[(C) LLM Wiki Pattern|LLM Wiki Pattern]] with the per-project Progress loop and authorship-by-location convention.
- **Index:** 21 → 23 pages (added Golf overview + Iron Swing; new Golf category).
- **Flagged unfinished:** `Theme Customization.md` ("Unique Rainbow Labels for Nested Folders" section is empty); `01 Journals/…/2026-06-04.md` had nothing durable.

## [2026-06-04] progress | Obsidian Configs — vault theming (Anupucci, rainbow folders, icons)

Established the vault-wide **Progress** workflow (root `CLAUDE.md`): `Progress/` = changelog, `Iteration Logs/` = fix backlog, daily `type: progress` files synthesizing journal + working notes. Registered `type: progress`; wired the convention into all three projects + the `new-project` skill.

- **Created** first progress file [[(C) 2026-06-04]] (Obsidian Configs) from `01 Journals/…/2026-06-04.md` + [[Theme Customization]].
- **Created** Iteration Log [[(C) Nested Folder Rainbow Labels]] for the carried-forward defect.
- **Added** `Progress/(C) Progress Log.md` — Dataview changelog table (test run).

## [2026-06-04] ingest | First synthesis sweep + wiki reorg

First run of the `synthesize` skill. Scanned all four source layers (`raw/notes/`, `01 Journals/`, project `Chats/`, project `Ideas/`): **25 files**.

- **Synthesized** `01 Journals/2026 Journals/06 June/2026-06-03.md` → new **Reading** category: created [[(C) Poor Charlie's Almanack|Poor Charlie's Almanack]] and [[(C) Vocabulary|Vocabulary]] (Social Security Act, FICA, Stentorian Admonishment). Incomplete draft fragments in the journal were skipped per the journal rubric.
- **Empty:** `2026-06-04.md` — nothing to synthesize.
- **Baseline-stamped** the 23 files already represented in the wiki (20 `raw/notes/` compiled 2026-06-02, 2 `Doculyze/Ideas/` architecture pages, 1 `Obsidian Configs/Chats/` reconfigure note) into the manifest **without re-synthesizing**.
- **Reorganized `wiki/` into content subfolders:** `Full Stack Development/` (13), `Programming/` (1), `Projects/` (2), `Meta/` (1), `Reading/` (2). Obsidian wikilinks resolve by filename, so no links broke.
- Updated `index.md` (mirrors the new subfolders; 19 → 21 pages) and stamped `(C) Synthesis Manifest.md` (last step).

---

## [2026-06-03] setup | Project↔wiki representation convention

Scaffolded the full `new-project` folder set (plain names) into both projects — `Ideas/`, `In Progress/`, `Done/`, `Goals/`, `Chats/`, `Skills/`, `Resources/`, `Progress/[Week]/`, `Iteration Logs/`, `System/` — and established the ongoing convention that project content is **represented in the wiki**:

- Created lightweight overview pages [[(C) Doculyze|Doculyze]] and [[(C) Obsidian Configs|Obsidian Configs]] in `wiki/` (kept short to save context).
- Encoded the rule in the root `CLAUDE.md` (Conventions) and both project `CLAUDE.md`s: project folders are the staging area, durable content flows up into the wiki, and **retrieval reads the wiki first** — drill into the project directory only when the wiki isn't comprehensive enough.
- Updated `index.md` — added both overviews; page count 17 → 19; noted the overview-first retrieval order.

---

## [2026-06-03] setup | Converted Obsidian Configs & Doculyze to full projects

Applied the `new-project` workflow (adapted to the LLM Wiki Pattern) to two project folders:

- **Dedup** — deleted the empty `Projects/Obsidian Configs/` and renamed `Projects/Obsidian Configs 1/` → `Projects/Obsidian Configs/` (kept the folder holding the vault-reconfigure chat note).
- **Obsidian Configs** — new project home: `CLAUDE.md` (role = vault maintainer; process = spot → decide → apply → reconcile → record) + `COMMANDS.md`. Scope: vault infrastructure, conventions, and the `.claude/skills/` skills.
- **Doculyze** — overwrote `CLAUDE.md` with the new-project template (Role / Process / Folder Structure / Rules / Status) while preserving the existing snapshot and open threads; added `COMMANDS.md`.
- Kept structure light per the LLM Wiki Pattern — project steps and notes live in `wiki/` / `Chats/`, not numbered process folders.
- Updated root `CLAUDE.md` (Current state → two projects) and `index.md` (added Obsidian Configs project home).

Earlier this session: repaired the three vault skills (`new-project`, `weekly-update`, `brain-setup`) — moved `claude/skills/` → `.claude/skills/`, renamed `SKILL.md.md` → `SKILL.md`, added YAML frontmatter.

---

## [2026-06-02] setup | Reconfigured vault to the LLM Wiki pattern

Restructured the existing vault into the [[(C) LLM Wiki Pattern|LLM Wiki Pattern]]:

- Created `raw/notes/` and moved all existing notes there (immutable source layer): `Firebase/`, `Full Stack Dev/`, `AI Document Analysis/`, plus loose notes (`Counter.md`, `SDK.md`, `2026-05-25.md`).
- Created `raw/assets/` and moved root images (`Pasted image *.png`) + the export zip there; copied the three LLM-Wiki pattern images (`llm-wiki-architecture.png`, `llm-wiki-architecture-layers.png`, `llm-wiki-second-brain-loop.webp`).
- Created `wiki/` and compiled 14 clean, interlinked pages from the raw notes.
- Created `Projects/Doculyze/` with a project `CLAUDE.md`, `(C) Auth Architecture`, and `(C) Technology Architecture`.
- Added system files: `index.md` (catalog), `log.md` (this file), root `CLAUDE.md` (vault schema).
- Adopted the `(C)` prefix convention for all LLM-created content files (system files exempt).
- Removed Obsidian boilerplate (`Welcome.md`, empty `Untitled.md`).

Pages created: [[(C) Auth Architecture|Auth Architecture]], [[(C) Technology Architecture|Technology Architecture]], [[(C) Next.js|Next.js]], [[(C) Express|Express]], [[(C) Firebase|Firebase]], [[(C) Firebase Admin SDK|Firebase Admin SDK]], [[(C) Authentication vs Authorization|Authentication vs Authorization]], [[(C) Tokens|Tokens]], [[(C) JWT|JWT]], [[(C) Firebase ID Token|Firebase ID Token]], [[(C) Session Cookies|Session Cookies]], [[(C) CSRF Protection|CSRF Protection]], [[(C) Server vs Client Components|Server vs Client Components]], [[(C) Rendering Strategies|Rendering Strategies]], [[(C) React Context Providers|React Context Providers]], [[(C) LLM Wiki Pattern|LLM Wiki Pattern]].

---

## [2026-06-02] ingest | Counter.md (test ingest)

Test of the ingest workflow on an existing raw source, `raw/notes/Counter.md`.

- **Read** the source; extracted: `collections.Counter` subclasses `dict` and maps elements → counts.
- **Created** [[(C) Python Counter|Python Counter]] in `wiki/` — a distinct topic (first non-Doculyze page), proving the second brain spans domains.
- **Updated** `index.md` — added a new "Programming — Python" category; page count 16 → 17.
- **Logged** this entry.

Result: full ingest loop (read → compile → index → log) verified working.
