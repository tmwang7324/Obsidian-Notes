---
type: next-step
project: Doculyze
status: open
effort: M
aliases:
  - Normalize to Markdown
tags:
  - next-step
  - doculyze
github: https://github.com/tmwang7324/DocuLyze/issues/11
issue: 11
parent: "[[(C) RAG Ingest and Query Data Architecture]]"
blocked_by: ["[[(C) Pull-Based Ingest Tracer]]"]
updated: 2026-07-21
---

# (C) Normalize to Markdown

**Next step.** Change the parse stage's output contract from plain text to **Markdown**, so structure — tables, headings, lists — survives into chunks and therefore into retrieval. This sits between [[(C) Pull-Based Ingest Tracer|ingest (#4)]] and [[(C) Embed + Chroma Tenant Gateway|embed (#5)]], and **blocks #5**, which chunks the parsed output. It also fixes a latent data-loss bug: the current `_parse_docx` reads `doc.paragraphs` only and **silently drops every table**. Per format: PDF → `pymupdf4llm.to_markdown()` (⚠ PyMuPDF is AGPL); DOCX → table-aware Markdown; text/code → passthrough; **`.doc` dropped as legacy** (antiword is structureless). Downstream, #5's chunker goes Markdown-aware (`MarkdownHeaderTextSplitter` → recursive token splitter, tables kept atomic).

## Acceptance criteria
- [ ] Parse stage returns Markdown for pdf / docx / text; sandbox output shape unchanged (`str`).
- [ ] DOCX tables render as Markdown pipe tables — regression test on the dropped-table case.
- [ ] PDF tables + headings preserved via `pymupdf4llm`.
- [ ] `.doc` removed from allowlist (`_lib/fileupload_schema.ts`) + precheck OLE2 branch + parsers table + antiword Dockerfile dep; a `.doc` is rejected at the gate, not at ingest.
- [ ] `.doc` job-seam test removed; remaining tests updated.

- **Effort:** M — two parser swaps plus a cross-cutting `.doc` removal that touches the neutral upload allowlist (client + server), precheck, worker, and Dockerfile.
- **Blocks:** [[(C) Embed + Chroma Tenant Gateway]] — the chunker consumes this stage's Markdown.
- **Blocked by:** [[(C) Pull-Based Ingest Tracer]] — extends its sandboxed parse stage.
- **Surfaced by:** the #5 design grill (2026-07-21) · GitHub issue #11
