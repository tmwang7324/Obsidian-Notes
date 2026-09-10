---
title: "Daily notes"
source: "https://obsidian.md/help/plugins/daily-notes"
author:
published:
created: 2026-06-17
description: "Daily notes - Obsidian Help"
tags:
  - "clippings"
---
Daily notes is a [core plugin](https://obsidian.md/help/plugins) that opens a note based on today's date, or creates it if it doesn't exist. Use daily notes to create journals, to-do lists, or daily logs for things you discovered during the day.

To open today's daily note, either:

- Click **Open today's daily note** in the [ribbon](https://obsidian.md/help/ribbon).
- Run **Open today's daily note** from the [Command palette](https://obsidian.md/help/plugins/command-palette).
- [Use a hotkey](https://obsidian.md/help/hotkeys#Set%20a%20hotkey) for the **Open today's daily note** command.

By default, Obsidian creates a new empty note named after today's date in the YYYY-MM-DD format.

> [!tip] If you prefer to have your daily notes in a separate folder, you can set the New file location under plugin options to change where Obsidian creates new daily notes.
> 

> [!example]- Automatic subfolders
> You can automatically organize your daily notes into folders using the **Date format** feature.
> 
> For instance, if you set the date format as `YYYY/MMMM/YYYY-MMM-DD`, your notes will be created as `2023/January/2023-Jan-01`.
> 
> You can explore more formatting options on the [momentJS](https://momentjs.com/docs/#/displaying/format/) documentation site.

## Create a daily note from template

If your daily notes have the same structure, you can use a [template](https://obsidian.md/help/plugins/templates) to add pre-defined content to your daily notes when you create them.

1. Create a new note named "Daily template" with the following text (or whatever makes sense to you!):
	```md
	# {{date:YYYY-MM-DD}}
	## Tasks
	- [ ]
	```
2. Open **[Settings](https://obsidian.md/help/settings)**.
3. In the sidebar, click **Daily notes** under **Plugin options**.
4. In the text box next to **Template file location**, select the "Daily template" note.

Obsidian uses the template the next time you create a new daily note.

## Daily notes and properties

When the Daily notes plugin is activated and a date property is present within any note, Obsidian will automatically attempt to generate a link to the daily note for that specific day. For instance, if a note titled `example.md` includes a date property like `2023-01-01`, this date will transform into a clickable link in the [live preview](https://obsidian.md/help/edit-and-read#Live%20Preview) section.

![daily-notes-and-date-properties.png#interface](https://publish-01.obsidian.md/access/f786db9fac45774fa4f0d8112e232d67/Attachments/daily-notes-and-date-properties.png)

daily-notes-and-date-properties.png#interface