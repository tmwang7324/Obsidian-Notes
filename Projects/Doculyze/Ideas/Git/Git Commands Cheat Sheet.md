
# Git Clone
Copies a repository from the internet (github.com, gitlab.com, etc.) into the directory you are currently working in.
```bash
git clone [repo_link]
```

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

