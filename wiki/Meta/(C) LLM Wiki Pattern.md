---
type: meta
aliases: ["LLM Wiki Pattern"]
tags: [meta, pattern, second-brain, workflow]
updated: 2026-06-11
sources: 6
---

# LLM Wiki Pattern

The organizing pattern behind this vault. Instead of re-deriving knowledge from raw documents on every query (classic RAG), the LLM **incrementally builds and maintains a persistent, interlinked wiki** that sits between you and your raw sources. The wiki is a **compounding artifact**: cross-references are already there, contradictions already flagged, the synthesis already reflects everything read. You curate and ask questions; the LLM does the bookkeeping.

> Obsidian is the IDE; the LLM is the programmer; the wiki is the codebase.

## Architecture layers

![[llm-wiki-architecture.png]]

| Layer | What lives there | Who owns it |
|---|---|---|
| `raw/` | Articles, notes, screenshots, transcripts, assets — immutable source material | **You** |
| `wiki/` | Summaries, concept pages, tool pages, comparisons, synthesis | **The LLM** |
| `log.md` | Append-only history of ingests, queries, and lint passes | The LLM updates it |
| `index.md` | A catalog of wiki pages with short summaries | The LLM updates it |
| `CLAUDE.md` | Rules for ingest, query, naming, structure, and conventions | You and the LLM together |

![[llm-wiki-architecture-layers.png]]

## The compounding loop

![[llm-wiki-second-brain-loop.webp]]

**Capture → Ingest → Index + Log → Query → Compound**, repeat.

1. **Capture** — clip articles, save notes, collect transcripts into `raw/`.
2. **Ingest** — ask the LLM to read the source and update the wiki (a single source may touch 10–15 pages).
3. **Index + Log** — refresh the catalog and append to the timeline.
4. **Query** — ask better questions against the compiled wiki; good answers get filed back as new pages.
5. **Compound** — useful answers re-enter the knowledge base, so explorations accumulate like sources do.

Why it works: the LLM does the boring maintenance (cross-references, consistency, flagging stale claims), so you stay focused on curation, judgment, and questions. Related in spirit to Vannevar Bush's **Memex** (1945) — the part Bush couldn't solve was *who does the maintenance*. The LLM handles that.

## Operations in this vault

- **Ingest** — drop a source in `raw/notes/` (or `raw/assets/`), then ask: *"ingest <source>."* The LLM reads it, writes/updates wiki pages, refreshes [[index]], and appends to `log.md`.
- **Query** — ask against the wiki; the LLM reads [[index]] first, drills into pages, answers with citations, and can file the answer back as a new page.
- **Lint** — periodically ask for a health check: contradictions, stale claims, orphan pages, missing cross-references, concepts lacking their own page.

## Conventions here

- LLM-created files are prefixed `(C)` (see the project `CLAUDE.md`); fixed-name system files (`CLAUDE.md`, `index.md`, `log.md`) are exempt.
- Pages carry YAML frontmatter (`type`, `aliases`, `tags`, `updated`, `sources`) for Dataview and clean linking.
- **Authorship by location** — within a project, hand-typed notes live in `Ideas/`; AI-generated idea files (`(C)`) live in `Chats/`. Clean separation by file type.
- The whole vault is just markdown — versionable with git.

## The per-project Progress loop

Each project records movement through a small set of file types, read by the `/daily-plan` (morning) and `/record-progress` (evening) skills:

- **`Goals/`** (`type: goal`) — direction. Work doesn't *need* a driving Goal to be logged; don't manufacture a retroactive one.
- **`Plans/`** (`type: plan`) — forward-looking **day plan**: a vault-level daily file (`Plans/Week of <Mon>/(C) YYYY-MM-DD.md`) generated each morning by `/daily-plan` from the week's focus project + the daily non-negotiables. Vault-level (not inside a project) because the plan is whole-day and cross-project; mirrors `Progress/` so the end-of-day plan↔progress diff is a same-date lookup.
- **`Progress/`** (`type: progress`) — backward-looking **changelog**: "what I did, when." A daily file synthesizes the day's journal **+** that day's working notes — never the journal alone (journal = narrative; working notes = concrete what-changed). Cite both. The evening Progress synthesis also reads the same-date plan and emits planned-vs-done + a sidetrack call-out (closing the plan loop).
- **`Iteration Logs/`** (`type: next-step`) — forward-looking **fix/improve backlog**: "what to do differently." A different axis from Progress, not a competitor; `/daily-plan` pulls open next-steps from here.

The payoff that justifies the frontmatter is a rolling **Dataview changelog**: `TABLE date, file.link FROM #progress SORT date DESC`. The one-line headline on each progress file keeps that table readable without opening files. Keep each file thin — one job apiece.

**Status markers on hand-typed `Ideas/` notes** — a feature/idea note records its status in the **filename suffix** (`… (DONE).md`, `… (IN PROGRESS).md`). The synthesis/progress skills sort by this suffix without parsing the body (finished → the day's `Done`; incomplete → stays in the backlog), and find what's new by **last-modified date**.

## Related implementations

- **[ar9av/obsidian-wiki](https://github.com/ar9av/obsidian-wiki)** — a catalog of agent skills that extends Karpathy's LLM-wiki idea with **cross-agent chat recall**. Worth mining for ideas as this vault's skill set grows. (Source: `01 Journals/.../2026-06-07.md` — note trails off unfinished; only the reference was durable.)

## Related

- [[index]] · project `CLAUDE.md` · source: `raw/notes/` (the immutable layer)
