
### What is Firebase?

Firebase is a backend as a service (BaaS) that provides mobile app developers access to analytics, user authentication, databases, deployment, and etc. These services are hosted in the cloud, and scale with little effort from the developer. 

Hosted on the Cloud means that the Google [[SDK]]s provided by Firebase interact with these components directly, allowing users to skip establishing a middleware between the application and service.

### Supports The SDKs: 
- User authentication with Cloud Functions
- Databases
- File and Image stroage
- Real Time Database Updates
- Firebase Queries
- hosting an application
- 
### FirebaseUI
provides a bunch of helpful utilies to make development with easeri.+ angularFire/ f

#### Auth objects:
`javascript const auth = getAuth(app);
`


### Project Setup 
1. `npm init -y` -  Select all default answers to node.js project customization questions.
2. `npm i firebase` - Install the firebase library into the directory.   
3. Go to https://console.firebase.google.com/u/1/?cloudshell=false and create a new Firebase project. 
4. Import the SDKs required such as firebase-app, firebase-auth, and firebase-firestore.
		- Use the hard urls if trying to render onto a static HTML page.
		- CLIs 
   
   ive the firebase config to teve -return user;x

corscorssconst docRef = doc(db, "users", "user1");vss
   all defaultshttps://www.gstatic.com/firebasejs/12.13.0/firebase
 - 1. 
 
### Errors
- This is a different issue from the earlier module error. Your page is being opened directly from disk as [index.html](vscode-file://vscode-app/c:/Users/seven/AppData/Local/Programs/Microsoft%20VS%20Code/0958016b2a/resources/app/out/vs/code/electron-browser/workbench/workbench.html), so the browser loads [index.js](vscode-file://vscode-app/c:/Users/seven/AppData/Local/Programs/Microsoft%20VS%20Code/0958016b2a/resources/app/out/vs/code/electron-browser/workbench/workbench.html) from `file:///...`. That gives the page an origin of `null`, and browsers block module/CDN fetches from [](vscode-file://vscode-app/c:/Users/seven/AppData/Local/Programs/Microsoft%20VS%20Code/0958016b2a/resources/app/out/vs/code/electron-browser/workbench/workbench.html) for CORS reasons.

There is no existing start/dev script in [package.json](vscode-file://vscode-app/c:/Users/seven/AppData/Local/Programs/Microsoft%20VS%20Code/0958016b2a/resources/app/out/vs/code/electron-browser/workbench/workbench.html), so the fix is to serve the [src](vscode-file://vscode-app/c:/Users/seven/AppData/Local/Programs/Microsoft%20VS%20Code/0958016b2a/resources/app/out/vs/code/electron-browser/workbench/workbench.html) folder over `http://localhost`, not open the HTML file directly.

Use one of these options:

1. VS Code Live Server  
    Open [index.html](vscode-file://vscode-app/c:/Users/seven/AppData/Local/Programs/Microsoft%20VS%20Code/0958016b2a/resources/app/out/vs/code/electron-browser/workbench/workbench.html), then use “Open with Live Server”.
    
2. Node static server  
    From the workspace root: