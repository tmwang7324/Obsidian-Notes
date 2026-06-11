---
name: new-project
description: Create a new project inside `Projects/` by interviewing the user, then scaffolding the folder structure, CLAUDE.md, and COMMANDS.md. Use when the user wants to start, create, or set up a new project in the vault.
---

# Skill: New Project

Create a new project inside `Projects/` by interviewing the user, then scaffolding the folder structure, CLAUDE.md, and COMMANDS.md.

## How It Works

1. Interview the user one question at a time (6 questions max)
2. Based on answers, create the folder structure and files
3. If the user doesn't have an answer yet, that's fine — use sensible defaults and leave TODOs in the CLAUDE.md for them to fill in later

## Interview Questions (Ask One at a Time)

Ask these questions conversationally using AskUserQuestion. Each answer can shape the next question. If someone says "I'm not sure yet" or gives a partial answer, don't push — just work with what you have.

### 1. What's the project called?
Used for the folder name under `Projects/`.

### 2. What is this project?
One paragraph. What are we building / doing / creating? Who is it for?

### 3. What does "done" look like?
What's the goal? What does success look like for this project? This becomes the prime directive in the CLAUDE.md — the thing Claude nudges toward.

### 4. Who else is involved?
Key people and their roles. Could be "just me" — that's fine.

### 5. What's the process from start to finish?
Walk me through how something goes from idea to done in this project.

### 6. Any rules or conventions Claude should follow?
Things Claude should always or never do in this project. Specific formats, naming conventions, etc. Optional — skip if they don't have any yet.

## After the Interview

### Step 1: Create the project folder and standard subfolders
All projects use this flat folder structure — no numbered prefixes:

```
Projects/<ProjectName>/
├── CLAUDE.md
├── COMMANDS.md
├── Chats/          ← Archived, summarized Claude sessions
├── Goals/          ← Short- and long-term project goals
├── Ideas/          ← Raw ideas, inputs, things to explore
├── Iteration Logs/ ← Next-step backlog (type: next-step files; feeds /create-daily-plan)
├── Progress/       ← Weekly folders (Week of <Mon date>/): daily (C) YYYY-MM-DD.md reports
├── Resources/      ← Links, references, docs (cite these in wiki pages)
├── Skills/         ← Reusable scripts/automations as markdown (NOT Claude Code skills)
└── System/         ← Scripts, config, reusable processes
```

Create all folders, even if the user has no content yet. Use PowerShell:
```powershell
$base = "C:\Users\jw300\OneDrive\Documents\Obsidian Vault\Projects\<ProjectName>"
$folders = @("Chats", "Goals", "Ideas", "Iteration Logs", "Progress", "Resources", "Skills", "System")
foreach ($f in $folders) { New-Item -ItemType Directory -Path "$base\$f" -Force | Out-Null }
```

### Step 2: Write CLAUDE.md
Use this structure. Fill in what you learned from the interview. For anything the user wasn't sure about, add a `<!-- TODO: fill this in -->` comment.

```markdown
# [Project Name]

[One paragraph: what this project is, from question 2]

## Claude's Role

[What Claude does in this project. Be specific — not "help me ship" but the actual job based on what the project needs.]

[Prime directive based on question 3. Follow this format:]
If a session is drifting without moving toward [shipped output], nudge me back: "[contextual nudge message]"

## Process

[Step-by-step process from question 5. Numbered steps showing how work flows from start to finish. If they weren't sure, write a simple default and add a TODO.]

## Key People

[From question 4. Name — role/what they do. Skip section if solo project.]

## Folder Structure

[List every folder with a short description of what goes in it]

## Rules & Conventions

- **`(C)` prefix** — Every file Claude creates is prefixed with `(C)`. **Exempt:** `CLAUDE.md`, `COMMANDS.md`.
- **Editing rule** — Before editing any file without the `(C)` prefix, ask for permission first.
- **Skills** — Reusable scripts/automations are saved as markdown files in `Skills/`, not as Claude Code skills.
- **Represented in the wiki** — durable content flows up into `../../wiki/`. Read project content from the wiki first; drill into these folders only when the wiki isn't comprehensive enough.
- **Progress loop** — follows the vault-wide **Progress** workflow in the root `CLAUDE.md`: `Goals/` set direction; daily `(C) YYYY-MM-DD.md` files under `Progress/Week of <Mon date>/` (`type: progress`) record work and link the goal they advance, synthesizing the day's journal + working/`Ideas/` notes; `Iteration Logs/` holds `type: next-step` files (the backlog that feeds `/create-daily-plan`). For this project, `project: <ProjectName>`, tag `<project-slug>`.
[Add any project-specific rules from question 6]

## Current Status

> **Last updated:** [today's date]
> **Status:** Just created — getting started.

<!-- TODO: Update this as the project progresses -->
```

### Step 3: Write COMMANDS.md

```markdown
# Commands & Skills

Quick reference for all available skills and commands in this project.

## Skills (in Skills/)
_No project-specific skills yet._

## Commands
_No project-specific commands yet._
```

### Step 4: Update the root CLAUDE.md
The `## Current state` section at the bottom of the root `CLAUDE.md` tracks active projects. Update the sentence that lists them to include the new project with a one-line description.

### Step 5: Confirm to the user
Show them:
- The folder structure that was created
- A summary of the CLAUDE.md
- Remind them they can update the CLAUDE.md and folder structure anytime as the project evolves
- If any sections have TODOs, point those out so they know what to fill in later
