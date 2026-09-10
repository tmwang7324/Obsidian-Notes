---
type: progress-dashboard
project: Interview Prep
tags: [progress, interview-prep]
updated: 2026-07-20
---

# (C) Global Progress - Interview Prep

## Company Progress

```dataview
TABLE date, project, file.link AS Entry
FROM "Projects/Interview Prep/Company"
WHERE type = "progress"
SORT date DESC
```

## Open Company Next Steps

```dataview
TABLE project, goal, effort, file.link AS Next
FROM "Projects/Interview Prep/Company"
WHERE type = "next-step" AND status = "open"
SORT project ASC, effort ASC, file.name ASC
```

## Parent-Level Next Steps

```dataview
TABLE goal, effort, file.link AS Next
FROM "Projects/Interview Prep/Iteration Logs"
WHERE type = "next-step" AND status = "open"
SORT effort ASC, file.name ASC
```

