---
type: idea
project: Doculyze
aliases: [Docker Compose CLI Equivalent]
tags: [docker, doculyze]
updated: 2026-08-10
---

# (C) Docker Compose CLI Equivalent

The `docker run` CLI equivalents of Doculyze's `docker-compose.yml` (base) and `docker-compose.dev.yml` (dev override). Useful for understanding what `docker compose up` actually does under the hood.

## Setup: network and volume

```bash
docker network create ingest
docker volume create chunk-output
```

## RabbitMQ

```bash
docker run -d \
  --name rabbitmq \
  --hostname doculyze-rabbit \
  --network ingest \
  -e RABBITMQ_DEFAULT_USER=doculyze \
  -e RABBITMQ_DEFAULT_PASS="${RABBITMQ_PASS:-devpass}" \
  -p 127.0.0.1:5672:5672 \
  -p 127.0.0.1:15672:15672 \
  --health-cmd "rabbitmq-diagnostics -q ping" \
  --health-interval 10s \
  --health-timeout 5s \
  --health-retries 5 \
  rabbitmq:4-management
```

## Build the worker image

```bash
docker build -t doculyze-ingest-worker ./ingest-worker
```

## Ingest worker — base (production-like)

Uses a named volume for chunk output.

```bash
docker run -d \
  --name ingest-worker \
  --network ingest \
  -e RABBITMQ_URL="amqp://doculyze:${RABBITMQ_PASS:-devpass}@rabbitmq:5672" \
  -e INGEST_QUEUE=doc.ingest \
  -e FIREBASE_STORAGE_BUCKET="${FIREBASE_STORAGE_BUCKET:-doculyze.firebasestorage.app}" \
  -e GOOGLE_APPLICATION_CREDENTIALS=/run/secrets/serviceAccount.json \
  -e CHUNK_OUTPUT_DIR=/data/chunks \
  -v "$(pwd)/doculyze/serviceAccount.json:/run/secrets/serviceAccount.json:ro" \
  -v chunk-output:/data/chunks \
  doculyze-ingest-worker
```

## Ingest worker — dev override

Two differences from base: adds `FIRESTORE_EMULATOR_HOST` so the worker points at the host's Firestore emulator, and swaps the named volume for a bind-mount so chunks are visible on the host filesystem.

```bash
docker run -d \
  --name ingest-worker \
  --network ingest \
  -e RABBITMQ_URL="amqp://doculyze:${RABBITMQ_PASS:-devpass}@rabbitmq:5672" \
  -e INGEST_QUEUE=doc.ingest \
  -e FIREBASE_STORAGE_BUCKET="${FIREBASE_STORAGE_BUCKET:-doculyze.firebasestorage.app}" \
  -e GOOGLE_APPLICATION_CREDENTIALS=/run/secrets/serviceAccount.json \
  -e CHUNK_OUTPUT_DIR=/data/chunks \
  -e FIRESTORE_EMULATOR_HOST=host.docker.internal:8085 \
  -v "$(pwd)/doculyze/serviceAccount.json:/run/secrets/serviceAccount.json:ro" \
  -v "$(pwd)/ingest-worker/chunk-output:/data/chunks" \
  doculyze-ingest-worker
```

## Notes

- **`depends_on` has no CLI equivalent.** Compose's health-gated dependency doesn't translate — you'd poll `docker inspect --format='{{.State.Health.Status}}' rabbitmq` manually or script a wait loop before starting the worker.
- **Network DNS works by container name.** Containers on the same `--network` resolve each other by `--name`, so `rabbitmq` in the AMQP URL resolves correctly.
