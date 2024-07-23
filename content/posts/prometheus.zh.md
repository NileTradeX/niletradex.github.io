---
title: "使用 Helm 在 EKS 集群上部署 Prometheus"
date: "2024-07-23"
tags: ["Prometheus","EKS"]
description: ""
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
---

## 使用 Helm 在 EKS 集群上部署 Prometheus

Prometheus 是一个开源的系统监控和报警工具，而 Helm 是 Kubernetes 的软件包管理工具，它简化了应用的部署和管理过程。本文将使用 Helm 在 AWS 的 EKS（Elastic Kubernetes Service）集群上部署 Prometheus 进行监控。

### 前提条件

在开始之前，请确保你已经具备以下条件：

1. 一个已创建并配置好的 EKS 集群。
2. 已安装并配置好的 `kubectl` 命令行工具。
3. 已安装 Helm。

### 步骤一：配置 kubectl 以访问你的 EKS 集群

确保你的 `kubectl` 已经配置好可以访问你的 EKS 集群。你可以使用 AWS CLI 来配置：

```sh
aws eks --region <region-code> update-kubeconfig --name <cluster-name>
```

### 步骤二：安装 Helm

如果你还没有安装 Helm，请参阅[安装 Helm](https://helm.sh/docs/intro/install/)。

### 步骤三：添加 Prometheus Helm 仓库

首先，我们需要添加 Prometheus 的 Helm 仓库：

```sh
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```

### 步骤四：创建命名空间

为了更好地组织资源，我们将为 Prometheus 创建一个独立的命名空间：

```sh
kubectl create namespace prometheus
```

### 步骤五：使用 Helm 安装 Prometheus

现在，我们可以使用 Helm 在 `prometheus` 命名空间中安装 Prometheus：

```sh
helm upgrade -i prometheus prometheus-community/prometheus --namespace prometheus 
```

这将会部署 Prometheus 及其相关组件。

###### 笔记

如果执行此命令时出现错误`Error: failed to download "stable/prometheus" (hint: running `helm repo update ，请运行，然后尝试再次运行步骤 2 的命令。` may help)``helm repo update prometheus-community`

如果出现错误`Error: rendered manifests contain a resource that already exists`，请运行`helm uninstall *your-release-name* -n *namespace*`，然后尝试再次运行步骤 3 命令。


   ```tex
   Release "prometheus" does not exist. Installing it now.
   NAME: prometheus
   LAST DEPLOYED: Fri Jun  7 10:15:54 2024
   NAMESPACE: prometheus
   STATUS: deployed
   REVISION: 1
   TEST SUITE: None
   NOTES:
   The Prometheus server can be accessed via port 80 on the following DNS name from within your cluster:
   prometheus-server.prometheus.svc.cluster.local
   
   
   Get the Prometheus server URL by running these commands in the same shell:
     export POD_NAME=$(kubectl get pods --namespace prometheus -l "app.kubernetes.io/name=prometheus,app.kubernetes.io/instance=prometheus" -o jsonpath="{.items[0].metadata.name}")
     kubectl --namespace prometheus port-forward $POD_NAME 9090
   
   
   The Prometheus alertmanager can be accessed via port 9093 on the following DNS name from within your cluster:
   prometheus-alertmanager.prometheus.svc.cluster.local
   
   
   Get the Alertmanager URL by running these commands in the same shell:
     export POD_NAME=$(kubectl get pods --namespace prometheus -l "app.kubernetes.io/name=alertmanager,app.kubernetes.io/instance=prometheus" -o jsonpath="{.items[0].metadata.name}")
     kubectl --namespace prometheus port-forward $POD_NAME 9093
   #################################################################################
   ######   WARNING: Pod Security Policy has been disabled by default since    #####
   ######            it deprecated after k8s 1.25+. use                        #####
   ######            (index .Values "prometheus-node-exporter" "rbac"          #####
   ###### .          "pspEnabled") with (index .Values                         #####
   ######            "prometheus-node-exporter" "rbac" "pspAnnotations")       #####
   ######            in case you still need it.                                #####
   #################################################################################
   
   
   The Prometheus PushGateway can be accessed via port 9091 on the following DNS name from within your cluster:
   prometheus-prometheus-pushgateway.prometheus.svc.cluster.local
   
   
   Get the PushGateway URL by running these commands in the same shell:
     export POD_NAME=$(kubectl get pods --namespace prometheus -l "app=prometheus-pushgateway,component=pushgateway" -o jsonpath="{.items[0].metadata.name}")
     kubectl --namespace prometheus port-forward $POD_NAME 9091
   
   For more information on running Prometheus, visit:
   https://prometheus.io/
   ```

### 步骤六：验证安装

你可以使用以下命令查看 Prometheus 是否已成功部署：

```sh
kubectl get pods -n prometheus
```


```
> kubectl get pods -n prometheus
NAME                                                 READY   STATUS    RESTARTS      AGE
prometheus-alertmanager-0                            1/1     Running   0             7d6h
prometheus-kube-state-metrics-67848d7455-sfkmd       1/1     Running   0             7d1h
prometheus-prometheus-node-exporter-j7sfk            1/1     Running   0             7d22h
prometheus-prometheus-node-exporter-mlj2v            1/1     Running   0             7d2h
prometheus-prometheus-node-exporter-rb9ht            1/1     Running   2 (30h ago)   8d
prometheus-prometheus-node-exporter-sx7rb            1/1     Running   0             8d
prometheus-prometheus-pushgateway-58cb869bcc-phfmn   1/1     Running   0             7d1h
prometheus-server-5787759b8c-479n5                   2/2     Running   0             7d6h
```

你应该能够看到多个 Prometheus 相关的 Pod 正在运行。

### 步骤七：访问 Prometheus UI

默认情况下，Prometheus 服务是以 ClusterIP 类型部署的，这意味着它只能在 Kubernetes 集群内部访问。为了从外部访问 Prometheus UI，可以使用端口转发：

```sh
kubectl port-forward -n prometheus deploy/prometheus-server 9090:9090
```

然后你可以在浏览器中访问 `http://localhost:9090` 以查看 Prometheus UI。

### 结论

通过以上步骤，我们成功地使用 Helm 在 EKS 集群上部署了 Prometheus。Prometheus 可以帮助我们监控集群的各种指标，并在需要时发送报警。

如果你希望进一步自定义 Prometheus 的配置，可以参考 Prometheus 的 Helm chart 文档，根据需要修改 `values.yaml` 文件进行配置。

------