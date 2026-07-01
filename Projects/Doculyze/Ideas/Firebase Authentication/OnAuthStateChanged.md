Adds an observer for changes to the user's sign-in state.

Prior to 4.0.0, this triggered the observer when users were signed in, signed out, or when the user's ID token changed in situations such as token expiry or password change. After 4.0.0, the observer is only triggered on sign-in or sign-out.

**Parameters**
* nextOrObserver: *Observer<any* | ((a: *User | null*) => any)

Ensure that onAuthStateChanged is set to a constant and returned in a *useEffect* hook. This mounts the observer on component start, and unmounts it once the component is switched.