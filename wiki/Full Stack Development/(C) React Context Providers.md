---
type: concept
aliases: ["React Context Providers", "Context Providers"]
tags: [react, nextjs, concept, state]
updated: 2026-06-02
sources: 1
---

# React Context Providers

Context providers share global state and logic across a component tree — themes, the current user's auth state, etc. They typically live near the application root.

## The Server Component catch

React context is **not supported in Server Components** (see [[(C) Server vs Client Components|Server vs Client Components]]). Creating a context at the App Router root would force the whole app to be a Client Component, or error.

**Solution:** create the context and render its provider inside a dedicated **Client Component** (`"use client"`), then wrap `{children}` with it in `layout.tsx`. The children can still be Server Components.

> **Rule:** every component that *consumes* `useContext` must be a Client Component. *Rendering* a provider from a Server Component is fine.

## In Doculyze

The `AuthProvider` (in `providers.tsx`) is a `"use client"` component holding `{ user, loading }` from [[(C) Firebase|Firebase]]'s `onAuthStateChanged`. It is the client UI source of truth only — **not** the security boundary (that's the [[(C) Session Cookies|session cookie]]). See [[(C) Auth Architecture|Auth Architecture]].

## Related

- [[(C) Server vs Client Components|Server vs Client Components]] · [[(C) Next.js|Next.js]] · [[(C) Auth Architecture|Auth Architecture]]
