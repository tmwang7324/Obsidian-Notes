# Overview
**Capture job applications at submit time in the browser, store them as notes in this vault, and let an email poller track what happens to them afterward.**

Originally scoped as "scrape confirmation emails into a Google Sheet." That was abandoned: confirmation emails don't contain the job link or the JD, and the posting is usually dead by the time you'd want to reread it. Capture has to happen at the browser, at submit.

Framing: **utility, but a learning experience.** Not a portfolio piece. Optimize for "still running untouched in a year," not for architecture to talk about.

***App Password:*** namg uoyy rrjn tvdh

---

## Architecture

Two sources, **different jobs** — not redundant detectors.

|                       | Owns      | Gives you                                    |
| --------------------- | --------- | -------------------------------------------- |
| **Browser extension** | Creation  | URL, JD snapshot, company, role, timestamp   |
| **IMAP poller**       | Lifecycle | status changes — rejected, screen, interview |

Email never creates records in the happy path. It finds an existing note and updates it.

```
Chrome (Windows)                    Docker container (WSL2)
┌──────────────────┐                ┌────────────────────────┐
│ content script   │                │  HTTP server :8000     │
│  - liberal buffer│  POST /capture │    └─ writes note       │
│  - submit detect ├───────────────►│                        │      ┌─────────────┐
│  - toast confirm │  (queued in    │  IMAP poller (15 min)  ├─────►│ C:\Obsidian │
│                  │   chrome.      │    └─ classify → match │ bind │   Vault     │
│ chrome.storage   │   storage,     │       → update note    │ mount└─────────────┘
│  (offline queue) │   retried)     │                        │
└──────────────────┘                └────────────────────────┘
```

---

## Decisions

### Store — Obsidian notes, one per application
Not a Sheet, not SQLite. Reasons:
- The JD needs a home. A 5,000-word posting has no place in a spreadsheet cell; a note body is exactly right.
- **Bases** (core plugin, already enabled) renders an editable table over frontmatter — the spreadsheet ergonomics, without the spreadsheet. Dataview is read-only; Bases is not. *Inline property editing verified working 2026-08-06.*
- Writing a record = writing a text file. No API, no OAuth, no rate limits, no migrations.
- Already in this vault daily. A Sheet you have to remember to open is a Sheet you stop trusting.

**Rule: one store, edited directly by humans.** No machine store + human mirror with sync between them. That's the trap that turns a weekend utility into a six-month conflict-resolution bug.

### Identity — human filename, machine frontmatter
Filename: `2026-08-05 Stripe — Backend Engineer.md` — cosmetic, rename it freely.

The poller reads `company_key` and `role` from **frontmatter**, never by parsing the filename. Two reasons: company names break filename parsing (`Johnson & Johnson`, `H-E-B`, `Engineer, Backend (L4)`), and you chose this store so you could hand-edit it — so nothing machine-critical may live in a string you might edit.

```yaml
---
id: 01J8FQ2K7XN3        # stable, survives renames
company: Stripe
company_key: stripe     # normalized, for matching
role: Backend Engineer
url: https://boards.greenhouse.io/stripe/jobs/4012
ats: greenhouse
applied: 2026-08-05
status: applied
last_update: 2026-08-05
source: extension       # or: backfill — lower fidelity, exclude from stats
---

## Job Description
<Readability-extracted snapshot>

## Timeline
- 2026-08-05 — applied
```

### Status — minimal states + timeline
`applied` → `screen` / `interview` → `offer` / `rejected`

`ghosted` is **derived**, not written — anything at `applied` with no update in 30 days, as a Bases filter. Nobody sends a ghosting email.

Frontmatter `status` is the current value (Bases sorts on it); `## Timeline` in the body is the history. Denormalized on purpose — one writer, and it buys response rate and time-to-rejection, which a single overwritten field can't answer.

### Detection — DOM heuristic + manual, both behind a toast
`MutationObserver` watching for "thank you for applying" / "application submitted" / "we've received your application." No per-ATS selector list, and it generalizes to no-name career pages.

**Bias to recall, not precision.** A missed capture is unrecoverable — the JD is gone, which is the whole point of the project. A false positive is a note you delete in two seconds.

Then precision stops mattering: on detection, show a **toast with extracted company/role + Save/Dismiss**. False positives cost one click, you correct mangled fields while you still remember, and the manual path is the same code path with less pre-filled.

### Capture — liberal per-tab buffer, filter at commit
The confirmation page has no JD. So the extension is a **buffer with a commit trigger**, not a detector.

