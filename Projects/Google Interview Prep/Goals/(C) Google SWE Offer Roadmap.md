---
type: goal
project: Google Interview Prep
aliases: [Google SWE Offer Roadmap]
date: 2026-06-12
target: 2026-07-26
status: active
tags: [goal, google-prep]
sources: 0
---

# (C) Google SWE Offer Roadmap

**Long-term goal:** Land a **New Grad Software Engineer offer at Google** — and, in the same motion, build durable mastery of data structures, algorithms, and DP that outlasts the interview. This advances the vault [[GOALS|North Star]] (recruit into FAANG/Google).

**Definition of done (interview-ready):** By **July 26, 2026** (the day before the Barclays start), I can:
- Solve a *new* medium in **≤ 30 minutes**, communicating my approach out loud throughout.
- Recognize and *formulate* a DP problem from scratch — state, transition, base case, fill order — not just recall solved ones.
- Handle graphs (BFS/DFS, matrix, topo sort, union-find) cold.
- Tell 5–6 polished STAR behavioral stories ("Googleyness" + impact).

## Calibration (the honest baseline, 2026-06-12)
- **Comfortable:** arrays/hashing, two pointers, sliding window, stacks (easy/med).
- **Shaky → the real work:** graphs, harder trees, and especially **DP** (recognition & formulation).
- **DP starting point:** climbing stairs, house robber, coin change (unbounded knapsack) — the classic 1-D trio. Mechanics yes; recognition/formulation, 0/1 knapsack, subsequence DP, and all of 2-D = not yet.
- **Capacity:** ~5+ focused hrs/day for ~6.5 weeks (~180+ hrs).
- **Scope note:** New Grad SWE @ Google = **coding + behavioral**. No heavy system-design round (that's L4+) — spend ~zero there.

## Week-by-week roadmap

> **Reordered 2026-06-19 — front-loaded on graphs + DP.** A graph question sank a *previous* Google interview, so graphs (the evidenced weakness, not a hypothetical one) and DP (the boss fight) now own the peak-energy middle instead of waiting until the old Weeks 3–5. The comfortable topics (arrays, sliding window, two pointers, trees, heaps, BST, linked lists) drop out of dedicated study and become **timed confirmation sweeps + ~30 min/day spaced review** — staying warm without eating the hard-topic budget. This is the cure for the busy-work relapse, not a retreat into it. Trees keeps a short 2–3 day wrap *only* because tree recursion is the DP on-ramp (recursion → memo → table).

| Block                  | Dates        | Focus                                                                                | Why                                                                                                                                    |
| ---------------------- | ------------ | ------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------- |
| **Trees wrap**         | now–Jun 21   | Finish trees: timed confirmation + the recursion→memo bridge                         | Don't let it sprawl — already versed; this exists to seed DP recursion, nothing more.                                                  |
| **Graphs (deep)**      | Jun 22–Jul 1 | BFS/DFS, matrix/grid, topo sort, union-find                                          | **The wound.** Biggest block, peak energy. Ends with a *cold, timed* graph medium — no "done on feel," since feel lied here last time. |
| **DP**                 | Jul 2–Jul 16 | 1-D framework → knapsack contrast → subsequence → 2-D/grid (see ladder below)        | The boss fight, now with full runway — the whole point of accelerating.                                                                |
| **Mop-up**             | Jul 17–21    | Backtracking (Google medium-hard staple), intervals, greedy, advanced graphs         | Backtracking earns real time — *not* in the comfort zone.                                                                              |
| **Mocks + behavioral** | Jul 22–26    | Timed random mediums/hards out loud; STAR stories; spaced review of everything shaky | Unchanged — the final-week dress rehearsal.                                                                                            |
| **Throughout**         | every day    | ~30 min spaced review of comfortable topics (arrays, sliding window, trees, heaps)   | Keeps the known stuff sharp without burning a dedicated week on it.                                                                    |

**Confirmation-only (no study block, swept timed):** heaps/PQ, BST, linked lists, sliding window, two pointers, arrays/hashing — known territory; *prove* they're airtight, don't grind them. The trap: "moderately versed" quietly becoming "under-confirmed" — so master-check gates get **stricter** for the front-loaded topics, not looser.
**Gambled (lower-yield, deliberately skimmed):** Tries (light), and Bit Manipulation / Math-Geometry (mostly dropped) — Google asks these rarely; the time is protected for graphs and DP.

## Parallel track — Doculyze MVP (portfolio + behavioral fodder)
**Why it's here, honestly:** this is **mainly a behavioral talking point** — a working RAG/LangChain demo that backs a *fresh, true* "most difficult project" STAR story (see [[STAR Stories]]). The interviewer never reads this code; the whole ROI is being able to tell the story well. So this track is **deliberately thin and time-boxed**, not the "L" build the [[(C) Doculyze MVP for Interview Portfolio|next-step]] originally implied. DSA is the offer-critical path, and a full build will quietly eat it alive.

**The trap to watch:** building Doculyze will always *feel* more productive than failing a DP problem — that feeling is the danger, not a signal (root `CLAUDE.md`: retreating into comfortable busy-work to avoid the hard thing). More time on a talking point is low marginal return. When in doubt, the hour goes to DP.

**Scoped to a demoable slice (cut everything else):** sign in (reuse the already-designed [[(C) Auth Architecture|Firebase auth]]) → upload a doc → **chunk → embed → store in a vector DB → retrieve → LLM answers a question *with a citation* over that doc.** That single flow *is* the MVP. **Explicitly cut for now:** microservices, Kubernetes, Jenkins/CI, RabbitMQ — all the heavy infra from the old STAR story. The RAG core + minimal auth + one clean UI flow is the whole demo.

**Cadence — squeezed into evening margins, DSA-first, hard-paused for DP.** The reorder removed the old "light" early weeks (graphs is now front-loaded and just as hard as DP), so Doculyze loses its daytime window and lives in **weekday-evening margins only**. DSA's ~5 hrs/day gets first claim, always; the extra hours from 8+ hr days should make the build *less rushed*, **not bigger**. If it can't fit thin, it's cut — see rule 3.

| When                       | Doculyze block                                                            |
| -------------------------- | ------------------------------------------------------------------------- |
| Trees wrap (now–Jun 21)    | Spec the slice (~30 min); scaffold + wire Firebase auth (reuse existing design) if evenings allow. DSA owns the days. |
| Graphs (Jun 22–Jul 1)      | Evening margins only: doc upload, then **RAG core** — chunk/embed/store + retrieval + cited LLM answer. The showcase. |
| **DP (Jul 2–16)**          | **HARD PAUSE.** DP + 2-D DP own every hour — *including* the extra ones from the 8+ schedule. No Doculyze.            |
| Mop-up / mocks (Jul 17–26) | End-to-end UI + citations rendered + one clean demo path; record a ~2-min demo; rewrite the "most difficult project" STAR story around *this* RAG work. Behavioral payoff. |

**Rules:** (1) DSA's daily block comes *first* — Doculyze never touches it. (2) The "done" line is **frozen**: one screen-recordable flow (upload → ask → cited answer) + a tightened STAR story. Anything beyond that is post-interview polish. (3) First sign it's bleeding into the DP block (Jul 2–16) → it's **cut, not extended**.

## The DP ladder (week 4–5)
Taught **Recursion → Memoization → Tabulation**, in that order — write brute-force recursion first (forces "state = function arguments"), add a cache, *then* convert to a table. That pipeline *is* the recognition framework.

1. **Framework (mostly review for me):** climbing stairs → house robber → house robber II — build the recursion→memo→table reflex on tiny state.
2. **Anchor + extend:** re-derive coin change *with the framework* → coin change II (count ways) → word break.
3. **Knapsack contrast (big unlock):** I know *unbounded* — learn **0/1 knapsack** (partition equal subset sum) by seeing exactly what one line changes.
4. **Subsequence DP:** longest increasing subsequence → decode ways.
5. **2-D / grid (week 5):** unique paths → min path sum → longest common subsequence → edit distance → longest palindromic substring.

## Operating principles (baked into every topic)
- **Master-check gate** — a topic isn't "done" until I can re-derive the pattern *cold* and solve a fresh medium under time pressure.
- **Communicate from day 1** — narrate approach out loud even solo; Google scores it. Don't save it for week 6.
- **Spaced review** — ~30 min/day revisiting an older shaky topic, not just the current one.
- **Behavioral early** — draft 5–6 STAR stories now (a doc in `Resources/`), refine throughout.
- **Hints before answers** — when stuck, escalating hints, never copy a solution I don't understand (root `CLAUDE.md` hard line).

## Progress advancing this goal
```dataview
TABLE date AS Date, file.link AS Entry
FROM #progress AND #google-prep
WHERE contains(goals, this.file.link)
SORT date DESC
```

## Open next-steps for this goal
```dataview
TABLE status AS Status, effort AS Effort
FROM #next-step AND #google-prep
WHERE status = "open" AND contains(goal, this.file.link)
SORT effort
```
