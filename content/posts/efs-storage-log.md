---
title: "Using EFS to store application logs"
date: "2024-07-24"
tags: ["EFS","EKS","Caddy"]
description: ""
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
---

## Using EFS to store application logs

### Pre-requisites

1. **Deployed EKS cluster** : Ensure that the AWS CLI is configured and connected to your EKS cluster.
2. **EKS cluster already configured with the EFS Storage plugin** : Not configured see [documentation](https://docs.aws.amazon.com/eks/latest/userguide/efs-csi.html)
3. **kubectl**: The `kubectl` tool is installed and configured.

### Step 1: Configure the EFS storage class for the EKS cluster

 - Make sure that the EFS storage plugin is installed on the cluster, see [documentation](https://docs.aws.amazon.com/eks/latest/userguide/efs-csi.html) if it is not.
 - To create the EFS storage class, create the `SC.yaml` file and run

```yaml
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: efs
provisioner: efs.csi.aws.com
reclaimPolicy: Retain
allowVolumeExpansion: true
parameters:
  provisioningMode: efs-ap
  fileSystemId: fs-0bbb30c3d8cefacb1
  directoryPerms: "700"
  gidRangeStart: "1000" # optional
  gidRangeEnd: "2000" # optional
  ensureUniqueDirectory: "true" # optional
  reuseAccessPoint: "false" # optional
```

### Step 2: Create the PVCs and PVs required for logging storage

Using the following recommended configuration, create the `PVCAndPV.yaml` file and execute the

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: app-log-pvc
  namespace: dev
spec:
  storageClassName: efs
  volumeMode: Filesystem
  volumeName: app-log-pv
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 16Gi
---
apiVersion: v1
kind: PersistentVolume
metadata:
  name: app-log-pv
spec:
  capacity:
    storage: 16Gi
  csi:
    driver: efs.csi.aws.com
    volumeHandle: fs-0bbb30c3d8cefacb1
  accessModes:
    - ReadWriteMany
  claimRef:
    kind: PersistentVolumeClaim
    namespace: dev
    name: app-log-pvc
  persistentVolumeReclaimPolicy: Retain
  storageClassName: efs
  volumeMode: Filesystem
```
**Description:**
 - Change the value of storageClassName to the name of the EFS storage class you created.
 - Adjust the size of the storage to what you need.
 - Change the value of volumeHandle to the ID of the EFS class.

### Step 3: Modify the PVC that Deployment uses for EFS storage.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{APP_NAME}}
  namespace: {{NAMESPACE}}
spec:
  replicas: {{POD_REPLICAS}}
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
  template:
    spec:
      nodeSelector:
        env: {{NAMESPACE}}
      imagePullSecrets:
        - name: my-registry-admin
      volumes:
        - name: persistent-storage
          persistentVolumeClaim:
            claimName: app-log-pvc
      containers:
        - name: {{APP_NAME}}
          image: {{IMAGE_URL}}:{{IMAGE_TAG}}
          imagePullPolicy: Always
          ports:
            - containerPort: 8080
              name: port
              protocol: TCP
          command: [ "/bin/sh" ]
          args: [ "-c", "set -e && java -Dspring.profiles.active={{NAMESPACE}} -Dserver.port=8080 -jar app.jar" ]
          volumeMounts:
            - name: persistent-storage
              mountPath: /logs
```

To which the following two paragraphs have been added

```yaml
      volumes:
        - name: persistent-storage
          persistentVolumeClaim:
            claimName: app-log-pvc
```

```yaml
          volumeMounts:
            - name: persistent-storage
              mountPath: /logs
```

**Description:**
 - claimName is the name of the created PVC
 - mountPath is the path where the logs will be output.

### Conclusion

With the above steps, the service log files are stored in EFS, but to view the log files directly, you need to mount EFS, we will talk about how to mount EFS on EC2 instance and use Caddy to build an online file browsing service to view the log files online in the next article.

------
