---
title: "Deploying Promtail on an EKS Cluster using Helm"
date: "2024-07-23"
tags: ["Promtail","EKS"]
description: ""
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
---

### Deploying Promtail on an EKS Cluster using Helm

In modern cloud-native architecture, log aggregation and management are crucial. Promtail, the log collector for Loki, is used to send logs to Loki for storage and querying. This tutorial demonstrates how to deploy Promtail on an Amazon EKS cluster using Helm.

#### Prerequisites

1. **EKS Cluster**: An EKS cluster that is already created and configured.
2. **kubectl**: `kubectl` tool installed and configured.
3. **Helm**: Helm tool installed and configured.
4. **Loki**: Loki has been deployed in the EKS cluster.

#### Step 1: Configure AWS CLI and kubectl

Ensure the AWS CLI is configured and connected to your EKS cluster. Use the following command to configure `kubectl` to connect to the EKS cluster:

```sh
aws eks update-kubeconfig --region <region> --name <cluster-name>
```

#### Step 2: Install Helm

Make sure that Helm is installed. See [Installing Helm](https://helm.sh/docs/intro/install/).

#### Step 3: Add the Promtail Helm Repository

Add the Promtail Helm repository so we can install Promtail using Helm:

```sh
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
```

#### Step 4: Create Promtail Configuration File

Create a Promtail configuration file named `promtail-values.yaml`. Below is a sample configuration file that you can modify as needed:

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

In this configuration file, we define the address for Promtail to send logs to Loki, and configure log positions and other parameters.

#### Step 5: Install Promtail using Helm

Use the following command to install Promtail:

```sh
helm upgrade --values promtail-values.yaml --install promtail grafana/promtail -n loki
```

#### Step 6: Verify the Deployment

You can use the following command to verify that Promtail is successfully deployed:

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

You can also check the logs of the Promtail Pod to ensure it is running correctly and sending logs to Loki:

```sh
kubectl logs promtail-58xrs -n loki
```

#### Summary

By following these steps, we have successfully deployed Promtail on an EKS cluster using Helm. This configuration helps you efficiently collect and manage logs in a cloud-native environment. If you need to further customize Promtail's behavior, modify the `promtail-values.yaml` configuration file and redeploy.

I hope this article is helpful! If you have any questions or suggestions, feel free to reach out and discuss.

------
