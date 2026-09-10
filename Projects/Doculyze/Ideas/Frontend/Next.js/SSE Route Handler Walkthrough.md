# Overview

A step-by-step walkthrough of the `GET` handler in DocuLyze's `app/api/documents/[docId]/stream/route.ts`. This is the **pipeline progress stream** (issue #10): the browser opens an `EventSource` to this route and receives Server-Sent Events every time the document's Firestore record changes status (`uploaded → processing → ready/failed`). Push end to end: worker write → Firestore → Admin-SDK snapshot listener → this stream → browser.

The big idea: **a Route Handler can hold a connection open** and stream frames to the client, instead of returning one response body and finishing. The price is that the server now holds resources (a Firestore listener) for as long as the client is present — so cleanup becomes a correctness requirement, not a courtesy.

## Step 0 — Module setup

```typescript
export const runtime = "nodejs";        // Admin SDK needs Node, not the Edge runtime
export const dynamic = "force-dynamic"; // never cache/prerender this route
```

Route handlers live in `route.ts` files and are **not** wrapped by the `(protected)/layout.tsx` session gate — layouts only protect *pages*. So this route has to do its own auth.

## Step 1 — Authenticate from the session cookie

```typescript
const uid = await getCurrentUid(); // hot read — no checkRevoked round-trip
if (!uid) return new Response("Unauthorized", { status: 401 });
```

`getCurrentUid()` verifies the httpOnly `refresh` session cookie server-side. It's the read-path accessor (returns `null` instead of throwing), and skips the revocation check because this is a hot read.

## Step 2 — Tenant isolation by path construction

```typescript
const { docId } = await params;          // params is a Promise in Next.js 15+
const ref = documentRef(uid, docId);     // users/{uid}/documents/{docId}
```

The Firestore path is built from the **cookie's** uid plus the URL's docId. There is no ownership *check* — there doesn't need to be one. A tampered docId can only ever point inside the caller's own `users/{uid}/documents/` namespace. Same shape as `finalizeUpload`. This is authorization by construction, not by comparison.

## Step 3 — Create the streaming body

```typescript
const stream = new ReadableStream<Uint8Array>({
  start(controller) { ... },
  cancel() { close(); },
});
```

Instead of a string body, the `Response` gets a `ReadableStream`. Everything interesting happens inside `start()`, which runs once when the response begins. `controller.enqueue(bytes)` pushes a chunk to the client; `controller.close()` ends the response.

Note the trick with `let close: () => void = () => {}` declared *outside* the stream: `start()` reassigns it to the real cleanup function, so `cancel()` and the outer scope can call it too.

## Step 4 — The guarded `send` helper

```typescript
const send = (frame: string) => {
  if (closed) return;
  try {
    controller.enqueue(encoder.encode(frame));
  } catch {
    close(); // consumer already gone — release the listener
  }
};
```

Two guards: a `closed` flag (never write after close), and a try/catch because `enqueue` throws if the client vanished. A failed write is treated as a disconnect signal → tear everything down.

## Step 5 — The Firestore snapshot listener (the heart)

```typescript
const unsubscribe = ref.onSnapshot(
  (snap) => {
    if (!snap.exists) { close(); return; }
    const data = snap.data()!;
    const status = typeof data.status === "string" ? data.status : "";
    send(`data: ${JSON.stringify({ status, version: data.version ?? 0 })}\n\n`);
    if (isTerminalDocStatus(status)) close();
  },
  () => close() // listener error: end cleanly so EventSource reconnects
);
```

Point by point:

* `onSnapshot` fires **immediately** with the current document, then again on every change. That free initial snapshot is what makes `EventSource` auto-reconnect resync for free — a reconnecting client instantly gets the current state.
* SSE wire format: each event is `data: <payload>\n\n` (the blank line terminates the event).
* Payload contract is deliberately tiny: `{status, version}` only. The client already has the rest of the record.
* **Terminal statuses end the stream.** The route doesn't hardcode them — `isTerminalDocStatus` comes from the neutral `_lib/ingest_contract.ts` (`TERMINAL_DOC_STATUSES = ["ready", "failed"]`), one list shared by server and client so the two close conditions can't drift. Non-terminal or unknown statuses pass through verbatim.
* The error callback closes the stream *cleanly* — a clean end makes the browser's `EventSource` reconnect, which re-runs this whole handler.

## Step 6 — Keepalive and hard deadline

```typescript
const keepalive = setInterval(() => send(": keepalive\n\n"), KEEPALIVE_MS);   // 15s
const deadline = setTimeout(close, HARD_DEADLINE_MS);                        // 5 min
```

* Lines starting with `:` are SSE **comments** — ignored by the client, but they keep proxies from buffering/killing an idle connection.
* The hard deadline bounds the damage of an abandoned-but-not-aborted stream: worst case, a leaked listener lives 5 minutes. The client just reconnects if it still cares.

## Step 7 — Idempotent `close()` — every exit funnels through here

```typescript
close = () => {
  if (closed) return;   // idempotent — safe to call from any path, any number of times
  closed = true;
  unsubscribe();        // release the Firestore listener (the actual resource)
  clearInterval(keepalive);
  clearTimeout(deadline);
  try { controller.close(); } catch { /* runtime may have closed it already */ }
};

req.signal.addEventListener("abort", close);
```

Exit paths that all end at `close()`: terminal status, missing doc, listener error, failed enqueue, hard deadline, client abort (`req.signal`), and stream `cancel()`. Since any two can race, `close()` must be idempotent — hence the flag-first pattern.

## Step 8 — Return the SSE response

```typescript
return new Response(stream, {
  headers: {
    "Content-Type": "text/event-stream",
    "Cache-Control": "no-cache, no-transform",
    Connection: "keep-alive",
  },
});
```

`text/event-stream` is what makes the browser treat this as SSE. `no-transform` tells proxies not to compress/buffer the body.

## Mental model

```
EventSource.open ──► GET handler
                       ├─ auth (cookie → uid)                 [401 if not]
                       ├─ ref = users/{uid}/documents/{docId} [tenancy by construction]
                       └─ ReadableStream
                            ├─ onSnapshot ── initial + every change ──► "data: {status,version}"
                            ├─ 15s keepalive comments
                            ├─ 5min hard deadline ──► close()
                            └─ close(): unsubscribe + clear timers + controller.close()
   terminal status (ready/failed) ──► server close() + client closes EventSource
```

## Related

* [[Cookies]] — the httpOnly session cookie this route authenticates with
* [[Client vs Server Components]] — why route handlers, not the layout, guard API routes
* [[Ack, Nack, DLQ]] — the worker side that writes the status transitions this stream relays
* [[Dynamically Rendered Pages vs Statically Rendered Pages]] — `force-dynamic`
