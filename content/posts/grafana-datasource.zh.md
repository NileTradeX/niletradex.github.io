---
title: "使用 Grafana 配置 Prometheus 和 Loki 数据源"
date: "2024-07-24"
tags: ["Grafana","EKS"]
description: ""
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
---

# 使用 Grafana 配置 Prometheus 和 Loki 数据源

在本文中将展示如何在 Grafana 中配置 Prometheus 和 Loki 数据源。收集和可视化指标数据（Prometheus）以及日志数据（Loki），从而更好地监控和诊断系统。

## 前提条件

在开始之前，请确保已经完成以下准备工作：

1. 已在 EKS 集群安装并运行 Grafana。
2. 已在 EKS 集群安装并运行 Prometheus。
3. 已在 EKS 集群安装并运行 Loki。

## 步骤一：配置 Prometheus 数据源

### 1. 登录 Grafana

首先，打开您的浏览器并登录到 Grafana 的 Web 界面。使用安装 grafana 那篇文章配置的的用户名和密码登录。

### 2. 添加 Prometheus 数据源

1. 在 Grafana 仪表盘的左侧导航栏中，点击三杠图标（**配置**）。
2. 选择 **Data Sources**（数据源）。
   ![grafana-config](/img/grafana-config.png)
3. 点击页面右上角的 **Add data source**（添加数据源）按钮。
4. 在出现的列表中，选择 **Prometheus**。
   ![grafana-Prometheus](/img/grafana-Prometheus.png)

### 3. 配置 Prometheus 数据源

1. 在 HTTP 部分，填写以下字段：

   - **URL**: 输入 Prometheus 服务器的 URL（例如 `http://prometheus-server.prometheus.svc.cluster.local`）。
    
    ![prometheus-datasource](/img/prometheus-datasource.png)

2. 点击页面底部的 **Save & Test** 按钮，验证配置是否成功。

如果配置正确，您将看到 "Successfully queried the Prometheus API." 的提示消息。

![prometheus-success](/img/prometheus-success.png)

## 步骤二：配置 Loki 数据源

### 1. 添加 Loki 数据源

1. 在 Grafana 仪表盘的左侧导航栏中，点击齿轮图标（**配置**）。
2. 选择 **Data Sources**（数据源）。
   ![grafana-config](/img/grafana-config.png)
3. 点击页面右上角的 **Add data source**（添加数据源）按钮。
4. 在出现的列表中，选择 **Loki**。
   ![grafana-loki](/img/grafana-loki.png)

### 2. 配置 Loki 数据源

1. 在 HTTP 部分，填写以下字段：

   - **URL**: 输入 Loki 服务器的 URL（例如 `http://loki-gateway.loki.svc.cluster.local`）。
  ![loki-datasource](/img/loki-datasource.png)

2. 点击页面底部的 **Save & Test** 按钮，验证配置是否成功。

如果配置正确，您将看到 "Data source successfully connected." 的提示消息。

![loki-success](/img/loki-success.png)

## 总结

通过以上步骤，已经成功在 Grafana 中配置了 Prometheus 和 Loki 数据源。这将更好地监控和诊断系统，提升整体运维效率。

------
