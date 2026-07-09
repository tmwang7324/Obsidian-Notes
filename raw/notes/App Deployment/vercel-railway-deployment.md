---
title: Vercel + Railway Deployment Guide
aliases:
  - Vercel Railway Deployment
tags:
  - deployment
  - vercel
  - railway
  - nextjs
  - fastapi
created: 2026-07-03
---

# Vercel + Railway Deployment Guide

This guide documents how to deploy this project with:

- Vercel hosting the Next.js frontend in `frontend/`
- Railway hosting the FastAPI backend in `api/`

It also covers the environment variables, CORS setup, and the project-specific details that matter for this repository.

## 1. Understand the Deployment Split

This repository has two deployable surfaces:

- Frontend: `frontend/` (Next.js)
- Backend: `api/main.py` (FastAPI)

The backend is not truly `api/`-only in the filesystem sense. It also depends on:

- `src/` for shared Python logic
- `data/processed/` for processed CSV and GeoJSON assets
- `requirements.txt` for Python dependencies
- `railway.json` for Railway deploy settings

Because of that, the safest Railway setup is to deploy from the repository root, not from `api/` as an isolated root directory.

## 2. What You Do Not Need to Delete

You do not need to delete anything from the repository to deploy this stack.

- Vercel can deploy only the `frontend/` directory.
- Railway can deploy the backend from the repo root.
- Unused local dev files remain in the repo and are simply not used by the target platform.

## 3. Deploy the Frontend on Vercel

### 3.1 Create the Vercel Project

1. Push the repository to GitHub.
2. In Vercel, create a new project from that GitHub repository.
3. In the project settings, set the **Root Directory** to `frontend`.

This is the key step that makes Vercel deploy only the Next.js app instead of the full monorepo.

### 3.2 Vercel Build Settings

This repository already includes `frontend/vercel.json`:

```json
{
  "$schema": "https://openapi.vercel.sh/vercel.json",
  "framework": "nextjs",
  "buildCommand": "next build",
  "devCommand": "next dev",
  "installCommand": "npm install"
}
```

In most cases, you do not need to manually enter these commands in the Vercel dashboard.

### 3.3 Frontend Environment Variable

Set this environment variable in Vercel:

```bash
NEXT_PUBLIC_API_URL=https://your-railway-backend.up.railway.app
```

Notes:

- Do not include a trailing slash.
- This variable is used by `frontend/lib/api.ts` as the API base URL.
- If you omit it, the frontend falls back to `http://127.0.0.1:8000`, which is only correct for local development.

### 3.4 Deploy and Verify

After deployment:

1. Open the Vercel site.
2. Load the K-selection page.
3. Confirm it can call the backend without CORS errors.
4. Confirm the Ranking page can fetch `/api/rank` successfully.

## 4. Deploy the Backend on Railway

### 4.1 Create the Railway Service

1. In Railway, create a new project or service from the same GitHub repository.
2. Keep the service rooted at the repository root.

Do not set the Railway root directory to `api/` unless you also restructure the repo so the backend no longer depends on `src/` and `data/processed/` outside that folder.

### 4.2 Use `railway.json`

This repository already includes `railway.json`:

```json
{
  "$schema": "https://railway.app/railway.schema.json",
  "build": {
    "builder": "NIXPACKS"
  },
  "deploy": {
    "startCommand": "uvicorn api.main:app --host 0.0.0.0 --port $PORT",
    "healthcheckPath": "/api/health",
    "healthcheckTimeout": 60,
    "restartPolicyType": "ON_FAILURE",
    "restartPolicyMaxRetries": 3
  }
}
```

Railway reads this file during deploy, so you generally do not need to manually re-enter these fields in the Railway dashboard.

This file already defines:

- builder: `NIXPACKS`
- start command: `uvicorn api.main:app --host 0.0.0.0 --port $PORT`
- health check path: `/api/health`
- restart policy

You still need to configure variables and any optional service settings in Railway itself.

### 4.3 Railway Environment Variables

Set these in Railway under the service Variables section.

Required or commonly used:

```bash
FRONTEND_ORIGINS=https://your-vercel-app.vercel.app
OPENAI_API_KEY=...
ANTHROPIC_API_KEY=...
SUPABASE_URL=https://your-project-ref.supabase.co
SUPABASE_SERVICE_ROLE_KEY=...
VOYAGE_AI_API_KEY=...
```

Optional:

```bash
ANTHROPIC_MODEL=claude-sonnet-4-6
EMBEDDING_BACKEND=auto
SENTENCE_TRANSFORMER_MODEL=all-MiniLM-L6-v2
```

Important:

- Railway provides `PORT` automatically.
- Do not commit secrets into the repository.
- Keep using local `.env` only for local development.
- In production, Railway Variables are the source of truth.

### 4.4 CORS Setup

The backend reads `FRONTEND_ORIGINS` from the environment and uses it to configure CORS.

Example:

```bash
FRONTEND_ORIGINS=https://your-vercel-app.vercel.app,https://your-preview-url.vercel.app
```

Use comma-separated URLs if you want to allow both production and preview deployments.

If this variable is missing, the backend defaults to localhost origins only, which will break deployed frontend calls.

### 4.5 Railway Watch Paths

