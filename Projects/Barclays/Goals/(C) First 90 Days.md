---
type: goal
project: Barclays
status: active
aliases: [Barclays First 90 Days]
tags: [goal, barclays]
updated: 2026-07-17
---

# (C) First 90 Days

Start **2026-07-27** on a **Risk Management run-the-bank (RTB)** team, reporting directly to
Anupma Rathore (confirmed on the 2026-07-17 intro call). Ninety days lands around **2026-10-25**.

This is not the assignment I wanted. I want to build; RTB is on paper the opposite. But I am
reacting to a **label** — four words — and I know essentially nothing yet about the actual work,
the stack, or how much of it is tooling and automation built *around* operations rather than
operations itself. The first 90 days is mostly about **finding out**, and about not letting
disappointment quietly decide how I show up.

## The bet

RTB sees the system as it actually is: under load, when it breaks. That is exactly the raw
material my "design before I develop" thesis is made of — you cannot design around failure
modes you have never seen. **Become the person who knows why things break.** It's a real,
earnable edge, and RTB hands it to me in a way a build team wouldn't.

I also closed my intro-call pitch on wanting to see **where failures are expensive**. Risk RTB
is the place in a bank where that is most true. I more or less asked for this.

Anupma's own path is the proof it isn't a dead end: developer → integration testing → eight
years technical support → service management → Director, Head of Enterprise Data Platforms.
She walked the operational road to running a platform org, and she is the person who decides
what I get to do next.

## The trap — named here so I see it coming

Two years of ticket triage builds no portfolio and makes internal mobility **harder**, not
easier. That risk is real. But what decides the outcome isn't the assignment — it's whether I
show up as the person who understands the system better than anyone on the team, or as someone
quietly waiting for the Google track to bail him out. Half-showing-up gets the worst of both:
no portfolio, no offer, no story. Per my ethics, I don't fake things, and that includes
half-showing-up to a job I actually hold.

## Definition of done (by ~2026-10-25)

- I can explain in my own words what my team keeps running and what breaks most often.
- The unknowns are closed: stack, service model, who the team is, and what "good" means here —
  per Anupma's answer, not my guess.
- **At least one thing is better because I was there** — a fix, a piece of tooling, an
  automation. Not just tickets closed.
- Anupma would describe me as someone who understands the system, not someone who processes work.
- The Google track hasn't degraded how I show up here. If it has, I say so out loud rather than
  letting it slide.

## Before I start (10 days)

- 401(k) election — Barclays matches 6% (`../../raw/notes/401k.md`). **Vesting schedule still unknown.**
- Capture the 2026-07-17 intro-call debrief while it's still fresh.

## Open next steps
```dataview
TABLE status, effort FROM #next-step
WHERE project = "Barclays" AND status = "open"
SORT effort ASC
```

## Progress advancing this goal
```dataview
TABLE date FROM #progress
WHERE project = "Barclays"
SORT date DESC
```
