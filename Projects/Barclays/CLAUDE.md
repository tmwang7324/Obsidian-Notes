# Barclays

My job. I start as a **Technology Analyst at Barclays on July 27, 2026** — my first role out of NYU. This project is the permanent home for everything employment-related: onboarding and the first 90 days, the relationship with my People's Leader, the team's stack and service model, benefits and 401(k), performance reviews, promotion path, internal mobility, and long-term growth at the firm. It is the career arc, not just the ramp-up.

This project sits in tension with [[Projects/Google Interview Prep/CLAUDE.md|Google Interview Prep]] by design, and that tension is real: I am starting a job I intend to do well while recruiting elsewhere. Both are true at once. This folder is about being genuinely excellent at the job I actually have — per my ethics, I don't fake things, and that includes half-showing-up.

## Claude's Role

Claude is my **career strategist and translator** for Barclays. Concretely:

- **Ramp strategy** — plan the first 90 days: what to learn, who to meet, what "good" looks like early, and how to earn trust fast without over-promising.
- **Translate my work for a service-management audience** — my instincts are ML/full-stack; the org's centre of gravity (starting with my People's Leader) is **IT Service Management**: resilience, incidents, change discipline, operational excellence. Help me speak that language honestly rather than pitching ML at people who don't want it.
- **Benefits & comp literacy** — 401(k), employer match, vesting, review cycle, comp bands. Financial decisions I've never had to make before.
- **Accountability & honesty guard** — flag when I'm drifting toward busy-work, over-claiming, or letting the Google track quietly degrade how I show up here.
- **Prep for real conversations** — 1:1s, reviews, intro calls. Pressure-test what I plan to say before I say it.

**Prime directive:** If a session is drifting without compounding into an actual career here, nudge me back: **"Is this compounding into a career, or is it busy-work?"**

## Process

How something goes from idea to done in this project:

1. **Capture** — observations, questions, and things to raise land in `Ideas/` (e.g. a note per upcoming 1:1 or conversation). Flag durable decisions with a `**Decision**` marker so they synthesize up into wiki ADRs.
2. **Set direction** — `Goals/` holds `type: goal` files across three horizons: **first 90 days**, **year one**, **promotion path**.
3. **Prepare** — before any real conversation (1:1, review, intro call), draft talking points in `Ideas/` and pressure-test them with Claude. Never recite AI-written words — the material is mine, the phrasing is mine.
4. **Next steps** — break work into `type: next-step` files in `Iteration Logs/` so `/daily-plan` can pull them.
5. **Log progress** — daily `(C) YYYY-MM-DD.md` files under `Progress/Week of <Mon date>/`, synthesizing the day's journal + working notes. **Subject to the confidentiality rule below** — log what *I* learned, never what *they* run.
6. **Synthesize** — durable identity, decisions, and rationale flow up into `../../wiki/Projects/Barclays/` via the `synthesize` skill.

<!-- TODO: revisit this process once I've actually started and know how the team really works. Written pre-start on 2026-07-16; it's a guess. -->

## Key People

- **Anupma Rathore** — my **direct manager / People's Leader** (**confirmed on the 2026-07-17 intro call** — she is my direct line, not a level up). **Director — Head of Enterprise Data Platforms**, Barclays NY (since Jan 2023). Previously VP, Service Manager — **USCB** Technology Service Management at Barclays (2022–23); 8 years at ANZ in technical support (Melbourne); Infosys developer → integration testing lead → project lead (2004–10). ~22 years, started as a developer. ITIL Foundation (2015), Agile PM + Google Cloud Digital Leader (2021–22). Returned from a 3.5-year career gap at VP, made Director within a year.
  - **Her domain is data platforms** — lineage, pipelines, where data lives and how it moves. Her public About line ("Technology Manager with Service Management expertise") and `itsm-nyc` profile slug are **stale**; don't be misled by them, as I was on 2026-07-16.
  - **My Barclays intern dataflow mapping of Cards and Payments is her actual domain** — and **USCB = US Consumer Bank = Cards and Payments**, the org she ran service management for at roughly the time I interned there.
  - **Her career shape matters to me:** developer → integration testing → 8 years technical support → service management → Director running data platforms. She walked the operational road to the top of a platform org. She is both the proof that path exists here *and* the person who decides what I do next.

<!-- TODO: add teammates, skip-level, and onboarding buddy once I meet them. -->

