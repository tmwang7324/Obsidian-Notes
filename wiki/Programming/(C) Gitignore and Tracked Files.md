---
type: concept
aliases: ["Gitignore and Tracked Files", "gitignore tracked gotcha"]
tags: [git, tooling, gotcha, concept]
updated: 2026-06-12
sources: 1
---

# Gitignore and Tracked Files

**`.gitignore` only affects *untracked* files.** Adding a path to `.gitignore` does **not** hide it if git is already tracking it — git keeps tracking whatever is in the index, ignore rules notwithstanding. This is the single most common "my gitignore isn't working" cause.

## Diagnosing it

- `git check-ignore -v <path>` reports nothing for a path that's **already tracked**, even when a matching rule exists — because the index wins.
- `git check-ignore --no-index -v <path>` ignores the index and tests the rule in isolation. If this matches but the plain form doesn't, the file is tracked — that's your answer.
- `git ls-files <path>` lists what's tracked under a path; a non-empty result confirms it.

## The fix

Untrack the path (keeps the files on disk, removes them from git), then commit:

```bash
git rm -r --cached <path>     # stop tracking; files stay on disk
git add .gitignore            # make sure the ignore rule itself is committed
git commit -m "Stop tracking <path>; add to gitignore"
```

After this, the path stays in the working tree but git ignores it going forward. (Bonus check: confirm `.gitignore` itself is committed — an uncommitted `.gitignore` isn't part of history at all.)

## Related

- Source: `Projects/Google Interview Prep/Chats/(C) Setup Google Interview Prep Project.md` (diagnosed on the vault's `_fit/` folder).
