---
title: "LMS System Code Handover Documentation"
date: "2024-07-22"
tags: ["Terraform", "EKS"]
description: ""
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
---

# LMS Code Handover Documentation

## Project Overview

LMS is an open source financial services platform designed to provide core banking functionality. It supports microfinance institutions, credit unions, insurance companies, and other financial service providers to manage their businesses through a flexible and scalable solution.LMS provides a full suite of functionality for lending, savings, bill payment, customer management, and more.

## Key Features

1. **Loan Management**
   - Provides full-cycle loan management functions from application to repayment.
   - Supports a wide range of loan product types, including personal loans, group loans and agricultural loans.
   - Provides flexible repayment plan and interest rate setting.
2. **Savings and Deposits**
   - Supports a wide range of savings products, including time deposits, demand deposits and savings accounts.
   - Automatically calculates interest and generates account statements.
3. **Bill Payment**
   - Integrate multiple payment channels and support customers to make repayment through bank transfer and mobile payment.
   - Automatically generate and manage bills.
4. **Customer Management
   - Provides detailed customer information management and supports KYC (Know Your Customer) process. Supports customer classification and hierarchical management.
   - Supports customer classification and hierarchical management.
5. **Accounting**
   - Built-in accounting module, supports multiple accounting standards.
   - Provides financial statement generation and auditing functions.
6. **Analysis and Reporting**
   - Provides comprehensive data analysis and reporting functions to help organisations make business decisions.
   - Supports customised reports and data export.

## Project structure

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

 - Application layer (loan-management-app): Contains application services and data transfer objects (DTOs). This layer coordinates domain objects to perform business operations and provide service interfaces to external parties.
 - Loan-management-domain: The core of the DDD, containing the domain model (entities, value objects), domain services, and repository interfaces. This layer encapsulates business logic and business rules.
 - Loan-management-infrastructure: Provides the implementation of technical details, such as database access (repository implementation), mail services, etc., to support the upper application and domain layers.
 - Interface layer (loan-management-client and loan-management-adapter): contains the interfaces for interaction with the outside world, such as REST API controllers and web interface controllers. This layer is responsible for converting external requests into a form that can be handled by the application layer and returning the results to the client.

## Technical Overview

### **System Requirements**

- Java 21 or above
- Apache Maven 3.9 or above
- MySQL or PostgreSQL database

### Architecture
Fineract's architecture is designed with a focus on flexibility and scalability and consists of the following components:

- **API Layer**: provides a RESTful API to support external system integration.
- **Service Layer**: implements business logic, including core functions such as lending, savings, and customer management.
- **Persistence layer**: use relational database (e.g. MySQL, PostgreSQL) for data storage.


#### Database Design

Fineract's database design uses a relational database, and the main table structures include:

- **Customer table (m_client)**: stores basic information about the customer.
- **Loan table (m_loan)**: records loan applications and their status.
- **Deposits table (m_savings_account)**: manages savings account information.
- **Transaction table (m_transaction)**: records account transaction history.
- **Product table (m_product)**: defines attributes of loan and deposit products.

Example table structure:

```sql
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
Structure file of the database, please refer to [SQL](https://cdn.jsdelivr.net/gh/NileTradeX/NileTradeX.github.io@master/static/sql/loan-management.sql) for details.

## Related Documents

[Official website](https://fineract.apache.org/)

[GitHub repository](https://github.com/apache/fineract)

[User documentation](https://cwiki.apache.org/confluence/display/FINERACT/Apache+Fineract)

[Developer Guide](https://cwiki.apache.org/confluence/display/FINERACT/Developer+Guide)

Translated with www.DeepL.com/Translator (free version)