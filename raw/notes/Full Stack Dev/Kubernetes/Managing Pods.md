# Managing Pods

## Delete all pods in a namespace

```bash
kubectl delete pods --all -n <namespace>
```

If pods are managed by a Deployment/ReplicaSet/StatefulSet, they will respawn immediately. To truly stop them, delete the controller:

```bash
kubectl delete deployments --all -n <namespace>
```

## Pulling updated images

If you repush a Docker image with the same tag (e.g. `latest`), the cluster won't automatically pull the new version unless `imagePullPolicy` is set to `Always` in the deployment spec.

Force a fresh pull by restarting the rollout:

```bash
kubectl rollout restart deployment/<deployment-name> -n <namespace>
```

Use versioned tags (`v1.0`, `v1.1`) instead of `latest` to avoid caching issues and make rollbacks easy.
