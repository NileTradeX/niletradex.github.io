---
title: "使用 Helm 在 EKS 集群部署 Promtail"
date: "2024-07-23"
tags: ["Grafana","EKS"]
description: ""
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
---



# Deploying Grafana in an EKS Cluster with Helm

Grafana is an open source monitoring and observation tool that can be integrated with a variety of data sources such as Prometheus, Loki, etc. In this article, we will detail how to deploy Grafana on an Amazon EKS (Elastic Kubernetes Service) cluster using Helm. In this article, we will detail how to deploy Grafana on an Amazon EKS (Elastic Kubernetes Service) cluster using Helm.

We will go through the following steps to complete the deployment:

1. **Preparation**
2. **Installing Helm**
3. **Configure the EKS cluster**
4. **Deploying Grafana using Helm** 5.
5. **Accessing Grafana** 1.

## 1. Preparation

Before you begin, make sure you have completed the following preparations:

- An EKS cluster has been created and configured.
- The `kubectl` command-line tool has been installed and configured.
- The AWS CLI has been installed and configured with the appropriate credentials.

## 2. Install Helm

Helm is the package management tool for Kubernetes. If you have not installed Helm, see [Install Helm](https://helm.sh/docs/intro/install/).

## 3. Configure the EKS cluster

Make sure your ``kubectl`` is properly configured and can access your EKS cluster:

```sh
aws eks --region <your-region> update-kubeconfig --name <your-cluster-name>
kubectl get nodes
```

The above command should return a list of nodes in your EKS cluster, indicating that ``kubectl`` has been properly configured.

## 4. Deploying Grafana with Helm

1. Add the Helm repository:

```sh
helm repo add grafana https://grafana.github.io/helm-charts
Helm repo update
```

2. Create a namespace for deploying Grafana:

```sh
kubectl create namespace grafana
``` 

3. Create a custom `values.yaml` file.

The following is a sample configuration file that you can modify as needed:

```yaml

```

### Configuration description:

- ``adminPassword``: Configures the admin password.
- ``ingress.enabled``: Enables Ingress.
- `ingress.annotations`: Configure Ingress annotations, such as specifying the Ingress class and rewrite target.
- `ingress.hosts`: Configures the domain name for Grafana.
- `datasources.datasources.yaml`: Configures the datasources, here the `Prometheus` and `Loki` datasources are configured.

1. Install Grafana using Helm:

```sh
helm install grafana grafana/grafana --namespace grafana
```

This will download and deploy Grafana to your EKS cluster. You can check the status of the deployment using the following command:

```sh
kubectl get pods -n grafana
```

## 5. Accessing Grafana

Once Grafana is installed, you can access it through the configured domain name, or you can access the Grafana UI through port forwarding:

```sh
kubectl port-forward --namespace grafana svc/grafana 3000:80
```

Go to `http://localhost:3000` in your browser and log in using the username `admin` and the password you configured.

## Summary

With these steps, we have successfully deployed Grafana on our EKS cluster using Helm. You can now start configuring your data sources and dashboards to take full advantage of Grafana's powerful monitoring and visualisation capabilities.

------
