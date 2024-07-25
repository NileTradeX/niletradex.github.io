---
title: "VPN Proxy Server Deployment Installation"
date: "2024-07-25"
tags: ["Xray-core", "3x-ui"]
description: ""
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true 
---

# VPN Proxy Server Deployment Installation

3x-ui is an open source Xray-core panel that simplifies the deployment and management of Xray-core. In this article, we will describe how to deploy the 3x-ui panel on a server and add inbound connections. We will use an Ubuntu 20.04 system as an example.

## Preparation

Before you begin, make sure you have a running Ubuntu server with root or sudo privileges.

### Documentation

[![3x-ui](https://via.placeholder.com/100x30?text=3x-ui)](https://github.com/MHSanaei/3x-ui)

### Recommended operating system

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

## Step 1: Update your system

Firstly, update the system packages to ensure that all packages are up to date.

```bash
sudo apt update
sudo apt upgrade -y
```

## Step 2: Install 3x-ui 

```bash
bash <(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh)
```
## Step 3: Configure inbound links

Open the 3x-ui page in your browser, select ``Inbound List`` and click ``Add Inbound``.

![3x-ui1](https://cdn.jsdelivr.net/gh/NileTradeX/NileTradeX.github.io@master/static/img/3x-ui1.png)

Enter the inbound name in the comments and click `Add`.

![3x-ui2](https://cdn.jsdelivr.net/gh/NileTradeX/NileTradeX.github.io@master/static/img/3x-ui2.png)

## Step 4: Configure the local client

Click the `+` sign on the inbound link, then click the `! ` sign and copy the `URl`
![3x-ui3](https://cdn.jsdelivr.net/gh/NileTradeX/NileTradeX.github.io@master/static/img/3x-ui3.png)

Open the local `V2BOX` client, click on `config`, click on the `+` sign, click on `Import v2ray uri from clipboard` !
![3x-ui4](https://cdn.jsdelivr.net/gh/NileTradeX/NileTradeX.github.io@master/static/img/3x-ui4.png)

Go back to the `V2BOX` `home` page and click on the link.

------
