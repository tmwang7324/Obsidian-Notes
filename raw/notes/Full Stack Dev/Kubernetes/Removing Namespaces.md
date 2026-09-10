# Removing Namespaces

## Delete a namespace

```bash
kubectl delete namespace <namespace-name>
```

This is irreversible — all resources scoped to that namespace (pods, services, configmaps, secrets, etc.) are destroyed.

## System namespaces (do not delete)

- `default`
- `kube-system`
- `kube-public`
- `kube-node-lease`

Deleting any of these will break the cluster.

## Stuck in `Terminating` state

If a namespace hangs in `Terminating`, a finalizer usually can't complete.

1. Inspect:
   ```bash
   kubectl get namespace <name> -o yaml
   ```
2. Look at the `finalizers` field.
3. Remove the finalizer via `kubectl edit` or a JSON patch — but verify the underlying resource is actually cleaned up first.
