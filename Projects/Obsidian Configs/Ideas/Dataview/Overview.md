Dataview is a community plugin that allows users to use SQL-like commands to query Obsidian data. Specifically, it is a live index and query engine over my personal knowledge base. I can add frontmatter **metadata** to my notes and query them using the **Dataview Query Language**^f41140

# LIST

```dataview
LIST LIMIT 3
```
```dataview
LIST WITHOUT ID rows.file.link + " - " + type GROUP BY type WHERE type != null
```
# TABLE
Example of using the `TABLE` command:
```dataview
TABLE file.link AS Entry FROM #project 
```

```dataview
TABLE WITHOUT ID rows.file.link as "Most Recent",
list(rows.summary[0], rows.summary[1]), project FROM #progress SORT date DESC GROUP BY project WHERE project != null
FLATTEN list(rows.file.link[0], rows.file.link[1])
``` 



flat(date)```dataview
TABLE WITHOUT ID file.link AS Entry, project, date AS Date, summary AS Summary, goals AS Advances
FROM #progress FLATTEN(project)
SORT date DESC LIMIT 2
```TABLE WITHOUT ID flat(rows.file.link), project FROM #progress GROUP BY project SORT row DESC LIMIT 2
```dataview
TABLE WITHOUT ID rows.file.link[0] as "Most Recent",
rows.file.link[1 AS "Previous, rows.summary[01], project FROM #progress SORT date DESC GROUP BY project WHERE project != null
FLATTEN entry
``` 
flat(date)```dataview
TABLE WITHOUT ID file.link AS Entry, project, date AS Date, summary AS Summary, goals AS Advances
FROM #progress FLATTEN(project)
SORT date DESC LIMIT 2
```TABLE WITHOUT ID flat(rows.file.link), project FROM #progress GROUP BY project SORT row DESC LIMIT 2 AS "Previous
```dataview
```TABLE WITHOUT ID flat(rows.file.link), project FROM #progress GROUP BY project SORT row DESC LIMIT 2 AS "Previous as "Most Recent",list(rows.file.link[0], rows.file.link[1])
TABLE WITHOUT ID rows.file.link as "Most Recent",
list(rows.summary[0], rows.summary[1]), project FROM #progress SORT date DESC GROUP BY project WHERE project != null
FLATTEN list(rows.file.link[0], rows.file.link[1])
``` 
```TABLE WITHOUT ID flat(rows.file.link), project FROM #progress GROUP BY project SORT row DESC LIMIT 2 AS "Previous as "Most Recent",
