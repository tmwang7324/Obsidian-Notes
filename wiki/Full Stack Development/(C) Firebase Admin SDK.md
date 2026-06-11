---
type: entity
aliases: ["Firebase Admin SDK"]
tags: [firebase, admin, backend, auth, tool]
updated: 2026-06-02
sources: 1
---

# Firebase Admin SDK

A set of **server-side** libraries that let you interact with [[(C) Firebase|Firebase]] from privileged environments with full admin rights. This is the backend half of Firebase auth in [[(C) Auth Architecture|Auth Architecture]].

## What it can do

- Run queries/mutations on Firebase data with full admin privileges.
- Read/write Realtime Database data as admin.
- Send Firebase Cloud Messaging programmatically.
- **Generate and verify Firebase auth tokens** — the key capability for sessions.
- Access Google Cloud resources (Cloud Storage, Firestore).
- Build a simplified admin console (look up users, change emails, etc.).

## Setup

1. **Service Accounts** tab → your project in the Firebase console.
2. **Generate Private Key** → save the JSON into the backend directory (e.g. `serviceAccountKey.json`).
3. Install: `npm init -y` then `npm install firebase-admin nodemon`.
4. Stand up an [[(C) Express|Express]] server:
   ```js
   const express = require("express");
   const cors = require("cors");
   const server = express();
   server.use(express.json());
   server.use(express.urlencoded({ extended: true }));
   ```
5. Import `firebase-admin` and the service-account key.
   - **CommonJS:**
     ```js
     const admin = require("firebase-admin");
     const serviceAccount = require("./serviceAccountKey.json");
     ```
   - **ESM:**
     ```ts
     import { cert, getApp, getApps, initializeApp } from "firebase-admin/app";
     import { getAuth } from "firebase-admin/auth";
     import serviceAccount from "../../serviceAccountKey.json";
     ```
6. Initialize once — guard against re-initialization:
   ```js
   if (admin.apps.length === 0) {
     admin.initializeApp({
       credential: admin.credential.cert(serviceAccount),
       databaseURL: "https://YOUR_PROJECT_ID-default-rtdb.firebaseio.com",
     });
   } else {
     admin.app();
   }
   ```
7. Get the auth handle: `const adminAuth = admin.auth();` — controls all server-side user authentication.

## Role in Doculyze

The backend uses `adminAuth.verifyIdToken()` / `createSessionCookie()` to exchange a [[(C) Firebase ID Token|Firebase ID Token]] for an HTTP-only [[(C) Session Cookies|session cookie]], and `verifySessionCookie()` inside `requireAuth` to protect data routes. The Edge runtime **cannot** run `firebase-admin`, which is why Next.js middleware only checks for cookie *existence* — real verification happens here. See [[(C) Auth Architecture|Auth Architecture]].

## Related

- [[(C) Firebase|Firebase]] · [[(C) Express|Express]] · [[(C) Firebase ID Token|Firebase ID Token]] · [[(C) Session Cookies|Session Cookies]] · [[(C) Auth Architecture|Auth Architecture]]
