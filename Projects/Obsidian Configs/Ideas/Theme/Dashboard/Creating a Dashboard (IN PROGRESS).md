For the love of God, please PIN the dashboard as the default home page upon app start.
# What should be on my Dashboard? (DECISION)

### Central Widgets 
* Projects; each project should have an overview file that describes the identity, purpose, and progress of the project. This widget should be an embedded base to all Project overview files.
* Daily Plan, which can be pulled from *Plans/[Current Week]/[today's date]*
* Today's Journal should be linked. If it does not exist, create a new daily journal.
* Recent files updated. 
### Miscellaneous Widgets
* A focus timer that I can stop, reset, and change time.
* Have a year-long Project progress tracker built like a github contribution chart, with intensity of color indicating how productive I was for a specific project each day. Measured by amount of daily goals completed within a day.
* Have a Sleep Tracker built like the KomoreBi weekly charts. The intensity of designated color should indicate how early I woke up. *Time Woken Up* should be a field within the daily journal.
### Time + Date
 Time + Date should be displayed as a central part of the dashboard (in the middle, styled fancily, and dynamic).

### Project To Focus On
This field should also be a focal point of the dashboard. It pulls the project listed as this week's focus project in the root Goal.md, and allows me to edit the focus project upon click.
* Try to automate saving the answer to this prompt to GOAL.md using QuickAdd and Templater (DIFFICULT).

### Daily Contribution Graph
**Contribution Graph** plugin. Color it based on characters written in Daily Journal + Ideas.

### Project Progress (DECISION)
Instead of simply displaying a base of my Projects, I want to display the top 2 recent entries in each Progress Log in addition to the linked overviews on the Projects widget on my dashboard.
I already know what each of my projects are. I specifically want to know where I am at for each project when I start up the day.

Can't use standard `Dataview` due to the global `LIMIT` constraint as well as

### Limiting 

I want to base my design off this. 
[[gave-my-obsidian-vault-a-notion-style-dashboard-v0-tsujictrx4qg1.webp]]. It is primarily written in dataviewjs [[Dashboard-Komorebi]].

```dataviewjs 
const = 
```

![[Date Card.canvas]]
#### Using Cards (NOTE)
Create cards of each section in the Dashboard, including a daily note embedded card.

> **How to Create a Card?**
> 	1. Must create a canvas first by clicking the **Create new Canvas** icon in the sidebar or use the command Ctrl + P.
> 	2. Double-click anywhere on the canvas grid or drag the card icon from the bottom toolbar.
> 	3. Drag and drop existing notes from your file explorer directly onto the canvas to see them as cards.

I am unsure how to render these canvas.

This command is used by another user (Jake Mahr) to embed the current day's daily note even if it does not exist.
```dataview
join(list("![[",dateformat(date(today), "y-MM-dd-cccc"),"]]"), "")
```

#### Using Callouts
1. First import or write a multi-column css snippet that organizes items underneath a callout >[!callout_name] into columns that dynamically fit the page.
2. The multi-col css files I use are from: https://github.com/efemkay/obsidian-modular-css-layout
3. Pretty straightforward except for learning the different callouts the multi-column css snippet has.
4. Declare a section to have the multi-column rule with: 
>>![multi-column]

5. Then, use designed callouts such as [!info] and [!warning] to create specialized columns
6.  See more on frontmatter + metadata styling [[Frontmatter Styling (NOTE)]] [[Callout Metadata Styling (NOTE)]]

> [!multi-column]
> 
> >[!info]
> >Hi
> 
> >[!warning]
> >This is a warning
![[Untitled 1.base]]

#### Embedded Links (NOTE)
Do "!["[Embedded Link]"] to embed pages and images into a note.
 

## Approach (DECISION)
I aim to prompt Claude to use callouts controlled by "multi-column" to create and link the widgets accordingly. The time + date, timer, and "Project of the week" sections should be made using dataviewjs. 

**Rationale:** Time + date, focus timer, and "Project of the week" all are dynamic features, most of them requiring user interaction. I believe static linking is not enough to achieve seamless user experience.

**Update:** Pomodero timer will not be included in the dashboard. Most likely, I will implement it in a separate note and then keep it on my right sidebar.

See more in [[Finalizing V1 of Dashboard (DONE)]]
I believe implementating the github contribution chart requires a plugin called **Contribution Graph** by vran.

```dataview
LIST FROM [[]] and !outgoing([[]])
```
```dataview
TABLE file.ctime AS "Created"
WHERE file.ctime >= date(today) - dur(1 week)
```