---
type: concept
aliases: ["Authentication vs Authorization"]
tags: [auth, concept, identity]
updated: 2026-06-02
sources: 1
---

# Authentication vs Authorization

Two distinct steps, often confused:

- **Authentication** — verifies *who* a user is. (Login: prove identity.)
- **Authorization** — determines *what* a user can do. (Permissions: access control.)

You authenticate first, then authorize. In the [[(C) Auth Architecture|Auth Architecture]] of DocuLyze, authentication is handled by [[(C) Firebase|Firebase]] + the backend [[(C) Session Cookies|session cookie]]; authorization (which documents a user may read) is enforced by `requireAuth` on [[(C) Express|Express]] routes.

Common protocols: **OAuth 2.0** for authorization, **OIDC (OpenID Connect)** for authentication through external trusted providers. Both use [[(C) Tokens|token]]-based strategies.

## Related

- [[(C) Tokens|Tokens]] · [[(C) JWT|JWT]] · [[(C) Auth Architecture|Auth Architecture]]
