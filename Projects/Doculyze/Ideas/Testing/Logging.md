# Logging — AsyncLocalStorage Request Correlation

Functions share a parent's `requestId` through Node's `AsyncLocalStorage`, not through parameters.

The outer server function starts a context containing a generated `requestId`. Any awaited child call runs within that same async context, so the logger retrieves the same ID implicitly:

```ts
await withRequestContext(() => finalizeUpload(...));
// finalizeUpload: requestId = loggerContext.getStore()?.requestId
// publishIngestJob: same requestId
// createChannel: same requestId
```

If a function is invoked standalone and there's no active context, its logging wrapper creates one first. This preserves every existing function signature while making nested log events correlate naturally.

## Scope Lifecycle

The nested shared `requestId` simply leaves scope when the outer request wrapper resolves or rejects. `AsyncLocalStorage.run(context, operation)` makes the `requestId` available only while that async call chain is active. A child's terminal event does not clear it — its parent may still be running. Once the top-level operation finishes, the context is no longer accessible to later work, and the object can be garbage-collected when nothing references it.
