# Overview
To test the next.js app for features Github Issue #2 [[(C) Mint-First Lifecycle Reversal]] , [[(C) Stale-Pending Reap]] and onward, be sure to fire up the Firebase [[Emulators]]  and run the docker containers for **ingest-worker**
```bash
npm run emulators # run emulators
docker compose -f docker-compose.yaml -f docker-compose-dev.yaml up
# OR
docker compose -f docker-compose.yaml -f docker-compose-dev.yaml -d --build 

```


## commands
#### test
To run all tests, use:
```bash
npm run test
```

#### test:watch
To watch the tests on firebase emulators, use the command:
```bash
npm run test:watch
```

#### test --file_name, path
This command only runs the tests for file {file_path} provided after `--`. 

The -- passes everything after it to Vitest/ It matchesby partial filename, so `utils` alond would run any test file containing "utils" in the path.

```bash
npm run test --file_name,
```

#### reporter=verbose
In order to see every single `describe() + it()` test, add the `--reporter=verbose` flag
```bash
npx vitest --reporter=verbose # displays the result of every describe and it assertion
```