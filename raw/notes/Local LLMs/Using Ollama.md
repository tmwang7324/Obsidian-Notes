# Overview
Ollama is a free open-source platofrm that allows me to run LLMs locally on my own computer.

Instead of sending my data to local servers like OpenAI or Anthropic, Ollama downloads open-weight models --- such as **Llama**, **Mistral**, **Gemma**, and **Qwen** --- directly onto my hardware: *C:\Users\jw300\.cache\huggingface\hub\models--Qwen--Qwen2.5-7B-Instruct\*

## Key Benefits
* **Complete Privacy:** My prompts and data stay on my machine and are never sent to thrid-party servers or used for training.
* **No Cost or Subscriptions:** Once downloaded, running models is free with no recurring API token fees.
* **Offline Capability:** It works entirely without an internet connection after the intiail setup.
* **Developer Friendly:** It provides a simple command-line interface (CLI) and exposes a local REST API that is compatible with OpenAI endpoints.

## Pulling Models
Under the hood, whenever a model is being pulled from the Ollama registry, a modelfile is created.


### Python Chat Implementation Using OpenAI
```python
from langchain_core.messages import HumanMessage, SystemMessage
from langchain_openai import OpenAI

  

# --- Ollama-hosted Qwen 2.5 7B ---

# HuggingFace version downloads to C:\Users\jw300\.cache\huggingface\hub\models--Qwen--Qwen2.5-7B-Instruct\

MODEL_NAME = "qwen2.5:14b-instruct-q4_K_M"
SYSTEM_PROMPT="What is the Capital of France?"
client = ChatOpenAI(base_url="http://localhost:11434/v1", api_key="ollama")

context = "\n\n --- \n\n Some context"

response = llm.invoke([
    SystemMessage(
        content=(
            "Answer the following question based only on the provided context. "
            # "If the context does not contain the answer, respond with 'I don't know.'"
        )
    ),
HumanMessage(content=f"Context:\n{context}\n\nQuestion:\n{question}"),
])
print(response.content)
	
```

### Maximizing GPU
To maximize GPU usage, it is imperative to 
### Set GPU Layers
```bash
set OLLAMA_GPU_L
```