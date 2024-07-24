---
title: "Configuring Prometheus and Loki Data Sources in Grafana"
date: "2024-07-24"
tags: ["Grafana","EKS"]
description: ""
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
---

# Configuring Prometheus and Loki Data Sources in Grafana

In this tutorial, we will walk through the steps to configure Prometheus and Loki data sources in Grafana. This will enable you to collect and visualize metrics (Prometheus) and logs (Loki) for better monitoring and diagnosing of your system.

## Prerequisites

Before starting, ensure you have the following in place:

1. Grafana installed and running.
2. Prometheus installed and running.
3. Loki installed and running.

## Step 1: Configure Prometheus Data Source

### 1. Log in to Grafana

First, open your browser and log in to the Grafana web interface. Use your username and password to log in.

### 2. Add Prometheus Data Source

1. In the left-hand navigation panel of the Grafana dashboard, click on the gear icon (**Configuration**).
2. Select **Data Sources**.
   ![grafana-config](https://cdn.jsdelivr.net/gh/NileTradeX/NileTradeX.github.io@master/static/img/grafana-config.png)
3. Click the **Add data source** button at the top right of the page.
4. From the list that appears, select **Prometheus**.
   ![grafana-Prometheus](https://cdn.jsdelivr.net/gh/NileTradeX/NileTradeX.github.io@master/static/img/grafana-Prometheus.png)

### 3. Configure Prometheus Data Source

1. In the HTTP section, fill in the following fields:

   - **URL**: Enter the URL of your Prometheus server (e.g., `http://prometheus-server.prometheus.svc.cluster.local`).
   ![prometheus-datasource](https://cdn.jsdelivr.net/gh/NileTradeX/NileTradeX.github.io@master/static/img/prometheus-datasource.png) 

2. Click the **Save & Test** button at the bottom of the page to verify the configuration.

If the configuration is correct, you will see a "Successfully queried the Prometheus API." message.

![prometheus-success](https://cdn.jsdelivr.net/gh/NileTradeX/NileTradeX.github.io@master/static/img/prometheus-success.png)

## Step 2: Configure Loki Data Source

### 1. Add Loki Data Source

1. In the left-hand navigation panel of the Grafana dashboard, click on the gear icon (**Configuration**).
2. Select **Data Sources**.
   ![grafana-config](https://cdn.jsdelivr.net/gh/NileTradeX/NileTradeX.github.io@master/static/img/grafana-config.png)
3. Click the **Add data source** button at the top right of the page.
4. From the list that appears, select **Loki**.
   ![grafana-loki](https://cdn.jsdelivr.net/gh/NileTradeX/NileTradeX.github.io@master/static/img/grafana-loki.png)

### 2. Configure Loki Data Source

1. In the HTTP section, fill in the following fields:

   - **URL**: Enter the URL of your Loki server (e.g., `http://loki-gateway.loki.svc.cluster.local`).
   ![loki-datasource](https://cdn.jsdelivr.net/gh/NileTradeX/NileTradeX.github.io@master/static/img/loki-datasource.png)

2. Click the **Save & Test** button at the bottom of the page to verify the configuration.

If the configuration is correct, you will see a "Data source successfully connected." message.

![loki-success](https://cdn.jsdelivr.net/gh/NileTradeX/NileTradeX.github.io@master/static/img/loki-success.png)

## Summary

By following these steps, you have successfully configured Prometheus and Loki data sources in Grafana . This setup will help you better monitor and diagnose your system, improving overall operational efficiency.

------
