
### What is Firebase?

Firebase is a backend as a service (BaaS) that provides mobile app developers access to analytics, user authentication, databases, deployment, and etc. These services are hosted in the cloud, and scale with little effort from the developer. 

Hosted on the Cloud means that the Google [[SDK]]s provided by Firebase interact with these components directly, allowing users to skip establishing a middleware between the application and service.

### Supports The SDKs: 
- User authentication with Cloud Functions
- Databases
- File and Image storage (S3 buckets)
- Real Time Database Updates
- Firebase Queries
- hosting an application
- Admin
### Firebase UI

 


### Admin SDK
The Admin SDK is a set of server libraries that lets you interact with Firebase from privileged environments to perform actions like:
* Perform queries and mutations on a Firebase SQL Connect service for bulk data management and other operations with full admin privileges.
* Read and write Realtime Database data with full admin privileges.
* Programmically send Firebase Cloud Messaging messages using a simple, alternative approach to Firebase Cloud Messaging server protocols.
* **Generate and verify Firebase auth tokens.**
* Access Google Cloud resources like Cloud Storage buckets and Cloud Firestore databases associated with your Firebase projects.
* Create your own simplified admin console to do things like look up user data or change a user's email address for authentication.

### Admin Setup 

1. Go to Service Accounts tab in your specified project in the Firebase console. 
2. Click the Generate Private Key button for your desired coding language and copy that key into a json file in the backend directory.
3. Install firebase-admin using npm: `npm init -y` + `npm install firebase-admin nodemon`
4.  Create a basic express.js server: ``` 
	const express = require("express"); 
	const cors = require("cors");
	const server = express();
	server.use(express.json());
	server.use(express.urlencoded({extended:true});```
	
5.  Import `firebase-admin` and your service account private key from the json file that contains the key: ``` 
		const admin = require("firebase-admin");
		const serviceAccount = require("./serviceAccountKey.json");
		```
		**OR IF INITIALIZING USING ESM**
``` typescript
 
		import { cert, getApp, getApps, initializeApp } from "firebase-admin/app";
		import { getAuth } from "firebase-admin/auth";
		import type { ServiceAccount } from "firebase-admin";
		import serviceAccount from "../../serviceAccountKey.json";
```
1.   First check if there are any pre-existing admin applications, if not initialize the firebase-admin SDK using initializeApp() and your imported service account private key.
##### 
``` typescript
if(admin.apps().length === 0) {
	admin.initializeApp({
		credential: admin.credential.cert(serviceAccount),
		databaseURL: "https://YOUR_PROJECT_ID-default-rtdb.firebaseio.com"
	});
	}
else {
	admin.app();
}
```
#### ESM 
7. Declare the adminAuth variable using the .auth() method, which controls all user authentication orchestrated by the firebase-admin SDK.
`const adminAuth = admin.auth();`
   

oh damgiven the fact that chromadb only supports FastAPI and LangChain is primarily python-supported, should I make the backend

const adminAuth = auth()admin.auth();getAuth();process.env.FIREBASE_SERVICE_ACCOUNT_KEY as string; //adminimport serviceAccount from "../../serviceAccountKey.json";

import firebase-adminimport { <firebase-amd</firebase-amdin> }So, what youronsole.log(`User session created on backend for user ${response.json()}`);"Error fetching user data from backend:", error);"Error creating CSRF token:", error);"Error creating user session on backend:", error);"Session cookie created successfully" onClick={(e) => {

                e.preventDefault();

                }}} onChange={(e) => {e.preventDefault(); setPassword(e.target.value)} onChange={(e) => {e.preventDefault(); setEmail(e.target.value)}}

    }**OR IF INITIALIZING ON ESM**``

### Project Setup 

1. `npm init -y` -  Select all default answers to node.js project customization questions.
2. `npm i firebase` - Install the firebase library into the directory.   
3. Go to https://console.firebase.google.com/u/1/?cloudshell=false and create a new Firebase project. 
4. Paste the config information in an object variable: 
	```
	firebaseConfig = {
		apiKey: "YOUR_API_KEY",
		authDomain: "YOUR_PROJECT_ID.firebaseapp.com",  
		projectId: "YOUR_PROJECT_ID",  
		storageBucket: "YOUR_PROJECT_ID.firebasestorage.app",  
		messagingSenderId: "YOUR_MESSAGING_SENDER_ID",  
		appId: "YOUR_APP_ID",  
		measurementId: "YOUR_MEASUREMENT_ID"};
	```
and initialize the app with `const app = initializeApp(firebaseConfig)`
		
5. Import the SDKs required such as firebase-app, firebase-auth, and firebase-firestore.
		- Use the hard urls if trying to render onto a static HTML page.
			- Not recommended as module bundling eliminates unused firebase code (Tree Shaking)
		-  Framework CLIs such as React, Nextjs, Angular CLI, Vue CLI, and SvelteKit all support module bundling by implementing Webpack or Rollup underneath the hood.
	
6.  **Optional**: Web

### Errors
- This is a different issue from the earlier module error. Your page is being opened directly from disk as [index.html](vscode-file://vscode-app/c:/Users/seven/AppData/Local/Programs/Microsoft%20VS%20Code/0958016b2a/resources/app/out/vs/code/electron-browser/workbench/workbench.html), so the browser loads [index.js](vscode-file://vscode-app/c:/Users/seven/AppData/Local/Programs/Microsoft%20VS%20Code/0958016b2a/resources/app/out/vs/code/electron-browser/workbench/workbench.html) from `file:///...`. That gives the page an origin of `null`, and browsers block module/CDN fetches from [](vscode-file://vscode-app/c:/Users/seven/AppData/Local/Programs/Microsoft%20VS%20Code/0958016b2a/resources/app/out/vs/code/electron-browser/workbench/workbench.html) for CORS reasons.

There is no existing start/dev script in [package.json](vscode-file://vscode-app/c:/Users/seven/AppData/Local/Programs/Microsoft%20VS%20Code/0958016b2a/resources/app/out/vs/code/electron-browser/workbench/workbench.html), so the fix is to serve the [src](vscode-file://vscode-app/c:/Users/seven/AppData/Local/Programs/Microsoft%20VS%20Code/0958016b2a/resources/app/out/vs/code/electron-browser/workbench/workbench.html) folder over `http://localhost`, not open the HTML file directly.

Use one of these options:

1. VS Code Live Server  
    Open [index.html](vscode-file://vscode-app/c:/Users/seven/AppData/Local/Programs/Microsoft%20VS%20Code/0958016b2a/resources/app/out/vs/code/electron-browser/workbench/workbench.html), then use "Open with Live Server".
    
2. Node static server  
    From the workspace root:
