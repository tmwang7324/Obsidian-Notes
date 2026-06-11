---
type: concept
aliases: ["CSRF Protection", "CSRF token", "Double-submit cookie"]
tags: [auth, concept, security, csrf]
updated: 2026-06-02
sources: 1
---

# CSRF Protection

A **CSRF (cross-site request forgery)** attack tricks a logged-in user's browser into making an unwanted request to your backend. Because browsers **automatically attach cookies** to requests, a malicious site can ride on an existing [[(C) Session Cookies|session cookie]]. A CSRF token proves a request actually originated from *your* frontend.

## Double-submit cookie pattern

1. Backend generates a `csrfToken` and sets it as a **readable** (non-HTTP-only) cookie.
2. Frontend reads it (e.g. a `getCookie` helper).
3. Frontend sends it in a request header (`CSRF-Token: <value>`).
4. Backend compares the header value against the cookie value — if they match, accept the request.

```ts
function getCookie(name: string) {
  const cookie = document.cookie.split("; ").find(row => row.startsWith(`${name}=`));
  return cookie ? decodeURIComponent(cookie.split("=")[1]) : null;
}
```

> `getCookie` is **not** a Firebase API — it's a helper you write yourself.

## Two cookies, two jobs

| Cookie      | HTTP-only | Purpose                                       |
| ----------- | --------- | --------------------------------------------- |
| `session`   | ✅ Yes     | Authenticates the user — backend reads only   |
| `csrfToken` | ❌ No      | Proves request origin — frontend must read it |

## Related

- [[(C) Session Cookies|Session Cookies]] · [[(C) Auth Architecture|Auth Architecture]] · [[(C) Express|Express]]
