---
name: record-progress
description: >-
  Generate the vault's daily Progress/ changelog files by synthesizing the day's dated
  journal plus that day's modified Project notes — one (C) YYYY-MM-DD.md file per project
  that saw activity, with type:progress frontmatter, an Advances: goal link, a Done section
  built from (DONE)-marked work, a Next steps section wired to Iteration Logs, and cited
  sources. Use this whenever the user wants to record, log, capture, or write up their
  progress for a day — phrases like "record progress", "log my progress", "write today's
  progress note", "update my progress files", "what did I get done today", end-of-day
  logging, or any request to produce the daily Progress/ changelog. Run it proactively at
  the end of a working session when the user is wrapping up. It is lightweight and runs
  end-to-end with minimal interaction.
---

# Record Progress

Automates the vault's **Progress** workflow: turn a day's raw work (the hand-typed journal
+ the Project notes touched that day) into the durable daily changelog files under each
project's `Progress/` folder. This is the backward-looking "what I did, when" half of the
loop that `Goals/` → `Progress/` → `Iteration Logs/` → `/create-daily-plan` runs on.

**Design priority: lightweight, minimal interaction.** The user explicitly wants this to
run with almost no back-and-forth. Auto-detect everything you can, make the obvious call,
and only stop to ask when something is genuinely destructive or ambiguous (e.g. an existing
file would be overwritten). Don't ask the user to confirm source notes or project lists —
the scan already decided those.

## The one rule that matters most

A real work day's progress file **cites at least two sources**: the dated journal **and**
that day's working/`Ideas/` notes — *never the journal alone*. The journal is thin narrative
("worked on my Obsidian setup"); the substance lives in the working notes. If you only have
the journal, the file will be hollow — say so rather than pretending it's complete.

## Step 1 — Resolve the date and scan deterministically

Default to **today**. If the user names a date ("record progress for last Thursday",
"...for 2026-06-04"), resolve it to `YYYY-MM-DD`.

Run the bundled scanner — it does all the fiddly date math (Monday-based week folder,
month-name journal path like `06 June`) and the modified-note scan in one shot, so you never
redo it by hand:

```powershell
& "<skill-dir>/scripts/scan_day.ps1" -VaultRoot "<vault-root>" -Date "YYYY-MM-DD"
```

`<vault-root>` is the directory holding `CLAUDE.md` + `index.md` + `Projects/` (the current
working directory in a normal session). Omit `-Date` to use today.

The JSON it returns is your whole work order:

- `journal_path`, `journal_exists` — the narrative source.
- `week_folder` — the **correct, Monday-based** folder name to write into (e.g. `Week of 2026-06-01`).
- `projects[]` — one entry **per project with activity that day**. Each has:
  - `modified_notes[]` — the day's working notes, each with `folder`, `filename_marker`
    (`DONE`/`INCOMPLETE`/null), `body_markers`, and `has_decision` (true when the note carries
    a `**Decision**` marker, a Decision header, or a `(DECISION)` tag — see **Log decisions** in
    Step 2). Notes under any `Archive/` folder are excluded by the scan.
  - `goals[]` — the project's goal files, to match `Advances:` against.
  - `iteration_logs[]` — existing `type: next-step` files, to link instead of recreating.
  - `existing_progress` — path of an already-written progress file for this date (searched
    across *all* `Week of *` folders), or null.

If `projects[]` is empty, there's no logged activity — tell the user, don't invent a file.

## Step 2 — For each project in `projects[]`, build one progress file

Read that project's modified notes and the journal. Then synthesize. Do all projects in the
same pass; a day that touched Golf + Obsidian Configs yields two files.

### Route work using the (DONE)/(INCOMPLETE) convention

The user marks Project Ideas with `(DONE)` (shipped) and `(INCOMPLETE)` (still backlog),
either in the **filename** or inline in the **body**. Use these as the routing signal so you
don't have to guess what's finished:

- **`(DONE)` items → the `## Done` section.** Concrete, past-tense changelog lines.
- **`(INCOMPLETE)` items → the `## Next steps` section** (and Iteration Logs, Step 3).
- **Unmarked notes** still count as sources and as evidence of what changed — read them and
  fold their substance into `## Done`, but lean on the markers when present.

### Log decisions and link up to their ADRs

When a modified note has **`has_decision: true`** (or you spot a `**Decision**` marker or a
`(DECISION)` tag while reading it), the note records a durable design decision. **You do not author the decision
record** — that's `synthesize`'s job: it writes the immutable `type: decision` ADR to
`wiki/Projects/<Project>/Decisions/(C) <Decision>.md`. Your job is only the **dated half**:

- Add a line to a **`## Decisions`** section: `**Decided:** <one-line decision> — [[(C) <Decision>|<Decision>]]`.
  Capture *what* was decided in one line; the *why/rationale* lives in the ADR, **don't copy it here**.
- **Link up by the ADR's name.** If a matching record already exists in
  `wiki/Projects/<Project>/Decisions/`, link that exact name. If `synthesize` hasn't authored
  it yet, link the title you'd expect it to use — the wikilink resolves once the page appears
  (Obsidian shows it unresolved until then). Keep the title concise and topic-based so the two
  skills converge on the same name.
- A decision is **not** the same as a `(DONE)` item — a note can be both. List the shipped work
  under `## Done` and the decision under `## Decisions`.

Omit `## Decisions` entirely when no note carries a decision (same rule as `## Next steps`).

