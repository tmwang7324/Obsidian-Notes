---
type: decision
project: Google Interview Prep
date: 2026-06-12
status: accepted
aliases: ["Curriculum Strategy"]
tags: [decision, google-prep, interview-prep]
sources: 1
supersedes:
superseded-by:
---

# (C) Curriculum Strategy

**Status:** accepted · **Date:** 2026-06-12 · Inferred from the curriculum design conversation.

## Context

Prepping for a Google New-Grad SWE loop with ~6.5 weeks runway (to before the 2026-07-27 Barclays start) at ~5+ focused hrs/day (~180 hrs). Honest baseline: comfortable on easy/medium arrays/hashing/two-pointers/sliding-window/stack; **shaky on graphs, harder trees, and especially DP** (mechanics of the 1-D intro trio — climbing stairs, house robber, coin change — but no recognition/formulation, no 0/1 knapsack, no 2-D). Need a curriculum shape that spends the time where it converts.

## Decision

- **Spine:** the **NeetCode 150**, worked **topic-by-topic** (pattern by pattern, easy→hard within each).
- **DP gets a ~2-week block** — the single largest allocation.
- **Comfort zones compressed** to timed re-confirmation (a warm-up weekend), not study.
- **Graphs get a full week** (shaky + a Google signature).
- **Deliberately skim the low-yield tail:** tries kept *light* (know the structure, code it once), and **bit-manipulation / math-geometry mostly dropped**.
- **No system-design prep** — not part of the new-grad loop.
- **DP is taught Recursion → Memoization → Tabulation** (see [[(C) Dynamic Programming|Dynamic Programming]]).

## Rationale

- The DP difficulty is **recognition + formulation**, not mechanics — that's a teaching problem, not a volume problem, so it needs *time and a framework*, hence the 2-week block. Grinding more coin-change variants would not close it.
- With a fixed ~180 hrs, time is zero-sum: every hour on rarely-asked topics (bit-manip, math, deep trie variants) is an hour stolen from graphs/DP, which are both high-frequency *and* the candidate's weak spots.
- New-grad Google interviews are coding + behavioral; system design (L4+) would be wasted effort.
- Comfort zones need confirmation, not relearning — so they're time-boxed to protect the back half.

## Alternatives rejected

- **Pure problem-volume grind** (e.g. "just do 300 problems") — doesn't bake in the master-check/communication layers Google scores, and wouldn't fix DP recognition.
- **Even coverage of all ~18 NeetCode categories** — 6.5 weeks isn't enough to perfect everything; spreading thin would leave the weak, high-frequency areas still weak.
- **Shrinking DP below 2 weeks** — rejected after the baseline clarification; it's the highest-pain, highest-reward gap.

## Consequences

- The dated week-by-week calendar + the DP ladder live in `Goals/(C) Google SWE Offer Roadmap.md` (planning, not wiki).
- A gamble: if a low-yield topic (bit-manip, advanced trie) shows up in the real loop, it's under-prepared — accepted for the expected-value gain on graphs/DP.
- Reversing this (e.g. if DP clicks early and time frees up) is a *new* decision that supersedes this one, not an edit.

## Sources

- [[(C) Setup Google Interview Prep Project]] — Exchanges 3–5 (curriculum backbone, DP recalibration, trie scoping).
