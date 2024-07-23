---
title: "使用 Helm 在 EKS 集群部署 Grafana"
date: "2024-07-23"
tags: ["Grafana","EKS"]
description: ""
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
---

# 使用 Helm 在 EKS 集群部署 Grafana

Grafana 是一个开源的监控和观察工具，可以与多种数据源集成，如 Prometheus、Loki 等。在本文中将详细介绍如何使用 Helm 在 Amazon EKS（Elastic Kubernetes Service）集群上部署 Grafana。

我们将通过以下几个步骤完成部署：

1. **准备工作**
2. **安装 Helm**
3. **配置 EKS 集群**
4. **使用 Helm 部署 Grafana**
5. **访问 Grafana**

## 1. 准备工作

在开始之前，请确保你已经完成以下准备工作：

- 已经创建并配置了一个 EKS 集群。
- 已经安装并配置了 `kubectl` 命令行工具。
- 已经安装了 AWS CLI 并配置了适当的凭证。

## 2. 安装 Helm

Helm 是 Kubernetes 的包管理工具。如果你还没有安装 Helm，请参阅[安装 Helm](https://helm.sh/docs/intro/install/)。

## 3. 配置 EKS 集群

确保你的 `kubectl` 已经正确配置并可以访问你的 EKS 集群：

```sh
aws eks --region <your-region> update-kubeconfig --name <your-cluster-name>
kubectl get nodes
```

上述命令应该返回你的 EKS 集群中的节点列表，表明 `kubectl` 已经正确配置。

## 4. 使用 Helm 部署 Grafana

1. 添加 Helm 仓库：

```sh
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
```

2. 创建一个命名空间用于部署 Grafana：

```sh
kubectl create namespace grafana
```
3. 创建自定义 `values.yaml` 文件

以下是一个示例配置文件，您可以根据需要进行修改：

```yaml

```

### 配置说明：

- `adminPassword`: 配置 admin 密码。
- `ingress.enabled`: 启用 Ingress。
- `ingress.annotations`: 配置 Ingress 的注解，例如指定 Ingress 类和重写目标。
- `ingress.hosts`: 配置 Grafana 的域名。
- `datasources.datasources.yaml`: 配置数据源，这里配置了 `Prometheus` 和 `Loki` 的数据源。

1. 使用 Helm 安装 Grafana：

```sh
helm install grafana grafana/grafana --namespace grafana
```

这将会下载并部署 Grafana 到你的 EKS 集群中。你可以使用以下命令查看部署状态：

```sh
kubectl get pods -n grafana
```

## 5. 访问 Grafana

Grafana 安装完成后，你可以通过配置的域名访问，也可以通过端口转发来访问 Grafana UI：

```sh
kubectl port-forward --namespace grafana svc/grafana 3000:80
```

在浏览器中访问 `http://localhost:3000`，使用用户名 `admin` 和你配置的密码进行登录。

## 总结

通过以上步骤，我们已经成功地使用 Helm 在 EKS 集群上部署了 Grafana。你现在可以开始配置你的数据源和仪表板，充分利用 Grafana 强大的监控和可视化功能。

