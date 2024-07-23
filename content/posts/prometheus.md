---
title: "Deploying Prometheus on an EKS Cluster Using Helm"
date: "2024-07-23"
tags: ["Prometheus","EKS"]
description: ""
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
---

## Deploying Prometheus on an EKS Cluster Using Helm

In this article, we'll cover how to deploy Prometheus on an Amazon EKS (Elastic Kubernetes Service) cluster using Helm. Prometheus is an open-source system monitoring and alerting toolkit, while Helm is a package manager for Kubernetes that simplifies application deployment and management.

### Prerequisites

Before we begin, ensure you have the following:

1. An EKS cluster created and configured.
2. `kubectl` command-line tool installed and configured.
3. Helm installed.

### Step 1: Configure `kubectl` to Access Your EKS Cluster

Ensure that `kubectl` is configured to access your EKS cluster. You can configure it using the AWS CLI:

```sh
aws eks --region <region-code> update-kubeconfig --name <cluster-name>
```

### Step 2: Install Helm

If you haven't installed Helm yet, See [Installing Helm](https://helm.sh/docs/intro/install/).

### Step 3: Add the Prometheus Helm Repository

First, we need to add the Prometheus Helm repository:

```sh
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```

### Step 4: Create a Namespace

To better organize our resources, we'll create a separate namespace for Prometheus:

```sh
kubectl create namespace prometheus
```

### Step 5: Install Prometheus Using Helm

Now, we can use Helm to install Prometheus in the `prometheus` namespace:

```sh
helm upgrade -i prometheus prometheus-community/prometheus --namespace prometheus 
```

This command will deploy Prometheus and its associated components.

   ###### Note

   If you get the error `Error: failed to download "stable/prometheus" (hint: running `helm repo update` may help)` when executing this command, run `helm repo update prometheus-community`, and then try running the Step 2 command again.

   If you get the error `Error: rendered manifests contain a resource that already exists`, run `helm uninstall *your-release-name* -n *namespace*`, then try running the Step 3 command again.
   
   
   
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

### Step 6: Verify the Installation

You can verify if Prometheus has been successfully deployed with the following command:

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

You should see several Prometheus-related pods running.

### Step 7: Access the Prometheus UI

By default, the Prometheus service is deployed as a ClusterIP service, meaning it is accessible only within the Kubernetes cluster. To access the Prometheus UI externally, you can use port forwarding:

```sh
kubectl port-forward -n prometheus deploy/prometheus-server 9090:9090
```

You can then access the Prometheus UI by navigating to `http://localhost:9090` in your web browser.

### Conclusion

By following these steps, we've successfully deployed Prometheus on an EKS cluster using Helm. Prometheus will help monitor various metrics of the cluster and send alerts when necessary.

If you wish to further customize Prometheus's configuration, refer to the Prometheus Helm chart documentation and modify the `values.yaml` file as needed.

------
