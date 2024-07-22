---
title: "Use Terraform to deploy an EKS cluster"
date: "2024-07-22"
tags: ["Terraform","EKS"]
showToc: true
TocOpen: false
draft: false
hidemeta: false
comments: false
description: "Desc Text."
disableHLJS: false # to disable highlightjs
disableShare: false
disableHLJS: false
hideSummary: false
searchHidden: true
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
ShowRssButtonInSectionTermList: true
UseHugoToc: true
---

# Use Terraform to deploy an EKS cluster

## Prerequisites

Clone the project (https://github.com/NileTradeX/infrastructure-as-code.git) and go to the EKS directory.

To run the Terraform project, you will need:

- [Terraform](https://developer.hashicorp.com/terraform/install) v1.8+
- an [AWS account](https://portal.aws.amazon.com/billing/signup?nc2=h_ct&src=default&redirect_url=https%3A%2F%2Faws.amazon.com%2Fregistration-confirmation#/start)
- the AWS CLI v2.7.0/v1.24.0 or newer, [installed](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) and [configured](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)
- [AWS IAM Authenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html)
- [kubectl](https://kubernetes.io/docs/tasks/tools/) v1.24.0 or newer

## Installation

- [Terraform](https://developer.hashicorp.com/terraform/install) v1.8+
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) v2.7.0/v1.24.0 or newer
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) v1.24.0 or newer

## AWS Configuration

1. Configure your AWS credentials using the AWS CLI with `aws configure`. You will need your AWS Access Key ID, Secret Access Key, and default region name.

## Deployment

1. Initialize your Terraform workspace, which will download the provider plugins for AWS:
````sh
terraform init
````
1. Validate the Terraform configuration files:
````sh
terraform validate
````
1. Plan your changes:
````sh
terraform plan
````
1. Apply your changes:
````sh
terraform apply
````
## Outputs

This Terraform module will output the following:

- `cluster_name`: The name of the EKS cluster.
- `cluster_version`: The version of the EKS cluster.
- `cluster_endpoint_public_access`: Whether the EKS cluster endpoint is publicly accessible.
- `enable_cluster_creator_admin_permissions`: Whether the creator of the EKS cluster has admin permissions.

## Configure kubeconfig

After the EKS cluster is created, you can configure kubectl to use the new cluster by updating your kubeconfig file:

aws eks --region <region> update-kubeconfig --name <cluster_name>

Replace `<region>` with your AWS region and `<cluster_name>` with the output `cluster_name`.

## Destruction

To destroy the Terraform-managed infrastructure:
````sh
terraform destroy
````
Please note that this will destroy all the resources created by Terraform, including the EKS cluster and the VPC.