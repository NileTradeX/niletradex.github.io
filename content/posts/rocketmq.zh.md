---
title: "在 EKS 集群使用 Helm 部署 RocketMQ 集群"
date: "2024-07-25"
tags: ["EFS","RocketMQ"]
description: ""
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
---

# 在 EKS 集群使用 Helm 部署 RocketMQ 集群

## 前置条件

在开始之前，确保您已经具备以下条件：

1. 一个可用的 EKS 集群。
2. 已安装并配置好的 `kubectl` 和 `Helm`。

### 版本兼容性

- Kubernetes 1.18+
- Helm 3.3+
- RocketMQ `>= 4.5`

## 步骤一：配置 Kubernetes 命名空间

首先，为 RocketMQ 创建一个新的命名空间：

```bash
kubectl create namespace rocketmq
```

## 步骤二：添加 RocketMQ Helm 仓库

添加 RocketMQ 的 Helm 仓库：

```bash
## 添加 helm 仓库
helm repo add rocketmq-repo https://helm-charts.itboon.top/rocketmq
helm repo update rocketmq-repo
```

## 步骤三：安装存储类

创建`SC.yaml`文件，复制以下文本创建存储类。前提 EKS 集群配置好 EBS 存储插件，[参考文档](https://docs.aws.amazon.com/eks/latest/userguide/ebs-csi.html)

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: gp3
provisioner: ebs.csi.aws.com
parameters:
  type: gp3
reclaimPolicy: Retain
volumeBindingMode: WaitForFirstConsumer
```

## 步骤四：配置 RocketMQ 

RocketMQ 安装后，您可以根据需要自定义配置。可以通过 Helm 的 `values.yaml` 文件来完成。先下载 `values.yaml` 文件：

```bash
helm show values rocketmq-repo/rocketmq > values.yaml
```

编辑 `values.yaml` 文件，根据您的需求修改配置。例如，可以调整 `broker` 的数量，或修改 `storageClass` 以适应 EKS 环境。

以下为示例的配置

```yaml
clusterName: "rocketmq-cluster-production"
nameOverride: rocketmq

image:
  repository: "apache/rocketmq"
  pullPolicy: IfNotPresent
  tag: "5.2.0"

broker:
  size:
    master: 2
    replica: 1

  master:
    brokerRole: ASYNC_MASTER
    jvm:
      maxHeapSize: 2048M
      # javaOptsOverride: ""
    resources:
      limits:
        cpu: 4
        memory: 16Gi
      requests:
        cpu: 500m
        memory: 4Gi

  replica:
    jvm:
      maxHeapSize: 1300M
      # javaOptsOverride: ""
    resources:
      limits:
        cpu: 4
        memory: 16Gi
      requests:
        cpu: 100m
        memory: 2Gi

  persistence:
    enabled: true
    size: 20Gi
    storageClass: "gp3"

  aclConfigMapEnabled: true
  aclConfig: |
    globalWhiteRemoteAddresses:
      - '*'
      - 10.*.*.*
      - 192.168.*.*
    accounts:
      - accessKey: greatWay
        secretKey: d6a3ba3d
        whiteRemoteAddress: '*'
        # if it is admin, it could access all resources
        admin: true

  config:
    ## brokerClusterName brokerName brokerRole brokerId 由内置脚本自动生成
    deleteWhen: "04"
    fileReservedTime: "48"
    flushDiskType: "ASYNC_FLUSH"
    waitTimeMillsInSendQueue: "1000"
    aclEnable: true

  affinityOverride: {}
  nodeSelector: {}

  ## broker.readinessProbe
  readinessProbe:
    tcpSocket:
      port: main
    initialDelaySeconds: 20
    periodSeconds: 10
    timeoutSeconds: 5
    failureThreshold: 3

nameserver:
  replicaCount: 2

  jvm:
    maxHeapSize: 1024M
    # javaOptsOverride: ""

  resources:
    limits:
      cpu: 2
      memory: 6Gi
      ephemeral-storage: 8Gi
    requests:
      cpu: 50m
      memory: 1Gi
      ephemeral-storage: 1Gi

  persistence:
    enabled: false
    size: 8Gi
    #storageClass: "gp2"

  affinityOverride: {}
  nodeSelector: {}

  ## nameserver.readinessProbe
  readinessProbe:
    tcpSocket:
      port: main
    initialDelaySeconds: 20
    periodSeconds: 10
    timeoutSeconds: 5
    failureThreshold: 3

proxy:
  enabled: true
  replicaCount: 2
  jvm:
    maxHeapSize: 1024M
    # javaOptsOverride: ""

  resources:
    limits:
      cpu: 2
      memory: 6Gi
    requests:
      cpu: 100m
      memory: 2Gi

  affinityOverride: {}
  nodeSelector: {}

  ## proxy.readinessProbe
  readinessProbe:
    tcpSocket:
      port: main
    initialDelaySeconds: 20
    periodSeconds: 10
    timeoutSeconds: 5
    failureThreshold: 3

  ## proxy.service
  service:
    annotations:
      external-dns.alpha.kubernetes.io/hostname: rocketmq-proxy.great-way.link
    type: LoadBalancer

dashboard:
  enabled: true
  replicaCount: 1
  image:
    repository: "apacherocketmq/rocketmq-dashboard"
    pullPolicy: IfNotPresent
    tag: "1.0.0"

  auth:
    enabled: true
    users:
      - name: admin
        password: Great8765Way
        isAdmin: true
      - name: greatWay
        password: greatWay09752

  jvm:
    maxHeapSize: 600M

  resources:
    limits:
      cpu: 1
      memory: 2Gi
    requests:
      cpu: 20m
      memory: 1Gi

  ## dashboard.readinessProbe
  readinessProbe:
    failureThreshold: 5
    httpGet:
      path: /
      port: http
  livenessProbe: {}

  service:
    annotations: {}
    type: ClusterIP
    # nodePort: 31007

  ingress:
    enabled: true
    className: "alb"
    annotations:
      kubernetes.io/ingress.class: alb
      alb.ingress.kubernetes.io/scheme: internet-facing
      alb.ingress.kubernetes.io/target-type: ip
      alb.ingress.kubernetes.io/listen-ports: '[{"HTTP": 80}, {"HTTPS":443}]'
      alb.ingress.kubernetes.io/certificate-arn: arn:aws:acm:us-west-1:992382721746:certificate/455cfe47-104c-46ad-9efc-5a303ba09635
    hosts:
      - host: rocketmq-dashboard.great-way.link
    tls: []
    #  - secretName: example-tls
    #    hosts:
    #      - rocketmq-dashboard.example.com
```

## 步骤五：部署 RocketMQ

使用以下命令在 `rocketmq` 命名空间中安装 RocketMQ：

```bash
helm upgrade --install rocketmq rocketmq-repo/rocketmq-cluster -f values.yaml --namespace rocketmq --create-namespace
```

可以通过以下命令检查安装情况：

```bash
helm ls --namespace rocketmq
```

## 步骤六：验证部署

部署完成后，验证 RocketMQ 集群是否正常运行：

```bash
kubectl get pods --namespace rocketmq
```

确保所有 pod 都处于 `Running` 状态。

```
kubectl get pods --namespace rocketmq
NAME                                  READY   STATUS    RESTARTS   AGE
rocketmq-broker-master-0              1/1     Running   0          8d
rocketmq-broker-master-1              1/1     Running   0          8d
rocketmq-broker-replica-id1-0         1/1     Running   0          2d23h
rocketmq-broker-replica-id1-1         1/1     Running   0          8d
rocketmq-dashboard-645d97c69b-2xmw6   1/1     Running   0          8d
rocketmq-nameserver-0                 1/1     Running   0          8d
rocketmq-nameserver-1                 1/1     Running   0          8d
rocketmq-proxy-7dc9dc9d58-8fph9       1/1     Running   0          8d
rocketmq-proxy-7dc9dc9d58-mgdwm       1/1     Running   0          8d
```

## 步骤七：访问 RocketMQ

在 Kubernetes 集群内访问可以通过 `rocketmq-proxy` 或者 `rocketmq-nameserver` 的 service 地址访问

 - `rocketmq-proxy`：rocketmq-proxy.rocketmq.svc.cluster.local:8081
 - `rocketmq-nameserver`：rocketmq-nameserver.rocketmq.svc.cluster.local:9876

## 常见问题排查

如果在部署过程中遇到问题，可以通过以下命令查看 pod 的日志：

```bash
kubectl logs <pod_name> --namespace rocketmq
```

通过这些日志，可以了解 RocketMQ 集群启动过程中出现的具体问题并进行相应的处理。

## 总结

通过以上步骤，您应该能够在 EKS 集群上成功部署并运行 RocketMQ 集群。使用 Helm 大大简化了部署和管理工作，使得您可以更专注于应用层面的开发和优化。

------
