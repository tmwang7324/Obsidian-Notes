# Overview
The Firebase Local Emulator Suite is a set of advanced tools for developers looking to build and test apps locally using Cloud Firestore, Realtime Database, Cloud Storage for Firebase, Authentication, Firebase Hosting, Cloud Functions (beta), Pub/Sub (beta), and Firebase Extensions (beta).

### Emulator Suite
My prototype and test workflow can make use of the Local Emulator Suite in various ways:
* **Unit Tests:** using the Firebase Test SDK, you can write unit tests in [[Node.js]] using the mocha test runner. The Test SDK provides several convenience methods for loading Security Rules, one of them being `firestore.rules`, flushing the local database between tests, and managing synchronous interactions with the emulators.


## Setup
1. Install firebase-tools using npm, which gives you access to the `firebase` CLI command:
```bash
npm install -g firebase-tools
```
2. Create a firebase project:
```bash
firebase init
```
3. If there is a pre-existing project, then just 
