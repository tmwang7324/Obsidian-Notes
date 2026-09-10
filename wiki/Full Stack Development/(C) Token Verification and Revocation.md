---
type: concept
aliases: ["Token Verification and Revocation", "Token Storage and Transport", "Revocation Window"]
tags: [auth, tokens, jwt, sessions, security, concept]
updated: 2026-08-09
sources: 1
---

# Token Verification and Revocation

Why the access/refresh split exists, where tokens are allowed to live, and what it actually costs to ask "is this session still valid?" Extends [[(C) Tokens|Tokens]] with the *mechanics* the base page leaves implicit.

**Thesis:** the dual-token system is not about carrying identity. It is the trick that buys you **stateless fast verification on every request** *and* **the ability to kill a session** — two things that are otherwise mutually exclusive.

## 1. Role, storage, and transport are three separate axes

"Access token" names a **role**, not a location. It says nothing about where the token is kept or how it travels. Conflating these is the usual source of confusion.

| Axis | Options |
|---|---|
| **Role** | access (short-lived, proves identity per request) · refresh (long-lived, mints new access tokens) |
| **Storage** | JS memory · `localStorage` · IndexedDB · **cookie** |
| **Transport** | manual `Authorization: Bearer` header · automatic cookie attachment |

Consequence: **a dual-token system can live entirely in cookies.** Nothing about the access-token role implies browser-facing JavaScript.

## 2. Why the split exists — revocation, not identity

A common misreading is that the refresh token is the "central record" that lets access tokens carry the user ID. It isn't. A [[(C) JWT|JWT]] access token is self-describing — the `sub` claim carries the `uid` on its own. Delete the refresh token entirely and access tokens still identify the user.

The real reason:

> **You cannot revoke a stateless JWT.** Verification is offline — the API checks a signature and never asks a database "is this still good?" That is what makes it fast, and it is also why a leaked token stays valid until it expires.

So the design compensates:

1. Make access tokens **short-lived** (5–60 min) to bound the blast radius of a leak.
2. That alone would log users out constantly — so add a **long-lived refresh token** that *is* stateful (a DB row), used only against the auth endpoint.
3. Revocation now has a home: delete the row, and the session dies within one access-token lifetime.

What *is* true about identity: you need a **stable, static user identifier** — the `uid` / `sub`. It never changes across rotations (new access token hourly, same `uid` forever) and it is the join key into your own data. In Doculyze that is the `userId` on `documents/{docId}` and the value the Chroma tenant gateway filters on.

## 3. Storage and the XSS ↔ CSRF tradeoff

You do not get both. You pick an attack surface and mitigate it.

| Storage | Safe from | Vulnerable to | Mitigation |
|---|---|---|---|
| JS-readable (`localStorage`, IndexedDB, memory) | **CSRF** — the header is attached manually, so a cross-site request can't forge it | **XSS** — any injected script reads and exfiltrates the token | CSP, output escaping; keep in memory only so it dies on reload |
| **HttpOnly cookie** | **XSS theft** — JS cannot read `document.cookie` | **CSRF** — the browser attaches cookies automatically, including on attacker-triggered requests | `SameSite` + double-submit token — see [[(C) CSRF Protection\|CSRF Protection]] |

### The all-cookie dual-token setup

```
Set-Cookie: access_token=eyJ...;  HttpOnly; Secure; SameSite=Lax;
            Path=/;               Max-Age=900          ← 15 min

Set-Cookie: refresh_token=eyJ...; HttpOnly; Secure; SameSite=Strict;
            Path=/auth/refresh;   Max-Age=2592000      ← 30 days
```

Both HttpOnly, so JS can read neither — nothing for an XSS payload to steal. The elegant detail is `Path=/auth/refresh`: browsers only send a cookie to matching paths, so the **long-lived, high-value credential is off the wire on every request except the one endpoint that mints new access tokens.**

## 4. Verification economics — why access checks are cheap

Cheapness is **not intrinsic to the token**. Both are just strings; neither is inherently harder to verify. The asymmetry is in *what you choose to check*.

**Access token:**
```
recompute signature over header.payload   → CPU, microseconds
check exp / iss / aud                     → CPU
done
```
Pure computation. No I/O, no network, no shared state.

**Refresh token:**
```
look up the token in the session store    → I/O, network round-trip
is this session still live?               → authoritative current state
```
The expensive part isn't parsing. It's that it answers *"has this been revoked?"* — a fact about **current server state**, which by definition cannot be encoded in a token minted in the past.

**Access verification is cheaper because it deliberately checks less.** It skips the revocation question and knowingly accepts a stale answer in exchange for zero I/O. You *could* make a refresh token a stateless JWT and verify it just as fast — but then you couldn't revoke it, destroying the only reason it exists. It is *deliberately* stateful.

### Why the trade works: frequency

| | verified how often | check cost | affordable? |
|---|---|---|---|
| Access token | **every API request** — hundreds/sec | must be ~0 | a DB hit here makes the auth store a bottleneck for the whole system |
| Refresh token | **once per access-token lifetime** — every 15–60 min per user | can be expensive | ~1/200th the volume; a lookup is nothing |

