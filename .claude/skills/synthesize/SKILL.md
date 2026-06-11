---
name: synthesize
description: Sweep the vault's source layers (raw/notes, 01 Journals, every project Chats/ and Ideas/) for new or changed notes and synthesize their durable content up into the wiki, index.md, and log.md. Project wiki pages capture identity, purpose, architecture, and durable design decisions + rationale — never dated progress; significant topics and `**Decision**`-marked decisions noted in a project's Ideas/ get their own dedicated wiki pages (decisions become immutable type:decision ADRs). Also archives fully-processed Ideas/ notes (relocate-only, with confirmation). Use when the user says "synthesize", "ingest", "update the wiki", "sweep my notes", or runs the nightly synthesis. Tracks what's been processed in (C) Synthesis Manifest.md so each run only handles what's new.
---

# Skill: Synthesize

Pull durable knowledge out of the vault's **source layers** and compound it into the **wiki**. This is the executor for the Ingest workflow described in the root `CLAUDE.md` — extended to project `Chats/` and `Ideas/` folders and made idempotent via a manifest.

The "auto" in auto-sweep means **discovery within a run**: one invocation finds everything new or changed across all source folders. It does NOT run on file save — it runs when invoked (manually, or nightly via `/schedule`).

## When to Use

- The user says "synthesize", "ingest", "sweep my notes", "update the wiki".
- The nightly scheduled job fires.
- After a `/grill-me` session or `archive-conversation` drop, when the user wants new material folded into the wiki.

## Source layers (inputs)

Scan these areas, **recursively**. They are **read-only** — never edit a source file.

- `raw/notes/` — cross-project immutable sources.
- `01 Journals/` — daily notes, nested as `2026 Journals/<MM Month>/<date>.md`. Recurse the whole tree. Apply the **Journal synthesis rubric** below — synthesize only the durable parts.
- `Projects/*/Chats/` — condensed chat notes (produced by `archive-conversation`).
- `Projects/*/Ideas/` — grill-me takeaways and hand-typed stuck-point notes.

> **Skip any `Archive/` folder.** Notes under `Projects/*/Ideas/Archive/` are already fully processed (see **Step 9 — Archive**). Never re-scan or re-synthesize them.

## Journal synthesis rubric

Daily notes are mostly logging. Synthesize selectively — a single journal can be *partially* synthesized. The test: **"Would I want to retrieve this again, on its own, months from now — and is it complete enough to stand alone?"**

**The `Important` override (highest priority — always wins):** any content tagged **Important** (e.g. a line prefixed `**Important**`) or anything under a header named **Important** (e.g. `## Important`) **must be synthesized**, regardless of which bucket it would otherwise fall in. When in doubt about anything else, default to *not* synthesizing — but never skip content the user flagged Important.

