---
type: concept
aliases: ["JWT", "JSON Web Token"]
tags: [auth, concept, tokens, jwt]
updated: 2026-06-02
sources: 1
---

# JWT (JSON Web Token)

A **signed** token format that securely encodes claims (e.g. user identity) as JSON. Because a JWT's integrity can be cryptographically verified, a server can trust its contents without a database lookup.

A JWT has three dot-separated parts: **header.payload.signature** (Base64URL-encoded). The signature lets any holder of the signing key verify the token wasn't tampered with.

[[(C) Firebase ID Token|Firebase ID Tokens]] are JWTs signed by Firebase — which is why a backend can verify them with the [[(C) Firebase Admin SDK|Firebase Admin SDK]] and trust the `uid`/`email` inside.

## Related

- [[(C) Firebase ID Token|Firebase ID Token]] · [[(C) Tokens|Tokens]] · [[(C) Authentication vs Authorization|Authentication vs Authorization]]
