---
type: entity
aliases: ["Express"]
tags: [express, node, backend, framework, tool]
updated: 2026-06-02
sources: 2
---

# Express

A minimal Node.js web framework — the backend server in [[(C) Technology Architecture|Doculyze]], responsible for session creation and verification.

## Body parsing

```js
const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
```

- `express.json()` — parses JSON request bodies.
- `express.urlencoded({ extended: true })` — parses URL-encoded bodies (HTML form submissions sent as `application/x-www-form-urlencoded`), so Express can read `req.body` from POST requests.

## Role in Doculyze

Express owns the **authoritative** side of [[(C) Auth Architecture|Auth Architecture]]:

- `POST /api/session` — receives a [[(C) Firebase ID Token|Firebase ID Token]], verifies it via the [[(C) Firebase Admin SDK|Firebase Admin SDK]], and sets an HTTP-only [[(C) Session Cookies|session cookie]].
- `requireAuth` middleware — verifies the session cookie on every protected route (`verifySessionCookie`).
- `GET /api/session/verify` — returns `{ email, uid }` on 200, 401 if invalid.
- `POST /api/session/logout` — clears the session cookie (`res.clearCookie('session')`).

A `401` from any protected route is the single signal the frontend uses to reconcile its client auth state (see the `apiFetch` pattern in [[(C) Auth Architecture|Auth Architecture]]).

## Related

- [[(C) Firebase Admin SDK|Firebase Admin SDK]] · [[(C) Session Cookies|Session Cookies]] · [[(C) CSRF Protection|CSRF Protection]] · [[(C) Next.js|Next.js]] · [[(C) Auth Architecture|Auth Architecture]]
