
# Git Clone
Copies a repository from the internet (github.com, gitlab.com, etc.) into the directory you are currently working in.
```bash
git clone [repo_link]
```

# Git merge
Performs a three-way merge on the current branch and specified branch
# Git Restore (with git 2.24)
Unstages a file that has been added to a commit. 
```bash
git restore --staged <file_path>
```

# Git reset
Undoes commits either by deleting all changes from local machine (**hard**) or just remove the commit.
```bash
git reset --hard [HEAD~1 or can use commit id] # discard all changes to files
git reset --soft [HEAD~1 or can use commit id] # revert one commit but keep changes staged
git reset --mixed [HEAD~1 or can use commit id] # revert one commit and unstage changes
```
*HEAD~1* refers to the first node from the HEAD commit (most recent commit). What this command does is it "resets" to the previous commit.
**Lowkey much easier to use commit id**

Also can be used to unstage any staged changes for given files.
```bash
git reset -- <file_path>
```


# Git rm --cached
Removes files from Git's tracking index (staging area) without deleting them from my local hard drive.
Also unstages files completely.

To untrack a specific file while keeping my local copy intact:
```bash
git rm --cached <file_path>
```
To untrack a specific directory and all of its contents, add the  recursive `-r`
```bash
git rm -r --cached <folder_path>
```

# Git revert 
If a push sits on top of earlier history, I can commit a request to revert a specific push specified by **sha256** id using:
```bash
git revert <sha> # where sha is the push code
# IMPORTANT: This ends up undoing all progress 
git revert --no-commit <sha> # Staged Changes
git push
```

# Git cherry-pick 
# Git Diff
By default, running a bare `git diff` displays the differences between my **current working directory and the staging area** (tracked files that have been modified but not yet staged with `git add`).

```bash
git diff # staging area vs current working directory
git diff <branch-1> <branch-2> # Compares the differences between two branches
git diff <commit-1> <commit-2> # Compares two specific commits via sha256 hash ids. 
git diff --cached # staged vs head
git diff --name-only --diff-filter=AMD # only reveals the filenames of modified, added, and deleted files.
```
