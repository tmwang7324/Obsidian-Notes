# Overview 
A cheatsheet for essential commands to know for Python
## Creating a virtual env
I use `uv`:
```bash
uv venv --python 3.11 myenv # creates virtual environment named myenv with Python version 3.11
source myenv/Scripts/activate # activates virtual environment in terminal (interactive shell)
uv sync # syncs environment to current dependencies
uv pip install <package-name> # installs package to activated venv with uv
uv pip install -r requirements.txt # installs all packages listed in requirements.txt to current virtual env
uv pip check

```
Using regular `python -m venv`:
```bash
python -m venv .venv
```
The way to activate and the virtual environment is the same as `uv.` Execute `activate.bat` in `.venv/Scripts`


## Enumerate

## Creating a Module
Create an empty `__init__.py` in the folder you want to be a module.
***For example:*** In [Doculyze], `ingest` is a module because it has an empty `__init__.py`

To run a specific file within a module, run `python -m <module-name>.<script-name>`

## Reading Files
There are 4 primary ways to read files:

| Method                | Output Type     | Best Used For                                        |     |
| --------------------- | --------------- | ---------------------------------------------------- | --- |
| **read()**            | `str`           | Small files where I need all text at once            |     |
| **for line in file:** | `str`           | Large datasets and text logs to save system RAM      |     |
| **readlines()**       | `list` of `str` | Parsing files where I need relative line lookups<br> |     |
| **json.dump()**       | `object`        | Exporting JSON content into objects                  |     |


```python
with open(file_path: str, "r", encoding="utf-8") as f: 
	for line in f:
		print(line)
		
with open(file_path: str, "r", encodindg="utf-8") as f:
	lines = f.readlines()
	
	
		
```

## Writing to Files