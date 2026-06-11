
Context providers typically live near the root of an application to share global state and logic.

For example, your application's theme, a user's authenticated state, etc.

However, React context is not supported in Server Components. If you try to create a context at your application's root, either you have to convert the entire application to a Client Component or run into an error. 

The solution is to create your context and render its provider inside a dedicated Client Component.

**IMPORTANT: EVERY COMPONENT THAT CONSUMES USECONTEXT MUST BE A CLIENT COMPONENT**