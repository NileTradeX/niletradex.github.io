---
title: "Deploying MongoDB Operator with Helm on an EKS Cluster and Deploying a MongoDB Cluster"
date: "2024-07-25"
tags: ["EFS", "MongoDB"]
description: ""
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true 
---

# Deploying MongoDB Operator on an EKS Cluster with Helm and Deploying a MongoDB Cluster

In Kubernetes, Operator is a tool for automating the management of applications and infrastructure.MongoDB Operator makes it easier to manage MongoDB clusters on a Kubernetes cluster. This article describes how to deploy MongoDB Operator on an Amazon EKS (Elastic Kubernetes Service) cluster using Helm and deploy a MongoDB cluster using the Operator.

## Preparation

Before you begin, make sure you have the following environments ready:

1. an installed and configured Amazon EKS cluster.
2. an installed Helm (version 3 and above). 3. an installed and configured Amazon EKS cluster.
3. an installed and configured `kubectl` command-line tool.

### Refer to the documentation

[![MongoDBOperator](https://via.placeholder.com/100x30?text=MongoDBOperator)](https://github.com/mongodb/mongodb-kubernetes-operator/blob/master/README.md)

## Step 1: Install MongoDB Operator

First, we need to install MongoDB Operator using Helm. MongoDB provides a Helm chart that makes it easy to deploy MongoDB Operator in a Kubernetes cluster.

1. Add the MongoDB Helm repository:

```bash
helm repo add mongodb https://mongodb.github.io/helm-charts
helm repo update
```

2. Install MongoDB Operator using Helm:

```bash
helm install mongodb-operator mongodb/community-operator --set operator.watchNamespace="mongodb" --namespace mongodb --create-namespace
```

   This command installs MongoDB Operator in the `mongodb` namespace; if you want to use another namespace, modify the command accordingly. `-set operator.watchNamespace="mongodb"` for the namespace that Operator should watch.

## Step 2: Deploying the MongoDB Cluster

Once MongoDB Operator is installed, we can use it to deploy a MongoDB cluster.

1. Create a MongoDB Custom Resource (CR) file (e.g. ``mongodb-cluster.yaml``):

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

   In this file, we define a MongoDB cluster named `mongodb` with 2 members, 1 arbiter, using MongoDB version 6.0.5 with persistent storage enabled.

2. Apply the MongoDB CR file to deploy the MongoDB cluster:

```bash
kubectl apply -f mongodb-cluster.yaml
```

   This command creates a MongoDB cluster in the ``mongodb`` namespace.

## Step 3: Verify the MongoDB Cluster

To verify that the MongoDB cluster was successfully deployed, perform the following steps:

1. View the Pod status of the MongoDB Operator and the MongoDB cluster:

```bash
kubectl get pods -n mongodb
```

   You should see that both the MongoDB Operator's pod and the MongoDB cluster's pod are in the `Running` state.

2. View the services of the MongoDB cluster:

```bash
kubectl get svc -n mongodb
``

   You should see the services associated with the MongoDB cluster.

## Summary

With the above steps, we have successfully deployed a MongoDB Operator on an Amazon EKS cluster using Helm and deployed a MongoDB cluster using that Operator. This allowed us to more easily manage and scale our MongoDB cluster while leveraging the power of Kubernetes to ensure high availability and scalability.

------
