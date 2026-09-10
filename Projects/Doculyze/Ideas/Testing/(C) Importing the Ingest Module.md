---
aliases: [Importing the Ingest Module]
tags: [doculyze, testing, python, ingest-worker]
updated: 2026-08-10
sources: 1
---

# Overview

How to make `from ingest.parsers import PARSERS` work when running ingest-worker scripts locally. Companion to [[Python Ingest-Worker|Python Ingest-Worker testing]] — that note covers `pytest` usage, this one covers plain script/module runs, which are what actually break.

> **Which Doculyze?** This describes the **code repo** at `C:\Users\jw300\Doculyze` (WSL: `/mnt/c/Users/jw300/Doculyze`). That is a different place from this vault's `Projects/Doculyze/`, which holds notes only. Every `C:\...` path below is in the code repo.

## The failure

```
Traceback (most recent call last):
  File "C:\Users\jw300\Doculyze\ingest-worker\src\ingest\parser-comparison.py", line 5, in <module>
    from ingest.parsers import PARSERS
ModuleNotFoundError: No module named 'ingest'
```

**Root cause:** `ingest` is never installed into the venv. There is no `pyproject.toml`, no `setup.py`, no editable install — it exists only as a source tree at `src\ingest\`. Running a file by path puts *that file's own directory* (`src\ingest\`) on `sys.path[0]`, which makes `parsers` importable but not `ingest.parsers`. The package's **parent** directory (`src\`) is what has to be on the path.

## The fix — a `.pth` file

Create one file, once:

- **Path:** `C:\Users\jw300\Doculyze\ingest-worker\.venv\Lib\site-packages\ingest_src.pth`
- **Contents:** a single line, with a trailing newline:

```
C:\Users\jw300\Doculyze\ingest-worker\src
```

Python appends every line of a `site-packages\*.pth` file to `sys.path` at interpreter startup, so `src\` is on the path for **every** run of that venv's interpreter.

## Usage after the fix

PowerShell, from `C:\Users\jw300\Doculyze\ingest-worker`:

```powershell
cd C:\Users\jw300\Doculyze\ingest-worker
.\.venv\Scripts\Activate.ps1

python -m ingest.consumer
python src\ingest\parser-comparison.py
python -m pytest tests
```

No `PYTHONPATH`, any cwd, any shell — including the VS Code Run button and debugger.

**`parser-comparison.py` must be run by path, not `-m`.** The hyphen makes `ingest.parser-comparison` an invalid module name. Sibling modules (`ingest.consumer`, `ingest.parsers`) are fine with `-m`.

## Verifying it

Run with `PYTHONPATH` explicitly stripped, so a leftover env var can't take the credit:

```bash
# WSL bash, cwd = /mnt/c/Users/jw300/Doculyze/ingest-worker
env -u PYTHONPATH ./.venv/Scripts/python.exe -c "import ingest, ingest.parsers; print('OK', ingest.__file__)"
# -> OK C:\Users\jw300\Doculyze\ingest-worker\src\ingest\__init__.py

cd /mnt/c && env -u PYTHONPATH '/mnt/c/Users/jw300/Doculyze/ingest-worker/.venv/Scripts/python.exe' \
  -c "import ingest.parsers as p; print('OK from any cwd:', len(p.PARSERS), 'parsers')"
# -> OK from any cwd: 11 parsers
```

## Dead ends

- **`cd`-ing into `src\ingest\` and running the file there** — same failure. Wrong directory on `sys.path`; see root cause above.
- **`PYTHONPATH=... ./.venv/Scripts/python.exe script.py` from a WSL shell, without `WSLENV`** — exact same traceback. The var is set in bash but never reaches the Windows process.
- **Assuming `-m` works for `parser-comparison.py`** — impossible, the hyphen is not a legal module name.
- **`pip install -e .`** — not available; there is no packaging config in `ingest-worker/`. This would be the more conventional fix if someone adds a `pyproject.toml`, and is worth doing eventually.
- **Suffixed `WSLENV` (`/p`, `/l`)** — would be actively wrong here. Those translate paths between WSL and Windows format, and the value being passed is already a Windows path, so a translating suffix mangles it. Bare name = pass through verbatim.

## Caveats

- **The `.pth` path is absolute.** Moving or renaming the repo breaks it — edit the one line.
- **`.venv/` is gitignored.** The `.pth` does not travel to another machine, and is lost whenever the venv is rebuilt. Recreating it is a manual step, not automatic.
- **The container is unaffected.** The Dockerfile still uses `ENV PYTHONPATH=/app/src` with `WORKDIR /app` and `CMD ["python","-m","ingest.consumer"]`. Nothing here changes it.
- **`tests/` never needed any of this.** `tests/conftest.py` does its own `sys.path.insert(0, ROOT/"src")` (and pins the Firestore/Storage emulator hosts). `python -m pytest tests` worked before the fix — and still needs the emulators running, per [[Python Ingest-Worker|Python Ingest-Worker]].

## Environment

| | |
|---|---|
| Venv | `C:\Users\jw300\Doculyze\ingest-worker\.venv` (Windows layout: `Scripts\`, `Lib\site-packages\`) |
| Interpreter | `.venv\Scripts\python.exe` → Python 3.11.9 |
| Base | WindowsApps `PythonSoftwareFoundation.Python.3.11` |
| WSL python | `/usr/bin/python3` → 3.8.10, bare (no `pymupdf4llm`). No Linux venv exists. |

**The Windows interpreter is mandatory**, for three independent reasons: it is the only venv with the dependencies; WSL's system Python is 3.8 and bare; and `parser-comparison.py` hardcodes absolute `C:\...` paths in `main()`, which a Linux interpreter cannot resolve regardless of deps. The third reason is specific to that script — the first two apply to the whole worker.

## Appendix — running from a WSL shell

Superseded by the `.pth` fix; kept because it explains the boundary. Only relevant when a **WSL shell launches a Windows interpreter** — irrelevant in a native Windows terminal.

```bash
cd /mnt/c/Users/jw300/Doculyze/ingest-worker
WSLENV=PYTHONPATH PYTHONPATH='C:\Users\jw300\Doculyze\ingest-worker\src' \
  ./.venv/Scripts/python.exe src/ingest/parser-comparison.py
```

A plain `VAR=x` exported in bash is **not** inherited by a Windows `.exe` launched from WSL. `WSLENV` is the allowlist naming which variables cross the boundary; the bare name (no `/p`, `/l`, `/u`) passes the value verbatim, which is what a Windows-format path needs. `PYTHONPATH` is single-quoted so bash does not eat the backslashes.

## Untested hypotheses

If the import still fails on Windows, these were suggested as *likely* causes but never confirmed against a live terminal — diagnose before trusting:

- `cmd.exe` `set PYTHONPATH="C:\...\src"` storing the quote characters as part of the value.
- The env var set in a different shell than the one running Python.
- The venv not activated.

## Sources

- Peer Claude session `doculyze-75` ("Run parser comparison script"), 2026-08-10 — diagnosed the failure, applied the `.pth` fix, and verified it.