**The `Decision` marker (sibling to `Important`):** any content tagged **Decision** (a line prefixed `**Decision**`), under a header named **Decision**, or carrying a **`(DECISION)` tag** (the user's own convention — a header suffix like `## Approach (DECISION)` or an inline/filename tag) **must be authored as a decision record (ADR)** — see **Decision records** under Targets. All three forms are equivalent *guaranteed* triggers; you must also **infer** clear unmarked decisions (a choice + its rationale) and author ADRs for them as a fallback, reporting each so the user knows. Marker = never miss; inference = catch the unmarked.

Otherwise, sort content into three buckets:

1. **Durable → synthesize up.** Reusable definitions/terms, reading takeaways and book mental models, technical discoveries, decisions, stuck-point breakthroughs. Anything that stands on its own beyond the day it was written.
2. **Leave in the journal → never synthesize.** Day-to-day logs, mood, schedule, habit tracking, "what I did today," focus/accountability notes. This is read in place for accountability, not compounded into the wiki.
3. **Skip (not durable *yet*) → report, don't synthesize.** Incomplete fragments: trailing blanks, dangling/half sentences, empty bullets, obvious mid-thought drafts. Report each as "skipped — looked unfinished" so the user can finish it later. (Exception: if it's tagged **Important**, synthesize what's there and flag that it was incomplete.)

## Targets (outputs)

> **The wiki never holds *dated progress*.** It describes *identity, purpose, concepts, topics, architecture, and durable design decisions + rationale* — what things are and why they matter, **not what changed when**. The dated changelog lives exclusively in each project's `Progress/` directory. A decision's *rationale* is durable wiki content; only the *"it happened on this date"* fact is progress. See the **No-progress rule** below.

**Per-project wiki folder layout** — `Architecture.md` sits **directly under the project folder, a sibling of `Decisions/` (never inside it)**:

```
wiki/Projects/<Project>/
├── (C) <Project>.md       ← overview (identity & purpose)
├── (C) Architecture.md    ← mutable current-state map  (sibling of Decisions/)
└── Decisions/             ← immutable ADRs, one file per decision
    └── (C) <Decision>.md
```

- `wiki/Projects/<Project>/(C) <Project>.md` — the project overview page. Describes the project's **identity and purpose only**: what it is, why it exists, its scope and aim. **Never** dated progress, status updates, or changelog. Keep it short. Links to its `Architecture.md` and `Decisions/`.
- `wiki/Projects/<Project>/(C) Architecture.md` — the **mutable current-state** map of the project's system (what it *is* today; overwrite as it changes; no history). Links *down* to the decision records.
- `wiki/Projects/<Project>/Decisions/(C) <Decision>.md` — **immutable decision records (ADRs)**, one per significant decision. Authored when a `Projects/*/Ideas/` or journal note carries a `**Decision**` marker (or a clear unmarked decision is inferred). Frontmatter: `type: decision`, `project`, `date`, `status: accepted|superseded`, `aliases`, `tags: [decision, <slug>]`, `sources`, `supersedes`/`superseded-by`. Body: Context / Decision / Rationale / Alternatives rejected / Consequences. **The rationale is frozen** — never edit it except on explicit direction to correct a wrong one; a reversal is a *new* record that sets the old one's `status: superseded` (+ a `superseded-by` link). Cite the source note; link the project's `Architecture.md` and any domain concept pages it touches. Shared frameworks stay as domain pages — link *into* them, don't duplicate.
- `wiki/<Domain>/(C) <Topic>.md` — **dedicated topic pages for significant topics the user notes in `Projects/*/Ideas/`.** When an Idea note develops a substantive topic (a design, concept, or approach worth retrieving on its own) that is *not* a project-specific decision, give that topic its own standalone wiki page rather than only weaving it as an example. Cite the source Idea note and link the page from the relevant project overview. See the **Significant-topic test** below.
- `wiki/(C) <Concept>.md` — cross-project concept/entity pages (ML concepts, tools, etc.) synthesized from `raw/notes/` and journals. Durable content flows up here; non-progress project specifics may appear as illustrative examples. **No progress content.**
- **Reading category** (`index.md`) — reading/book takeaways and **vocabulary/terms** both live here. Vocabulary is filed under Reading, not as a separate category.
- `index.md` — add new rows / update summaries; bump the page count and `_Last updated_`.
- `log.md` — append one entry per run.
- `(C) Synthesis Manifest.md` (vault root) — the run's memory; stamp it last.

### The No-progress rule

The wiki must contain **no *dated changelog* content** — not on project pages, not woven into concept pages. The changelog is captured solely in each project's `Progress/` directory by the `record-progress` workflow. **Durable design decisions + rationale are *not* changelog** — they are wiki content (decision records); see **Decision records** above.

- **Progress vs decision — the test.** "Added X", "fixed Y", "now supports Z", "as of <date>" = *progress* → keep out of the wiki. "We chose X over Y because Z" = *decision + rationale* → belongs in the wiki as a `type: decision` ADR. The dated fact that the decision was made is the progress half and stays in `Progress/`.
- **Project overview pages = identity & purpose only.** No dated status lines. (Architecture + decisions live in their own pages.)
- **Examples on concept pages must be durable, not progress.** A concept page may cite a project to illustrate a technique, but never a dated "what changed" note.
- **Conditional purge of existing progress.** When you touch a wiki page that already contains *dated changelog* content, strip that content **only if it is already recorded** in the relevant project's `Progress/` directory. If it is **not** captured there, leave it in place and **flag it** to the user (so the information isn't lost before it's migrated to `Progress/`). **Never purge `type: decision` records or decision rationale** — they are durable wiki content, not progress.

### Significant-topic test

An Idea note earns its own `wiki/(C) <Topic>.md` page when the topic is **substantive and standalone** — a design, concept, decision, or approach you'd want to retrieve on its own months later. Fleeting one-liners, TODOs, and half-formed fragments do **not** get a page (treat like the journal "skip" bucket — report, don't synthesize). Anything tagged **Important** always earns synthesis. Each topic page carries normal wiki frontmatter (`type: concept`, `aliases`, `tags`, `updated`, `sources`) and cites its source Idea note.

## The Manifest

A single global file at vault root: `(C) Synthesis Manifest.md`. A markdown table, one row per source file, that records what has been synthesized so each sweep only processes what's new or changed.

Columns:

| Column | Meaning |
|---|---|
| Source | path relative to vault root (e.g. `Projects/Doculyze/Ideas/rag-fix.md`) |
| Modified | the source file's last-modified timestamp at the time it was synthesized (`YYYY-MM-DD HH:MM`) |
| Synthesized | date of the run that processed it (`YYYY-MM-DD`) |
| Wiki targets | the `(C)` pages it fed, comma-separated (reverse traceability) |

**Change detection is by timestamp** (not content hash). A source is new/changed when its current modified time is later than the `Modified` value in its manifest row, or when it has no row.

> Note: timestamps can be bumped by OneDrive sync without a content change, which may cause an occasional unnecessary re-synthesis. That's an accepted trade-off for simplicity. If re-syntheses become noisy, revisit switching to content hashes.

## Procedure

