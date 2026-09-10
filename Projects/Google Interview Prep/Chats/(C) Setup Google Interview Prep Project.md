---
source: claude-code
project: "C:\\"
date: 2026-06-12
tags: [claude-archive, google-prep]
---

# Setup Google Interview Prep Project

> A `_fit` folder `.gitignore` fix, then the full creation and curriculum design of the **Google Interview Prep** project — a calibrated 6.5-week New Grad SWE plan locked into `Goals/` with the warm-up weekend seeded into `Iteration Logs/`.

---

## Exchange 1 · 2026-06-11

**Asked:** Is the `.gitignore` in the Obsidian Vault (containing `_fit/`) correct to hide the `_fit` folder?

**Answered:** The `_fit/` pattern syntax is correct (clean, no BOM; `git check-ignore --no-index` confirms it would match), **but it won't hide `_fit` because the folder is already tracked** — 6 files were already committed under it (`.obsidian/*.json`, `Welcome.md`), and `.gitignore` only applies to untracked files. Also flagged that `.gitignore` itself wasn't committed. Fix: untrack with `git rm -r --cached _fit`, then `git add .gitignore` and commit.

---

## Exchange 2 · 2026-06-12

**Asked:** Untracked it successfully. Now create a new project via `/new-project Google Interview Prep`.

**Answered:** Confirmed the vault path (`C:\Obsidian Vault\Projects`, not the OneDrive path in the skill template), interviewed via `AskUserQuestion` (target role = SWE New Grad; goal = land the offer *and* master fundamentals; process = topic-by-topic; timeline = interview-ready before the July 27 Barclays start), then scaffolded the standard folder structure, a filled-in `CLAUDE.md` (coach role, hints-not-answers, "no faking it" tie-back), `COMMANDS.md`, and updated the root `CLAUDE.md` to list four active projects.

---

## Exchange 3 · 2026-06-12

**Asked:** Talk through the curriculum before writing it to a file.

**Answered:** Proposed the **NeetCode 150** as the topic-by-topic spine, tiered by Google frequency (Core: arrays/hashing, two pointers, sliding window, stack, binary search, trees, graphs, 1-D/2-D DP; Important: linked list, heaps, backtracking, intervals, greedy; Lower-yield: tries, advanced graphs, bit-manip, math). Calibrating questions established baseline = comfortable on easy/med (graphs/DP shaky) and capacity = 5+ hrs/day (~180 hrs over 6.5 weeks). Produced a week-by-week plan, noted New Grad SWE = coding + behavioral (no heavy system design), and flagged DP for a 2-week block.

---

## Exchange 4 · 2026-06-12

**Asked:** Still very much a DP beginner — the most complex DP problem fully understood is unbounded knapsack / coin change.

**Answered:** Confirmed the 2-week DP block stays. Reframed the gap as **recognition + formulation** (knowing a problem is DP and defining state/transition/base case cold), not volume. Prescribed teaching DP as **Recursion → Memoization → Tabulation** (recursion first forces "state = function arguments"), with a concrete ladder: climbing stairs/house robber → coin change w/ framework → coin change II/word break → **0/1 knapsack contrast** (partition equal subset sum) → LIS/decode ways → 2-D grid (unique paths, LCS, edit distance). Reinforced keeping the warm-up weekend fast so it doesn't steal back-half time.

---

## Exchange 5 · 2026-06-12

**Asked:** Have also completed house robber and climbing stairs. Also — what are Tries?

**Answered:** Noted the DP foundation is the classic 1-D intro trio (so ladder rung 1 is review, not new teaching). Explained a **trie / prefix tree**: each edge is a character, paths spell prefixes, shared prefixes stored once (`car`/`cat`/`dog` example); nodes hold a children map + `isEndOfWord` flag; insert/search/startsWith are all O(word length), independent of word count. Classic problems: Implement Trie (LC 208), Word Search II. Scoped it "light" — know the structure, code it once, don't grind.

---

## Exchange 6 · 2026-06-12

**Asked:** Lock the curriculum into `Goals/` and seed the `Iteration Logs/`.

**Answered:** Checked existing projects for a template (empty), so followed the root `CLAUDE.md` frontmatter spec and `GOALS.md` house style. Wrote `(C) Google SWE Offer Roadmap.md` (`type: goal`) with the definition of interview-ready (≤30 min mediums by July 26, DP formulation cold, graphs cold, 5–6 STAR stories), the week-by-week table, the DP ladder, operating principles, and two Dataview blocks (progress + open next-steps). Seeded 4 `type: next-step` warm-up files (Arrays & Hashing, Two Pointers, Sliding Window, Stack) each with a curated NeetCode problem set, `effort: M`, `google-prep` tag, and a master-check. Updated the project `CLAUDE.md` status to "curriculum locked."

---

## Exchange 7 · 2026-06-12

**Asked:** Good enough for tonight — will continue tomorrow.

**Answered:** Signed off; everything saved in the vault. Tomorrow: run `/daily-plan` to pull the four warm-up next-steps into a sized checklist, and keep the warm-up fast (re-confirmation, not study) to protect graphs/DP time later.
*Archived 2026-06-12 via `/archive-conversation`.*
