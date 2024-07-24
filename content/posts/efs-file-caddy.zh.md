---
title: "在 EC2 实例挂载 EFS 存储，并搭建 Caddy 实现在线浏览文件"
date: "2024-07-24"
tags: ["EFS","EC2","Caddy"]
description: ""
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
---

## 在 EC2 实例挂载 EFS 存储，并搭建 Caddy 实现在线浏览文件

### 前置条件

1. **已经创建好了 EFS 存储，并且应用已经可以成功将日志写入 EFS**
2. **一台 EC2 实例** ：用于挂载 EFS 存储目录，并搭建 Caddy

### 步骤一：在 EC2 实例安装 Amazon EFS 客户端

1. 通过(SSH)访问实例的终端，然后使用相应的用户名登录。

 - 如果 EC2 实例系统是 Amazon Linux 系统

 2. 运行以下命令来安装该`amazon-efs-utils`包。
   ```sh
   sudo yum install -y amazon-efs-utils
   ```
 - 如果 EC2 实例系统是 Debian 或者 Ubuntu

 2. 要构建并安装 Debian 软件包：
   
    ```sh
    $ sudo apt-get update
    $ sudo apt-get -y install git binutils rustc cargo pkg-config libssl-dev
    $ git clone https://github.com/aws/efs-utils
    $ cd efs-utils
    $ ./build-deb.sh
    $ sudo apt-get -y install ./build/amazon-efs-utils*deb
    ```

    如果您的 Debian 发行版不提供 rust 或 cargo 包，或者您的发行版提供的是早于 1.68 的版本，那么您可以通过 rustup 安装 rust 和 cargo：

    ```sh
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    . "$HOME/.cargo/env"
    ```
2. 如果安装有任何问题请参考 [文档](https://github.com/aws/efs-utils/tree/master)

### 步骤二：创建目录挂载 EFS

1. 使用以下命令创建目录 efs 作为文件系统挂载点
   
   ```sh
    sudo mkdir efs
   ```

2. 使用以下命令挂载 EFS
   
   ```sh
    sudo mount -t efs -o tls fs-0bbb30c3d8cefacb1:/ efs
   ```
    **注意：** `fs-0bbb30c3d8cefacb1`为 EFS 的 ID

### 步骤三：安装 Caddy
以下只举例 Ubuntu 安装命令，其他系统参考[文档](https://caddyserver.com/docs/install)

```sh
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https curl
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
sudo apt update
sudo apt install caddy
```
### 步骤四：配置 CaddyFile 并启动 Caddy
1. 创建`Caddyfile`文件，输入以下内容，具体参考[文档](https://caddyserver.com/docs/caddyfile)
```
vpn.great-way.link {
        root * /home/admin/efs
        file_server browse
        basic_auth {
                admin $2a$14$NLRgL1aezQg6IkDQCWnESeUo6U1RRNqsN6mSk.9EvhRBTqq39Tdc2
        }
}
```
**说明：**
 - `vpn.great-way.link` 为指向这台 EC2 实例 IP 的域名，Caddy 会自动配置 SSl 证书和 HTTPS 访问。
 - `root * /home/admin/efs` 其中 `/home/admin/efs` 为 EFS 挂载的目录
 - `file_server browse` 是设置为文件浏览服务
 - `basic_auth` 开启基础认证，`admin` 为用户名，`$2a$14$NLRgL1aezQg6IkDQCWnESeUo6U1RRNqsN6mSk.9EvhRBTqq39Tdc2` 为使用命令 `caddy hash-password -p password` 加密后的的密码，参考文档 [basic_auth](https://caddyserver.com/docs/caddyfile/directives/basic_auth) [caddy hash-password](https://caddyserver.com/docs/command-line#caddy-hash-password)

### 步骤五：访问配置的域名，在线浏览文件
浏览器打开`vpn.great-way.link`地址，输入用户名密码即可访问
![caddy](https://cdn.jsdelivr.net/gh/NileTradeX/NileTradeX.github.io@master/static/img/caddy.png)

------
