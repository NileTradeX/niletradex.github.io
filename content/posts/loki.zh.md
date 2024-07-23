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

根据你的需求修改配置，例如存储类型、持久化存储等。

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

确保所有的 Pods 的状态为 `Running`。

#### 5. 访问 Loki

可以通过暴露 Loki 服务的方式访问 Loki 实例，例如通过 NodePort、LoadBalancer 或者 Ingress。

### 结论

通过这篇文章，你学会了如何使用 Helm 在 Amazon EKS 上部署 Loki 日志聚合系统。你可以进一步扩展这个配置，根据你的需求和环境进行定制和优化。

------

根据你的具体情况，可能需要调整一些细节，比如存储配置、网络访问方式等。希望这可以帮助到你开始在 EKS 上部署 Loki！



