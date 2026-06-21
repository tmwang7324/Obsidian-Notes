# Overview
Next.js provides Route Handlers as an easier way to write RESTful APIs. Instead of creating a designated server at a different location, one can nest "route.tsx|js" into folders to create API routes.

# Example
```typescript
// /api/auth/route.tsx
export async function GET(req) {
	const data = req.json();
	return data;
}
```

Use fetch from the browser to call the API.