Put the **expensive, authoritative** check at the rare event and the **cheap, approximate** check at the frequent one.

### The revocation window

The price of that trade: after you kill a session, it stays alive until the current access token expires.

> **The access token's lifetime *is* your revocation window.** "15 minutes" is not arbitrary — it is a decision about how long you are willing to be wrong about whether a session is still valid.

### Wrinkle: refresh tokens often aren't JWTs

Commonly just a high-entropy random string stored **hashed** in the DB. If you're doing a lookup anyway the token needn't *carry* anything — the row holds the uid, expiry, device info. No signature to verify at all. So refresh verification is conceptually *simpler* (hash + indexed lookup) but operationally *more expensive* (I/O against shared state).

## 5. Firebase does not remove the dual-token system — it operates it

The correction that matters. Firebase **is** dual-token rotation; Google just runs it for you. It is visible in the client `User` object (see [[(C) Firebase ID Token|Firebase ID Token]]):

```json
"stsTokenManager": {
  "refreshToken": "AMf-vBw...",           // long-lived, stateful, revocable
  "accessToken":  "<Firebase ID Token>",  // short-lived JWT, ~1 hour
  "expirationTime": 1779824079895
}
```

The client SDK silently POSTs the refresh token to `securetoken.googleapis.com` every ~55 minutes to mint a fresh ID token — textbook rotation running under the app.

So the accurate statement is **not** "with Firebase I don't need dual tokens" but *"with Firebase I don't need to **build** dual tokens."* What was correctly rejected for Doculyze was building a **second, custom** access/refresh pair on top of the one Google already runs — that would be duplication. The mechanism itself is very much present.

**Firebase's own pair is browser-faced and JS-readable** — stored in IndexedDB (localStorage in older SDK versions), retrieved via `getIdToken()`, attached manually as `Authorization: Bearer`. Nothing is HttpOnly. That is a real XSS surface, and it is *why* the session-cookie pattern exists as an alternative.

### The session cookie is the move into cookie-land

```
client signs in       → SDK holds refresh + ID token in IndexedDB
POST idToken ONCE     → your server
server                → createSessionCookie(idToken, { expiresIn: 14d })
                      → Set-Cookie: HttpOnly; Secure; SameSite
every later request   → verifySessionCookie(cookie, checkRevoked)
```

The session cookie **collapses both roles into one credential**: long-lived like a refresh token, yet verified directly on each request like an access token. Firebase gets away with the collapse because signature verification stays cheap (cached Google public certs) *and* `checkRevoked` provides the stateful check on demand — which is precisely what the split was buying.

### Firebase exposes the tradeoff as a literal boolean

The cleanest proof of §4 — same token, same function, the only difference is whether you ask the revocation question:

```js
verifyIdToken(token)         // signature check vs cached Google public certs.
                             // Local CPU. Fast. No revocation check.

verifyIdToken(token, true)   // ↑ PLUS a lookup against the user record to
                             // check revocation. Network round-trip.
```

The [[(C) Firebase Admin SDK|Admin SDK]] caches Google's signing certs (they rotate ~daily, honoring `Cache-Control`), so the default path is local CPU after the first fetch. Same parameter on `verifySessionCookie(cookie, checkRevoked)`. Server-side revocation is triggered by `revokeRefreshTokens(uid)`.

## 6. What this means for Doculyze

**Two systems run in parallel** — which is exactly what [[(C) Auth Architecture|Auth Architecture]] already names as the two-parallel-systems split:

| System | Storage | Role | Authority over |
|---|---|---|---|
| Client Firebase SDK | IndexedDB, JS-readable, auto-rotating hourly | refresh + ID token | **UI only** — "is someone signed in? show their email" |
| Session cookie | HttpOnly, server-verified | collapsed access+refresh | **data access** at the Next.js server-action boundary |

This explains the **401 reconciliation problem** flagged in Auth Architecture (Q9 / the `apiFetch` pattern): the client SDK keeps refreshing forever, so the UI insists the user is signed in — while the server-side session cookie has expired. Two independent lifetimes, no shared clock. **The only honest signal is a backend `401`.**

**Open decision — `checkRevoked` policy.** With Express retired and every Next.js server action verifying the session cookie itself, `checkRevoked: true` on every action means a Firebase round-trip per data access. The usual answer is `false` on ordinary reads and `true` on anything sensitive or state-changing: accept a bounded staleness window where it's cheap, pay for certainty where it matters. Not yet decided or recorded — [[(C) Architecture|Doculyze Architecture]] still describes the Express-era design where Express "mediates all data access."

## Related

- [[(C) Tokens|Tokens]] · [[(C) JWT|JWT]] · [[(C) Firebase ID Token|Firebase ID Token]] · [[(C) Session Cookies|Session Cookies]] · [[(C) CSRF Protection|CSRF Protection]] · [[(C) Firebase Admin SDK|Firebase Admin SDK]] · [[(C) Authentication vs Authorization|Authentication vs Authorization]] · [[(C) Auth Architecture|Auth Architecture]] · [[(C) Architecture|Doculyze Architecture]]

## Sources

- Query session 2026-08-09 — dual-token purpose, cookie vs browser-side storage, and why access-token verification is cheaper than refresh-token verification.
