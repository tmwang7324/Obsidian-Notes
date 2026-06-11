---
type: concept
aliases: ["Server vs Client Components", "Client vs Server Components"]
tags: [nextjs, react, concept, rendering]
updated: 2026-06-02
sources: 2
---

# Server vs Client Components

In the [[(C) Next.js|Next.js]] App Router, components are **Server Components by default**. Add `"use client"` at the top of a file to opt into a Client Component (needed for any browser-only feature — state, effects, event handlers, context).

## Capability matrix

| Feature | Client | Server | Notes |
|---|:--:|:--:|---|
| `useRouter`, `usePathname` | ✅ | ❌ | Client-side navigation/route info |
| `useContext` | ✅ | ❌ | Reads a React context provider |
| `useState` / `useEffect` / `useRef` | ✅ | ❌ | Local state, effects, refs |
| `useCallback` / `useMemo` | ✅ | ❌ | Memoization |
| `onClick` / `onSubmit` / event handlers | ✅ | ❌ | Browser events |
| `action` (Server Actions) | ✅ | ✅ | Definable in/passed to either |
| `async/await` (direct) | ❌ | ✅ | Server components are async by default |
| Database / backend access | ❌ | ✅ | Safe to query DB or call internal services |
| Secret env variables | ❌ | ✅ | Vars without `NEXT_PUBLIC_` are server-only |
| `cookies()` / `headers()` | ❌ | ✅ | Reading them opts the page into dynamic rendering |
| `fetch` with caching | ❌ | ✅ | Next extends `fetch` with `cache`/`revalidate` |
| SEO / initial HTML | ❌ | ✅ | HTML rendered on the server, visible to crawlers |

## Provider vs consumer rule

> **Rendering** a context provider from a Server Component is allowed. **Reading** context with `useContext` requires a Client Component.

Nested components don't automatically inherit `"use client"`. A Client parent converts child Server components into Client components **unless** the child is passed through the `children` prop — then the Server component still renders on the server. This is how Doculyze keeps secret-data Server Components inside a client `AuthProvider` (see [[(C) React Context Providers|React Context Providers]]).

For auth: use context only for small UI changes (login button, avatar). For protected data, read and verify the [[(C) Session Cookies|session cookie]] directly in a Server Component:

```ts
const session = cookieStore.get("session")?.value;
const user = await adminAuth.verifySessionCookie(session);
```

## Related

- [[(C) React Context Providers|React Context Providers]] · [[(C) Rendering Strategies|Rendering Strategies]] · [[(C) Next.js|Next.js]] · [[(C) Auth Architecture|Auth Architecture]]
