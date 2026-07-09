# Supabase Config & The Deployed Ranking Error

Chat note (first time using Supabase). Covers three things I got confused about after migrating embeddings from OpenAI (1536-dim) to **Voyage `voyage-4`** (1024-dim): (1) how `supabase/config.toml` and migrations actually work, (2) how to run the FastAPI backend locally, and (3) why the **local** app worked but the **deployed** Railway + Vercel ranking page threw an HTTP error. The root cause of (3) was a missing `VOYAGE_API_KEY` on Railway — a clean example of an environment-variable gap, not a code bug.

---

## 1. How Supabase's config, linking, and migrations fit together

Supabase has two halves that are easy to conflate:

- **Local project files** (in my repo, committed): `supabase/config.toml` + `supabase/migrations/*.sql`. This is *my description* of what the database should look like.
- **The hosted project** (on supabase.com): the actual Postgres database that Railway talks to at runtime.

The CLI is the bridge between them.

### `config.toml`
- `project_id` in `config.toml` is just a **local slug** (a label for this repo's Supabase setup). It is **not** the remote project reference — don't expect it to match the hosted project's ref.
- **I do not configure the migrations path here.** Migrations live in `supabase/migrations/` *by convention* — the CLI auto-discovers every `*.sql` file there and runs them in **filename order** (`0002_…` before `0005_…` before `0009_…`). That's why they're numbered.
- `[db.migrations].schema_paths` is a *different* feature (the "declarative schema" workflow) that I'm **not** using — leaving it `[]` is correct. The only setting that matters for me is `enabled = true`.
- `[db] major_version` must match the hosted Postgres major version. Check the hosted one with `SHOW server_version;` in the Supabase SQL editor if migrations ever refuse to apply.
- **Secrets never go in `config.toml`.** Keys (`SUPABASE_SERVICE_ROLE_KEY`, `VOYAGE_API_KEY`, etc.) live in `.env` locally and in the platform's env-var settings in production. `config.toml` uses `env(...)` substitution to *reference* them, never to store them.

### Linking and pushing
- `supabase link --project-ref <ref>` writes the remote link into the **gitignored** `supabase/.temp/` folder. That's why linking is per-machine and doesn't get committed.
- `supabase db push` applies the migration files to the linked hosted database. Supabase records which migrations have already run, so re-running `db push` is safe — it only applies what's new.

**Decision:** Treat `supabase/migrations/*.sql` (numbered, convention-located) as the single source of truth for schema; never hand-edit the hosted DB.
**Why:** The CLI tracks applied migrations by filename, so an ordered, committed migration folder makes the schema reproducible and re-pushable without clobbering existing data.
**How to apply:** Add schema changes as a new numbered migration, `supabase db push`, and keep secrets out of `config.toml` (reference them via `env(...)`).

---

## 2. Running the FastAPI backend locally

The Streamlit app and the FastAPI backend share the same `src/` core, but the ranking page (Next.js frontend) talks to **FastAPI**, not Streamlit. To run the backend locally:

```
uvicorn api.main:app --reload --port 8000
```

Endpoints: `/api/cluster`, `/api/filter`, `/api/rank`, `/api/agent`, `/api/geo/cdta`, `/api/health`.

For the frontend to hit a local backend, set `NEXT_PUBLIC_API_URL=http://localhost:8000` (bare origin — **no** `/api` suffix, **no** trailing slash).

---

## 3. The real bug: local worked, deployed didn't

### The symptom
Local ranking page worked fine. The **deployed** Railway backend + Vercel frontend threw an HTTP error on the ranking page. Both had "worked before" the Voyage migration. I'd already set the Supabase env vars on Railway.

### Why local vs. deployed diverged
This asymmetry was the whole clue. My **local** `.env` had `VOYAGE_API_KEY` set, so the local backend embedded queries with Voyage (1024-dim) and matched the 1024-dim Supabase table perfectly. Railway had the Supabase vars **but not** `VOYAGE_API_KEY`.

### The mechanism (this is the important part)
The backend picks its embedding provider at request time via `resolve_embedding_backend()`. In `auto` mode it checks, in order:
1. `VOYAGE_API_KEY` set? → use **Voyage** (1024-dim) ✅
2. else `OPENAI_API_KEY` set? → use **OpenAI** (1536-dim)
3. else → sentence-transformers

Railway still had `OPENAI_API_KEY` from before the migration (that's *why it worked before*), but **no** `VOYAGE_API_KEY`. So auto-mode silently fell to step 2 → embedded the query into a **1536-dim** vector → handed it to the `match_neighborhoods` RPC, which expects **`vector(1024)`**. Postgres rejected the dimension mismatch → the endpoint 500'd → the ranking page showed an HTTP error.

The Supabase table was already 1024-dim Voyage; Railway was querying it with the wrong-sized vector.

### The fix
In Railway → backend service → **Variables**, add:
```
VOYAGE_API_KEY=<voyage key>
EMBEDDING_BACKEND=voyage
```
- `VOYAGE_API_KEY` is the actual missing piece.
- `EMBEDDING_BACKEND=voyage` isn't strictly required (auto-mode picks Voyage once the key exists) but **pinning it** removes any chance of a silent fallback to OpenAI re-triggering the dim mismatch.

Saving a variable auto-redeploys Railway. Fixing the backend fixes Vercel too, since the frontend just proxies to Railway.

### How to verify
```
curl -Method POST https://<railway-domain>/api/rank -ContentType 'application/json' -Body '{"query":"coffee shop","alpha":0.6,"filters":{}}'
```
If it still fails, read Railway's deploy logs:
- a dimension / `vector` error → key still not being read (or `EMBEDDING_BACKEND` not set)
- a `voyageai` / auth error → key is wrong or missing

**Decision:** When a build works locally but fails only in deployment, suspect an **environment-variable gap** before suspecting code.
**Why:** Local `.env` and the production platform's env vars are separate; a migration that adds a new required key (here `VOYAGE_API_KEY`) will pass locally yet break in prod until the key is added there too. The "worked before" clue pointed at leftover `OPENAI_API_KEY` causing a silent, wrong-dimension fallback rather than a hard failure.
**How to apply:** After any change to required credentials, update **every** environment: `.env.example`, local `.env`, and Railway (and re-check `FRONTEND_ORIGINS` still lists the Vercel URL for CORS). Pin `EMBEDDING_BACKEND` so provider selection can't silently drift.

---

## Takeaways
- Migrations = numbered SQL files in `supabase/migrations/`, auto-run in order; `config.toml` doesn't point at them.
- Secrets live in env vars, never in `config.toml` or git.
- A silent auto-fallback (Voyage → OpenAI) is dangerous precisely because it *doesn't* error at selection time — it errors later as a confusing dimension mismatch. Pinning the backend prevents this.
- "Works locally, fails deployed" almost always means the two environments have different env vars.

Related: [[(C) Interview Scoping & HyDE]] — same project's embedding/retrieval design (query→document asymmetry, Voyage embeddings).
