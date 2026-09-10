### Express Stuff
#### Urlencoded

Returns middleware that only parses urlencoded bodies and only looks at requests where the Content-Type header matches the type option.

Urlencoded bodies primarily refer to request bodies of HTML form submissions sent with the content type: `application/x-www-form-urlencoded`

So, express can read `req.body` from POST requests

#### Setup 
```
const app = express();
app.use(express.json());
app.use(express.urlencoded{extended: true});

````


### Server-Side Rendering (Default)

```
"use server";
```

With SSR, when a user visits a URL, the server runs the code, fetches the necessary data, constructs the HTML on the fly, and sends the fully rendered page to the browser. 
	**Pros:** 
		* Content is always completely fresh and can adapt to the user making the request (e.g., showing their specific shopping cart or account details).
		* Fast initial loading
		* if search engine optimization (SEO) is important. Search engines look at server rendered HTML content.
		* Mostly static content such as a blog site
	**Cons:** Requires a dedicated backend server or serverless functions to process requests, which increases hosting costs and can result in slightly slower time-to-first-byte (TTFB) compared to a static file. Not recommended for navigation.


### Client-Side Rendering

In modern frameworks like Next.js (App Router), Client Components are always pre-rendered into static HTML on the server during build time or initial request, before being sent to the browser.

Client-side rendering is the process of building UIs in the browser (hydration).

#### How Client Components Work
* Server Pre-rendering: The framework generates a static HTML snapshot of the Client Component on the server.

``` typescript
"use client";
```
**Pros:**
	* SEO is not so important
	* Supports lots of user interaction with site / dynamic content typically behind authentication walls.
* 
**Cons:** 
	* Takes longer to render a page than server-side rendering because the browser first loads blank HTML, which is then populated by the server.
	* 


**Nested Components do not automatically make its parent a client component.** However, parent Client-side components convert child Server components into Client components unless the parent Client-side component wraps the Server component with the React `children` prop.
``` typescript
// page.tsx (Server Component by default)
import ClientWrapper from './ClientWrapper';
import ServerLeaf from './ServerLeaf';

export default function Page() {
  return (
    <main>
      <h1>My App</h1>
      {/* Passing the Server Component as children */}
      <ClientWrapper>
        <ServerLeaf />
      </ClientWrapper>
    </main>
  );
}

// ServerLeaf.tsx
// This runs strictly on the server

async function getSecretData() {
  // Safe to use database credentials or private API keys here
  return { message: "Secure data from the database" };
}

export default async function ServerLeaf() {
  const data = await getSecretData();

  return (
    <div style={{ border: '2px solid green', padding: '15px' }}>
      <h3>Server Component (Secure Data)</h3>
      <p>{data.message}</p>
    </div>
  );
}

// ClientComponent.tsx
'use client';

import { useState } from 'react';

export default function ClientWrapper({ children }: { children: React.ReactNode }) {
  const [count, setCount] = useState(0);

  return (
    <div style={{ border: '2px solid blue', padding: '20px' }}>
      <h2>Client Component (Interactive)</h2>
      <button onClick={() => setCount(count + 1)}>
        Clicks: {count}
      </button>
      
      {/* The Server Component will render here safely */}
      <div style={{ marginTop: '20px' }}>
        {children}
      </div>
    </div>
  );
}

```