Keep a rolling snapshot of the last ~5 pages per tab in `chrome.storage.session` (memory only, never disk, evicted on tab close). On submit-detect, look *backward* and pick which one was the posting.

Why commit-time: at capture time you're guessing blind. At commit time you know a submission happened, and the confirmation page tells you the company and role — so "which of these 5 pages mentions Stripe and has 'Responsibilities'?" replaces "is this random page a job posting?" The information arrives *after* the moment you'd have had to decide, so delay the decision.

Use **Mozilla Readability.js** for JD extraction — single bundled file, what Firefox Reader Mode uses, zero per-ATS maintenance.

### Email — IMAP, polling
Chosen over Gmail API for simplicity. No GCP console, no OAuth consent screen, no refresh-token expiry gotcha. `imap-tools`, App Password, `X-GM-LABELS` to label processed mail (`jobtracker/matched`, `jobtracker/unmatched`) — the processing log lives in Gmail, visible and searchable, no state file.

**No real-time.** A rejection found four hours late costs nothing. This kills Pub/Sub, IDLE, and webhooks — every option whose value is latency.

Tradeoff accepted: IMAP has no read-only mode. The App Password is full mailbox access, forever, until revoked. Keep it in a gitignored `.env`, never in the image.

Coarse filtering belongs in **Gmail, not Python** — a Gmail filter labels likely job mail, the poller reads only that label. Misclassifications get fixed by editing a filter in a UI, not by redeploying.

*Prereq: verify App Passwords generate on the account (needs 2FA; some Workspace admins disable them).*

### Classification — rules first
Rejection emails are formulaic: "unfortunately", "move forward with other candidates", "will not be proceeding". ~20 lines of regex.

**No LLM on day one.** Unmatched mail already goes to the queue note — so run it two weeks and *read the queue*. Empty means it was never needed; full means you now have a labeled set of the failures that actually occur, which is both the justification and the eval set. Building the LLM path first means guessing at a failure distribution you haven't observed.

### Matching — company + role, refuse when ambiguous
Rejection emails carry only company + role. `ats_id` and `url` are near-useless for lifecycle matching — they don't appear.

On ambiguity (four Stripe applications, one "Backend Engineer" rejection): **write nothing, queue it.** `Unmatched Email Queue.md`, one entry per unresolved email — subject, sender, date, and wikilinks to the candidate notes. Resolve by clicking a link and editing. The resolution tool is Obsidian itself; there's no UI to build.

> A tracker that's occasionally incomplete is fine. One that confidently marks the wrong job rejected is worse than no tracker.

### Runtime — Docker, port published, vault bind-mounted
`restart: unless-stopped` + Docker Desktop on login = it comes back after every reboot. Once it's always up, the poller is a `while True: sleep(900)` inside the app — no cron, no Windows Task Scheduler, no WSL-is-asleep problem.

That reliability is the actual reason to containerize here, not reproducibility.

- `-p 8000:8000` — reachable from Windows `localhost`, Chrome hits it directly
- `-v "/mnt/c/Obsidian Vault:/vault"` — Obsidian on Windows sees new files natively
- **inotify does not cross that mount.** Never build a file-watcher on the vault; it fails *silently*, no error. Not a constraint in practice — the poller re-reads the folder every cycle to match emails anyway.
- **Don't containerize during development.** venv until it works end to end, then containerize as the deployment step. Docker rebuilds in the inner loop tax exactly the part where you're learning how ATS pages and rejection emails are actually shaped.

### Loss-proofing
The extension writes to `chrome.storage` **first, always**, and flushes to the server when it can reach it. Container down, Docker not started, laptop rebooting — capture never depends on the server. Only sync does.

---

## Build order

1. **Note schema + writer** — pure function, no browser, no email. Testable alone.
2. **Extension, manual capture only** → toast → POST → note appears. End-to-end skeleton via the least fragile path.
3. **Liberal buffer + auto-detection.** Now the fragile part lands in a system that already works.
4. **IMAP poller** — rules classifier, matcher, queue note.
5. **Bases view** over the applications folder.
6. **Containerize.**
7. Backfill — *handling separately.*

## Open
- Backfill of historical applications — out of scope here, handling separately
- Confirm App Passwords generate on the account before step 4
- Company-name normalization rules (`Acme Inc.` / `Acme` / `acme.hire.ashbyhq.com` → `acme`) — the annoying part of matching
