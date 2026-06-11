---
type: concept
aliases: ["Rendering Strategies", "SSR vs CSR", "Dynamic vs Static Rendering"]
tags: [nextjs, react, concept, rendering, ssr]
updated: 2026-06-02
sources: 2
---

# Rendering Strategies

How and when HTML is produced. [[(C) Next.js|Next.js]] supports several; the choice affects freshness, SEO, and cost.

## Server-Side Rendering (SSR)

The server runs the code, fetches data, builds the HTML on the fly, and sends a fully rendered page that the browser then **hydrates**.

- **Pros:** always-fresh content that can adapt per-user (cart, account); fast initial paint; good SEO (crawlers see real HTML).
- **Cons:** needs a server/serverless function; slightly slower time-to-first-byte than a static file.

## Client-Side Rendering (CSR)

UI is built in the browser. In the Next.js App Router, Client Components are still **pre-rendered to static HTML on the server**, then made interactive in the browser.

- **Pros:** rich interactivity / dynamic content behind auth walls; SEO less important.
- **Cons:** slower to first meaningful render — the browser loads a near-blank shell, then populates it.

## Static vs Dynamic rendering

- **Static** — pre-built HTML files (build time).
- **Dynamic** — HTML generated on the server at request time. In Next.js, calling `cookies()` or `headers()` in a Server Component **opts the page into dynamic rendering** (see [[(C) Server vs Client Components|Server vs Client Components]]).

## Hydration

Hydration is the browser attaching React's interactivity (event listeners, state) to server-rendered static HTML. *(Open learning thread: "learn what hydration means fully" — to be expanded.)*

## Related

- [[(C) Server vs Client Components|Server vs Client Components]] · [[(C) Next.js|Next.js]] · [[(C) Auth Architecture|Auth Architecture]]
