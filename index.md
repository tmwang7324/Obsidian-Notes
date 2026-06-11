# Index

Catalog of every wiki page, grouped by category — mirroring the `wiki/` subfolders. The LLM updates this on every ingest. When answering a query, read this first to find relevant pages, then drill in. See `log.md` for the change timeline and the root `CLAUDE.md` for how the vault works.

_Last updated: 2026-06-11 · 37 pages_

## Projects

Read the project **overview** first; drill into the project directory only if the wiki isn't comprehensive enough.

| Page | Summary |
|---|---|
| [[(C) Doculyze\|Doculyze]] | **Overview** — AI Document Analysis app; stack, central auth design, status |
| [[(C) Auth Architecture\|Auth Architecture]] | The two-parallel-systems auth design — flows, decisions, 401 reconciliation |
| [[(C) Technology Architecture\|Technology Architecture]] | Planned frontend/backend shape for Doculyze |
| [[(C) Obsidian Configs\|Obsidian Configs]] | **Overview** — vault infrastructure & maintenance: LLM Wiki Pattern, conventions, `/daily-plan` design (locked), theming |
| [[(C) Architecture\|Obsidian Configs Architecture]] | Current-state map of the vault's knowledge system — the three layers, maintaining skills, capture flow |
| [[(C) Decisions in the Wiki\|Decisions in the Wiki]] | **Decision** — decisions+rationale are durable wiki content; per-project folders; immutable ADR shape |
| [[(C) Decision Capture Pipeline\|Decision Capture Pipeline]] | **Decision** — the `**Decision**` marker; `synthesize` authors ADRs; `record-progress` links up |
| [[(C) Archive Not Delete\|Archive Not Delete]] | **Decision** — never delete source notes; archive fully-processed ones to `Ideas/Archive/` |
| [[(C) Dashboard v1 Design\|Dashboard v1 Design]] | **Decision** — dashboard substrate (MCL + `dataviewjs`), v1 widgets, layout, Bases launcher |
| [[(C) Pomodoro Timer Placement\|Pomodoro Timer Placement]] | **Decision** — pomodoro in a pinned sidebar note, not the dashboard; `localStorage` state tier |
| [[(C) Recent Files Widget Scope\|Recent Files Widget Scope]] | **Decision** — the Recently-modified widget excludes `(C)` files |
| [[(C) Golf\|Golf]] | **Overview** — deliberate practice across driving, irons, short game, putting |

## Full Stack Development

### Tools & platforms

| Page | Summary |
|---|---|
| [[(C) Next.js\|Next.js]] | React framework — routing, navigation, Server/Client split, backend |
| [[(C) Express\|Express]] | Node backend — body parsing, the authoritative session endpoints |
| [[(C) Firebase\|Firebase]] | Google BaaS — client auth, the `auth` object, services |
| [[(C) Firebase Admin SDK\|Firebase Admin SDK]] | Server-side Firebase — verifies tokens, mints session cookies |

### Identity & tokens

| Page | Summary |
|---|---|
| [[(C) Authentication vs Authorization\|Authentication vs Authorization]] | Who you are vs what you can do |
| [[(C) Tokens\|Tokens]] | Credentials that carry identity/authorization; access tokens |
| [[(C) JWT\|JWT]] | Signed JSON token format; header.payload.signature |
| [[(C) Firebase ID Token\|Firebase ID Token]] | The signed JWT proving a Firebase user; acts as access token |

### Sessions & security

| Page | Summary |
|---|---|
| [[(C) Session Cookies\|Session Cookies]] | HTTP-only cookies; why JS can't read them |
| [[(C) CSRF Protection\|CSRF Protection]] | Double-submit cookie pattern; session vs csrf cookie |

### Rendering

| Page | Summary |
|---|---|
| [[(C) Server vs Client Components\|Server vs Client Components]] | Capability matrix; provider vs consumer rule |
| [[(C) Rendering Strategies\|Rendering Strategies]] | SSR vs CSR, static vs dynamic, hydration |
| [[(C) React Context Providers\|React Context Providers]] | Global state; the Server Component catch |

## Obsidian

| Page | Summary |
|---|---|
| [[(C) Dataviewjs Render State\|Dataviewjs Render State]] | Why one throwing Dataview block breaks every query (`p is not a function`) — shared Preact instance; reload to recover |
| [[(C) Dataviewjs State Persistence\|Dataviewjs State Persistence]] | Why in-memory state doesn't survive a note switch — each render is stateless; persist via `localStorage`/frontmatter |
| [[(C) Pomodoro Timer (DataviewJS)\|Pomodoro Timer (DataviewJS)]] | Persistent countdown — store end-timestamp not remaining; `window` interval + OS notification alert across note switches |
| [[(C) cssclasses Containment\|cssclasses Containment]] | `cssclasses:` brands the note wrapper so descendant selectors scope styling to one note |
| [[(C) Callout Metadata\|Callout Metadata]] | `[!type\|meta]` → `data-callout-metadata` CSS attribute for per-block targeting |
| [[(C) MCL Multi-Column Layout\|MCL Multi-Column Layout]] | Modular CSS Layout multi-column callouts — responsive columns from `[!multi-column]` |
| [[(C) Bases Launcher\|Bases Launcher]] | Obsidian Bases as a launcher — `base` codeblock vs `.base`, `type == overview` filtering |

## Programming

| Page | Summary |
|---|---|
| [[(C) Python Counter\|Python Counter]] | `collections.Counter` — counts item frequencies as a dict subclass |

## Golf

| Page | Summary |
|---|---|
| [[(C) Iron Swing\|Iron Swing]] | Iron technique cues — shoulder-led takeaway, late wrist hinge, bent lead arm, invisible wall |

## Reading

| Page | Summary |
|---|---|
| [[(C) Poor Charlie's Almanack\|Poor Charlie's Almanack]] | Charlie Munger — polymath, latticework of mental models, "modern-day Ben Franklin" |
| [[(C) Vocabulary\|Vocabulary]] | Reusable terms — Social Security Act, FICA, Stentorian Admonishment, Backlog, Derived Task |

## Meta

| Page                                       | Summary                                           |
| ------------------------------------------ | ------------------------------------------------- |
| [[(C) LLM Wiki Pattern\|LLM Wiki Pattern]] | How this second brain is organized and maintained |
