**DECISION:** Retired *Express.js* backend for Serverless functions.
**Rationale:**

| Service                    | Function                                                          |
| -------------------------- | ----------------------------------------------------------------- |
| **Next.js**                | Frontend                                                          |
| **Server Actions**         | Login, Registration                                               |
| **Firestore**              | User Profiles + document ref storage                              |
| **Firebase Client SDK**    | Local session persistence + idToken for cookie                    |
| **Firebase Cloud Storage** | Document content storage. Referenced by refs stored in Firestore. |
| **LangChain**              | Main RAG workflow. **To be Implemented**                          |


# Containers
**Self-hosted:** Next.js App
**Container #2:** Ingest-worker (embed pipeline)
**Container #3:** RabbitMQ broker
**Network #1:** RabbitMQ network
**Container #4:** Synchronous user-AI chat with Websockets
# Dataflow



## Global Auth Context
Upon launch, the application creates a global context named `AuthContext` and a provider named `AuthProvider.` `AuthContext` initializes states that represent the authenticated user and the **Header**  loading status.
`AuthProvider` mounts the observer `onAuthStateChanged` to listen for logins through the Firebase Client SDK. This changes the **Header** to display user info.


User registers in `app/register/page.tsx` 