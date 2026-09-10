### Frontend 
- [[Next[[raw/notes/AI Document Analysis/Next.js]].js]] with zustrand state management for frontend.should
- 
### Backend 
* Server actions in "app/actions.tsx"
* Route Handlers


### Authentication Flow
1. Use Firebase client auth only for registering users, signing them in, and refreshing identity. Logout users from the browser immediately after.
2. Exchange that identity, which comes in the form of a Firebase ID token, for a server-readable session, which is typically an HTTP-only cookie created by my backend.
	* The Firebase ID token is set as a HTTP-only session cookie.
	* This cookie is then ingested and verified by the Next.js Route Handlers to begin HTML hydration and provide users their uploaded documents.
	**Cookie creation and verification are controlled by Server Actions**
3. Let Next.js server components, middleware, and backend routes read that session for protected data and initial rendering.
	* The key is that Next.js is also able to verify the shared session HTTP-only cookie. 
4. Keep a thin client auth context only for live UI convenience, not as the source of truth.
	1.  This should be the Global user context.
**The alternative is keeping everything client-only and calling the backend with [[Firebase ID tokens]]**
### Grill-Me Convo:
##### Question 1: Do you want authentication to be only a client UI concern, or do you want the server to know who the user is so server components, route protection, and initial page rendering can depend on it?

##### Question 2: Should auth session creation and verification live in your Express backend, or do you want to move that into Next route handlers?
Auth session creation (HTTP-only cookies) should be handled by backend.
An issue is: How will I prevent latency and redundant request issues if the session needs to be communicated back to the Next.js frontend?

##### Question 3: Do you want Next itself to be able to resolve the current user during server render, or is it acceptable for Next to render unauthenticated HTML first and let the browser ask Express who the user is after hydration?

No brainer. BUT, there is an important implementation to be made here. Next.js must also have its own means of verifying shared session cookies and refreshing them if needed. This eliminates the problem of having to ping the Express server for every action.


,. NextHow will I prevent  will the Next.js Frontend know what to render? and UI changes.exchanging it once for a long-lived server session cookie long-term  long-term


()JsonID TokensFirebase ID TokensUntitled 1f POST the POSTed emails accounts for existing emails signed in. in order to c:\Users\jw300\skills\skills\productivity\grill-me