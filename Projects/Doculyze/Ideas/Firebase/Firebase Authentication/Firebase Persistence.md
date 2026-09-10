I can specify how the Authentication state persists using the Firebase JS SDK. For example, I can decide if the session expires when the user closes the application tab, explicitly signs out, or when the page is reloaded.


| Enum                                       | Value     | Description                                                                                                                                                                                                                                                                                     | Code          |
| ------------------------------------------ | --------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------- |
| **firebase.auth.Auth.Persistence.LOCAL**   | 'local'   | Indicates that the state will be persisted even when the browser window is closed or the activity is destroyed in React Native/ An explicit sign out is needed to clear that state. Note that Firebase Auth web sessions are single host origin and will be persisted for a single domain only. | getAuth().set |
| **firebase.auth.Auth.Persistence.SESSION** | 'session' | Indicates that the state will only persist iun the current session or tab, and will be cleared when the tab or window in which the user authenticated is closed. Applies only to web apps.                                                                                                      |               |
| **firebase.auth.Auth.Persistence.NONE**    | 'none'    | Indicates that the state will only be stored in memory and will be cleared when the window or activity is refreshed.                                                                                                                                                                            |               |

## Overview of Persistence 
* The default is `local` in a browser app if no user is signed in and no persistence is specified. 
* Initially, the SDK will check if an authenticated user already exists. If so, that user's persistence type will be applied to future new logins (with different metadata) unless changed using `setPersistence()`.

