---
title: "使用 Helm 在 EKS 集群部署 Loki 收集 EKS 集群日志"
date: "2024-07-23"
tags: ["Loki","EKS"]
description: ""
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
---

## 使用 Helm 在 EKS 集群部署 Loki 收集 EKS 集群日志

### 介绍

Loki 是一个由 Grafana 实现的开源日志聚合系统，专为 Kubernetes 和容器化工作负载设计。本文将使用 Helm 工具在 Amazon EKS（Elastic Kubernetes Service）集群上部署 Loki 日志聚合系统。

### 前提条件

- 已经设置好并且可以访问 EKS 集群。
- 安装了 `kubectl` 和 `helm` 工具，并配置好可以连接到你的 EKS 集群。

#### 软件要求

- Helm 3 或更高版本。请参阅[安装 Helm](https://helm.sh/docs/intro/install/)。

### 步骤

#### 1. 添加 Loki Helm 仓库

首先，添加 Loki 的 Helm 仓库到你的 Helm 客户端中：

```bash
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
```

#### 2. 创建 Loki 的配置文件

创建一个 `values.yaml` 文件来配置 Loki 的 Helm 部署。以下是一个基本的配置示例：

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

#### 3. 使用 Helm 部署 Loki

使用 Helm 安装 Loki 到你的 EKS 集群中：

```bash
helm upgrade --install loki --values  values.yaml --namespace=loki grafana/loki
```

这将会在你的集群中创建 Loki 的相关资源。

#### 4. 验证部署

使用以下命令检查 Loki 相关的 Pods 是否正常运行：

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
确保所有的 Pods 的状态为 `Running`。

#### 5. 访问 Loki

可以通过 Loki 服务访问 Loki 实例，例如 http://loki-gateway.loki.svc.cluster.local 这个地址会在后续配置 grafana 数据源时用到。

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


### 结论

我们已经使用 Helm 在 EKS 集群部署了 Loki，但是这并不能收集 EKS 所有 Pod 的日志，后续我们还需要安装 `Promtail` 来收集所有 Pod 的日志。

------
