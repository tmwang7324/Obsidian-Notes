---
type: meta
project: Doculyze
aliases: ["Code Explanations Index"]
tags: [doculyze, resources, code-explainer]
updated: 2026-07-20
sources: 3
---

# (C) Code Explanations Index

Entry point for the `/code-explainer` HTML walkthroughs in this folder. **Obsidian's file explorer cannot display `.html` files** — it only lists formats it can render — so this note exists to make them reachable from the GUI. Each link below opens in your default browser.

> The links use the angle-bracket form `[text](<file:///…>)`. This is required, not stylistic: the `(C)` prefix puts parentheses in the filenames, which break ordinary markdown link parsing.

## Walkthroughs

| Explanation                                                                                                                                                | Scope                                                 | Related next-step                                                        |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------- | ------------------------------------------------------------------------ |
| [Pull-based ingest](<file:///C:/Obsidian Vault/Projects/Doculyze/Resources/Code Explanations/2026-07-20-explanation-pull-based-ingest.html>)               | Full change explanation of the pull-based ingest work | [[(C) Pull-Based Ingest Tracer]]                                         |
| [Issue 4 — ingest worker](<file:///C:/Obsidian Vault/Projects/Doculyze/Resources/Code Explanations/(C) 2026-07-20-explanation-issue-4-ingest-worker.html>) | Issue-scoped, casual register                         | [[(C) Pull-Based Ingest Tracer]]                                         |
| [Ingest worker (Python)](<file:///C:/Obsidian Vault/Projects/Doculyze/Resources/Code Explanations/(C) 2026-07-20-explanation-ingest-worker-python.html>)   | The worker subsystem specifically                     | [[(C) Pull-Based Ingest Tracer]] · [[(C) Embed + Chroma Tenant Gateway]] |

All three describe the ingest half of the design specced in [[(C) RAG Ingest and Query Data Architecture|RAG Ingest and Query Data Architecture]].

## Provenance

Copied on 2026-07-20 from the `/code-explainer` skill workspace at `~/.claude/skills/code-explainer-workspace/iteration-1/`, where they are the **`with_skill` arm of a completed A/B eval** (each sits beside a `grading.json` and a `without_skill` markdown counterpart). They were **copied, not moved**, so that eval record stays intact and reproducible — the originals are still in the workspace.

## Housekeeping

This folder also contains two un-prefixed files, `2026-07-20-explanation-pull-based-ingest.html` and `2026-07-20-explanation-pull-based-ingest 1.html`. Both are **byte-identical** (MD5 `3ae2820…`) to the `(C)`-prefixed pull-based-ingest file linked above — they predate this index and appear to be a manual copy pasted twice. Safe to delete; left in place pending confirmation.
