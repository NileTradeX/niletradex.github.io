---
title: "使用 Terraform 部署 EKS 集群"
date: "2024-07-22"
tags: ["Terraform","EKS"]
description: ""
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
---

## 先决条件

克隆工程（https://github.com/NileTradeX/infrastructure-as-code.git），然后到 EKS 目录。

要运行这个 Terraform 项目，您将需要：

- [Terraform](https://developer.hashicorp.com/terraform/install) v1.8+
- 一个 [AWS 账户](https://portal.aws.amazon.com/billing/signup?nc2=h_ct&src=default&redirect_url=https%3A%2F%2Faws.amazon.com%2Fregistration-confirmation#/start)
- AWS CLI v2.7.0/v1.24.0 或更新版本，[已安装](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)并[已配置](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)
- [AWS IAM Authenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html)
- [kubectl](https://kubernetes.io/docs/tasks/tools/) v1.24.0 或更新版本

## 安装

- [Terraform](https://developer.hashicorp.com/terraform/install) v1.8+
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) v2.7.0/v1.24.0 或更新版本
- [kubectl](https://kubernetes.io/docs/tasks/tools/) v1.24.0 或更新版本

## AWS 配置

1. 使用 AWS CLI 配置您的 AWS 凭证，执行 `aws configure`。您将需要您的 AWS 访问密钥 ID、秘密访问密钥和默认区域名称。

## 部署

2. 初始化您的 Terraform 工作区，这将下载 AWS 的提供者插件：

```sh
terraform init
```

3. 验证 Terraform 配置文件：

```sh
terraform validate
```

4. 计划您的更改：

```sh
terraform plan
```

5. 应用您的更改：

```sh
terraform apply
```

## 输出

此 Terraform 模块将输出以下内容：

- `cluster_name`：EKS 集群的名称。
- `cluster_version`：EKS 集群的版本。
- `cluster_endpoint_public_access`：EKS 集群端点是否公开可访问。
- `enable_cluster_creator_admin_permissions`：EKS 集群的创建者是否拥有管理员权限。

## 配置 kubeconfig

在创建 EKS 集群后，您可以通过更新您的 kubeconfig 文件来配置 kubectl 以使用新集群：

```sh
aws eks --region <region> update-kubeconfig --name <cluster_name>
```

将 `<region>` 替换为您的 AWS 区域，将 `<cluster_name>` 替换为输出的 `cluster_name`。

## 销毁

要销毁 Terraform 管理的基础设施：

```sh
terraform destroy
```

请注意，这将销毁 Terraform 创建的所有资源，包括 EKS 集群和 VPC。