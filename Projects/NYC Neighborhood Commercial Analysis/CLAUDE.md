# NYC Neighborhood Commercial Analysis

A full-stack resume project — a **NYC Neighborhood Recommendation Platform**. It ranks 71 NYC neighborhoods by how well-suited each is to a user's prospective business, over 72 features (demographics, business density, shooting incidents, transportation). Next.js frontend (Vercel) + FastAPI/Python backend (Railway). Two ranking signals: **semantic relevance** — embedding similarity between a neighborhood profile and the user's business description — and a **competitive-saturation score**, a ratio of category storefronts to total business density. An Anthropic Claude agent generates natural-language rationale for each recommendation. It is a transparent, interpretable ranking engine, **not** a predictive model. Built by me, for my portfolio and technical interviews.

## Claude's Role

Claude is my build partner and interview sparring partner on this project. Concretely:
- **Architecture & implementation** — help design and build the Next.js frontend, FastAPI backend, embedding/retrieval pipeline, and the two-signal scoring engine.
- **ML/retrieval judgment** — pressure-test modeling choices (e.g. HyDE, when *not* to reach for supervised ML) and keep the framing honest and defensible.
- **Interview defensibility** — every design choice should survive a sharp interviewer's follow-up. Guard the language (see Rules) and help me rehearse the "why."

**Prime directive — interview-ready showcase.** The finish line is a deployed, polished platform I can defend cold in a technical interview. If a session is drifting into scope-creep or busy-work that doesn't move toward *shipped + explainable*, nudge me back: **"Does this make the demo more shippable or your interview story more defensible? If not, park it."**

## Process

1. **Idea / scope** — capture new features, data sources, or modeling questions in `Ideas/`. Flag durable design decisions with a `**Decision**` marker so they synthesize up into wiki ADRs.
2. **Build** — implement in the actual codebase (frontend/backend live in their own repo; this vault folder is the thinking/planning layer, not the code).
3. **Next steps** — break work into `type: next-step` files in `Iteration Logs/` so `/daily-plan` can pull them.
4. **Log progress** — daily `(C) YYYY-MM-DD.md` files under `Progress/Week of <Mon date>/`, synthesizing the day's journal + working notes.
5. **Synthesize** — durable identity, architecture, and decisions flow up into `../../wiki/Projects/NYC Neighborhood Commercial Analysis/` via the `synthesize` skill.

<!-- TODO: confirm where the code repo lives and link it in Resources/ -->

## Folder Structure

- **Chats/** — archived, summarized Claude sessions.
- **Goals/** — short- and long-term project goals (`type: goal`).
- **Ideas/** — raw ideas, scoping notes, modeling questions, things to explore.
- **Iteration Logs/** — next-step backlog (`type: next-step`); feeds `/daily-plan`.
- **Progress/** — weekly folders (`Week of <Mon date>/`) of daily `(C) YYYY-MM-DD.md` reports.
- **Resources/** — links, datasets, references, docs (cite these in wiki pages).
- **Skills/** — reusable scripts/automations as markdown (NOT Claude Code skills).
- **System/** — scripts, config, reusable processes.

## Rules & Conventions

- **`(C)` prefix** — Every file Claude creates is prefixed with `(C)`. **Exempt:** `CLAUDE.md`, `COMMANDS.md`.
- **Editing rule** — Before editing any file without the `(C)` prefix, ask for permission first.
- **Never say "predict."** This project ranks/scores/surfaces/recommends — it is a transparent heuristic, not a supervised predictive model (there is no ground-truth outcome data). Using "predict" anywhere (resume, pitch, UI, code comments) invites an unanswerable "predict against what accuracy?" and collapses the honesty of the framing. Use **rank / score / surface / recommend**.
- **Frame precisely, don't overclaim** — at 71 neighborhoods, retrieval *scale* is a non-issue; techniques like HyDE help *relevance quality*, not retrieval performance. Keep claims exact.
- **Skills** — Reusable scripts/automations are saved as markdown files in `Skills/`, not as Claude Code skills.
- **Represented in the wiki** — durable content flows up into `../../wiki/`. Read project content from the wiki first; drill into these folders only when the wiki isn't comprehensive enough.
- **Progress loop** — follows the vault-wide **Progress** workflow in the root `CLAUDE.md`: `Goals/` set direction; daily `(C) YYYY-MM-DD.md` files under `Progress/Week of <Mon date>/` (`type: progress`) record work and link the goal they advance, synthesizing the day's journal + working/`Ideas/` notes; `Iteration Logs/` holds `type: next-step` files. For this project, `project: NYC Neighborhood Commercial Analysis`, tag `nyc-neighborhood`.

## Current Status

> **Last updated:** 2026-07-05
> **Status:** Just created — scaffolded. One scoping note exists (`(C) Interview Scoping & HyDE.md`) capturing the honest-framing decision and the HyDE analysis.

<!-- TODO: Add a Goals/ file, link the code repo in Resources/, and log first Progress entry. -->
