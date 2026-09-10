# Deploying the frontend to Vercel

Covers the Next.js app in `doculyze/` only. The ingest worker and RabbitMQ stay
on your machine — see [What does not work in production](#what-does-not-work-in-production).

## Before you start

`serviceAccount.json` and `.env*` are gitignored, so nothing in them reaches
Vercel automatically. Credentials now load from environment variables instead
(`_lib/admin.tsx`), which you set by hand in step 2.

Resolve the paused cherry-pick in `ingest-worker/` first — you can't push until
the tree is clean:

```bash
git status              # shows the conflicted files
git cherry-pick --abort # or resolve, then: git cherry-pick --continue
```

## 1. Create the project

Import the repo at [vercel.com/new](https://vercel.com/new), then:

- **Root Directory** → `doculyze`

That one is easy to miss and the build fails without it — the app is not at the
repo root. Framework preset, build command, and output directory are all
detected correctly on their own.

## 2. Set environment variables

Project → Settings → Environment Variables. Apply each to **Production**,
**Preview**, and **Development**.

| Variable                      | Value                                                  | Notes                                     |
| ----------------------------- | ------------------------------------------------------ | ----------------------------------------- |
| `FIREBASE_ADMIN_PROJECT_ID`   | `doculyze`                                             | from `serviceAccount.json` → `project_id` |
| `FIREBASE_ADMIN_CLIENT_EMAIL` | `firebase-adminsdk-…@doculyze.iam.gserviceaccount.com` | → `client_email`                          |
| `FIREBASE_ADMIN_PRIVATE_KEY`  | the full PEM block                                     | → `private_key`; see below                |
| `FIREBASE_STORAGE_BUCKET`     | `doculyze.firebasestorage.app`                         | uploads throw without it                  |

Copy the values out of your local `doculyze/.env`, which already has all four.

**The private key.** Paste it whole, including the
`-----BEGIN PRIVATE KEY-----` and `-----END PRIVATE KEY-----` lines. Vercel
accepts real line breaks in the value box. Your local `.env` stores it on one
line with literal `\n` escapes instead — `admin.tsx` unescapes those, so either
form works and you don't have to convert anything.

**Do not set `FIRESTORE_EMULATOR_HOST`.** It exists in your local `.env.local`
to point at the emulator. Set in production, it silently redirects every
Firestore call to a host that isn't there.

**Do not set `RABBITMQ_URL`.** Leaving it unset is what makes the app degrade
cleanly rather than hang — covered below.

No `NEXT_PUBLIC_*` variables are needed. The browser-side Firebase config is hardcoded in `_lib/firebase.tsx`, and those values are public by design (they identify the project; they don't grant access — Firestore rules and the session
cookie do that).

These are read during the build, not just at runtime, so a missing one fails the
build rather than the first request. That's the intended behaviour: a loud stop
beats a half-working deploy.

## 3. Deploy, then note your URL

Deploy. You'll get something like `https://doculyze.vercel.app`. Login,
registration, and the dashboard work at this point. **Uploads do not yet** — one
more step.

## 4. Allow uploads from your new domain

The browser sends file bytes straight to Google Cloud Storage, so the bucket has
to recognise the domain they're coming from. Right now `cors.json` lists only
`localhost` and the Firebase hosting domains, so uploads from Vercel are
rejected by the browser before they leave the page.

Add your domain to `cors.json`:

```json
[
  {
    "origin": [
      "http://localhost:3000",
      "https://doculyze.web.app",
      "https://doculyze.firebaseapp.com",
      "https://doculyze.vercel.app"
    ],
    "method": ["PUT"],
    "responseHeader": ["Content-Type", "x-goog-content-length-range"],
    "maxAgeSeconds": 3600
  }
]
```

Then apply it to the bucket:

```bash
gsutil cors set cors.json gs://doculyze.firebasestorage.app
gsutil cors get gs://doculyze.firebasestorage.app   # verify
```

Editing the file alone changes nothing — it's a local copy of the bucket's
config until you run `set`.

**Preview deployments won't upload.** Every pull request gets a fresh random
subdomain, and this list only matches exact origins — no wildcards. Either test
uploads on the production URL only, or assign a stable domain to your preview
branch and add that.

## 5. Check it end to end

1. Register a new account → lands on the dashboard.
2. Sign out, sign back in → session survives a refresh.
3. Upload a small PDF → progress reaches **Queued**, then stops with
   *"upload saved — retried later"*. **This is the expected result in
   production**, not a failure; see below.
4. Dashboard lists the document with status `uploaded`.

If the upload fails at the byte transfer instead, step 4 above didn't take
effect — check the browser console for a CORS error.

## What does not work in production

**Documents never reach `ready`.** After a successful upload the app publishes a
job to RabbitMQ, which runs in Docker on your machine and isn't reachable from
Vercel. With `RABBITMQ_URL` unset, `publishIngestJob` raises `IngestDisabledError`,
`finalizeUpload` returns `enqueue: "failed"`, and the progress view stops at
*"upload saved — retried later"*. The upload itself is fully committed — bytes in
Storage, record in Firestore at status `uploaded` — so nothing is lost and the
documents are recoverable whenever ingest is reachable.

What a visitor can do on the live link: register, sign in, upload, and see their
documents listed. What they can't: watch a document parse, or chat with one.

Closing that gap means hosting the worker somewhere reachable (Cloud Run, Fly,
a VM) with a managed broker (CloudAMQP), then setting `RABBITMQ_URL` in Vercel.
That's a separate piece of work — the frontend needs no changes for it.

## Changed for this deployment

- `_lib/admin.tsx` — credentials read from `FIREBASE_ADMIN_*` env vars instead
  of importing `serviceAccount.json`. The static import failed the build outright
  once the gitignored file was absent. This is the migration already stubbed out
  in comments there.
- `app/api/documents/[docId]/stream/route.ts` — added `maxDuration = 300` so the
  host doesn't sever the progress stream at its 60s default, well before the
  route's own five-minute deadline. If your plan rejects 300, the build fails and
  the value has to drop to 60.

Local development is unaffected: `serviceAccount.json` is untouched, and `.env`
already carries the `FIREBASE_ADMIN_*` values the new code reads.
