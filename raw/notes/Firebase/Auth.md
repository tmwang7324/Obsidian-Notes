
The `Auth` object is basically the client-side authentication manager for your Firebase app. 

```
const app = initializeApp(firebaseConfig);
const auth = getAuth(app);
```

```
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
	...  
	}

  

```
Automatically detects if emails sent through POST requests would be duplicates with pre-existing emails registered.
