# Overview
This file details the procedure to build a new ingest-worker image, a new ingest network, as well as run containers for it along with the rabbitmq image using the docker compose files.

## Steps
**To build a new doculyze/ingest-worker image, run:**
```bash
docker compose -f docker-compose.yml -f docker-compose.dev.yml build # builds the images specified in docker-compose and overrides the ingest-worker to connect to the firestore emulator instead of prod firestore

docker compose up # only runs the production firestore
docker compose 
```



