# Table-Aware NER Models

Created: 2026-09-05
Status: Research
Related: [[Local LLMs for NER and Generation]]

## Problem

**GliNER** (and other flat-sequence NER models like **spaCy, vanilla BERT-NER**) serialize tables row-by-row, destroying the column-header-to-cell relationship. A cell containing "42.5" has no meaning without knowing its column is "Revenue (M USD)". Google Cloud NLP has the same limitation — it treats input as a flat text stream with no layout awareness.

Any solution needs to either preserve 2D layout or work from a representation that already encodes structure (e.g. Markdown tables + LLM).

## Layout-Aware Models

### LayoutLMv3 / LayoutXLM (Microsoft)
- **What it does:** Jointly encodes text, 2D bounding-box coordinates, and image patches so it understands cell-to-header relationships
- **Params:** ~133M (base), ~368M (large)
- **Strengths:** Strongest general option for document-understanding NER on visually rich documents; fine-tunable for custom entity types
- **Weakness:** Requires bounding-box info (pre-OCR data), so it must run *before* Markdown conversion — earlier in the pipeline than current NER would sit
- **License:** MIT

### UDOP — Universal Document Processing (Microsoft)
- **What it does:** Unified vision-language-layout model handling NER, classification, and QA over documents with tables
- **Strengths:** More general than LayoutLM
- **Weakness:** Heavier compute requirements
- **License:** MIT

### Donut / Pix2Struct
- **What it does:** OCR-free document understanding — reads directly from the rendered page image
- **Strengths:** Sidesteps the linearized-table-text problem entirely; handles complex merged cells and nested headers
- **Weakness:** Requires rendering the document to an image; slower inference
- **License:** MIT (Donut), Apache 2.0 (Pix2Struct)

### TAPAS / TaPEx
- **What it does:** Designed for table reasoning (originally QA); adaptable for entity extraction from structured tabular data
- **Strengths:** Purpose-built for tables when data is already parsed into rows/columns
- **Weakness:** Narrower scope — table QA, not general document NER
- **License:** Apache 2.0

### NuNER / UniNER
- **What it does:** Small models (< 1B) fine-tuned for NER as a generative task
- **Strengths:** Minimal resource usage
- **Weakness:** Narrower than general LLMs — entity tagging only, not arbitrary extraction
- **License:** Varies

## LLM-Based Extraction (Practical Alternative)

Feed the Markdown table (which DocuLyze's pipeline already produces via Docling/PyMuPDF) to a local LLM with a structured extraction prompt. Models handle table semantics natively because they understand row/column relationships from context. No fine-tuning needed.

See [[Local LLMs for NER and Generation]] for model recommendations.

## Google Cloud NLP API

- Good for entity recognition on **prose** (people, orgs, locations, dates, quantities), sentiment analysis, syntax parsing, content classification
- Zero setup — no training, no GPU, just an API call
- **Does not solve the table problem** — same flat-text limitation as GliNER
- Still viable as a complement for tagging entities in narrative sections of chunks
- Listed in PLAN.md as a planned integration for prose NER + sentiment

## Recommendation for DocuLyze

Two viable paths:
1. **Layout-aware model (LayoutLMv3):** Requires bounding-box data, so it runs pre-Markdown-conversion. Higher integration effort.
2. **Local LLM on existing Markdown chunks:** Lowest friction — table structure is already preserved in the text. Preferred path.

Decision: **LLM-based extraction** on existing Markdown chunks. See [[Local LLMs for NER and Generation]] for model selection.
