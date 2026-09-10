# Overview
This note explains what [Next.js] Server actions are

Server Actions are serverless functions that run on the server and can be directly called from both Client and Server components. They are designed for **mutations** --- form submissions, database writes, updating data.

They must be wrapped within a `"use server"` directive. 


## How they work
## Under the Hood — RPC Mechanism

Server Actions are **RPCs (Remote Procedure Calls)**. At build time, Next.js does two things:

1. **Server side** — registers each server action in an internal lookup table, keyed by a unique hash (e.g. `abc123`). The function itself never leaves the server.
2. **Client side** — replaces the actual function with a stub that sends a POST request with the header `Next-Action: abc123`.

When a user triggers the action (e.g. submitting a form with `action={myServerAction}`):

- The browser sends a **POST request to the same URL** you're already on
- That POST carries a special header: `Next-Action: abc123`
- Next.js receives the request, reads the header, looks up `abc123` in its table
- It finds the function, runs it on the server, and sends the result back

The client calls the function as if it were local, but the actual execution happens remotely — the network request in between is invisible to the developer.

## Rate Limiting Server Actions

Since server actions are just POST endpoints under the hood, you rate limit them the same way you would any API endpoint:

1. **Inside the action itself** — check the caller's identity (IP, user ID, session) against a store and reject if over the limit. Libraries like `@upstash/ratelimit` (Redis-backed, works in serverless) make this straightforward.
2. **In Next.js middleware** — intercept POST requests with the `Next-Action` header before they reach the action. Better for blanket limits across all actions.
3. **At the infrastructure level** — Vercel, Cloudflare, or a reverse proxy (nginx) can enforce rate limits before the request even hits your app code.
