---
title: "使用 Helm 在 EKS 集群部署 Promtail"
date: "2024-07-23"
tags: ["Promtail","EKS"]
description: ""
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
---

### 使用 Helm 在 EKS 集群部署 Promtail

在现代云原生架构中，日志聚合和管理是至关重要的部分。Promtail 是 Loki 的日志收集组件，用于将日志发送到 Loki 进行存储和查询。在本教程中将展示如何在 Amazon EKS 集群上使用 Helm 部署 Promtail。

#### 前提条件

1. **EKS 集群**: 已经创建并配置好的 EKS 集群。
2. **kubectl**: 已安装并配置好的 `kubectl` 工具。
3. **Helm**: 已安装并配置好的 Helm 工具。
4. **Loki**: 已经在 EKS 集群部署好了 Loki。

#### 第一步：配置 AWS CLI 和 kubectl

确保 AWS CLI 已配置并连接到您的 EKS 集群。可以使用以下命令来配置 `kubectl` 以连接到 EKS 集群：

```sh
aws eks update-kubeconfig --region <region> --name <cluster-name>
```

#### 第二步：安装 Helm

确保已安装 Helm。请参阅[安装 Helm](https://helm.sh/docs/intro/install/)。

#### 第三步：添加 Promtail Helm 仓库

添加 Promtail Helm 仓库，这样我们可以使用 Helm 安装 Promtail：

```sh
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
```

#### 第四步：创建 Promtail 配置文件

创建一个 Promtail 的配置文件 `promtail-values.yaml`。以下是一个示例配置文件，您可以根据需要进行修改：

```yaml
daemonset:
  # -- Deploys Promtail as a DaemonSet
  enabled: true

service:
  enabled: false
  # -- Labels for the service
  labels: {}
  # -- Annotations for the service
  annotations: {}

secret:
  # -- Labels for the Secret
  labels: {}
  # -- Annotations for the Secret
  annotations: {}

configmap:
  # -- If enabled, promtail config will be created as a ConfigMap instead of a secret
  enabled: false

initContainer: []
  # # -- Specifies whether the init container for setting inotify max user instances is to be enabled
  # - name: init
  #   # -- Docker registry, image and tag for the init container image
  #   image: docker.io/busybox:1.33
  #   # -- Docker image pull policy for the init container image
  #   imagePullPolicy: IfNotPresent
  #   # -- The inotify max user instances to configure
  #   command:
  #     - sh
  #     - -c
  #     - sysctl -w fs.inotify.max_user_instances=128
  #   securityContext:
  #     privileged: true

# -- Annotations for the DaemonSet
annotations: {}

# -- Number of old history to retain to allow rollback (If not set, default Kubernetes value is set to 10)
# revisionHistoryLimit: 1

# -- The update strategy for the DaemonSet
updateStrategy: {}

# -- Pod labels
podLabels: {}

# -- Pod annotations
podAnnotations: {}
#  prometheus.io/scrape: "true"
#  prometheus.io/port: "http-metrics"

# -- The name of the PriorityClass
priorityClassName: null

# -- Liveness probe
livenessProbe: {}

# -- Readiness probe
# @default -- See `values.yaml`
readinessProbe:
  failureThreshold: 5
  httpGet:
    path: "{{ printf `%s/ready` .Values.httpPathPrefix }}"
    port: http-metrics
  initialDelaySeconds: 10
  periodSeconds: 10
  successThreshold: 1
  timeoutSeconds: 1

# -- Resource requests and limits
resources: {}
#  limits:
#    cpu: 200m
#    memory: 128Mi
#  requests:
#    cpu: 100m
#    memory: 128Mi

# -- The security context for pods
podSecurityContext:
  runAsUser: 0
  runAsGroup: 0

# -- The security context for containers
containerSecurityContext:
  readOnlyRootFilesystem: true
  capabilities:
    drop:
      - ALL
  allowPrivilegeEscalation: false

rbac:
  # -- Specifies whether RBAC resources are to be created
  create: true
  # -- Specifies whether a PodSecurityPolicy is to be created
  pspEnabled: false

# -- The name of the Namespace to deploy
# If not set, `.Release.Namespace` is used
namespace: loki

serviceAccount:
  # -- Specifies whether a ServiceAccount should be created
  create: true
  # -- The name of the ServiceAccount to use.
  # If not set and `create` is true, a name is generated using the fullname template
  name: null
  # -- Image pull secrets for the service account
  imagePullSecrets: []
  # -- Annotations for the service account
  annotations: {}

# -- Node selector for pods
nodeSelector: {}

# -- Affinity configuration for pods
affinity: {}

# -- Tolerations for pods. By default, pods will be scheduled on master/control-plane nodes.
tolerations:
  - key: node-role.kubernetes.io/master
    operator: Exists
    effect: NoSchedule
  - key: node-role.kubernetes.io/control-plane
    operator: Exists
    effect: NoSchedule

# -- Default volumes that are mounted into pods. In most cases, these should not be changed.
# Use `extraVolumes`/`extraVolumeMounts` for additional custom volumes.
# @default -- See `values.yaml`
defaultVolumes:
  - name: run
    hostPath:
      path: /run/promtail
  - name: containers
    hostPath:
      path: /var/lib/docker/containers
  - name: pods
    hostPath:
      path: /var/log/pods

# -- Default volume mounts. Corresponds to `volumes`.
# @default -- See `values.yaml`
defaultVolumeMounts:
  - name: run
    mountPath: /run/promtail
  - name: containers
    mountPath: /var/lib/docker/containers
    readOnly: true
  - name: pods
    mountPath: /var/log/pods
    readOnly: true

# Extra volumes to be added in addition to those specified under `defaultVolumes`.
extraVolumes: []

# Extra volume mounts together. Corresponds to `extraVolumes`.
extraVolumeMounts: []

# Extra args for the Promtail container.
extraArgs: []
# -- Example:
# -- extraArgs:
# --   - -client.external-labels=hostname=$(HOSTNAME)

# -- Extra environment variables. Set up tracing enviroment variables here if .Values.config.enableTracing is true.
# Tracing currently only support configure via environment variables. See:
# https://grafana.com/docs/loki/latest/clients/promtail/configuration/#tracing_config
# https://www.jaegertracing.io/docs/1.16/client-features/
extraEnv: []

# -- Extra environment variables from secrets or configmaps
extraEnvFrom: []

# -- Configure enableServiceLinks in pod
enableServiceLinks: true

# -- Configure additional ports and services. For each configured port, a corresponding service is created.
# See values.yaml for details
extraPorts: {}
#  syslog:
#    name: tcp-syslog
#    annotations: {}
#    labels: {}
#    containerPort: 1514
#    protocol: TCP
#    service:
#      type: ClusterIP
#      clusterIP: null
#      port: 1514
#      externalIPs: []
#      nodePort: null
#      loadBalancerIP: null
#      loadBalancerSourceRanges: []
#      externalTrafficPolicy: null
#    ingress:
#      # For Kubernetes >= 1.18 you should specify the ingress-controller via the field ingressClassName
#      # See https://kubernetes.io/blog/2020/04/02/improvements-to-the-ingress-api-in-kubernetes-1.18/#specifying-the-class-of-an-ingress
#      # ingressClassName: nginx
#      # Values can be templated
#      annotations: {}
#        # kubernetes.io/ingress.class: nginx
#        # kubernetes.io/tls-acme: "true"
#      paths: "/"
#      hosts:
#        - chart-example.local
#
#      tls: []
#      #  - secretName: chart-example-tls
#      #    hosts:
#      #      - chart-example.local

# -- Section for crafting Promtails config file. The only directly relevant value is `config.file`
# which is a templated string that references the other values and snippets below this key.
# @default -- See `values.yaml`
config:
  # -- Enable Promtail config from Helm chart
  # Set `configmap.enabled: true` and this to `false` to manage your own Promtail config
  # See default config in `values.yaml`
  enabled: true
  # -- The log level of the Promtail server
  # Must be reference in `config.file` to configure `server.log_level`
  # See default config in `values.yaml`
  logLevel: info
  # -- The log format of the Promtail server
  # Must be reference in `config.file` to configure `server.log_format`
  # Valid formats: `logfmt, json`
  # See default config in `values.yaml`
  logFormat: logfmt
  # -- The port of the Promtail server
  # Must be reference in `config.file` to configure `server.http_listen_port`
  # See default config in `values.yaml`
  serverPort: 3101
  # -- The config of clients of the Promtail server
  # Must be reference in `config.file` to configure `clients`
  # @default -- See `values.yaml`
  clients:
    - url: http://loki-gateway/loki/api/v1/push
  # -- Configures where Promtail will save it's positions file, to resume reading after restarts.
  # Must be referenced in `config.file` to configure `positions`
  positions:
    filename: /run/promtail/positions.yaml
  # -- The config to enable tracing
  enableTracing: false

  # -- Config file contents for Promtail.
  # Must be configured as string.
  # It is templated so it can be assembled from reusable snippets in order to avoid redundancy.
  # @default -- See `values.yaml`
  file: |
    server:
      log_level: {{ .Values.config.logLevel }}
      log_format: {{ .Values.config.logFormat }}
      http_listen_port: {{ .Values.config.serverPort }}
      {{- with .Values.httpPathPrefix }}
      http_path_prefix: {{ . }}
      {{- end }}
      {{- tpl .Values.config.snippets.extraServerConfigs . | nindent 2 }}

    clients:
      {{- tpl (toYaml .Values.config.clients) . | nindent 2 }}

    positions:
      {{- tpl (toYaml .Values.config.positions) . | nindent 2 }}

    scrape_configs:
      {{- tpl .Values.config.snippets.scrapeConfigs . | nindent 2 }}
      {{- tpl .Values.config.snippets.extraScrapeConfigs . | nindent 2 }}

    limits_config:
      {{- tpl .Values.config.snippets.extraLimitsConfig . | nindent 2 }}

    tracing:
      enabled: {{ .Values.config.enableTracing }}

# -- Base path to server all API routes fro
httpPathPrefix: ""

# -- Extra K8s manifests to deploy
extraObjects: []
  # - apiVersion: "kubernetes-client.io/v1"
  #   kind: ExternalSecret
  #   metadata:
  #     name: promtail-secrets
  #   spec:
  #     backendType: gcpSecretsManager
  #     data:
  #       - key: promtail-oauth2-creds
  #         name: client_secret
```

在该配置文件中，我们定义了 Promtail 发送日志到 Loki 的地址，并配置了日志位置等参数。

#### 第五步：使用 Helm 安装 Promtail

使用以下命令安装 Promtail：

```sh
helm upgrade --values promtail-values.yaml --install promtail grafana/promtail -n loki
```

#### 第六步：验证部署

您可以使用以下命令来验证 Promtail 是否成功部署：

```sh
kubectl get pods -l app.kubernetes.io/name=promtail -n loki
```

```
> kubectl get pods -l app.kubernetes.io/name=promtail -n loki
NAME             READY   STATUS    RESTARTS   AGE
promtail-58xrs   1/1     Running   0          7d5h
promtail-jxj9r   1/1     Running   0          30h
promtail-lcdjh   1/1     Running   0          7d2h
promtail-t9k77   1/1     Running   0          7d5h
```


还可以查看 Promtail Pod 的日志以确保它正在正常运行并将日志发送到 Loki：

```sh
kubectl logs promtail-58xrs -n loki
```

#### 总结

通过上述步骤，我们成功地在 EKS 集群上使用 Helm 部署了 Promtail。这个配置可以帮助您在云原生环境中更高效地收集和管理日志。如果需要进一步定制 Promtail 的行为，可以修改 `promtail-values.yaml` 配置文件并重新部署。

------
