
| Feature                       | Client Component | Server Component | Notes                                                               |
| ----------------------------- | :--------------: | :--------------: | ------------------------------------------------------------------- |
| useRouter                     |        ✅         |        ❌         | Client-side navigation and route info                               |
| useContext                    |        ✅         |        ❌         | Reads from a React context provider                                 |
| useState                      |        ✅         |        ❌         | Local reactive state                                                |
| useEffect                     |        ✅         |        ❌         | Runs side effects after render                                      |
| useRef                        |        ✅         |        ❌         | Mutable ref to a DOM element or value                               |
| useCallback                   |        ✅         |        ❌         | Memoizes a function reference                                       |
| useMemo                       |        ✅         |        ❌         | Memoizes an expensive computed value                                |
| onSubmit                      |        ✅         |        ❌         | Form submission event handler                                       |
| onClick / Event handlers      |        ✅         |        ❌         | Any browser event listener                                          |
| action                        |        ✅         |        ✅         | Server Actions can be defined in or passed to either component type |
| async/await (direct)          |        ❌         |        ✅         | Server components are async functions by default                    |
| Database / backend access     |        ❌         |        ✅         | Safe to query DB or call internal services directly                 |
| Access env variables (secret) |        ❌         |        ✅         | Variables without `NEXT_PUBLIC_` prefix are server-only             |
| cookies() / headers()         |        ❌         |        ✅         | Reading these opts the page into dynamic rendering                  |
| fetch with caching            |        ❌         |        ✅         | Next.js extends `fetch` with `cache` and `revalidate` options       |
| SEO / initial HTML            |        ❌         |        ✅         | HTML is rendered on the server — visible to crawlers immediately    |
| "use client" directive        |        ✅         |        ❌         | Must be declared at the top of any file using client-only features  |

### Client Components




### Server Components


When invoking the `headers()` or `cookies()` methods, the server component becomes a dynamically rendered page. 



A dynamically rendered page is a web page that generate their HTML on the server during runtime (at the exact moment a user requests them). This contrasts with static sites, which use pre-built HTML files.





