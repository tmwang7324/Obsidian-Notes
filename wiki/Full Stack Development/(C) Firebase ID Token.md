---
type: concept
aliases: ["Firebase ID Token", "Firebase ID Tokens"]
tags: [auth, firebase, tokens, jwt]
updated: 2026-06-02
sources: 2
---

# Firebase ID Token

Created by [[(C) Firebase|Firebase]] when a user signs in. It is a signed [[(C) JWT|JWT]] that securely identifies a user in a Firebase project, carrying basic profile info including the user's unique `uid`. Because its integrity can be verified, it can be sent to a backend to identify the currently signed-in user — which the [[(C) Firebase Admin SDK|Firebase Admin SDK]] does in [[(C) Auth Architecture|Auth Architecture]].

## Where it lives

The ID token is the `accessToken` inside the Firebase client `User` object's `stsTokenManager`:

```json
{
  "uid": "CP2ngnngq7blOPSUJ0zgmjf2NL62",
  "email": "tmwang7324@gmail.com",
  "emailVerified": false,
  "stsTokenManager": {
    "refreshToken": "AMf-vBw...",
    "accessToken": "<the Firebase ID Token — a JWT>",
    "expirationTime": 1779824079895
  }
}
```

- **accessToken** = the Firebase ID Token (short-lived JWT, ~1 hour).
- **refreshToken** = long-lived token the client SDK uses to silently mint new ID tokens.

> Firebase auto-refreshes the ID token, so the client observer keeps reporting a valid user even after the backend [[(C) Session Cookies|session cookie]] expires. The only signal of an expired session is a backend `401` — see [[(C) Auth Architecture|Auth Architecture]] (Q9 / the `apiFetch` pattern).

## Acts as the access token

Because the Firebase ID Token already behaves as a short-lived access token, the idea of splitting the backend session into separate refresh/access tokens was **rejected** — it would duplicate what Firebase already provides.

## Identity Provider tokens (distinct)

Federated providers (Google, Facebook) issue their own tokens — often OAuth 2.0 access tokens. Apps verify those, then convert them into Firebase credentials. These are *not* the same as Firebase ID tokens.

## Related

- [[(C) JWT|JWT]] · [[(C) Tokens|Tokens]] · [[(C) Firebase|Firebase]] · [[(C) Firebase Admin SDK|Firebase Admin SDK]] · [[(C) Session Cookies|Session Cookies]] · [[(C) Auth Architecture|Auth Architecture]]
