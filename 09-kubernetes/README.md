# 09 - Kubernetes

Container orchestration at scale. Kubernetes runs your containers in production with high availability.

## What You'll Learn

- Kubernetes architecture
- Pods, Deployments, Services
- ConfigMaps and Secrets
- Ingress and networking
- Persistent storage
- Helm charts
- Monitoring and debugging
- Production best practices

## Folder Structure

```
09-kubernetes/
├── notes/       # Your notes from lessons
├── labs/        # Completed lab exercises
└── projects/    # Hands-on projects
```

## Suggested Projects

- [ ] Deploy a multi-tier application
- [ ] Set up Ingress with TLS
- [ ] Create a Helm chart for your app
- [ ] Implement horizontal pod autoscaling
- [ ] Set up monitoring with Prometheus/Grafana

## Key Resources

| Resource | Purpose |
|----------|---------|
| Pod | Smallest deployable unit |
| Deployment | Manages pod replicas |
| Service | Exposes pods internally |
| Ingress | Exposes services externally |
| ConfigMap | Non-sensitive configuration |
| Secret | Sensitive data |
| PersistentVolume | Storage |
| Namespace | Resource isolation |

## Essential Commands

```bash
# Get resources
kubectl get pods
kubectl get svc
kubectl get deployments
kubectl get all

# Describe resources
kubectl describe pod <name>
kubectl describe svc <name>

# Logs
kubectl logs <pod>
kubectl logs -f <pod>

# Exec into pod
kubectl exec -it <pod> -- /bin/sh

# Apply manifests
kubectl apply -f manifest.yaml
kubectl delete -f manifest.yaml

# Context
kubectl config get-contexts
kubectl config use-context <name>
```

## Basic Deployment

```yaml
# deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
        - name: web
          image: nginx:1.25
          ports:
            - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: web
spec:
  selector:
    app: web
  ports:
    - port: 80
      targetPort: 80
  type: ClusterIP
```

## Local Development

For learning, use one of these to run Kubernetes locally:

- **Kind** – Kubernetes in Docker (recommended)
- **Minikube** – Local VM-based cluster
- **Docker Desktop** – Built-in Kubernetes

## Resources

- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
- [Helm Documentation](https://helm.sh/docs/)
