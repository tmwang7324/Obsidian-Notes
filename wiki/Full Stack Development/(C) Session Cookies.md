---
type: concept
aliases: ["Session Cookies", "Cookies", "HTTP-only cookie"]
tags: [auth, concept, cookies, session]
updated: 2026-06-02
sources: 2
---

# Session Cookies

Cookies are small pieces of data a web server generates and sends to a browser — digital memory that lets sites remember login state, carts, and preferences. They store a limited amount of **user state** and are sent over the HTTP protocol ("HTTP cookies").

## HTTP-only

```
httpOnly: true
```

An **HTTP-only** cookie cannot be read by client-side JavaScript (`document.cookie` won't see it). This is its entire security purpose: it protects the session token from XSS theft.

> Consequence for the frontend: you **cannot** detect an HTTP-only session cookie from JS. The frontend instead asks the backend ("is my session valid?") or relies on [[(C) Firebase|Firebase]] client state for fast UI. This is the root reason [[(C) Auth Architecture|Auth Architecture]] uses two parallel systems.

## The session cookie in Doculyze

Created by [[(C) Express|Express]] (via [[(C) Firebase Admin SDK|Firebase Admin SDK]] `createSessionCookie`) after verifying a [[(C) Firebase ID Token|Firebase ID Token]]. It is:

- **HTTP-only** — backend reads it, JS can't.
- Checked for **existence** by Next.js middleware for route protection (the Edge runtime can't verify it cryptographically).
- **Verified** by `requireAuth` on protected Express routes.

Contrast with the **CSRF token** cookie, which is deliberately *readable* — see [[(C) CSRF Protection|CSRF Protection]].

## Related

- [[(C) CSRF Protection|CSRF Protection]] · [[(C) Firebase ID Token|Firebase ID Token]] · [[(C) Auth Architecture|Auth Architecture]] · [[(C) Express|Express]]
