---
type: next-step
project: Doculyze
status: done
goal: "[[Doculyze MVP]]"
effort: M
aliases:
  - Retire or Revive the Legacy Express Backend
tags:
  - next-step
  - doculyze
updated: 2026-07-08
---

# (C) Retire or Revive the Legacy Express Backend

**Next step.** Auth now lives in Next.js Server Actions, so the Express `backend/` and its
satellites are dead weight that still contradicts the docs. Decide per item — delete or
intentionally revive — then reconcile `CLAUDE.md`/`PLAN.md` to the Server-Action reality.

- **Advances:** [[Doculyze MVP]]
- **Effort:** M — several files to remove/verify plus a docs pass; low risk but touches the whole auth story.
- **Candidates:** `backend/` (Express + CSRF), `_lib/api_with_express.tsx`, `app/actions.tsx`, `app/middleware/auth_check.tsx`, `app/pages/login/index.tsx`, empty `_lib/database.tsx`.
- **Surfaced by:** [[2026-07-08|2026-07-08 progress]] · [[DocuLyze-Architecture]]

When done, flip `status: done` and note the resolving progress entry.
