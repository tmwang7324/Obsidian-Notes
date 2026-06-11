---
type: synthesis
aliases: ["Technology Architecture"]
tags: [doculyze, architecture, nextjs, express, firebase]
updated: 2026-06-02
sources: 2
---
z
# Technology Architecture

The planned frontend/backend shape of [[CLAUDE|Doculyze]]. Companion to [[(C) Auth Architecture|Auth Architecture]], which covers the authentication design in depth.

## Frontend

- [[(C) Next.js|Next.js]] (App Router) with **Zustand** for state management.
- A thin client auth context (the global user context) for live UI convenience only — **not** the source of truth (see [[(C) React Context Providers|React Context Providers]]).

## Backend

- Server Actions in `app/actions.tsx`.
- Route Handlers.
- [[(C) Express|Express]] + [[(C) Firebase Admin SDK|Firebase Admin SDK]] for authoritative session handling.

> Open question from the notes: because ChromaDB only supports FastAPI and LangChain is primarily Python, the backend language for the document-analysis/AI layer is still undecided.

## Authentication flow (summary)

1. Use [[(C) Firebase|Firebase]] client auth **only** to register, sign in, and refresh identity — then drop the browser session immediately.
2. Exchange that identity (a [[(C) Firebase ID Token|Firebase ID Token]]) for a server-readable [[(C) Session Cookies|session cookie]] (HTTP-only), created and verified by Server Actions.
3. Let Next.js Server Components, middleware, and backend routes read that session for protected data and initial rendering. **Key:** Next.js can verify the shared session cookie itself, so it doesn't ping Express on every action.
4. Keep a thin client auth context only for live UI convenience.

The full design, decision log, and race conditions are in [[(C) Auth Architecture|Auth Architecture]].

## Related

- [[(C) Auth Architecture|Auth Architecture]] · [[(C) Next.js|Next.js]] · [[(C) Express|Express]] · [[(C) Firebase|Firebase]]
