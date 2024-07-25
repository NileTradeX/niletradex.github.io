---
title: "lipalater-loans code handover documentation"
date: "2024-07-25"
tags: ["loans"]
description: ""
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true 
--- - - - - - - - - - - - - - - - - - - - - - -

# lipalater-loans Code Handover Documentation

## 1. Project Description

This project is based on SpringBoot 2.7.2 and Java 8 development, is lipalater's pre-credit system, provides the following features:
 - Customer registration and authentication
 - Face recognition verification
 - Loan product management
 - Loan product management
 - Customer Management
 - Credit Line Application Approval
 - Credit Line Risk Control
 - Credit Line Management
 - Loan Repayment

## 2. Technical overview

### Languages and frameworks:
- **Java**: the main programming language for back-end development.
- **Maven**: dependency management and build tool.
- **Spring Boot**: A framework that simplifies the setup and development of Spring applications.
- **Spring Data**: for database interaction.

### Development environment:
- **IDE**: IntelliJ IDEA 2024.1.4
- **Database**: MySQL 8.0 +.
- **JDK version**: JDK 8

## 3. Project structure

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

 - `lipalater-loans-api`: the core project, all the core code is in this project, using SpringMVC structure.
 - ``lipalater-loans-risk``: is the risk control module that is needed when a customer applies for a credit line, using the chain-of-responsibility design pattern, it gradually evaluates the customer's credit score by obtaining third-party data, and finally calculates the customer's credit line based on the customer's income, expenses and occupation.
 - `lipalater-loans-sdk`: is the SDK for the project, this project is a microservice project, this SDK is a dependency needed for other microservice calls.
 - `lipalater-loans-wallet`: service for subsequent wallet expansion, test service, no real application.


