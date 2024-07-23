---
title: "Deploy Loki to collect EKS cluster logs"
date: "2024-07-23"
tags: ["Loki","EKS"]
description: ""
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
---

## Deploying Loki on an EKS Cluster using Helm

### Introduction

In this article, we will learn how to deploy the Loki logging aggregation system on an Amazon EKS (Elastic Kubernetes Service) cluster using the Helm tool. Loki, developed by Grafana, is an open-source log aggregation system designed for Kubernetes and containerized workloads.

### Prerequisites

- An EKS cluster set up and accessible.
- `kubectl` and `helm` tools installed and configured to connect to your EKS cluster.

#### Software Requirements

- Helm 3 or above. See [Installing Helm](https://helm.sh/docs/intro/install/).

### Steps

#### 1. Add the Loki Helm Repository

First, add the Loki Helm repository to your Helm client:

```bash
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
```

#### 2. Create the Loki Configuration File

Create a `values.yaml` file to configure the Loki Helm deployment. Here is a basic configuration example:

```yaml
deploymentMode: SingleBinary
loki:
  commonConfig:
    replication_factor: 1
  storage:
    type: 'filesystem'
  schemaConfig:
    configs:
    - from: "2024-01-01"
      store: tsdb
      index:
        prefix: loki_index_
        period: 24h
      object_store: filesystem # we're storing on filesystem so there's no real persistence here.
      schema: v13
singleBinary:
  replicas: 1
read:
  replicas: 0
backend:
  replicas: 0
write:
  replicas: 0
```

Modify the configuration according to your needs, such as storage type, persistent storage, etc.

#### 3. Deploy Loki using Helm

Install Loki on your EKS cluster using Helm:

```bash
helm upgrade --install loki --values  values.yaml --namespace=loki grafana/loki
```

This will create the necessary Loki resources in your cluster.

#### 4. Verify the Deployment

Check if the Loki-related pods are running properly:

```bash
kubectl get pods -n loki
```

```
> kubectl get pods -n loki
NAME                          READY   STATUS    RESTARTS   AGE
loki-0                        1/1     Running   0          7d
loki-canary-2c2jm             1/1     Running   0          7d6h
loki-canary-5gc5d             1/1     Running   0          7d6h
loki-canary-dvbgj             1/1     Running   0          7d6h
loki-canary-xrvsh             1/1     Running   0          7d1h
loki-chunks-cache-0           2/2     Running   0          7d23h
loki-gateway-b8957b47-2zrmb   1/1     Running   0          7d23h
loki-results-cache-0          2/2     Running   0          29h
```

Ensure all pods are in the `Running` state.

#### 5. Access Loki

Loki instances can be accessed through the Loki service, e.g. http://loki-gateway.loki.svc.cluster.local This address will be used when configuring the grafana data source later.

```
> kubectl get service -n loki
NAME                 TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)              AGE
loki                 ClusterIP   172.20.114.51    <none>        3100/TCP,9095/TCP    7d23h
loki-canary          ClusterIP   172.20.187.211   <none>        3500/TCP             7d23h
loki-chunks-cache    ClusterIP   None             <none>        11211/TCP,9150/TCP   7d23h
loki-gateway         ClusterIP   172.20.198.116   <none>        80/TCP               7d23h
loki-headless        ClusterIP   None             <none>        3100/TCP             7d23h
loki-memberlist      ClusterIP   None             <none>        7946/TCP             7d23h
loki-results-cache   ClusterIP   None             <none>        11211/TCP,9150/TCP   7d23h
```

### Conclusion

We have deployed Loki to the EKS cluster using Helm, but this does not collect logs from all the EKS pods, so we will need to install `Promtail` to collect logs from all the pods.

------
