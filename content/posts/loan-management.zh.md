---
title: "LMS 系统代码交接文档"
date: "2024-07-22"
tags: ["Terraform","EKS"]
description: ""
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
---

# LMS 系统代码交接文档

## 项目概览

LMS 系统是一个开源的金融服务平台，旨在提供核心银行业务功能。它支持微型金融机构、信用合作社、保险公司、和其他金融服务提供商通过灵活且可扩展的解决方案来管理其业务。LMS 提供了一整套用于贷款、储蓄、账单支付、客户管理等功能。

## 主要功能

1. **贷款管理**
   - 提供从申请到还款的全周期贷款管理功能。
   - 支持多种贷款产品类型，包括个人贷款、团体贷款、农业贷款等。
   - 提供灵活的还款计划和利率设定。
2. **储蓄和存款**
   - 支持多种储蓄产品，包括定期存款、活期存款和储蓄账户。
   - 自动计算利息并生成账户对账单。
3. **账单支付**
   - 集成多种支付渠道，支持客户通过银行转账、移动支付等方式进行还款。
   - 自动生成和管理账单。
4. **客户管理**
   - 提供详尽的客户信息管理，支持KYC（了解你的客户）流程。
   - 支持客户分类和分层管理。
5. **会计核算**
   - 内置会计模块，支持多种会计准则。
   - 提供财务报表生成和审计功能。
6. **分析与报告**
   - 提供全面的数据分析和报告功能，帮助机构进行业务决策。
   - 支持自定义报告和数据导出。

## 项目结构

```css
loan-management
.
├── loan-data-migration
│   └── src
│       └── main
│           └── java
│               └── com
│                   └── lipalater
│                       └── loan
│                           └── migration
│                               ├── callback
│                               ├── config
│                               ├── controller
│                               ├── core
│                               ├── dto
│                               ├── intercept
│                               ├── retrofit
│                               ├── service
│                               └── util
├── loan-management-adapter
│   └── src
│       └── main
│           └── java
│               └── com
│                   └── lipalater
│                       └── loan
│                           ├── activemq
│                           ├── api
│                           │   └── version
│                           ├── config
│                           ├── mobile
│                           ├── security
│                           ├── util
│                           │   ├── email
│                           │   ├── excel
│                           │   └── pdf
│                           └── web
│                               ├── accounting
│                               ├── authentication
│                               ├── customer
│                               ├── loan
│                               ├── organization
│                               └── system
├── loan-management-app
│   └── src
│       └── main
│           └── java
│               └── com
│                   └── lipalater
│                       └── loan
│                           └── app
│                               ├── accounting
│                               ├── authentication
│                               ├── catchlog
│                               ├── command
│                               ├── customer
│                               ├── loan
│                               ├── organisation
│                               ├── product
│                               ├── statemachine
│                               ├── system
│                               ├── utils
│                               └── validator
├── loan-management-batch
│   └── src
│       └── main
│           └── java
│               └── com
│                   └── lipalater
│                       └── loan
│                           └── batch
│                               ├── batch
│                               ├── config
│                               ├── enums
│                               ├── exception
│                               ├── listener
│                               ├── model
│                               ├── scheduler
│                               └── task
├── loan-management-client
│   └── src
│       └── main
│           └── java
│               └── com
│                   └── lipalater
│                       └── loan
│                           ├── api
│                           │   ├── accounting
│                           │   ├── customer
│                           │   ├── loan
│                           │   ├── organization
│                           │   └── system
│                           └── dto
│                               ├── accounting
│                               ├── common
│                               ├── customer
│                               ├── data
│                               ├── group
│                               ├── interestratechart
│                               ├── interoperation
│                               ├── loan
│                               ├── organization
│                               ├── product
│                               ├── saving
│                               ├── shared
│                               ├── system
│                               └── tax
├── loan-management-domain
│   └── src
│       └── main
│           └── java
│               └── com
│                   └── lipalater
│                       └── loan
│                           └── domain
│                               ├── accounting
│                               ├── cache
│                               ├── calendar
│                               ├── collateral
│                               ├── common
│                               ├── customer
│                               ├── exception
│                               ├── group
│                               ├── interestratechart
│                               ├── interoperation
│                               ├── job
│                               ├── loan
│                               ├── note
│                               ├── organisation
│                               ├── saving
│                               ├── shared
│                               ├── system
│                               ├── tax
│                               └── util
├── loan-management-infrastructure
│   └── src
│       └── main
│           └── java
│               └── com
│                   └── lipalater
│                       └── loan
│                           └── infrastructure
│                               ├── accounting
│                               ├── calendar
│                               ├── common
│                               ├── config
│                               ├── customer
│                               ├── job
│                               ├── loan
│                               ├── note
│                               ├── organisation
│                               ├── saving
│                               ├── system
│                               └── util
└── start
    └── src
        └── main
            └── java
                └── com
                    └── lipalater
                        └── loan
```

 - 应用层 (loan-management-app): 包含应用服务和数据传输对象（DTOs）。这一层协调领域层对象来执行业务操作，并向外部提供服务接口。
 - 领域层 (loan-management-domain): 是DDD的核心，包含领域模型（实体、值对象）、领域服务和仓库接口。这一层封装了业务逻辑和业务规则。
 - 基础设施层 (loan-management-infrastructure): 提供技术细节的实现，如数据库访问（仓库实现）、邮件服务等，支持上层的应用和领域层。
 - 接口层 (loan-management-client和loan-management-adapter): 包含与外界交互的接口，如REST API控制器和Web界面控制器。这一层负责将外部请求转换为应用层可以处理的形式，并将结果返回给客户端

