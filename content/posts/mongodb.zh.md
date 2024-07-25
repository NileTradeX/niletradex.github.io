---
title: "在 EKS 集群上使用 Helm 部署 MongoDB Operator 并部署 MongoDB 集群"
date: "2024-07-25"
tags: ["EFS", "MongoDB"]
description: ""
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
ShowWordCount: true 
---

# 在 EKS 集群上使用 Helm 部署 MongoDB Operator 并部署 MongoDB 集群

在 Kubernetes 中，Operator 是一种用于自动化管理应用程序和基础设施的工具。MongoDB Operator 使我们可以在 Kubernetes 集群上更轻松地管理 MongoDB 集群。本文将介绍如何在 Amazon EKS（Elastic Kubernetes Service）集群上使用 Helm 部署 MongoDB Operator，并使用该 Operator 部署一个 MongoDB 集群。

## 准备工作

在开始之前，请确保您已经准备好了以下环境：

1. 已安装并配置好的 Amazon EKS 集群。
2. 已安装的 Helm（版本 3 及以上）。
3. 已安装并配置好的 `kubectl` 命令行工具。

### 参考文档

[![MongoDBOperator](https://via.placeholder.com/100x30?text=MongoDBOperator)](https://github.com/mongodb/mongodb-kubernetes-operator/blob/master/README.md)

## 步骤一：安装 MongoDB Operator

首先，我们需要使用 Helm 安装 MongoDB Operator。MongoDB 提供了一个 Helm chart，可以方便地在 Kubernetes 集群中部署 MongoDB Operator。

1. 添加 MongoDB Helm 仓库：

```bash
helm repo add mongodb https://mongodb.github.io/helm-charts
helm repo update
```

2. 使用 Helm 安装 MongoDB Operator：

```bash
helm install mongodb-operator mongodb/community-operator --set operator.watchNamespace="mongodb" --namespace mongodb --create-namespace
```

   这条命令会在 `mongodb` 命名空间中安装 MongoDB Operator。如果您想使用其他命名空间，请相应地修改命令。`--set operator.watchNamespace="mongodb"` 为 Operator 应监视的命名空间。

## 步骤二：部署 MongoDB 集群

一旦 MongoDB Operator 安装完成，我们就可以使用它来部署 MongoDB 集群。

1. 创建一个 MongoDB Custom Resource（CR）文件（例如 `mongodb-cluster.yaml`）：

```yaml
---
apiVersion: mongodbcommunity.mongodb.com/v1
kind: MongoDBCommunity
metadata:
  name: mongodb
  namespace: mongodb
spec:
  members: 2
  arbiters: 1
  type: ReplicaSet
  version: "6.0.5"
  security:
    authentication:
      modes: ["SCRAM"]
  users:
    - name: greatway
      db: admin
      passwordSecretRef: # a reference to the secret that will be used to generate the user's password
        name: mongodb-password
      roles:
        - name: clusterAdmin
          db: admin
        - name: userAdminAnyDatabase
          db: admin
      scramCredentialsSecretName: mongodb-scram
  additionalMongodConfig:
    storage.wiredTiger.engineConfig.journalCompressor: zlib
  statefulSet:
    spec:
      selector:
        matchLabels:
          app.kubernetes.io/name: mongodb
      template:
        metadata:
          # label the pod which is used by the "labelSelector" in podAntiAffinty
          # you can label it witch some other labels as well -- make sure it change the podAntiAffinity labelselector accordingly
          labels:
           app.kubernetes.io/name: mongodb
        spec:
          tolerations:
          - key: "role"
            operator: "Equal"
            value: "middleware"
            effect: "NoSchedule"
          affinity:
            podAntiAffinity:
              preferredDuringSchedulingIgnoredDuringExecution:
                - weight: 100
                  podAffinityTerm:
                    labelSelector:
                      matchExpressions:
                        - key: app.kubernetes.io/name
                          operator: In
                          values:
                            - mongodb
                    topologyKey: kubernetes.io/hostname
      volumeClaimTemplates:
        - metadata:
            name: data-volume
          spec:
            accessModes: ["ReadWriteOnce"]
            storageClassName: gp3
            resources:
              requests:
                storage: 16G
        - metadata:
            name: logs-volume
          spec:
            accessModes: [ "ReadWriteOnce" ]
            storageClassName: gp3
            resources:
              requests:
                storage: 2G

# the user credentials will be generated from this secret
# once the credentials are generated, this secret is no longer required
---
apiVersion: v1
kind: Secret
metadata:
  name: mongodb-password
  namespace: mongodb
type: Opaque
stringData:
  password: ursYCnELB36S73lk
```

   在这个文件中，我们定义了一个名为 `mongodb` 的 MongoDB 集群，包含 2 个成员、1 个仲裁者，使用 MongoDB 6.0.5 版本，并启用了持久存储。

2. 应用该 MongoDB CR 文件以部署 MongoDB 集群：

```bash
kubectl apply -f mongodb-cluster.yaml
```

   这条命令会在 `mongodb` 命名空间中创建一个 MongoDB 集群。

## 步骤三：验证 MongoDB 集群

要验证 MongoDB 集群是否成功部署，请执行以下步骤：

1. 查看 MongoDB Operator 和 MongoDB 集群的 Pod 状态：

```bash
kubectl get pods -n mongodb
```

   您应该会看到 MongoDB Operator 的 Pod 和 MongoDB 集群的 Pod 都处于 `Running` 状态。

2. 查看 MongoDB 集群的服务：

```bash
kubectl get svc -n mongodb
```

   您应该会看到与 MongoDB 集群相关的服务。

## 总结

通过上述步骤，我们成功地在 Amazon EKS 集群上使用 Helm 部署了 MongoDB Operator，并使用该 Operator 部署了一个 MongoDB 集群。这使得我们可以更轻松地管理和扩展我们的 MongoDB 集群，同时利用 Kubernetes 的强大功能来确保高可用性和可伸缩性。

------
