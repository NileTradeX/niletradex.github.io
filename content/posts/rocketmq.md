---
title: "Deploying a RocketMQ Cluster with Helm in an EKS Cluster"
date: "2024-07-25"
tags: ["EFS", "RocketMQ"]
description: ""
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
ShowWordCount: true 
---

# Deploying a RocketMQ cluster with Helm in an EKS cluster.

## Pre-requisites

Before you begin, make sure that you have the following conditions in place:

1. an available EKS cluster.
2. an installed and configured `kubectl` and `Helm`.

### Version compatibility

- Kubernetes 1.18+
- Helm 3.3+
- RocketMQ `>= 4.5`.

## Step 1: Configure the Kubernetes Namespace

First, create a new namespace for RocketMQ:

```bash
kubectl create namespace rocketmq
```

## Step 2: Add the RocketMQ Helm repository

Add the RocketMQ Helm repository:

```bash
## Add the helm repository
helm repo add rocketmq-repo https://helm-charts.itboon.top/rocketmq
helm repo update rocketmq-repo
```

## Step 3: Install the storage class

Create the `SC.yaml` file and copy the following text to create the storage class. Prerequisite The EKS cluster is configured with the EBS storage plugin, [refer to the documentation](https://docs.aws.amazon.com/eks/latest/userguide/ebs-csi.html)

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata.
  name: gp3
provider: ebs.csi.aws.com
parameters: type: gp3
  type: gp3
reclaimPolicy: Retain
volumeBindingMode: WaitForFirstConsumer
```

## Step 4: Configuring RocketMQ 

Once RocketMQ is installed, you can customise the configuration as needed. This can be done through the `values.yaml` file in Helm. First, download the ``values.yaml`` file:

```bash
helm show values rocketmq-repo/rocketmq > values.yaml
```

Edit the `values.yaml` file to modify the configuration to suit your needs. For example, you can adjust the number of `brokers` or modify the `storageClass` to fit the EKS environment.

The following is an example configuration

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

## Step 5: Deploying RocketMQ

Install RocketMQ in the `rocketmq` namespace using the following command:

```bash
helm upgrade --install rocketmq rocketmq-repo/rocketmq-cluster -f values.yaml --namespace rocketmq --create-namespace
```

The installation can be checked with the following command:

```bash
helm ls --namespace rocketmq
```

## Step 6: Verify Deployment

Once the deployment is complete, verify that the RocketMQ cluster is working properly:

```bash
kubectl get pods --namespace rocketmq
```

Ensure that all pods are in the `Running` state.

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

## Step 7: Accessing RocketMQ

Access within the Kubernetes cluster can be through the `rocketmq-proxy` or `rocketmq-nameserver` service addresses

 - `rocketmq-proxy`: rocketmq-proxy.rocketmq.svc.cluster.local:8081
 - `rocketmq-nameserver`: rocketmq-nameserver.rocketmq.svc.cluster.local:9876

## Troubleshooting Common Problems

If you encounter problems during deployment, you can check the pod's logs with the following command:

```bash
kubectl logs <pod_name> --namespace rocketmq
```

You can use these logs to see what problems occurred during the startup of the RocketMQ cluster and deal with them accordingly.

## Summary

With these steps, you should be able to successfully deploy and run a RocketMQ cluster on an EKS cluster. Using Helm greatly simplifies deployment and management, allowing you to focus on application-level development and optimisation.

------

