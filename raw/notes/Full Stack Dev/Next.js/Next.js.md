
Next.js is an open-source web development framework built on top of React that allows developers to create and deploy high performance, full-stack applications (using Vercel). One uses React to build components and user interfaces. Next.js provides additional features and optimizaitons primarily regarding lower-level tools like bundlers an#d compilers.

### How to Create a new Next.js Application
#### System Requirements:
- Chrome 111+
- Edge 111+
- Firefox 111+
- Safari 16.4+
#### Create using CLI
Use `create-next-app`, which sets up everything automatically for you. To create a project, run:
`npm create next-app`
Choose default options: 



## Frontend
### Creating New Pages
* Under the `app` folder, create new routes by creating new folders with desired a route name like this: 
	* ![[Pasted image 20260525200605.png]] => "localhost:3000/login" and "localhost:3000/register"
*  Pages are created using standard React Components (Rafce, or export default functions)
* **ENSURE THAT THE PAGE COMPONENT FILE (which contains everything you want to render onto the route) IS NAMED "PAGE.TSX"**

### Layouts

* Renders only once when the application is first loaded.
* Used to render global persisting components of webpages such as a navigation bar. 
* Ni
### Navigation

### Refresh
In Next.js, the router.refresh() method updates the current page by fetching fresh data from the server and re-rendering Server Components without doing a full browser reload.

When you call router.refresh(), Nex


## Backend 

Next.js includes a backend service with the same port as the frontend.
### Server Actions
* Great for CUD (Create, Update, Delete), not Reading/fetching. 

### Route Handling
* Used for*



import router from 'next/dist/shared/lib/router/router';

  

import import { verify } from "crypto";ID Tokensimport { FormData } from 'formdata-node';import Link from "@react-navigation/native/lib/typescript/src/Link";import Link from '@react-navigation/native/lib/typescript/src/Link';        <Link to="/forgot-password">Forgot Password</Link>login_form

    )}

iconst email = formData.get("email")?.toString();

        const password = formData.get("password")?.toString();

        user, formData: FormDataWithUser// Implement login logic here, e.g., call an API route to authenticate the usershould import { ReadonlyRequestCookies } from "next/dist/server/web/spec-extension/adapters/request-cookies";register_formserver_api";: ReadonlyRequestCookies: ResponseCookie e<>CookiesRequest ResponseCookie</ReadonlyRequestCookies><input type = ""> </input>action={() => {

                const user = createUserWithEmailAndPassword

                }}useruser: User | null = auth.currentUserif (!user) {

                throw new Error("No authenticated user found");

            }

            const idToken: string = awaitimport { auth } from '@/_lib/firebase'; user.getIdToken();r<
### Client vs Server Components IMPORTANT

Client components

;.I  
   

createSessionCookie(user.getIdToken()).then(() => {Secret123COOKIE{ "Secret123const { create } = require("node:domain");res.cookieres.status(500).json({ error: "Internal server error" });if (!authBody || !authBody.idToken) {

            return res.status(401).json({ error: "ID token either does not exist or is invalid." });

        }

        }

        }const authHeader = req.headers.authorization;require("dotenv").config(); -fapifunctions.js          async (req, res) => {

    fetchCurrentUser(req, res);

}   console.log(user);Verifiedimport { onAuthStateChanged } from "firebase/auth";app.****  / continsUnauthorized`````[[### Auth]]  */"

  

}```
```
```

asdf
