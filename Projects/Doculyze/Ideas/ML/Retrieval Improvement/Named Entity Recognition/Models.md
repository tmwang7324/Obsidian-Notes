
## Models

| **Service**                 | **Description**                                                            | **Advantages**                                                                           | **Disadvantages**                                                                                   |
| --------------------------- | -------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| Google Natural Language API | Google's Natural Language API supports a powerful NER model that classifes | Cloud-based so no need to manage its infrastructure.<br><br>Only limited by request I/O. | No custom labels.<br><br>Unable to parse through structured tables.                                 |
| GliNER                      |                                                                            |                                                                                          | Unable to parse through structured tables                                                           |
| BERT                        |                                                                            |                                                                                          | Unable to parse through structured tables                                                           |
| spaCY                       |                                                                            |                                                                                          | Unable to parse through structured tables.<br>                                                      |
| xlm-Roberta-Large           |                                                                            |                                                                                          | Fine-tuned models are a bit inaccurate                                                              |
| Qwen2.5:7b-Instruct-q4_K_M  | Local LLM q4 quantized.                                                    |                                                                                          | Extremely inclusive **Person** and **Organization** labels<br><br>Takes 8GB VRAM easily to run.<br> |
| Google FLAN-T5              |                                                                            |                                                                                          |                                                                                                     |
|                             |                                                                            |                                                                                          |                                                                                                     |
Unable to parse through complex tables

  Models/approaches that handle tables well:

  1. LayoutLMv3 / LayoutXLM (Microsoft) — The strongest general option. These jointly encode text, layout (2D bounding-box coordinates), and image patches, so they understand that a cell value
     belongs to a specific row header and column header. Fine-tunable for custom entity types.
     LayoutLMv3 is the current go-to for document-understanding NER on visually rich documents.
  2. UDOP (Universal Document Processing) — Microsoft's unified vision-language-layout model. Handles
     NER, classification, and QA over documents with tables. Heavier than LayoutLM but more general.
  3. Donut / Pix2Struct — OCR-free document understanding models that read directly from the rendered image. They sidestep the "linearized table text" problem entirely by working on the visual
     representation. Good when your tables have complex merged cells or nested headers.
  4. TAPAS / TaPEx — Specifically designed for table reasoning (originally for QA), but can be adapted
     tables have complex merged cells or nested headers.
  5. TAPAS / TaPEx — Specifically designed for table reasoning (originally for QA), but can be adapted for entity
     extraction from structured tabular data when the table is already parsed into rows/columns.
  6. LLM-based extraction (practical winner for many cases) — Feed the Markdown table (which Docling already produces
     for you) to an LLM with a structured extraction prompt. Models like Claude handle table semantics natively because
     they understand row/column relationships from context. This avoids the linearization problem entirely and needs no
     fine-tuning.