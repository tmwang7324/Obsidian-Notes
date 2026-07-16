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

# Dataflow


## Global Auth Context
Upon launch, the application creates a global context named `AuthContext` and a provider named `AuthProvider.` `AuthContext` sets the   


User registers in `app/register/page.tsx` 