## 技术概览

### **系统要求**

- Java 21 或以上版本
- Apache Maven 3.9 或以上版本
- MySQL 或 PostgreSQL 数据库

### 架构
Fineract 的架构设计注重灵活性和可扩展性，主要包括以下组件：

- **API 层**：提供RESTful API，支持外部系统集成。
- **服务层**：实现业务逻辑，包括贷款、储蓄、客户管理等核心功能。
- **持久层**：使用关系型数据库（如MySQL、PostgreSQL）进行数据存储。


#### 数据库设计

Fineract 的数据库设计采用了关系型数据库，主要表结构包括：

- **客户表（m_client）**：存储客户的基本信息。
- **贷款表（m_loan）**：记录贷款申请及其状态。
- **存款表（m_savings_account）**：管理储蓄账户信息。
- **交易表（m_transaction）**：记录账户交易历史。
- **产品表（m_product）**：定义贷款和存款产品的属性。

示例表结构：

```
sql
复制代码
CREATE TABLE m_client (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    display_name VARCHAR(100),
    office_id BIGINT,
    status ENUM('Pending', 'Active', 'Closed'),
    activated_date DATE
);

CREATE TABLE m_loan (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    client_id BIGINT,
    loan_product_id BIGINT,
    principal_amount DECIMAL(19, 6),
    interest_rate DECIMAL(5, 2),
    term_period INTEGER,
    status ENUM('Pending', 'Approved', 'Disbursed', 'Closed')
);

CREATE TABLE m_savings_account (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    client_id BIGINT,
    savings_product_id BIGINT,
    deposit_amount DECIMAL(19, 6),
    interest_rate DECIMAL(5, 2),
    status ENUM('Active', 'Dormant', 'Closed')
);

CREATE TABLE m_transaction (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    account_id BIGINT,
    transaction_type ENUM('Deposit', 'Withdrawal', 'Transfer'),
    amount DECIMAL(19, 6),
    transaction_date DATE
);

CREATE TABLE m_product (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    type ENUM('Loan', 'Savings'),
    interest_rate DECIMAL(5, 2),
    description TEXT
);
```

数据库的结构文件，详细请参考 [SQL](https://cdn.jsdelivr.net/gh/NileTradeX/NileTradeX.github.io@master/static/sql/loan-management.sql)



## 使用场景

- **微型金融机构**：帮助微型金融机构管理其贷款和储蓄业务，提高运营效率。
- **信用合作社**：支持信用合作社进行成员管理和财务操作。
- **金融科技公司**：为金融科技公司提供可定制的金融服务平台。
- **非营利组织**：支持非营利组织提供普惠金融服务。

## 相关文档

[官方网站](https://fineract.apache.org/)

[GitHub 仓库](https://github.com/apache/fineract)

[用户文档](https://cwiki.apache.org/confluence/display/FINERACT/Apache+Fineract)

[开发者指南](https://cwiki.apache.org/confluence/display/FINERACT/Developer+Guide)