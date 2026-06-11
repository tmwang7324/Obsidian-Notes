---
type: entity
aliases: ["Next.js"]
tags: [nextjs, react, frontend, framework, tool]
updated: 2026-06-02
sources: 3
---

# Next.js

An open-source web framework built on **React** for high-performance full-stack apps (deployable on Vercel). You build components/UI with React; Next.js adds lower-level tooling — bundlers, compilers — plus routing, rendering strategies, and a backend layer on the same port.

## Creating an app

`npm create next-app` (uses `create-next-app`, sets everything up). Minimum browsers: Chrome/Edge/Firefox 111+, Safari 16.4+.

## Frontend (App Router)

**Pages & routes** — under `app/`, each folder is a route; the rendered component file **must** be named `page.tsx`. So `app/login/page.tsx` → `localhost:3000/login`.

**Layouts** — render once on first load; used for persistent global UI like a navbar.

**Navigation** (`next/navigation`, Client Components only):

| Hook                | Use                                                            |
| ------------------- | -------------------------------------------------------------- |
| `useRouter()`       | Programmatic navigation after logic (e.g. post-login redirect) |
| `usePathname()`     | Current path (e.g. highlight active nav link)                  |
| `useSearchParams()` | Read query params                                              |
| `useParams()`       | Read dynamic segments (e.g. `[documentId]`)                    |

Prefer `<Link>` for clickable links; use `router.push()` only in event handlers / after async logic. `router.refresh()` re-runs Server Components after a mutation without a full reload.

**Server-Component navigation** (no hooks): `redirect()`, `permanentRedirect()`, `notFound()`, `<Link>`, and the `params` / `searchParams` props.

## Backend

Next.js ships a backend on the same port as the frontend.

- **Server Actions** — great for Create/Update/Delete, not for reading/fetching.
- **Route Handlers** — API endpoints.

## Rendering model

Next.js distinguishes [[(C) Server vs Client Components|Server vs Client Components]] and [[(C) Rendering Strategies|Rendering Strategies]] (SSR vs CSR, static vs dynamic). Reading `cookies()` / `headers()` opts a page into dynamic rendering.

## Role in Doculyze

The frontend. Middleware (`middleware.ts`) checks the [[(C) Session Cookies|session cookie]] for route protection; Server Components verify the cookie for protected data; a `"use client"` `AuthProvider` holds client auth state. See [[(C) Auth Architecture|Auth Architecture]].

## Related

- [[(C) Server vs Client Components|Server vs Client Components]] · [[(C) Rendering Strategies|Rendering Strategies]] · [[(C) React Context Providers|React Context Providers]] · [[(C) Express|Express]] · [[(C) Auth Architecture|Auth Architecture]]
