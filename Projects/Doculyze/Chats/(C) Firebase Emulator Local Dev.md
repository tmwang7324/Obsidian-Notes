---
type: synthesis
aliases: ["Firebase Emulator Local Dev", "Emulator Setup"]
tags: [doculyze, firebase, emulator, testing, local-dev]
updated: 2026-07-18
sources: 1
---

# Firebase Emulator Local Dev

How the local [[CLAUDE|Doculyze]] dev loop points at the Firebase emulators, and the sharp edges found while wiring it up. Companion to the [[GRILL-ME-data-architecture-2026-07-16|data-architecture grill]]; the harness this describes was built for GitHub issue #2 (mint-first lifecycle).

## 1. Where the emulators come from

I didn't build any emulators — they're a feature of the **Firebase CLI** (`firebase-tools`, added as a devDependency). All that was authored is config + npm scripts; the CLI downloads and runs local Java reimplementations of Firestore, Storage, and Auth (hence Java must be installed).

The pieces:

- **`firebase-tools`** (`package.json` devDep) — provides `firebase emulators:start`.
- **`firebase.json`** — *what* to run and on which ports: auth `9099`, firestore `8085` (moved off the `8080` default because a Jetty process held it), storage `9199`, UI `4000`, `singleProjectMode`.
- **`.firebaserc`** — pins the project id to `doculyze` so the emulator namespace matches what the service account writes under. (A mismatch here caused an earlier phantom `demo-doculyze` / `projects/undefined` bug where the UI looked empty.)
- **`firestore.rules` / `storage.rules`** — deny-all stubs. Inert (the Admin SDK bypasses rules) but the CLI refuses to start without them.
- **npm scripts** — `emulators` (`emulators:start`, stays up) and `test:emulators` (`emulators:exec ... "vitest run"`, tears down after).

**Summary:** the emulators are Google's; the repo supplies four config files and two scripts. They're separate local processes and never touch production — the `*_EMULATOR_HOST` env vars are the only thing redirecting the SDK to them.

## 2. Connecting `npm run dev` — emulate data, keep login real

Firestore writes all go through the **Admin SDK** (server actions → DAL). The client SDK only touches *Auth*. So no code changes are needed for Firestore — the Admin SDK auto-detects the emulator from an env var. Put it in **`.env.local`** (loaded automatically by `npm run dev`, gitignored):

```
FIRESTORE_EMULATOR_HOST=127.0.0.1:8085
```

Run `npm run emulators` (terminal 1) then `npm run dev` (terminal 2). Log in with the real account; records land in the emulator Firestore, visible at http://127.0.0.1:4000.

**Auth is intentionally left real.** Emulating Auth on the server only would break things: the browser still signs in against production Auth, but the server's session-cookie / ID-token verification would run against the empty Auth emulator and fail. Real Auth on both sides → real uid, only the *data* is emulated. Full auth emulation would need a client-side `connectAuthEmulator()` change too.

## 3. The Storage 404 — signed URLs don't work against the Storage emulator

Symptom: the client PUT fails with
```
404 "No such object: doculyze.firebasestorage.app/users/.../documents/..."
```

**Cause:** the upload flow uses a **GCS v4 signed URL** (`getPresignedUrl` → client PUT → `finalizeUpload`). `getSignedUrl()` produces a URL the *real* GCS understands; with `STORAGE_EMULATOR_HOST` set, the SDK aims it at the emulator, but the Storage emulator only partially implements the signed-URL upload contract. A signed PUT isn't routed as a media upload, so it looks up an object that was never created → 404. This is a documented `firebase-tools` gap, **not** a bug in the signer or finalize logic. The correct object path in the error confirms the URL was well-formed.

**Fix: emulate Firestore, leave Storage real.** Real GCS + emulated Firestore is coherent:
- `getPresignedUrl` → pending record to **emulator Firestore**, signs a **real GCS** URL
- client PUT → lands in the **real bucket** (the tested production path — just works)
- `finalizeUpload` → reads real GCS metadata, writes `uploaded` to **emulator Firestore**

So the Storage lines are commented out in `.env.local`; only `FIRESTORE_EMULATOR_HOST` stays. Caveats: the real bucket needs its CORS config applied (`gsutil cors set cors.json gs://...`), and failed attempts leave `pending` records in the emulator (mint-first working as designed) — restart the emulators or wipe the collection in the UI. Fully-offline Storage would require rerouting bytes through the Storage **client SDK** (`connectStorageEmulator` + `uploadBytes`) — a parallel path from production, so not worth it.

## 4. `.env` vs `.env.local` — will putting the host in `.env` connect?

**Yes, it connects from either.** Nothing in the repo reads `FIRESTORE_EMULATOR_HOST`; `firebase-admin` checks `process.env` for it internally at init. The var connects the moment it exists in the process environment, regardless of which file (or shell `export`) set it.

**But keep it in `.env.local`, not `.env`:**

| File | Purpose | Loaded by `next build`/`start`? |
|------|---------|--------------------------------|
| `.env` | Project base/shared config | Yes |
| `.env.local` | Per-machine, temporary overrides (`.env.local` overrides `.env`) | Yes (conventional throwaway layer) |

Two reasons: (1) `.env` also loads during production builds — a baked-in `127.0.0.1:8085` would make a prod build try to reach a nonexistent emulator and fail; (2) `.env.local` overrides `.env`, so the clean pattern is real config in `.env`, temporary emulator shadow in `.env.local`. Revert by deleting one file / commenting three lines, base config untouched.

## Related

- [[GRILL-ME-data-architecture-2026-07-16|Data Architecture Grill]] · [[(C) Data Layer|Data Layer]] · [[(C) Technology Architecture|Technology Architecture]] · [[(C) Firebase Admin SDK|Firebase Admin SDK]]
