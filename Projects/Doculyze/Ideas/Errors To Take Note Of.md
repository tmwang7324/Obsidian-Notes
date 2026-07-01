# React Serialization
When a Server Action returns a `File` object, React serializes the return value to send it back to the client. React 19 supports `Blob` in this serialization, but the value is deserialized on the client as a plain **`Blob`, not a `File`**.

`File` extends `Blob` and adds `.name` (and `.lastModified`). A bare `Blob` only has `.size` and `.type`. So after a server action returns a `File`:
- `file.size` → ✅ works
- `file.type` → ✅ works
- `file.name` → ❌ `undefined` (renders blank)

This is why, in the upload form, the file size and type displayed but the file **name** was always empty.

**Solution:** Pull the metadata out of the `File` *on the server* (where it is still a real `File`) and return plain serializable primitives instead of the `File` object:

```tsx
const file = formData.get('file') as File | null;
return {
    message: 'success',
    fileName: file?.name ?? null,
    fileSize: file?.size ?? null,
    fileType: file?.type ?? null,
};
```

Returning primitives instead of the `File` also avoids shipping the file's binary contents back to the client — the file bytes should stay server-side.

# Race Condition in OnAuthStateChanged
Since `createRefresh` and `verifyUser` are both asynchronous functions, after a user signs into the application, there is no guarantee that the cookie is created before `verifyUser` executes in *onAuthStateChanged()* 

**Solution:** 
* Either trigger `verifyUser()` after `createRefresh` has finished by configuring a `useEffect` hook to listen to a global auth context, and mutating that context after `createRefresh`, 

***CAUTION:***
* or remove the call to `verifyUser()` whenever a user logs in from the client-side. 

# Proper OnAuthStateChanged Initialization


# Nested Divs
A `<div>` element or Component cannot be placed outside of the `<body>` tag.
The only permitted direct children of an `<html>` tag are `<head>` and`<body>`.

When I placed my `<Header>` component inside the `<RootLayout>`, I accidentally placed it underneath `<html>` and above `<head>`.

Furthermore, I found out that placing `<Header>` beneath `{children}` causes my header to become a footer.

**Solution**: place <Header> on top of children inside <body>.

<html>
	<head>
		<body>
			<Header></Header>
			{children}
		</body>
	</head>
</html>

#