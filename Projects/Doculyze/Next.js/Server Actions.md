# Overview
Server Actions are serverless functions that run on the server and can be directly called from both Client and Server components. They are designed for **mutations** --- form submissions, database writes, updating data.

They must be wrapped within a `"use server"` directive. 

## Example
```typescript
"use server";
async function getPresignedURL(file: File, title: string, size: number)
{
	
}
```
`file`, `title`, and `size` are parameters in the request body of `getPresignedURL`

Next.js has a default 1 MB **serversActions.bodySizeLimit.** So, **do not send entire files using server actions.**

