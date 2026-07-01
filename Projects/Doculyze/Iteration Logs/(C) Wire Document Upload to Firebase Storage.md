---
type: next-step
project: Doculyze
status: open
effort: M
aliases: [Wire Document Upload to Firebase Storage]
tags: [next-step, doculyze]
updated: 2026-06-25
---

# (C) Wire Document Upload to Firebase Storage

**Next step.** Uploads currently create a Firestore doc-ref but never write the file bytes to Storage, and the bucket isn't configured — so the dashboard will keep showing "No documents uploaded yet." Close the loop:

1. **Create the Storage bucket** and set `FIREBASE_STORAGE_BUCKET` in `.env.local` (usually `<projectId>.firebasestorage.app` or `<projectId>.appspot.com`). Until then, any Storage write throws.
2. **Write bytes in `upload_document.tsx`** — `requireUid()` → mint the doc-ref id first (`documentsCol(uid).doc().id`, since the id must exist before the Storage path) → `storage.bucket().file('users/'+uid+'/docs/'+docId+'/original.'+ext).save(buffer, { contentType })` → `createDocumentRecord({ title, storagePath, contentType, size })`.
3. Confirm the path convention matches the decided layout: bytes at `users/{uid}/docs/{docId}/original.<ext>`, extracted text later at `.../extracted.txt`.

- **Effort:** M — bucket + env setup plus the action rewrite and id-before-path ordering.
- **Surfaced by:** [[GRILL-ME-document-storage-2026-06-24|document-storage grill-me]] (open follow-ups) · 2026-06-25 session.
