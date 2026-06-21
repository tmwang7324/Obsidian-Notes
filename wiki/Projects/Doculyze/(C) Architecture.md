---
type: overview
aliases: ["Doculyze Architecture"]
tags: [doculyze, architecture]
updated: 2026-06-16
sources: 3
---

# Doculyze Architecture

The **mutable current-state map** of Doculyze's system. Overwrite as the design changes; history lives in the [[#Decisions|decision records]] and `Progress/`. For identity & purpose see [[(C) Doculyze|the overview]].

## Current shape

| Layer | Choice | Detail |
|---|---|---|
| **Frontend** | [[(C) Next.js|Next.js]] (App Router) + Zustand | Documents shell UI (upload + clickable list) |
| **Backend** | [[(C) Express|Express]] + [[(C) Firebase Admin SDK|Firebase Admin SDK]] | Verifies session, mediates all data access |
| **Identity** | [[(C) Firebase|Firebase]] client auth | Two-system split — see [[(C) Auth Architecture|Auth Architecture]] |
| **Ownership store** | **Firestore** | `documents/{docId}` records + per-user security rules |
| **Semantic index** | **ChromaDB** (local, persistent) | One chunk-grained collection; `userId` metadata filter for isolation |
| **RAG flow** | naive → improved (gated) | chunk → embed → store → retrieve → cited answer; Tier-2 improvements measured with Ragas |

The data layer is **two stores, each doing one job** — Firestore tracks the file record + ownership (drives the list UI); Chroma is the index (drives retrieval). A citation = a retrieved chunk's `docId` + `chunkIndex`, filename resolved from Firestore. Full design: [[(C) Data Layer|Data Layer]].

## Decisions

- [[(C) Two-Store Data Layer|Two-Store Data Layer]] — Firestore (ownership) + ChromaDB (index); no separate `chunks` collection.
- [[(C) Doculyze MVP Scope|Doculyze MVP Scope]] — two tiers, hard-gated; Tier 1 frozen, Tier 2 (improved RAG) gated behind DSA staying on track.

## Open thread

- ~~Backend language for the AI/document layer — undecided.~~ **Resolved 2026-06-20 → Python (Option B).** The AI/document layer (LangChain + RAG) is a small **Python/FastAPI service** alongside Express; Express stays the auth/Firestore gateway and calls the FastAPI service for chunk → embed → store → retrieve → cited answer. Accepted cost: a second process to run/wire/deploy. See [[(C) AI Layer Backend Language (DECISION)|the decision]]; ADR pending `synthesize`.

## Related

- [[(C) Auth Architecture|Auth Architecture]] · [[(C) Technology Architecture|Technology Architecture]] · [[(C) Data Layer|Data Layer]] · [[(C) Firebase|Firebase]] · [[(C) Doculyze|Overview]]
