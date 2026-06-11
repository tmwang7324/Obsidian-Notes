
# Create Today's Daily Plan Skill (DONE)


This skill considers which project I am grinding this week, my rough schedule, progress I have made on the project during the week, challenges I am facing, my character, and writes me a daily plan.

The skill should take the name of the project I want to focus on and return a markdown file containing a checklist of short goals that are measured to be achieveable by previous day progress.

These short-term goals should directly flow into the final goals laid out in the target project's Goals directory.
```bash
$ Parameters: Project directory name
$ Returns: a markdown file containing a num
/daily-plan [project-name]
```