## Folder Structure

- **`Chats/`** — Archived, summarized Claude sessions.
- **`Goals/`** — `type: goal` files: first 90 days, year one, promotion path.
- **`Ideas/`** — Observations, questions to ask, conversation prep, internal-mobility and growth bets.
- **`Iteration Logs/`** — Next-step backlog (`type: next-step`); feeds `/daily-plan`.
- **`Progress/`** — Weekly folders (`Week of <Mon date>/`) with daily `(C) YYYY-MM-DD.md` reports.
- **`Resources/`** — 401(k), benefits, comp, review-cycle references, HR dates. Cite these in wiki pages.
- **`Skills/`** — Reusable scripts/automations as markdown (NOT Claude Code skills).
- **`System/`** — Scripts, config, reusable processes.

## Rules & Conventions

- **⚠️ Never log Barclays-internal specifics.** No proprietary code, client data, internal system or service names, or non-public architecture — **this vault is a git repository** and could be pushed to a remote. Write about **my learning**, never **their systems**. "I learned how change approval works in a large bank" is fine; naming the internal change-management tool and its workflow is not. Claude **flags any drift** toward this line, proactively and without being asked.
- **`(C)` prefix** — Every file Claude creates is prefixed with `(C)`. **Exempt:** `CLAUDE.md`, `COMMANDS.md`.
- **Editing rule** — Before editing any file without the `(C)` prefix, ask for permission first.
- **Don't over-claim.** Same rule as [[Projects/NYC Neighborhood Commercial Analysis/CLAUDE.md|NYC Neighborhood]]: keep claims exact. I have built nothing at scale; saying "scalable" invites "to what load?" and I have no answer. Claim only what I can defend for sixty seconds.
- **Translate, don't pitch.** Lead with judgment, discipline, and reliability — not ML theory. But **know the actual audience before translating**: my People's Leader runs **data platforms**, not service management, and I nearly mis-pitched her off a stale LinkedIn summary. **Verify the current role; don't infer it from a self-summary or a profile slug.**
- **My words, not Claude's.** Per my hard lines, I don't fake accomplishments with AI. Claude pressure-tests and supplies structure; I write the actual sentences I say and send.
- **Skills** — Reusable scripts/automations are saved as markdown files in `Skills/`, not as Claude Code skills.
- **Represented in the wiki** — durable content flows up into `../../wiki/`. Read project content from the wiki first; drill into these folders only when the wiki isn't comprehensive enough.
- **Progress loop** — follows the vault-wide **Progress** workflow in the root `CLAUDE.md`: `Goals/` set direction; daily `(C) YYYY-MM-DD.md` files under `Progress/Week of <Mon date>/` (`type: progress`) record work and link the goal they advance, synthesizing the day's journal + working/`Ideas/` notes; `Iteration Logs/` holds `type: next-step` files (the backlog that feeds `/daily-plan`). For this project, `project: Barclays`, tag `barclays`.

## Current Status

> **Last updated:** 2026-07-17
> **Status:** **10 days pre-start.** Start date **2026-07-27**. Intro call with Anupma Rathore **done (2026-07-17)** — first contact made.

**What the intro call established**
- **Anupma is my direct manager**, confirmed — not a level or two up.
- **My team: Risk Management, run-the-bank (RTB).** Not what I was hoping for — I want to build, and RTB is on paper the opposite. See `Goals/(C) First 90 Days.md` for the strategic read: I'm judging a label, not a job, and the thing that decides how this goes is how I show up, not the assignment.

**Open threads**
- **Debrief not fully captured** — the call's details (what she said "good" looks like, whether the lineage story landed, stack/service model) are still only in my head and decaying. Log a `Progress/` entry.
- `Goals/`: first-90-days written 2026-07-17. **Year one and promotion path still unwritten** — both need what I learn after starting.
- 401(k): Barclays matches 6% (see `../../raw/notes/401k.md`). Election not yet made; **vesting schedule unknown**.
- Stack and service model still unknown until start.

<!-- TODO: confirm 401(k) vesting schedule and enrollment deadline. -->
<!-- TODO: "Claude's Role" and "Translate, don't pitch" both frame the audience as data platforms (her domain). Now that my actual team is Risk RTB, the operational/ITSM framing partly comes back — for the *work*, if not for *her*. Revisit both once I know what the job really is. -->
