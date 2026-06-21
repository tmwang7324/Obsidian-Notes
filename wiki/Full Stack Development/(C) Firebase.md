---
type: entity
aliases: ["Firebase"]
tags: [firebase, baas, auth, tool]
updated: 2026-06-16
sources: 3
---

# Firebase

A **Backend-as-a-Service (BaaS)** from Google that gives app developers cloud-hosted analytics, authentication, databases, storage, and hosting that scale with little developer effort. Because the services are cloud-hosted, the Google [[SDK]]s talk to them directly — you skip building middleware between your app and the service.

## Services (via SDKs)

- User authentication (with Cloud Functions)
- Databases (Realtime Database, Firestore)
- File & image storage (S3-style buckets)
- Real-time database updates
- Firebase Queries
- App hosting
- Admin operations (see [[(C) Firebase Admin SDK|Firebase Admin SDK]])

## Client setup

```js
const app = initializeApp(firebaseConfig); // config from the Firebase console
const auth = getAuth(app);
```

`firebaseConfig` holds `apiKey`, `authDomain`, `projectId`, `storageBucket`, `messagingSenderId`, `appId`, `measurementId`. Import only the SDKs you need (firebase-app, firebase-auth, firebase-firestore) — framework CLIs (Next.js, React, Angular, Vue, SvelteKit) bundle via Webpack/Rollup and tree-shake unused Firebase code.

## The Auth object

`auth` is the **client-side authentication manager** for the app. Shape:

```js
auth = {
  app: firebaseApp,
  currentUser: {
    uid: "abc123",
    email: "thomas@example.com",
    displayName: "Thomas",
    emailVerified: true,
    providerData: [...]
  },
  languageCode: "...",
  tenantId: null,
}
```

It automatically detects whether an email sent via a POST registration would duplicate an already-registered account.

## Local dev gotcha — serve over `http://localhost`, not `file://`

Opening `index.html` directly from disk gives the page an origin of `null`, and browsers **block module/CDN fetches from a `null` origin for CORS reasons** — so the Firebase SDK won't load. Fix: serve the folder over `http://localhost` (VS Code **Live Server**, or any static server like `npx serve`), never double-click the HTML file. Project bootstrap is `npm init -y` → `npm i firebase` → create the project in the Firebase console → import only the SDKs you need.

## Role in Doculyze

Firebase client auth is used **only** for registering users, signing them in, and refreshing identity — producing a [[(C) Firebase ID Token|Firebase ID Token]]. That token is then exchanged for a backend [[(C) Session Cookies|session cookie]]. The observer `onAuthStateChanged` drives client UI state. See [[(C) Auth Architecture|Auth Architecture]].

## Related

- [[(C) Firebase Admin SDK|Firebase Admin SDK]] · [[(C) Firebase ID Token|Firebase ID Token]] · [[(C) Auth Architecture|Auth Architecture]] · [[SDK]]
