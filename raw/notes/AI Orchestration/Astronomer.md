# Overview


## What AI Orchestration means
**With a pipeline:**
* It controls the run
* It checks the inputs, outputs, dependencies, etc.

## Which Work Belongs to AI
* Categorize a ticket into 5 categories = **AI**
* Calculate monthly revenue from subscription records = **Deterministic**
* Extract a renewal date from a contract PDF = **AI** + **deterministic**
## Turn a Business into a DAG


### AI Output
AI outputs should always be structured so that it can be reliably checked by deterministic validation checks

### Pydantic 
An industry standard for structured data format is Pydantic (I used this for my NER extraction)

### Branch on Validated AI Results

```python
ROUTE_BY_INTENT = {
...
}

```

## Decide What Should Retry
1. **Cost per call**: How much does each attempt spend in tokens, time, and rate-limit capacity?
***Retry the code. Do not retry the answer***
2. 

### Use an AI Call Pool
Much like the bucket token algorihtm for rate limiting. Used to avoid getting rate limited or blasting credits when there is an infrastructure issue.

### Prevent retry storms
Idempotency, a normal task it means running twice doesn't create two different duplicate rows. For AI, it means a call can't generate two different decisions


### Computing a model
How to compute:
Daily Volume = 20,000
average input = 600
output = 50 

## Do you need an Agent?
1. **Can upstream tasks fetch everything the model needs before the call?**
		If yes, use an informed LLM approach
		If no, the model has to decide what to look up. The model must run with a tool in a loop
2. **Is the work a loop?**
		Model equipped with tools => performs an action => Observes output => Decides next decision => repeat

#### Durable
Caches output and model calls, so retry calls pick up where teh agent left off.

### Give Your Agent SQL access
A **tool** is one named capability with:
	- intention / purpose i.e. querying a database
	- parameters that implement guardrails
	- 
### Hooks
```python

````

## MCP Server
`
The MCP Protocol: A server that contains all of the tools and hooks that the tools follow
```python 
MCPToolset(
	mcp_conn_id = "mcp_weather"
	Tool_prefix= "reports"
)	
```
