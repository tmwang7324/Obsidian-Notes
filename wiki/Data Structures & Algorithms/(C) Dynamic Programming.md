---
type: concept
aliases: ["Dynamic Programming", "DP"]
tags: [dsa, algorithms, dynamic-programming, interview-prep, concept]
updated: 2026-06-12
sources: 1
---

# Dynamic Programming

DP solves a problem by breaking it into **overlapping subproblems** with **optimal substructure** — the optimal answer is built from optimal answers to smaller pieces, and those pieces repeat (so you cache them instead of recomputing).

## The two skills (and which one is actually hard)

Knowing the *mechanics* of one DP problem (e.g. filling a 1-D coin-change table bottom-up) is not the bar. The interview difficulty splits into two skills:

1. **Recognition** — looking at a *fresh* problem and knowing it's DP (the optimal-substructure + overlapping-subproblems tell).
2. **Formulation** — defining, from scratch, the **state**, the **transition**, the **base case**, and the **fill order**.

The grind that fixes this is *not* more variants of a problem you already know — it's repeatedly practicing recognition + formulation on new problems.

## The recommended pipeline: Recursion → Memoization → Tabulation

Write it in this order, every time — it *is* the recognition framework:

1. **Brute-force recursion** — forces you to define **state = the function's arguments**. If you can write the recursion, you've formulated the problem.
2. **Memoization** — add a cache keyed on the state. Same recursion, now without recomputation (top-down).
3. **Tabulation** — convert to an iterative table (bottom-up). Often a constant-factor/space win.

Bottom-up tabulation is the *hardest* mental entry point, which is why learners who start there can solve a problem yet not generalize. Starting from the recursion makes the state explicit and transfers to any new problem.

## A beginner ladder (each rung reuses the last)

1. **Framework on tiny state:** climbing stairs → house robber → house robber II.
2. **Anchor + extend:** coin change (unbounded knapsack) → coin change II (count ways) → word break.
3. **Knapsack contrast (key unlock):** learn **0/1 knapsack** (partition equal subset sum) by seeing exactly what one line differs from the *unbounded* version.
4. **Subsequence DP:** longest increasing subsequence → decode ways.
5. **2-D / grid:** unique paths → min path sum → longest common subsequence → edit distance → longest palindromic substring.

## Related

- Part of the [[(C) Google Interview Prep|Google Interview Prep]] curriculum — see the [[(C) Curriculum Strategy|Curriculum Strategy]] decision (DP gets a 2-week block because recognition/formulation, not mechanics, is the gap).
- Source: `Projects/Google Interview Prep/Chats/(C) Setup Google Interview Prep Project.md`
