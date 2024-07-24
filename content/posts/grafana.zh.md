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
replicas: 1
## Expose the grafana service to be accessed from outside the cluster (LoadBalancer service).
## or access it from within the cluster (ClusterIP service). Set the service type and the port to serve it.
## ref: http://kubernetes.io/docs/user-guide/services/
##
service:
  enabled: true
  type: ClusterIP
  # Set the ip family policy to configure dual-stack see [Configure dual-stack](https://kubernetes.io/docs/concepts/services-networking/dual-stack/#services)
  ipFamilyPolicy: ""
  # Sets the families that should be supported and the order in which they should be applied to ClusterIP as well. Can be IPv4 and/or IPv6.
  ipFamilies: []
  loadBalancerIP: ""
  loadBalancerClass: ""
  loadBalancerSourceRanges: []
  port: 80
  targetPort: 3000
    # targetPort: 4181 To be used with a proxy extraContainer
  ## Service annotations. Can be templated.
  annotations: {}
  labels: {}
  portName: service
  # Adds the appProtocol field to the service. This allows to work with istio protocol selection. Ex: "http" or "tcp"
  appProtocol: ""

ingress:
  enabled: true
  # For Kubernetes >= 1.18 you should specify the ingress-controller via the field ingressClassName
  # See https://kubernetes.io/blog/2020/04/02/improvements-to-the-ingress-api-in-kubernetes-1.18/#specifying-the-class-of-an-ingress
  # ingressClassName: nginx
  # Values can be templated
  annotations:
    kubernetes.io/ingress.class: alb
    alb.ingress.kubernetes.io/scheme: internet-facing
    alb.ingress.kubernetes.io/target-type: ip
    alb.ingress.kubernetes.io/listen-ports: '[{"HTTP": 80}, {"HTTPS":443}]'
    alb.ingress.kubernetes.io/certificate-arn: arn:aws:acm:us-west-1:992382721746:certificate/455cfe47-104c-46ad-9efc-5a303ba09635
  labels: {}
  path: /

  # pathType is only for k8s >= 1.1=
  pathType: Prefix

  hosts:
    - grafana.great-way.link
  ## Extra paths to prepend to every host configuration. This is useful when working with annotation based services.
  extraPaths: []
  # - path: /*
  #   backend:
  #     serviceName: ssl-redirect
  #     servicePort: use-annotation
  ## Or for k8s > 1.19
  # - path: /*
  #   pathType: Prefix
  #   backend:
  #     service:
  #       name: ssl-redirect
  #       port:
  #         name: use-annotation

resources:
  limits:
    cpu: 500m
    memory: 1024Mi
  requests:
    cpu: 200m
    memory: 256Mi

## Node labels for pod assignment
## ref: https://kubernetes.io/docs/user-guide/node-selection/
#
nodeSelector: {}

## Tolerations for pod assignment
## ref: https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/
##
tolerations: []

## Affinity for pod assignment (evaluated as template)
## ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity
##
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
                  - grafana
          topologyKey: kubernetes.io/hostname
## Topology Spread Constraints
## ref: https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/
##
topologySpreadConstraints: []

## Additional init containers (evaluated as template)
## ref: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
##
extraInitContainers: []

## Enable an Specify container in extraContainers. This is meant to allow adding an authentication proxy to a grafana pod
extraContainers: ""
# extraContainers: |
# - name: proxy
#   image: quay.io/gambol99/keycloak-proxy:latest
#   args:
#   - -provider=github
#   - -client-id=
#   - -client-secret=
#   - -github-org=<ORG_NAME>
#   - -email-domain=*
#   - -cookie-secret=
#   - -http-address=http://0.0.0.0:4181
#   - -upstream-url=http://127.0.0.1:3000
#   ports:
#     - name: proxy-web
#       containerPort: 4181

## Volumes that can be used in init containers that will not be mounted to deployment pods
extraContainerVolumes: []
#  - name: volume-from-secret
#    secret:
#      secretName: secret-to-mount
#  - name: empty-dir-volume
#    emptyDir: {}

## Enable persistence using Persistent Volume Claims
## ref: http://kubernetes.io/docs/user-guide/persistent-volumes/
##
persistence:
  type: pvc
  enabled: true
  # storageClassName: default
  accessModes:
    - ReadWriteOnce
  size: 10Gi
  # annotations: {}
  finalizers:
    - kubernetes.io/pvc-protection
  # selectorLabels: {}
  ## Sub-directory of the PV to mount. Can be templated.
  # subPath: ""
  ## Name of an existing PVC. Can be templated.
  # existingClaim:
  ## Extra labels to apply to a PVC.
  extraPvcLabels: {}
  disableWarning: false

  ## If persistence is not enabled, this allows to mount the
  ## local storage in-memory to improve performance
  ##
  inMemory:
    enabled: false
    ## The maximum usage on memory medium EmptyDir would be
    ## the minimum value between the SizeLimit specified
    ## here and the sum of memory limits of all containers in a pod
    ##
    # sizeLimit: 300Mi

  ## If 'lookupVolumeName' is set to true, Helm will attempt to retrieve
  ## the current value of 'spec.volumeName' and incorporate it into the template.
  lookupVolumeName: true

  ## initChownData resource requests and limits
  ## Ref: http://kubernetes.io/docs/user-guide/compute-resources/
  ##
  resources: {}
  #  limits:
  #    cpu: 100m
  #    memory: 128Mi
  #  requests:
  #    cpu: 100m
  #    memory: 128Mi
  securityContext:
    runAsNonRoot: false
    runAsUser: 0
    seccompProfile:
      type: RuntimeDefault
    capabilities:
      add:
        - CHOWN

