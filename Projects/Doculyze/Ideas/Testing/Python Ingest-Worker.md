# Overview
All Python ingest-worker tests are built using `pytest.` Like [[Next.js App | Next.js App Testing]], ensure that emulators are activated and docker containers are created.

## Useful Variants
```bash
.venv\Scripts\python -m pytest tests\test_firestore_status.py -q   # just the claim table

.venv\Scripts\python -m pytest tests -q -k busy                    # tests matching "busy"
.venv\Scripts\python -m pytest tests -v                            # verbose, one line per test
```