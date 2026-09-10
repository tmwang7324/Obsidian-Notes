# Pushing Images to Docker Hub

## First-time push

1. **Login:**
   ```bash
   docker login
   ```

2. **Tag your image** with your Docker Hub username:
   ```bash
   docker tag <local-image>:<tag> <dockerhub-username>/<repo-name>:<tag>
   ```

3. **Push:**
   ```bash
   docker push <dockerhub-username>/<repo-name>:<tag>
   ```

## Rebuilding and repushing

Tag directly during the build to skip the separate `docker tag` step:

```bash
docker build -t <dockerhub-username>/<repo-name>:<tag> .
docker push <dockerhub-username>/<repo-name>:<tag>
```

Docker Hub overwrites the tag if it already exists.

## Viewing pushed images

- **Browser:** `https://hub.docker.com/r/<username>/<repo-name>`
- **CLI — remote manifest:** `docker manifest inspect <username>/<repo-name>:<tag>`
- **CLI — local images:** `docker images`

## Tagging best practices

Use versioned tags (`v1.0`, `v1.1`) instead of `latest` — makes rollbacks trivial and avoids Kubernetes caching surprises.