Optional but recommended: configure Railway watch paths so backend deploys only trigger on backend-relevant changes.

Suggested watch paths:

- `api/**`
- `src/**`
- `data/processed/**`
- `requirements.txt`
- `railway.json`

This helps avoid unnecessary backend redeploys when only the frontend changes.

## 5. Where the Railway Backend URL Comes From

`railway.json` does not contain your public backend URL.

Railway generates the backend domain when the service is deployed. To find it:

1. Open the Railway project dashboard.
2. Open your backend service.
3. Look in Settings, Networking, or Deployments for the generated domain.

It typically looks like:

```text
https://your-service-name.up.railway.app
```

Use that value as `NEXT_PUBLIC_API_URL` in Vercel.

## 6. Local `.env` vs Production Variables

### 6.1 Local Development

For local development, a repo-root `.env` file is fine.

The Python side loads environment variables locally through `python-dotenv` in places such as the embeddings and agent modules.

### 6.2 Production on Railway

When deploying to Railway, do not rely on the local `.env` file being your production config source.

Instead:

1. Keep `.env` local.
2. Put the same values into Railway Variables.
3. Let the backend read them through `os.getenv(...)` at runtime.

This repo is already structured for that pattern.

## 7. Supabase Configuration

Supabase is optional in this project, but when configured it powers the backend ranking path more efficiently.

### 7.1 Variables the Backend Expects

The backend expects:

```bash
SUPABASE_URL=https://your-project-ref.supabase.co
SUPABASE_SERVICE_ROLE_KEY=...
```

Important:

- The backend expects `SUPABASE_SERVICE_ROLE_KEY` specifically.
- Do not use the anon key for server-side privileged operations.
- Do not expose the service role key in the frontend.

### 7.2 Where to Find the Supabase Values

In Supabase:

1. Open your project.
2. Go to **Settings** -> **API**.
3. Copy the following:
   - Project URL -> `SUPABASE_URL`
   - service_role key -> `SUPABASE_SERVICE_ROLE_KEY`

Then add both values to Railway Variables.

## 8. Which Frontend Pages Hit Which Backend Endpoints

This is useful when verifying the deployment.

### K-selection page

The K-selection frontend calls:

- `POST /api/cluster`
- `GET /api/feature-ranges`
- `GET /api/geo/cdta`

### Ranking page

The Ranking frontend calls:

- `POST /api/filter`
- `POST /api/rank`
- `POST /api/agent` when the Claude analysis action is used

This means the backend must be fully reachable from the Vercel frontend, not just the clustering endpoint.

## 9. Health Check and Verification

After Railway deploys, test the backend directly:

```text
https://your-service-name.up.railway.app/api/health
```

Expected response includes fields such as:

- `status`
- `has_cdta_geojson`
- `has_anthropic_key`
- `has_openai_key`
- `supabase_configured`

Use this endpoint to confirm that:

- the backend is up
- the processed data file is available
- your environment variables are loaded

## 10. Recommended Deployment Order

1. Deploy the backend on Railway first.
2. Copy the generated Railway backend URL.
3. Set `NEXT_PUBLIC_API_URL` in Vercel.
4. Deploy the frontend on Vercel.
5. Set `FRONTEND_ORIGINS` in Railway to the Vercel URL.
6. Redeploy Railway if needed.
7. Verify `/api/health`, K-selection, and Ranking.

## 11. Common Failure Modes

### Frontend loads but API calls fail

Likely causes:

- `NEXT_PUBLIC_API_URL` is missing or incorrect
- `FRONTEND_ORIGINS` does not include the Vercel domain
- backend is not publicly reachable

### Railway deploy succeeds but backend crashes

Likely causes:

- missing Python dependencies
- backend root directory was changed incorrectly
- required files in `data/processed/` are missing from the deployment context

### Ranking endpoint does not behave as expected

Likely causes:

- `OPENAI_API_KEY` is missing and embeddings fallback is not available as expected
- Supabase variables are partly configured
- `SUPABASE_URL` or `SUPABASE_SERVICE_ROLE_KEY` are incorrect

### Claude analysis fails

Likely cause:

- `ANTHROPIC_API_KEY` is not set in Railway

## 12. Minimal Checklist

### Vercel

- Root Directory = `frontend`
- `NEXT_PUBLIC_API_URL` set
- successful deploy

### Railway

- deploy from repo root
- `railway.json` present at repo root
- `FRONTEND_ORIGINS` set to Vercel URL
- API keys and optional Supabase variables set
- `/api/health` returns `status: ok`

### Supabase

- Project URL copied into `SUPABASE_URL`
- service role key copied into `SUPABASE_SERVICE_ROLE_KEY`
- values stored only in Railway backend variables

## 13. Example Production Setup

### Vercel variable

```bash
NEXT_PUBLIC_API_URL=https://nyc-commercial-api.up.railway.app
```

### Railway variables

```bash
FRONTEND_ORIGINS=https://nyc-commercial.vercel.app
OPENAI_API_KEY=...
ANTHROPIC_API_KEY=...
SUPABASE_URL=https://abcdefghijklmnop.supabase.co
SUPABASE_SERVICE_ROLE_KEY=...
```

With that setup, the frontend on Vercel can call the backend on Railway, and the backend can optionally call Supabase for ranking.