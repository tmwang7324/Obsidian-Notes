# Local LLMs for NER and Generation

Created: 2026-09-05
Status: Research
Related: [[Table-Aware NER Models]]

## Context

Using a small open-source LLM for NER avoids API costs and handles tables naturally through the Markdown representation DocuLyze already produces. A local model can also serve the planned RAG chat interface.

## Model Comparison

### Qwen2.5-7B-Instruct
- **Params:** 7B
- **Q4_K_M size:** ~4.4GB
- **RAM at inference:** ~6GB
- **Context window:** 128K native
- **Structured output (JSON):** Very reliable
- **Multilingual:** Excellent (CJK especially)
- **Reasoning:** Decent — struggles on 4+ step chains
- **Code generation:** Strong
- **Long-form generation:** Tends to be terse, sometimes truncates
- **Hallucination:** Higher under ambiguity
- **RAG synthesis:** Adequate — sticks to context when prompted firmly
- **License:** Apache 2.0

### Qwen2.5-14B-Instruct
- **Params:** 14B
- **Q4_K_M size:** ~9GB
- **RAM at inference:** ~11-12GB
- **Context window:** 128K native
- **Structured output (JSON):** Very reliable
- **Multilingual:** Excellent (CJK especially)
- **Reasoning:** Noticeably better than the 7B — handles multi-step chains more reliably
- **Code generation:** Strong, ahead of the 7B
- **Long-form generation:** Less terse than 7B, better coherence
- **Hallucination:** Lower than 7B, still not Gemma-level calibration
- **RAG synthesis:** Better multi-chunk weaving than 7B; heavier footprint is the tradeoff
- **License:** Apache 2.0

### Gemma 4 12B (E4B)
- **Params:** 12B (E4B = ~4B effective via MoE-style sparsity)
- **Q4_K_M size:** ~7.5GB
- **RAM at inference:** ~9-10GB
- **Context window:** 128K native
- **Structured output (JSON):** Very reliable (Google trained hard on this)
- **Multilingual:** Good but weaker on CJK
- **Reasoning:** Significantly better — Gemini distillation, closer to 12B-class reasoning
- **Code generation:** Comparable to Qwen
- **Long-form generation:** More coherent over longer outputs
- **Hallucination:** Lower — more calibrated "I don't know" behavior
- **RAG synthesis:** Better at weaving multiple retrieved chunks into a coherent answer
- **Chain-of-thought:** More natural, less prompt engineering needed
- **License:** Gemma license (permissive but not Apache — has a use-policy restriction)

### Other Options
| Model | Params | Notes |
|---|---|---|
| Phi-3.5-mini | 3.8B | Punches above weight on structured tasks; ~8GB VRAM FP16; good JSON schema following |
| Llama 3.1-8B-Instruct | 8B | Very capable for extraction; well-supported ecosystem |
| Llama 3.2-3B-Instruct | 3B | Viable if memory-constrained; less reliable on complex tables |
| Mistral 7B Instruct v0.3 | 7B | Solid general-purpose; slightly behind Qwen2.5 on structured output |

## Recommended Split: Two Models

| Use Case | Model | Rationale |
|---|---|---|
| **NER extraction (ingest worker)** | Qwen2.5-7B | Batch, offline, cost-sensitive — smaller footprint, faster throughput |
| **RAG chat / answer generation** | Gemma 4 E4B | Interactive, quality-sensitive — better reasoning, lower hallucination, better multi-chunk synthesis |

Two Ollama models coexist fine — only the active one occupies GPU memory. The ingest worker and chat service hit the same Ollama endpoint with different model names.

## GGUF Quantization Tiers

| Variant | Size | Quality | Use Case |
|---|---|---|---|
| Q4_K_S | ~4.2GB | Slightly lower | Tight on RAM |
| **Q4_K_M** | **~4.4GB** | **Good** | **Best default** |
| Q5_K_M | ~5.1GB | Better | If you have the headroom |
| Q8_0 | ~7.7GB | Near-FP16 | Quality-sensitive tasks |

## How to Pull Models

### Ollama (recommended — simplest)
```bash
# Qwen (NER)
ollama pull qwen2.5:7b-instruct-q4_K_M
ollama pull qwen2.5:14b-instruct-q4_K_M

# Gemma 4 (RAG chat)
ollama pull gemma4:e4b
```

Ollama serves on `localhost:11434` — Python worker calls via HTTP or the `ollama` pip package.

### HuggingFace + llama.cpp (manual control)
```bash
pip install huggingface-hub

huggingface-cli download Qwen/Qwen2.5-7B-Instruct-GGUF \
  qwen2.5-7b-instruct-q4_k_m.gguf \
  --local-dir ./models

./llama-server -m ./models/qwen2.5-7b-instruct-q4_k_m.gguf -c 8192
```

### From Python (llama-cpp-python)
```python
from llama_cpp import Llama

llm = Llama.from_pretrained(
    repo_id="Qwen/Qwen2.5-7B-Instruct-GGUF",
    filename="qwen2.5-7b-instruct-q4_k_m.gguf",
    n_ctx=8192,
)
```

## Serving Options

| Tool | Best For | Notes |
|---|---|---|
| **Ollama** | Easiest setup | Good for batch ingest processing; simple REST API |
| **vLLM** | High throughput | Better for concurrent chunk processing |
| **llama.cpp / llama-cpp-python** | Lowest overhead | CPU-viable with quantized models |

## Integration Point in DocuLyze

The NER model slots into the ingest pipeline after chunking (`chunker.py`) and before/alongside embedding (`embedding.py`). The extracted entities could be:
- Stored as chunk-level metadata in ChromaDB (enabling entity-filtered retrieval)
- Written to Firestore document records (enabling entity-based search/browse in the UI)
- Both

The RAG chat model serves the planned chat interface, receiving retrieved chunks as context and generating grounded answers.
