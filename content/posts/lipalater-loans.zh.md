---
title: "lipalater-loans 代码交接文档"
date: "2024-07-25"
tags: ["loans"]
description: ""
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true 
---

# lipalater-loans 代码交接文档

## 1. 项目简介

本项目基于 SpringBoot 2.7.2 和 Java 8 开发，是 lipalater 的贷前系统，提供以下功能：
 - 客户注册认证
 - 人脸识别验证
 - 贷款产品管理
 - 额度产品管理
 - 客户管理
 - 客户信用额度申请审批
 - 信用额度风险控制
 - 信用额度管理
 - 贷款还款

## 2. 技术概览

### 语言和框架：
- **Java**：后端开发的主要编程语言。
- **Maven**：依赖管理和构建工具。
- **Spring Boot**：简化Spring应用的设置和开发的框架。
- **Spring Data**：用于数据库交互。

### 开发环境：
- **IDE**：IntelliJ IDEA 2024.1.4
- **数据库**：MySQL 8.0 +
- **JDK版本**：JDK 8

## 3. 项目结构

```css
lipalater-loans
├── lipalater-loans-api
│   └── src
│       └── main
│           ├── java
│           │   └── com
│           │       └── lipalater
│           │           └── loans
│           │               └── api
│           │                   ├── b2b
│           │                   ├── common
│           │                   ├── config
│           │                   ├── controller
│           │                   ├── listener
│           │                   ├── pojo
│           │                   └── ussd
│           └── resources
│               └── json
├── lipalater-loans-risk
│   └── src
│       └── main
│           ├── java
│           │   └── com
│           │       └── lipalater
│           │           └── loans
│           │               └── risk
│           │                   ├── client
│           │                   ├── config
│           │                   ├── enums
│           │                   ├── model
│           │                   ├── rules
│           │                   └── service
│           └── resources
│               └── META-INF
├── lipalater-loans-sdk
│   └── src
│       └── main
│           └── java
│               └── com
│                   └── lipalater
│                       └── loans
│                           └── sdk
│                               ├── api
│                               ├── dto
│                               ├── enums
│                               ├── exception
│                               ├── utils
│                               └── vo
└── lipalater-loans-wallet
    └── src
        └── main
            ├── java
            │   └── com
            │       └── lipalater
            │           └── loans
            │               └── wallet
            │                   ├── aspect
            │                   ├── common
            │                   ├── comp
            │                   ├── listener
            │                   ├── pojo
            │                   └── thirdparty
            └── resources
```

 - `lipalater-loans-api`：为项目的核心工程，所有的核心代码都在这个工程，采用 SpringMVC 的结构。
 - `lipalater-loans-risk`：为客户信用额度申请时所需要进行的风控模块，使用责任连的设计模式，通过获取第三方数据，逐步评估客户信用分数，最后根据客户的收入、支出和职业计算出客户的信用额度。
 - `lipalater-loans-sdk`：为项目的 SDK，本工程是微服务工程，此 SDK 是为其他微服务调用所需的依赖。
 - `lipalater-loans-wallet`：为后续钱包拓展的服务，测试服务，没有实际应用。

## 数据库结构

数据库的结构文件，详细请参考 [SQL](https://cdn.jsdelivr.net/gh/NileTradeX/NileTradeX.github.io@master/static/sql/lipalater_loans.sql)
