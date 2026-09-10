# Overview
See more in [Server Actions#]

## Example
```typescript
"use server";
async function getPresignedURL(file: File, title: string, size: number)
{
	
}
```
`file`, `title`, and `size` are parameters in the request body of `getPresignedURL`

Next.js has a default 1 MB **serversActions.bodySizeLimit.** So, **do not send entire files using server actions.**