### Pick the goal it advances

Read the project's `goals[]` files. If the day's work clearly moves one (or more) toward an
active goal — overarching project goal *or* a daily goal — set it in `goals:` frontmatter and
the `**Advances:**` line. Match by topic, not keywords. If nothing genuinely fits, **omit**
`goals`/`Advances` — work needs no goal to be logged, and a manufactured link is worse than
none.

### Compose the file

Follow this template exactly — the frontmatter is not decoration; `type: progress` + `date`
+ `project` + `goals` are what power the vault's Dataview changelog and per-goal rollup tables.

```markdown
---
type: progress
project: <Project>
date: YYYY-MM-DD
goals: ["[[(C) <Goal it advances>]]"]
tags: [progress, <project-slug>]
sources: <count>
---

# (C) YYYY-MM-DD — <one-line headline of what changed>

**Advances:** [[(C) <Goal>]]

## Done
- <concrete change, past tense — what changed, not how you felt>

## Decisions
- **Decided:** <one-line decision> — [[(C) <Decision>|<Decision>]]

## Next steps
- [[(C) <Iteration Log next-step>]] — <one-line what/why>

## Sources
- [[YYYY-MM-DD|Journal]] — narrative + context
- [[<working note>]] — concrete decisions / what changed
```

Notes on each part:

- **Headline** — one scannable line; it's what shows in the Dataview table without opening
  the file. Past tense, concrete.
- **`## Done`** — a dry changelog. What changed, not mood or narrative — that stays in the
  journal. Bold the key nouns (theme/plugin/feature names) like the existing files do.
- **`tags`** — always `[progress, <project-slug>]`; the slug comes from the scan.
- **`sources`** — the count of cited sources (journal + working notes).
- **Links to `(C)` pages use the alias form** `[[(C) Name|Name]]`. The journal link uses the
  date with a `Journal` alias: `[[YYYY-MM-DD|Journal]]`.
- **`## Decisions`** — only the dated line + an up-link to the wiki ADR (see **Log decisions**
  above). Never the rationale; that lives in the ADR. Drop the section when there's no decision.
- Omit a section only when it's truly empty (e.g. no forward work → drop `## Next steps`).

### Drop `## Next steps` if there's nothing forward-looking

Don't pad it. It exists to bridge to the backlog; if the day produced no `(INCOMPLETE)` items
or open threads, leave it out.

## Step 3 — Wire Next steps to Iteration Logs

Each forward-looking item (`(INCOMPLETE)` work, an open thread) belongs in the project's
`Iteration Logs/` as a thin `type: next-step` file, which the `## Next steps` section links to.

For each forward item:

1. **Check `iteration_logs[]` for a match** (by topic/title/alias). If one exists, just link
   it — don't recreate.
2. **If none matches, create a new next-step file** at
   `Projects/<Project>/Iteration Logs/(C) <Title>.md` using this frontmatter, then link it:

```markdown
---
type: next-step
project: <Project>
status: open
goal: "[[(C) <Goal>]]"
effort: S|M|L
aliases: [<Title>]
tags: [next-step, <project-slug>]
updated: YYYY-MM-DD
---

# (C) <Title>

**Next step.** <what to do and why, 1–2 sentences.>

- **Advances:** [[(C) <Goal>]]
- **Effort:** <S|M|L> — <one-line why>
- **Surfaced by:** [[YYYY-MM-DD|<date> progress]] · [[<source note>]]

When done, flip `status: done` and note the resolving progress entry.
```

Pick `effort` (S/M/L) from the apparent scope. If no goal applies, omit the `goal:` line and
`Advances:`.

## Step 4 — Write the file(s) and report

- Write each progress file to `Projects/<Project>/Progress/<week_folder>/(C) YYYY-MM-DD.md`,
  using the **Monday-based** `week_folder` from the scan. Create the week folder if missing.
- **Never silently overwrite.** If `existing_progress` is non-null, show the user what's there
  and ask whether to update/merge or skip — that's the one place stopping is worth it.
- Every file you create is prefixed `(C)`. You write only inside `Progress/` and
  `Iteration Logs/`.

Then give a short report: which progress files and next-step files you created (as clickable
paths), the goals advanced, and any **warnings** (journal missing, only one source, a
mislabeled `Week of …` folder you noticed). Per the vault's house style, **end with a single
suggested next action** plus an offer to discuss it.

## Hard constraints (from the vault contract)

- **Read sources, never edit them.** The journal (`01 Journals/…`) and `Ideas/`/`Chats/`
  notes are immutable input. You only ever read them. Editing any non-`(C)` file the user
  authored requires explicit permission — don't.
- **`(C)` prefix** on every file you create.
- **Cite sources** — progress files cite the journal + the working notes they were built from.
- **Don't reorganize** mislabeled week folders automatically; mention them as an optional
  cleanup and move on. Auto-fixing structure is scope creep the user didn't ask for.

## Edge cases

- **No journal for the date** — proceed from working notes, but warn that the narrative source
  is missing (the file will lack context).
- **Only the journal, no working notes** — warn that this violates the ≥2-sources rule; the
  entry will be thin. Write it if the user wants, but flag it.
- **No activity at all** (`projects[]` empty) — report that and stop; don't create empty files.
- **A note touches multiple projects** — cite it under each relevant project's file.
- **`existing_progress` set** — ask before overwriting; default to merging new `## Done` lines
  rather than clobbering.