1. **Scan** `raw/notes/`, `01 Journals/` (recursively), every `Projects/*/Chats/`, every `Projects/*/Ideas/` — **excluding any `Archive/` folder**. Collect each file's path and current modified time.
2. **Diff against the manifest:**
   - No row for the file → **new** → synthesize.
   - Current modified time later than the row's `Modified` → **changed** → re-synthesize.
   - Otherwise → **skip**.
3. **Present the candidate list** to the user (path + new/changed) and get a quick approval before writing. For the nightly scheduled run, proceed automatically but report what was processed.
4. **Discuss takeaways** (when interactive) — surface the key points from each source before committing them, per the CLAUDE.md Ingest step.
5. **Synthesize** the new/changed set:
   - Update or create the relevant `wiki/<Domain>/(C) <Concept>.md` pages (correct frontmatter: `type`, `aliases`, `tags`, `updated`, `sources`).
   - For each significant topic in a `Projects/*/Ideas/` note (per the **Significant-topic test**), create or update a dedicated `wiki/<Domain>/(C) <Topic>.md` page and link it from the project overview.
   - **For each `**Decision**` / `(DECISION)` marker (or clearly inferred unmarked decision)**, author an immutable `type: decision` ADR at `wiki/Projects/<Project>/Decisions/(C) <Decision>.md` (see **Decision records** under Targets), and update that project's `(C) Architecture.md` current-state summary to reflect + link it. If the decision reverses an earlier one, set the old record's `status: superseded` + `superseded-by` rather than editing it.
   - Refresh each touched project overview page to describe **identity & purpose only** — never dated progress (see the **No-progress rule**). Non-progress project specifics may illustrate concept pages as examples.
   - **Conditional progress purge:** if a wiki page you touch already contains progress/changelog content, remove it only when that content is already recorded in the project's `Progress/` directory; otherwise leave it and flag it for migration.
   - **Cite the source file** on each page touched (raw note, Chat note, or Idea note).
6. **Update `index.md`** — new rows / updated summaries, page count, `_Last updated_`.
7. **Append `log.md`:** `## [YYYY-MM-DD] ingest | <title>` summarizing what was synthesized and from where.
8. **Stamp `(C) Synthesis Manifest.md`** — add/update a row for every file processed with its current modified time, today's date, and the wiki targets. This is the last *write* step so a failed run doesn't mark work as done.
9. **Archive fully-processed Ideas/ notes** (relocate-only, confirmation required) — see **Step 9 — Archive** below.

## Step 9 — Archive fully-processed Ideas/ notes

Folder hygiene for `Projects/*/Ideas/`: move done notes out of the active view so open ones don't drown. **Never delete** — relocate only; content is never altered. See [[(C) Archive Not Delete]].

**Triple eligibility gate** — a `Projects/*/Ideas/` note (not already under `Archive/`) is archivable only when **all three** hold:

1. **`(DONE)`-marked** — in the filename suffix (`… (DONE).md`) or inline body. (`(INCOMPLETE)`/unmarked → not eligible; still in flight.)
2. **Synthesized** — it has a row in `(C) Synthesis Manifest.md` at its current modified time (actually processed, not just present).
3. **Progress-cited** — a file under that project's `Progress/Week of */` contains a wikilink to the note's filename (the changelog caught it too).

All three guard against yanking a note before the full loop ran. A `(DONE)` note that never earned a progress entry simply never archives — accepted.

**Procedure:**

- Collect every eligible note across all projects. If none, skip silently.
- **Present the list and get explicit confirmation** before moving anything — this is the one place a skill touches the source layer, so never move without the user's OK.
- On approval, move each into `Projects/<Project>/Ideas/Archive/` (create the folder if missing). Wikilinks resolve by filename, so all citations survive untouched — do **not** rewrite any links.
- Report what was archived (clickable paths). Note that archiving lags by a cycle: a note synthesized this run won't be eligible until a later run after `record-progress` has logged it.

## Rules

- **Never edit source file *content*** (`raw/`, `Chats/`, `Ideas/`). Read only. **One narrow exception:** Step 9 may *relocate* a fully-processed `Ideas/` note into `Ideas/Archive/` — never altering its content, always with the user's confirmation. **Never delete a source note.**
- **No dated changelog in the wiki.** Project overview pages describe identity & purpose only; concept pages use only durable (non-progress) examples. The dated changelog lives solely in each project's `Progress/`. **But durable decisions + rationale belong in the wiki** as `type: decision` ADRs — never purge them. (See the **No-progress rule**.)
- **Decisions are immutable** — author a `type: decision` ADR per `**Decision**` / `(DECISION)` marker (and infer unmarked ones); freeze the rationale; reverse by superseding, not editing. `Architecture.md` is the mutable summary that links to them.
- **Significant Ideas topics get their own page** — don't bury a substantive topic as a mere example (see the **Significant-topic test**).
- **Always cite sources** on synthesized pages.
- **Keep project overview pages short** to save context.
- **Stamp the manifest last** (before the archive sweep) — only after the wiki/index/log writes succeed.
- **Skip `Archive/` folders** on every scan.
- If nothing is new or changed, say so and stop — don't churn the wiki. (Still run the Step 9 archive sweep — eligibility can change even when no note changed.)