# Administrator credentials when not using an existing secret (see below)
adminUser: admin
adminPassword: Aq8wLzRFA3bU5gO2nVlfHFlXHjYCh7tL9F4sIpwD

# Use an existing secret for the admin user.
admin:
  ## Name of the secret. Can be templated.
  existingSecret: ""
  userKey: admin-user
  passwordKey: admin-password

## Container Lifecycle Hooks. Execute a specific bash command or make an HTTP request
lifecycleHooks: {}
  # postStart:
  #   exec:
  #     command: []

## Pass the plugins you want installed as a list.
##
plugins: []
  # - digrich-bubblechart-panel
  # - grafana-clock-panel
  ## You can also use other plugin download URL, as long as they are valid zip files,
  ## and specify the name of the plugin after the semicolon. Like this:
  # - https://grafana.com/api/plugins/marcusolsson-json-datasource/versions/1.3.2/download;marcusolsson-json-datasource

## Configure grafana datasources
## ref: http://docs.grafana.org/administration/provisioning/#datasources
##
datasources: 
  datasources.yaml:
    apiVersion: 1
    datasources:
      - name: Prometheus
        type: prometheus
        access: proxy
        url: http://prometheus-server.prometheus.svc.cluster.local
        isDefault: true
      - name: Loki
        type: loki
        access: proxy
        url: http://loki-gateway.loki.svc.cluster.local


## Configure grafana alerting (can be templated)
## ref: http://docs.grafana.org/administration/provisioning/#alerting
##
alerting: {}
  # rules.yaml:
  #   apiVersion: 1
  #   groups:
  #     - orgId: 1
  #       name: '{{ .Chart.Name }}_my_rule_group'
  #       folder: my_first_folder
  #       interval: 60s
  #       rules:
  #         - uid: my_id_1
  #           title: my_first_rule
  #           condition: A
  #           data:
  #             - refId: A
  #               datasourceUid: '-100'
  #               model:
  #                 conditions:
  #                   - evaluator:
  #                       params:
  #                         - 3
  #                       type: gt
  #                     operator:
  #                       type: and
  #                     query:
  #                       params:
  #                         - A
  #                     reducer:
  #                       type: last
  #                     type: query
  #                 datasource:
  #                   type: __expr__
  #                   uid: '-100'
  #                 expression: 1==0
  #                 intervalMs: 1000
  #                 maxDataPoints: 43200
  #                 refId: A
  #                 type: math
  #           dashboardUid: my_dashboard
  #           panelId: 123
  #           noDataState: Alerting
  #           for: 60s
  #           annotations:
  #             some_key: some_value
  #           labels:
  #             team: sre_team_1
  # contactpoints.yaml:
  #   secret:
  #     apiVersion: 1
  #     contactPoints:
  #       - orgId: 1
  #         name: cp_1
  #         receivers:
  #           - uid: first_uid
  #             type: pagerduty
  #             settings:
  #               integrationKey: XXX
  #               severity: critical
  #               class: ping failure
  #               component: Grafana
  #               group: app-stack
  #               summary: |
  #                 {{ `{{ include "default.message" . }}` }}

## Configure notifiers
## ref: http://docs.grafana.org/administration/provisioning/#alert-notification-channels
##
notifiers: {}
#  notifiers.yaml:
#    notifiers:
#    - name: email-notifier
#      type: email
#      uid: email1
#      # either:
#      org_id: 1
#      # or
#      org_name: Main Org.
#      is_default: true
#      settings:
#        addresses: an_email_address@example.com
#    delete_notifiers:

## Configure grafana dashboard providers
## ref: http://docs.grafana.org/administration/provisioning/#dashboards
##
## `path` must be /var/lib/grafana/dashboards/<provider_name>
##
dashboardProviders: {}
#  dashboardproviders.yaml:
#    apiVersion: 1
#    providers:
#    - name: 'default'
#      orgId: 1
#      folder: ''
#      type: file
#      disableDeletion: false
#      editable: true
#      options:
#        path: /var/lib/grafana/dashboards/default

## Configure grafana dashboard to import
## NOTE: To use dashboards you must also enable/configure dashboardProviders
## ref: https://grafana.com/dashboards
##
## dashboards per provider, use provider name as key.
##
dashboards: {}
  # default:
  #   some-dashboard:
  #     json: |
  #       $RAW_JSON
  #   custom-dashboard:
  #     file: dashboards/custom-dashboard.json
  #   prometheus-stats:
  #     gnetId: 2
  #     revision: 2
  #     datasource: Prometheus
  #   local-dashboard:
  #     url: https://example.com/repository/test.json
  #     token: ''
  #   local-dashboard-base64:
  #     url: https://example.com/repository/test-b64.json
  #     token: ''
  #     b64content: true
  #   local-dashboard-gitlab:
  #     url: https://example.com/repository/test-gitlab.json
  #     gitlabToken: ''
  #   local-dashboard-bitbucket:
  #     url: https://example.com/repository/test-bitbucket.json
  #     bearerToken: ''
  #   local-dashboard-azure:
  #     url: https://example.com/repository/test-azure.json
  #     basic: ''
  #     acceptHeader: '*/*'
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

通过以上步骤，已经成功地使用 Helm 在 EKS 集群上部署了 Grafana。现在可以配置数据源和仪表板，充分利用 Grafana 强大的监控和可视化功能。

------
