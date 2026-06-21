
### Question 8 — Where to Put the Pomodero Timer (DECISION)

Since the Pomodero timer requires stateful `dataviewjs` to keep track of the elapsed time, switching to another note causes the script to reload. Thus, keeping it on one note such as the dashboard is very possible, just difficult to do.  
The way to do this is to store `endTime = totalTime (set by user) + timeWhenClockStarted` and then calculate `remainingTime = endTime - now` where `now` is a variable that holds the current time.
Use a global window: `window._pomoInt` to keep the timer running despite note switches, and keep its HTML dynamically updating.
Store endtime, remaining time, running, and mode in `localStorage` which is exposed globally.


However, **a much easier approach is to either install a pomodero plugin or create a note that I can attach to the sidebar that I never have to switch off of.**
**Rationale:** No need for `window._pomoInt` and global storage in `localStorage.` Just calculate remaining time by decrementing the totalTime by 1 using an interval. 

Link to Chat: [[(C) Pomodoro Timer Approach]]
### Question 9  — Include AI generated files in Recently Modified Widget? (DECISION)
No, only include files that do not start with a "(C)" in this section. 

**Rationale:** Including AI generated files will inevitably result in the "Recent Files Edited" being populated with synthesized files in the Wiki. Although this helps me keep track of what I learned and my decisions, the synthesis file already does that. Furthermore, the purpose of the "Recent Files Edited" widget is to allow me to have a shortcut back into my idea files.
******

### Question 10 — Projects Bases launcher: how does it select files, and inline or standalone? (DECISION)
**Two sub-decisions:**
  1. Selection rule. Your three overviews are type: overview under wiki/Projects/. But that folder also holds (C)
  Architecture.md and Decisions/*.md (which are type: decision/other). So:
    - Filter by type == "overview" AND folder under wiki/Projects → selects exactly your three project overviews,
  cleanly, and won't catch architecture/decision pages or any domain overviews elsewhere.
    - Filter by folder alone → drags in architecture + decision files. Wrong.
  2. Inline base codeblock vs standalone .base file. A ```base codeblock lives *in* the dashboard note (consistent with
  our single-note substrate); a .base file is a separate file embedded via ![[x.base]]. You have two stray Untitled.base
  experiments lying around.

  My recommendation + Rationale:
  - Filter: type == "overview" scoped to the wiki/Projects folder.
  - Inline base codeblock in the dashboard note — keeps the dashboard one self-contained file (our Q1 decision), nothing extra to track. Delete the two Untitled*.base experiments separately.
  - Columns: project name (link) + updated date. Skip tags — noise for a launcher. (No status text, per Q3.)

### Question 11 — Layout: where does each widget sit in the MCL grid? (DECISION)

Your original note wanted Time+Date "central, in the middle, fancy" and the Projects + Plan as focal points. For a
  morning-glance surface, the priority order is: what time/day is it → what do I do today → jump into work. Here's the
  arrangement I'd build:

  ┌─────────────────────────────────────────────┐
  │            ⏱  TIME + DATE (live)            │   ← full-width, centered, the fancy focal clock
  │         14:32:07 · Tuesday, June 9 2026      │
  ├──────────────────────┬──────────────────────┤
  │  📋 TODAY'S PLAN      │  📓 Today's Journal  │   ← MCL two-column callout
  │  (embedded checklist) │  [open / create]    │
  │  ☐ task 1            │                      │
  │  ☐ task 2            │  🕐 Recent files     │
  │  ☐ ...               │  • note A            │
  │  (or "run /daily-plan")│ • note B ...        │
  ├──────────────────────┴──────────────────────┤
  │  🗂  PROJECTS  (Bases launcher)              │   ← full-width table
  │  Doculyze        2026-06-03                  │
  │  Golf            2026-06-05                  │
  │  Obsidian Configs 2026-06-06                 │
  └─────────────────────────────────────────────┘

  **Rationale:** Clock owns the top as the focal banner you wanted. The Plan gets the most width (left column) because the embedded checklist is the day's action surface. Journal + Recent stack in the narrower right column — both are one-click jumps, not things you read in place. Projects sits full-width at the bottom as a launcher row (a Bases table wants horizontal room — your MCL Wide Views snippet is made for exactly this).


### Change Dataview in Recents to Dataviewjs
> [!multi-column]
>> [!blank|wide-1] 
>> **🕐 Recent**
>```dataview
>LIST WITHOUT ID file.link
>WHERE !startswith(file.name, "(C)")
>WHERE !startswith(file.folder, "wiki")
>WHERE !contains(file.folder, "Progress")
>WHERE !startswith(file.folder, "Plans")
>WHERE file.name != "index" AND file.name != "log"
>SORT file.mtime DESC
>LIMIT 7
>
```dataview
LIST WITHOUT ID file.link
WHERE !startswith(file.name, "(C)")
WHERE !startswith(file.folder, "wiki")
WHERE !contains(file.folder, "Progress")
WHERE !startswith(file.folder, "Plans")
WHERE file.name != "index" AND file.name != "log"
SORT file.mtime DESC
LIMIT 7
```

Why does the dataview code not work anymore? It was working fine before I implemented the onclick onto the embedded notes in *Daily Journal.*
```dataview
LIST 
```
![[Pasted image 20260610171820.png]]



p = p.onclick = () => {
>> 	   app.workspace.openLinkText(path, "", false);
>>    };>> [!note] 🕐 Recent
>>
>> ```dataview
>> LIST WITHOUT ID file.link
>> WHERE !startswith(file.name, "(C)")
>> WHERE !startswith(file.folder, "wiki")
>> WHERE !contains(file.folder, "Progress")
>> WHERE !startswith(file.folder, "Plans")
>> WHERE file.name != "index" AND file.name != "log"
>> SORT file.mtime DESC
>> LIMIT 7
>> ```