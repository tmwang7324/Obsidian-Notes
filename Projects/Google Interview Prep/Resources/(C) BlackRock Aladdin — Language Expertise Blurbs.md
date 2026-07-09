---
type: reference
aliases: [BlackRock Aladdin Language Blurbs]
tags: [reference, job-application, blackrock, aladdin]
updated: 2026-07-06
sources: 1
---

# (C) BlackRock Aladdin — Language Expertise Blurbs

Copy-paste-ready proficiency descriptions for the BlackRock (Aladdin) application's
"describe your expertise in each language" fields. Tuned to Aladdin's stack:
Java-first backend, Python for data/analytics/quant, TypeScript for data-dense financial UIs.

**Source:** `Thomas_Wang_Resume.pdf`. All claims are resume- or coursework-backed — nothing invented (see [[CLAUDE]] "no faking it" hard line).

---

## Python — **Advanced**

> **Advanced.** My primary language for data, analytics, and ML. On the data side: statistical forecasting with pandas/statsmodels (10-year enrollment/expenditure regressions) and reliable containerized asynchronous ETL pipelines. On the ML side: an unsupervised K-means clustering pipeline over 72 features for a neighborhood-ranking platform, and LangChain-based Retrieval-Augmented Generation (RAG) with vector search (Voyage AI, ChromaDB). Through university coursework and labs, implemented core ML algorithms from scratch — regression, neural network training, and Q-learning — giving me the fundamentals beneath the libraries. Deepening on large-scale numerical performance.

**Leaner alternate:**
> **Advanced.** Primary language for my analytics and ML work — statistical forecasting/regression (pandas/statsmodels), unsupervised K-means clustering pipelines, and LangChain-based RAG with vector search (Voyage AI, ChromaDB). Built neural network training and Q-learning implementations from scratch in coursework and labs, so I understand the mechanics beneath the frameworks. Strong on the scientific/data stack and reliable data pipelines.

> ⚠️ **Check before sending:** keep "from scratch" only if the labs had you hand-implement
> (e.g. writing backprop / the Q-update yourself). If they were PyTorch/scikit-learn wrappers,
> change to "implemented … in coursework and labs" — don't overclaim the depth.

---

## TypeScript / JavaScript — **Advanced**

> **Advanced.** 3+ years of full-stack TypeScript/JavaScript, with a focus on data-dense interfaces. Built d3.js visualizations mapping dataflow across critical Trading, Card Payments, and Global Payments applications to speed error detection, a cross-platform Electron desktop app (Node.js + React) for an enterprise team, and Next.js frontends over typed REST APIs. Fluent in React, Node/Express, and TypeScript.

**Leaner alternate:**
> **Advanced.** Full-stack TypeScript across web and desktop, oriented toward analytical and operational tooling. Delivered d3.js dataflow visualizations across trading and payments systems, an Electron desktop app with resource indexing and fault-tolerant error handling, and typed React/Next.js frontends. Strong on React, TypeScript, and Node.js.

---

## Java — **Intermediate**

> **Intermediate.** Learned Java through university coursework, where I implemented core data structures and algorithms — linked lists, trees, hash tables, graphs — from the ground up rather than relying on libraries. This gave me a solid grasp of OOP and the fundamentals Java is built on. I haven't yet used it in production, but I ramp quickly on new languages (I've shipped work in Python, TypeScript, R, and Go) and am eager to build production Java depth.

**Leaner alternate:**
> **Intermediate.** Solid academic foundation — implemented core data structures and algorithms in Java across my CS coursework, with a strong grasp of OOP fundamentals. No production experience yet, but a fast ramp given my full-stack background in other languages.

> 💡 **Aladdin note:** Java is Aladdin's core language, but they expect to train new grads on it —
> the honest coursework framing + "ramp quickly" line answers what they actually screen for.
> Keep the "no production experience yet" clause; cutting it is the overclaim they probe for.

---

## C — **Familiar**

> **Familiar.** Used C in coursework to implement data structures and understand memory management, pointers, and lower-level program behavior. Comfortable reading and writing it at a foundational level; my applied work has been in higher-level languages.

---

## Databases / SQL

> Built a well-indexed PostgreSQL database for blockchain transactions supporting low-latency reads and writes, with a focus on schema design and indexing strategy. Hands-on experience with vector databases for semantic search and retrieval — Qdrant, ChromaDB, and PostgreSQL with pgvector. Worked with NoSQL document databases such as MongoDB and Firestore for user authentication and document storage.

> 💡 **Framing intent:** phrased around **design + indexing + integration** (not analytical
> querying) to steer interviewers toward systems/design questions and away from "write this query."
> A description nudges but can't fence off a determined interviewer — spend ~30 min before the
> interview on joins, `GROUP BY`, and a simple window function as insurance.
> **Fixed:** MongoDB/Firestore are "NoSQL document databases," NOT "object stores" (S3/GCS are).

---

## Cross-cutting reminders

- **Proficiency ladder used:** Advanced (Python, TS/JS) → Intermediate (Java) → Familiar (C).
  Reserve "Expert" for nothing — as a May-2026 grad, well-scoped confidence reads as mature;
  overclaiming reads as naïve and gets caught in the technical screen.
- **The honest-edge clauses ("deepening on…", "no production experience yet") are load-bearing** —
  they're what make the strong claims credible. Don't trim them to look stronger.
- **Say TypeScript explicitly** (not just "JavaScript") — Aladdin's front-end teams weight it.
