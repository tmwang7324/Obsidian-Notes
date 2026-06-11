---
source: claude-code
date: 2026-06-04
project: C:\Users\jw300
tags: [claude-archive]
---

# Designing the Daily Progress File

> Decided where on-the-spot, goal-less work should be logged, separated `Progress/` (changelog) from `Iteration Logs/` (improve-backlog), and designed a `type: progress` daily file that synthesizes the journal + working notes — with frontmatter chosen specifically to power a Dataview changelog table. Registered the new type in the vault schema.

---

## Exchange 1 · 2026-06-04

**Asked:** Where do I log progress for work that had no Goal driving it (set up Anupucci theme, heading colors, rainbow folders, folder icons)? I don't want it in `Ideas/`, which holds reasoning walkthroughs and insights.

**Answered:** The right home is `Progress/` — the project CLAUDE.md already defines it as "weekly folders of daily progress reports." `Ideas/` = the *why*; `Progress/` = the *what you did*. Don't manufacture a retroactive Goal — the Process "Spot" step explicitly admits a noticed config tweak as a valid entry point. Goals are for *deliberate* targets set ahead of time, not a prerequisite for logging.

---

## Exchange 2 · 2026-06-04

**Asked:** Talk through `Progress/` vs `Iteration Logs/`. Also, when drafting a progress file, ingest the day's daily journal (where I hand-type progress). Is this a good structure?

**Answered:** They're different axes, not competitors:
- **Progress/** — backward-looking changelog ("what did I do, when").
- **Iteration Logs/** — forward-looking fix/improve backlog ("what to do differently"). The nested-folder rainbow limitation noted in `Ideas/Theme Customization.md` is an Iteration Log entry, not progress.

Ingesting the journal is the right raw→synthesized shape (journal = source, `(C)` progress file = synthesis citing it). **Hard caveat:** the journal alone is too thin — today's entry only said "worked on setting up my Obsidian," while the real substance lived in `Ideas/Theme Customization.md`. Rule: **journal = narrative/context; working notes = concrete what-changed; cite both.** Flagged the over-structuring risk (journal → Progress → Iteration Logs → log.md → wiki) against the project's own "structure I won't keep up" prime directive — keep each thin with one job.

---

## Exchange 3 · 2026-06-04

**Asked:** Nail down the daily progress file template first.

**Answered:** Proposed the template (below) and surfaced two decisions: (1) register `type: progress` as a real vault type, or skip frontmatter; (2) drop a `Context/Why` section since the journal already holds the why.

**Key insight — frontmatter earns its keep as a Dataview table.** The reason to put YAML on these files isn't tidiness; it's that `type: progress` + `date` + `project` lets a single Dataview query roll up a queryable, scannable changelog across every day and project:

```dataview
TABLE date, file.link FROM #progress SORT date DESC
```

That payoff is what justifies the structure — without it, the frontmatter would just be ceremony. The one-line headline exists so that table is readable without opening files.

---

## Exchange 4 · 2026-06-04

**Asked:** Record this chat in `Chats/`, and register the `type: progress` decision.

**Answered:** Registered `type: progress` in the vault contract (root `CLAUDE.md` frontmatter rule) with the Dataview query, and added a **Progress vs Iteration Logs** convention + the full daily-progress template to `Projects/Obsidian Configs/CLAUDE.md`. Archived this session here.

---

## The agreed template

```markdown
---
type: progress
project: Obsidian Configs
date: 2026-06-04
tags: [progress, obsidian-configs]
sources: 2
---

# (C) 2026-06-04 — <one-line headline>

## Done
- <concrete change, past tense — what changed, not how you felt>

## Carried forward
- <defect / improvement> → [[(C) <Iteration Log entry>]]

## Sources
- [[2026-06-04|Journal]] — narrative + context
- [[Theme Customization]] — working checklist / decisions
```

**Key design decisions:**
- `type: progress` is a *new* vault type (not in the wiki enum `concept|entity|synthesis|overview|meta`) — progress files aren't wiki pages, so they get their own type rather than overloading `synthesis`.
- Frontmatter is the price of a rolling Dataview changelog table — that's the whole justification.
- `Done` is a dry, past-tense changelog; mood/narrative stays in the journal (no `Context/Why` section).
- `Carried forward` bridges to `Iteration Logs/` so the progress file stays a changelog and the backlog lives where it belongs.
- A real work day cites ≥2 sources: journal **+** working/`Ideas` notes, never the journal alone.
