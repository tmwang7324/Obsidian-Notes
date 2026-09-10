---
type: next-step
project: Doculyze
status: done
effort: S
aliases:
  - Dashboard Loading and Error States
tags:
  - next-step
  - doculyze
updated: 2026-06-25
---

# (C) Dashboard Loading and Error States

**Next step.** The dashboard page (`app/(protected)/dashboard/page.tsx`) is now an async **Server Component** that `await`s `listDocuments()` directly. Because it renders once on the server, the old client-side `loading` / `error` `useState` branches no longer apply. Add the idiomatic sibling files in `app/(protected)/dashboard/`:

- `loading.tsx` — Next wraps the page in a `<Suspense>` boundary and shows this while the async page resolves.
- `error.tsx` (must be `"use client"`) — catches anything `listDocuments()` throws, including the "User is not authenticated" error from `requireUid`.

- **Effort:** S — two small scaffold files, no new logic.
- **Surfaced by:** server-component rewrite of the dashboard (2026-06-25 session).


