# Overview
Commands cheat sheet for `grep`, a Unix native command that finds a specific string within a filesystem.

### 
The below command marks any found instance of *string* in red, returns the entire line, searches recursively across `doculyze/`, excludes instances in directory `.next/`, and ignores case.
```bash
grep --color=auto -ri --exclude-dir=".next" string doculyze

grep --color=auto -ri --exclude-dir=".next" "validateUploadClaim" doculyze
```