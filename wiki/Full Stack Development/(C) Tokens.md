---
type: concept
aliases: ["Tokens"]
tags: [auth, concept, tokens, identity]
updated: 2026-06-02
sources: 1
---

# Tokens

Tokens are pieces of data that carry just enough information to determine a user's identity or to authorize access to data or an action. They are the artifacts that let applications perform [[(C) Authentication vs Authorization|authentication and authorization]].

Identity frameworks use token-based strategies to secure access — e.g. OAuth 2.0 (authorization) and OIDC (authentication) via external providers.

## Access tokens

A short-lived credential that grants **direct** access to resources and APIs. In Doculyze, the [[(C) Firebase ID Token|Firebase ID Token]] *is* the access token — which is why the plan to split the session into separate access/refresh tokens was dropped (see [[(C) Firebase ID Token|Firebase ID Token]]).

## Token types in play

- [[(C) JWT|JWT]] — the signed format Firebase ID tokens use.
- [[(C) Firebase ID Token|Firebase ID Token]] — proves a signed-in Firebase user.
- Identity Provider tokens — OAuth 2.0 access tokens from Google/Facebook etc.

## Related

- [[(C) JWT|JWT]] · [[(C) Firebase ID Token|Firebase ID Token]] · [[(C) Session Cookies|Session Cookies]] · [[(C) Authentication vs Authorization|Authentication vs Authorization]]
