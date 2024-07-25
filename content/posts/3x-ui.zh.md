---
title: "VPN 代理服务器部署安装"
date: "2024-07-25"
tags: ["Xray-core", "3x-ui"]
description: ""
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true 
---

# VPN 代理服务器部署安装

3x-ui 是一个开源的 Xray-core 面板，简化了 Xray-core 的部署和管理。本文将介绍如何在服务器上部署 3x-ui 面板，并添加入站连接。我们将以 Ubuntu 20.04 系统为例进行说明。

## 准备工作

在开始之前，请确保您已经有一台运行中的 Ubuntu 服务器，并且拥有 root 权限或具有 sudo 权限的用户。

### 参考文档

[![3x-ui](https://via.placeholder.com/100x30?text=3x-ui)](https://github.com/MHSanaei/3x-ui)

### 推荐操作系统

- Ubuntu 20.04+
- Debian 11+
- CentOS 8+
- Fedora 36+
- Arch Linux
- Parch Linux
- Manjaro
- Armbian
- AlmaLinux 9+
- Rocky Linux 9+
- Oracle Linux 8+
- OpenSUSE Tubleweed

## 步骤一：更新系统

首先，更新系统软件包以确保所有软件包都是最新的。

```bash
sudo apt update
sudo apt upgrade -y
```

## 步骤二：安装 3x-ui 

```bash
bash <(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh)
```
## 步骤三：配置入站链接

 - 浏览器打开 3x-ui 页面，选择`入站列表`，点击`添加入站 `

![3x-ui1](https://cdn.jsdelivr.net/gh/NileTradeX/NileTradeX.github.io@master/static/img/3x-ui1.png)

 - 在备注输入入站名称，然后点击`添加`

![3x-ui2](https://cdn.jsdelivr.net/gh/NileTradeX/NileTradeX.github.io@master/static/img/3x-ui2.png)

## 步骤四：配置本地客户端

 - 点击入站链接的`+`号，再点击`！`号，复制 `URl`
![3x-ui3](https://cdn.jsdelivr.net/gh/NileTradeX/NileTradeX.github.io@master/static/img/3x-ui3.png)

 - 打开本地 `V2BOX` 客户端，点击 `config`，点击`+`号，点击`从剪切板导入 v2ray uri`
![3x-ui4](https://cdn.jsdelivr.net/gh/NileTradeX/NileTradeX.github.io@master/static/img/3x-ui4.png)

 - 回到 `V2BOX` `home` 页点击链接即可
