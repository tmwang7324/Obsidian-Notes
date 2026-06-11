---
type: meta
aliases: ["Synthesis Manifest"]
tags: [meta, synthesis, manifest]
updated: 2026-06-11
---

# Synthesis Manifest

Run memory for the `synthesize` skill. One row per source file that has been synthesized into the wiki. Each sweep compares a source's current modified time to the `Modified` value here: a file is new/changed (and gets synthesized) when it has no row or its modified time is later. **Change detection is by timestamp.** Stamped as the last step of each run. Do not edit by hand.

| Source                                                                              | Modified         | Synthesized | Wiki targets                                |
| ----------------------------------------------------------------------------------- | ---------------- | ----------- | ------------------------------------------- |
| raw/notes/2026-05-25.md                                                             | 2026-05-25 12:15 | 2026-06-04  | baseline (2026-06-02 build)                 |
| raw/notes/SDK.md                                                                    | 2026-05-25 12:15 | 2026-06-04  | baseline (2026-06-02 build)                 |
| raw/notes/Full Stack Dev/JWT (JSON Web Token).md                                    | 2026-05-26 15:47 | 2026-06-04  | baseline (2026-06-02 build)                 |
| raw/notes/Firebase/Auth.md                                                          | 2026-05-26 16:51 | 2026-06-04  | baseline (2026-06-02 build)                 |
| raw/notes/Firebase/Untitled.md                                                      | 2026-05-29 19:26 | 2026-06-04  | baseline (2026-06-02 build)                 |
| raw/notes/Full Stack Dev/Cookies.md                                                 | 2026-05-29 19:36 | 2026-06-04  | baseline (2026-06-02 build)                 |
| raw/notes/Firebase/Firebase ID tokens.md                                            | 2026-05-30 12:16 | 2026-06-04  | baseline (2026-06-02 build)                 |
| raw/notes/AI Document Analysis/Technology Architecture.md                           | 2026-05-30 12:24 | 2026-06-04  | baseline (2026-06-02 build)                 |
| raw/notes/AI Document Analysis/grill-me/Auth State Architecture Using Express.md    | 2026-05-30 12:26 | 2026-06-04  | baseline (2026-06-02 build)                 |
| raw/notes/Full Stack Dev/Authentication vs Authorization.md                         | 2026-05-30 12:37 | 2026-06-04  | baseline (2026-06-02 build)                 |
| raw/notes/Full Stack Dev/ID Tokens.md                                               | 2026-05-30 12:38 | 2026-06-04  | baseline (2026-06-02 build)                 |
| raw/notes/AI Document Analysis/Progress/2026-05-27.md                               | 2026-05-30 15:31 | 2026-06-04  | baseline (2026-06-02 build)                 |
| raw/notes/Full Stack Dev/Dynamically Rendered Pages vs Statically Rendered Pages.md | 2026-05-30 15:34 | 2026-06-04  | baseline (2026-06-02 build)                 |
| raw/notes/Full Stack Dev/Next.js/Next.js.md                                         | 2026-05-30 15:36 | 2026-06-04  | baseline (2026-06-02 build)                 |
| raw/notes/Full Stack Dev/Context Providers.md                                       | 2026-05-30 16:12 | 2026-06-04  | baseline (2026-06-02 build)                 |
| raw/notes/Full Stack Dev/Next.js/Client vs Server Components.md                     | 2026-05-30 16:13 | 2026-06-04  | baseline (2026-06-02 build)                 |
| raw/notes/AI Document Analysis/Progress/2026-05-30.md                               | 2026-06-02 16:22 | 2026-06-04  | baseline (2026-06-02 build)                 |
| raw/notes/Full Stack Dev/Full Stack Dev.md                                          | 2026-06-02 21:15 | 2026-06-04  | baseline (2026-06-02 build)                 |
| raw/notes/Firebase/Firebase Setup.md                                                | 2026-06-02 21:19 | 2026-06-04  | baseline (2026-06-02 build)                 |
| raw/notes/Counter.md                                                                | 2026-06-02 21:33 | 2026-06-04  | baseline ((C) Python Counter)               |
| Projects/Doculyze/Chats/(C) Auth Architecture.md                                    | 2026-06-04 11:58 | 2026-06-05  | already a wiki page (moved Ideas→Chats)     |
| Projects/Doculyze/Chats/(C) Technology Architecture.md                              | 2026-06-04 12:00 | 2026-06-05  | already a wiki page (moved Ideas→Chats)     |
| Projects/Obsidian Configs/Chats/Reconfigure Obsidian Vault with LLM Wiki Pattern.md | 2026-06-03 01:16 | 2026-06-04  | baseline (2026-06-02 build)                 |
| 01 Journals/2026 Journals/06 June/2026-06-03.md                                     | 2026-06-04 08:12 | 2026-06-04  | (C) Poor Charlie's Almanack, (C) Vocabulary |
| 01 Journals/2026 Journals/06 June/2026-06-04.md                                     | 2026-06-04 21:30 | 2026-06-05  | (nothing durable — journal narrative)       |
| raw/notes/Untitled.md                                                               | 2026-06-04 11:57 | 2026-06-05  | (skipped — empty)                           |
| Projects/Golf/Ideas/Iron Swing.md                                                   | 2026-06-04 21:26 | 2026-06-05  | (C) Iron Swing, (C) Golf                    |
| Projects/Obsidian Configs/Chats/Designing the Daily Progress File.md                | 2026-06-04 21:52 | 2026-06-05  | (C) Obsidian Configs, (C) LLM Wiki Pattern  |
| Projects/Obsidian Configs/Chats/Grilling the Daily Plan Skill.md                    | 2026-06-05 16:25 | 2026-06-06  | (C) Obsidian Configs, (C) LLM Wiki Pattern  |
| Projects/Obsidian Configs/Ideas/Project Ideas Structure (DONE).md                   | 2026-06-04 22:03 | 2026-06-05  | (C) Obsidian Configs, (C) LLM Wiki Pattern  |
| Projects/Obsidian Configs/Ideas/Theme Customization.md                              | 2026-06-06 00:10 | 2026-06-06  | (C) Obsidian Configs                        |
| Projects/Obsidian Configs/Ideas/Give me Today's Daily Plan.md                       | 2026-06-04 23:21 | 2026-06-05  | (skipped — empty)                           |
| Projects/Obsidian Configs/Ideas/Untitled.md                                         | 2026-06-04 21:30 | 2026-06-05  | (skipped — empty)                           |
| 01 Journals/2026 Journals/06 June/2026-06-05.md                                     | 2026-06-06 03:04 | 2026-06-06  | (C) Obsidian Configs                        |
| Projects/Obsidian Configs/Ideas/Notes.md                                            | 2026-06-06 02:59 | 2026-06-06  | (C) Vocabulary, (C) Obsidian Configs        |
| Projects/Obsidian Configs/Ideas/Raw Notes vs Project Ideas (In Progress).md         | 2026-06-05 13:53 | 2026-06-06  | (C) Obsidian Configs (open question)        |
| Projects/Obsidian Configs/Ideas/Track Daily Progress Ideas (IN PROGRESS).md         | 2026-06-06 02:56 | 2026-06-06  | (C) Obsidian Configs, (C) LLM Wiki Pattern  |
| Projects/Obsidian Configs/Ideas/Give me Today's Daily Plan (DONE).md                | 2026-06-04 23:21 | 2026-06-06  | (skipped — empty)                           |
| Projects/Obsidian Configs/Ideas/Theme/Dashboard/Creating a Dashboard (IN PROGRESS).md | 2026-06-11 13:42 | 2026-06-11 | (C) Dashboard v1 Design, (C) MCL Multi-Column Layout, (C) Bases Launcher |
| Projects/Obsidian Configs/Ideas/Theme/Dashboard/Finalizing V1 of Dashboard (DONE).md | 2026-06-11 14:18 | 2026-06-11 | (C) Dashboard v1 Design, (C) Pomodoro Timer Placement, (C) Recent Files Widget Scope, (C) Bases Launcher |
| Projects/Obsidian Configs/Chats/(C) Pomodoro Timer Approach.md                      | 2026-06-09 15:29 | 2026-06-11  | (C) Pomodoro Timer Placement                |
| Projects/Obsidian Configs/Ideas/Theme/Dashboard/Callout Metadata Styling (NOTE).md  | 2026-06-10 13:48 | 2026-06-11  | (C) Callout Metadata                        |
| Projects/Obsidian Configs/Ideas/Theme/Dashboard/Frontmatter Styling (NOTE).md       | 2026-06-10 14:04 | 2026-06-11  | (C) cssclasses Containment                  |
| Projects/Obsidian Configs/Ideas/Theme/Theme Customization.md                        | 2026-06-11 14:42 | 2026-06-11  | (C) Obsidian Configs (theming)              |
| 01 Journals/2026 Journals/06 June/2026-06-07.md                                     | 2026-06-10 12:35 | 2026-06-11  | (C) LLM Wiki Pattern (reference)            |
| Projects/Obsidian Configs/Ideas/Structure/Should Progress be Included in Wiki (DONE).md | 2026-06-08 12:48 | 2026-06-11 | (C) Decisions in the Wiki (06-08)          |
| Projects/Obsidian Configs/Ideas/Structure/Wiki Structure (DONE).md                  | 2026-06-11 14:36 | 2026-06-11  | (C) Decisions in the Wiki (06-08)           |
| Projects/Obsidian Configs/Ideas/Structure/Track Daily Progress Ideas (IN PROGRESS).md | 2026-06-11 14:20 | 2026-06-11 | (C) Obsidian Configs, (C) Archive Not Delete |
| Projects/Obsidian Configs/Ideas/Obsidian Notes.md                                   | 2026-06-06 17:26 | 2026-06-11  | (C) Vocabulary, (C) Obsidian Configs        |
| Projects/Obsidian Configs/Ideas/Structure/Project Ideas Structure (DONE).md         | 2026-06-04 22:03 | 2026-06-11  | (C) Obsidian Configs (moved)                |
| Projects/Obsidian Configs/Ideas/Structure/Raw Notes vs Project Ideas (In Progress).md | 2026-06-05 13:53 | 2026-06-11 | (C) Obsidian Configs (open question, moved) |
| Projects/Obsidian Configs/Ideas/Structure/Give me Today's Daily Plan (DONE).md       | 2026-06-04 23:21 | 2026-06-11  | (skipped — empty, moved)                    |
| Projects/Obsidian Configs/Chats/(C) Reconfigure Obsidian Vault with LLM Wiki Pattern.md | 2026-06-03 01:16 | 2026-06-11 | baseline (renamed +(C))                    |
| Projects/Obsidian Configs/Chats/(C) Designing the Daily Progress File.md            | 2026-06-04 21:52 | 2026-06-11  | (C) Obsidian Configs, (C) LLM Wiki Pattern (renamed) |
| Projects/Doculyze/Ideas/Creating Firebase Databases.md                              | 2026-06-06 12:40 | 2026-06-11  | (skipped — empty)                           |
| 01 Journals/2026 Journals/06 June/2026-06-08.md                                     | 2026-06-08 23:56 | 2026-06-11  | (nothing durable — journal narrative)       |
| 01 Journals/2026 Journals/06 June/2026-06-10.md                                     | 2026-06-10 14:01 | 2026-06-11  | (skipped — empty journal)                   |
| 01 Journals/2026 Journals/06 June/2026-06-11.md                                     | 2026-06-11 14:19 | 2026-06-11  | (nothing durable — journal narrative)       |
