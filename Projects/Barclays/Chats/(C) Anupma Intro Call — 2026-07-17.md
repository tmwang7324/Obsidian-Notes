---
type: idea
project: Barclays
date: 2026-07-16
status: open
tags: [barclays, people-leader, prep]
---

# (C) Anupma Intro Call — 2026-07-17, 1:30–1:55pm

Welcome call with **Anupma Rathore**, my People's Leader. 25 minutes, 11 days before my July 27 start. First contact.

## Who she is (CORRECTED 2026-07-16 from profile screenshot)

**Current role: Director — Head of Enterprise Data Platforms, Barclays** (Jan 2023 – present, New York).

| Period | Role |
|---|---|
| Jan 2023 – present | **Director — Head of Enterprise Data Platforms**, Barclays, NY |
| Jan 2022 – Jan 2023 | VP, Service Manager — **USCB** Technology Service Management, Barclays |
| Sep 2018 – Jan 2022 | Stay-at-home parent, NYC (3 yrs 5 mos) |
| Jul 2013 – Sep 2018 | Technical Support Portfolio Manager, ANZ, Melbourne |
| Sep 2010 – Jul 2013 | Senior Technical Support Specialist, ANZ, Melbourne |
| May 2009 – Jan 2010 | Technical Project Lead, Infosys, Bengaluru |
| Dec 2005 – May 2009 | Integration Testing Lead, Infosys, Greater Hartford |
| Mar 2004 – Dec 2005 | IT Developer, Infosys, Bengaluru |

~22 years, started as a developer. Pune University 1999–2003. ITIL Foundation (2015); Agile PM + Google Cloud Digital Leader (2021–22 — lines up with the move into data platforms). Returned from a 3.5-year career gap at VP and made Director inside a year.

> **⚠️ Earlier read was WRONG.** The `itsm-nyc` slug and the "Technology Manager with Service Management expertise" About line are **stale** — service management is her *history*, not her present. She runs **Enterprise Data Platforms**: lineage, pipelines, where data lives and how it moves.

**What this changes:**
- **The Cards and Payments dataflow mapping is her actual domain** — a junior version of her job. Sharper still: her VP role was **USCB** = US Consumer Bank = Cards and Payments. I mapped dataflows in the org she ran service management for, at roughly the time she ran it. **Describe it in data terms** — lineage, how data moved across systems.
- **The RAG app matters more than first assumed.** A Head of Enterprise Data Platforms in 2026 is being asked what it takes to put AI on the bank's data. Video transcription RAG = unstructured-data-to-embeddings = a data platform problem. Still **don't pitch ML theory** — but *"what data has to look like for AI to work"* is her problem, and I've built one.
- Her service-management years (ANZ, USCB) are real and long — resilience/discipline framing still lands. It's just not the lead.

<!-- TODO: she's a Director — confirm she's actually my direct People's Leader vs. a level or two up. And find out what team I'm joining: reporting into a data org may mean the Technology Analyst role is data-related. -->

#### Profile Screenshot
![[Pasted image 20260716020548.png]]

#### Profile Screenshot
![[Pasted image 20260716020548.png]]

## The one story to have loaded
**The NYC project's honest-framing decision.** There's no ground-truth outcome data, so any accuracy claim would be unanswerable — I built a transparent, interpretable **ranking** engine and deliberately refuse to call it prediction. In financial services that *is* the conversation: interpretability, governance, knowing what a system can and cannot defend. Volunteering what my system **deliberately doesn't claim** signals someone who won't cause an incident.

**Backup if there's room:** Doculyze's design-before-build. Auth architecture fully designed and documented *before* implementation — two systems that never cross-talk, HTTP-only session cookies, CSRF protection — and a refresh/access-token split **considered and rejected with a recorded rationale**. To an ITIL person that's change discipline, and the security angle is native to her world.

## Pitch — what to cut (v1 was generic)
v1: *"New NYU grad, BA in CS and math. As passionate about building scalable and secure applications as learning new topics in the fintech space."*

- ❌ **"Scalable"** — an overclaim, and it violates my own NYC project rule (*"Keep claims exact"*). I've built nothing at scale. Invites "scalable to what load?" — no answer. In a bank, that word means something specific and expensive. **Cut.**
- ✅ **"Secure"** — this one I can back (Doculyze auth). Keep, with evidence loaded.
- ❌ **"New NYU grad, BA in CS and math"** — already on her screen. Spending the opening on my résumé; "arts" preemptively flags a distinction nobody raised.
- ❌ **"Passionate about"** — dead phrase, claim without evidence, every other new grad says it.
- ⚠️ **"Fintech topics"** — invites "which ones?" My vault has one 401(k) note. Get specific or drop it.
- **Structural problem:** swap the name and it's any of 500 new grads. Nothing in it is *mine*.

**Shape to aim at:** what I build and the discipline I bring → the honest-framing decision as proof → the bridge to her world (coming somewhere that things breaking has real consequences; I want to learn how that's actually done). **My words, not Claude's.**

## Don't
- Lead with the math/theory. Real energy, wrong audience. (Data *platforms* ≠ ML theory — the distinction still holds.)
- Describe these as **resume projects for technical interviews**. True, but pitching my portfolio-for-interviewing to the manager I start with in 11 days sends a signal I don't want. Same projects, honest reframe: this is how I learn and what I build for fun.
- Force a rehearsed pitch into a welcome call. **She'll talk for most of the 25 minutes.** I get maybe 3–5. One crisp story reads as prepared; five talking points read as insecure.

## Questions for her (she'll remember these longer than my project list)
<!-- TODO: draft 2 in my own words before the call. Aim at her actual world: -->
- How the team handles resilience / incidents.
- What "good" looks like for a new analyst in the first 90 days.

## After the call
- [x] Confirm her exact title + reporting line → update `../CLAUDE.md` Key People.
- [ ] Capture team, stack, and service model (**within the confidentiality rule** — my learning, not their systems).
- [ ] Log a `Progress/` entry.
