---
title: "使用 EFS 存储应用日志"
date: "2024-07-24"
tags: ["EFS","EKS","Caddy"]
description: ""
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
---

## 使用 EFS 存储应用日志

### 前置条件

1. **已经部署好的 EKS 集群** ： 确保 AWS CLI 已配置并连接到您的 EKS 集群。
2. **EKS 集群已经配置好了 EFS 存储插件** ： 未配置请参阅[文档](https://docs.aws.amazon.com/eks/latest/userguide/efs-csi.html)
3. **kubectl**: 已安装并配置好的 `kubectl` 工具。

### 步骤一：配置 EKS 集群的 EFS 存储类

 - 请确保集群已经安装 EFS 存储插件，未安装请参阅[文档](https://docs.aws.amazon.com/eks/latest/userguide/efs-csi.html)。
 - 创建 EFS 存储类，创建`SC.yaml`文件，并执行

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

### 步骤二：创建日志存储所需的 PVC 和 PV

使用以下推荐配置，创建`PVCAndPV.yaml`文件，并执行

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
**说明：**
 - 修改 storageClassName 的值为你创建的 EFS 存储类的名字
 - 调整 storage 的大小，为实际所需
 - 修改 volumeHandle 的值为 EFS 的 ID

### 步骤三：修改 Deployment 使用 EFS 存储的 PVC

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

其中增加了以下两段

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

**说明：**
 - claimName 为创建 PVC 的名字
 - mountPath 为日志输出的路径

### 结论

通过以上步骤就将服务的日志文件存储在了 EFS，但是需要直接查看日志文件，还要挂载 EFS ，将在下一篇讲如何在 EC2 实例上挂载 EFS，并且使用 Caddy 搭建在线文件浏览服务在线查看

------
