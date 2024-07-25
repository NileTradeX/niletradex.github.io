---
title: "CRM 系统代码交接文档"
date: "2024-07-25"
tags: ["CRM"]
description: ""
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true 
---

# CRM 系统代码交接文档

## 项目简介

CRM 系统是 GreatWay 的客户管理系统，我主要参与开发了以下功能：

 - 系统用户管理（SysUser）
 - 标签管理（Label）
 - 活动管理（Activity）
 - 线索管理（Leads）
 - 发送邮件

## 技术栈

- **编程语言**: Java
- **框架**: Spring Boot, MyBatis Plus
- **数据库**: SQL（具体数据库类型未指定，需根据实际情况调整）
- **依赖管理**: Maven
- **其他工具库**: Hutool, Apache Commons Lang3

## 开发模块

### 系统用户管理（SysUser）

#### 模块结构

系统用户管理功能主要包含以下几个部分：

1. **实体类** (`SysUser`): 位于 `com.greatway.rbac.entity` 包下，表示系统用户的基本信息。

2. **数据访问层** (`SysUserMapper`): 位于 `com.greatway.rbac.mapper` 包下，继承 `BaseMapper`，用于定义与数据库交互的基本操作。

3. **服务接口** (`SysUserService`): 位于 `com.greatway.rbac.service` 包下，定义了用户管理相关的业务逻辑接口。

4. **服务实现类** (`SysUserServiceImpl`): 位于 `com.greatway.rbac.service.impl` 包下，实现了 `SysUserService` 接口，包含用户管理的具体业务逻辑。

5. **控制器** (`SysUserController`): 位于 `com.greatway.rbac.controller` 包下，处理前端发来的用户管理相关请求，并调用服务层的方法。

#### 主要功能

- **用户保存**: 新增用户信息。
- **用户编辑**: 修改已存在的用户信息。
- **用户查询**: 根据用户ID、用户IDs、部门ID等条件查询用户信息。
- **用户删除**: 根据用户ID删除用户。
- **修改密码**: 允许用户修改自己的密码。
- **修改用户状态**: 启用或禁用用户账号。
- **用户登录**: 用户登录验证。
- **查询部门用户**: 根据部门ID查询该部门下的所有用户。
- **查询简单用户字典**: 获取用户的简略信息列表，通常用于下拉选择框。

#### 开发注意事项

- **事务管理**: 在修改数据库内容的操作中，务必使用 `@Transactional` 注解确保操作的原子性。
- **安全性**: 用户密码在保存前应进行加密处理。
- **异常处理**: 适当使用自定义异常（如 `BizException`）进行错误处理和友好的错误提示。
- **代码规范**: 遵循项目中已有的编码规范，保持代码的整洁和一致性。



### 标签管理（Label）

#### 概述

标签管理功能允许用户对标签进行增删改查操作，包括保存标签、编辑标签、通过ID查询标签、通过模块查询标签、通过模块和资源ID查询标签、通过模块和资源IDs查询标签、查询资源IDs通过标签ID、删除标签、分页查询标签以及标签的映射和删除映射关系。

#### 主要类和接口

- `Label.java`: 标签实体类，包含标签的基本信息如ID、名称、模块、颜色样式、创建和更新信息等。
- `LabelDTO.java`: 标签的数据传输对象，用于服务层和控制层之间的数据传递。
- `LabelService.java`: 标签服务接口，定义了标签管理相关的业务逻辑方法。
- `LabelServiceImpl.java`: 标签服务接口实现类，实现了标签管理的业务逻辑。
- `LabelController.java`: 标签控制器类，处理前端对标签管理功能的请求。
- `LabelMapper.java`: 标签MyBatis Mapper接口，定义了对数据库中标签表的操作方法。

#### 功能说明

- **保存标签** (`save`): 检查同名同模块标签是否存在，不存在则保存新标签。
- **编辑标签** (`edit`): 检查除当前标签外同名同模块标签是否存在，不存在则更新标签信息。
- **通过ID查询标签** (`queryById`): 根据标签ID查询标签信息。
- **通过模块查询标签** (`queryByModule`): 根据模块查询相关标签。
- **通过模块和资源ID查询标签** (`queryByModuleAndResourceId`): 根据模块和资源ID查询相关标签。
- **通过模块和资源IDs查询标签** (`queryByModuleAndResourceIds`): 根据模块和资源IDs查询相关标签，并返回资源ID到标签列表的映射。
- **查询资源IDs通过标签ID** (`queryResourceIdsByLabelId`): 根据标签ID查询使用该标签的资源IDs。
- **删除标签** (`deleteById`): 根据标签ID删除标签，前提是该标签未被任何资源使用。
- **分页查询标签** (`queryPage`): 根据查询条件分页查询标签。
- **关联标签** (`mappingLabel`): 创建资源与标签之间的映射关系。
- **删除关联标签** (`deleteMapping`): 删除资源与标签之间的映射关系。

#### 数据库设计

- `com_label` 表: 存储标签信息。
- `com_label_mapping` 表: 存储资源与标签之间的映射关系。

#### 注意事项

- 所有的数据操作都应该考虑事务管理，特别是在进行删除和编辑操作时。
- 在进行标签的删除操作前，需要检查是否有资源正在使用该标签。
- 分页查询功能需要注意SQL性能，尤其是在数据量大时。

### 活动管理（Activity）

#### 概述
活动管理功能是为了提供对活动记录的创建、编辑、查询、删除等操作的支持。该功能涉及到活动的基本信息管理，以及与活动参与者相关的操作。

#### 主要文件和类的说明

1. **实体类**
   - `Activity.java`: 活动实体类，包含活动的基本信息如活动ID、更新时间等。
   - `ActivityParticipant.java`: 活动参与者实体类，记录活动参与者的信息，如参与者ID、活动ID等。

2. **控制器**
   - `ActivityController.java`: 活动相关的控制器，处理前端发来的关于活动管理的请求，如保存活动、编辑活动、查询活动等。

3. **服务接口及实现**
   - `ActivityService.java`: 定义了活动相关的业务逻辑接口。
   - `ActivityServiceImpl.java`: 实现了`ActivityService`接口，提供了活动管理的具体业务逻辑实现。

4. **数据访问对象**
   - `ActivityMapper.java`: MyBatis Mapper接口，用于定义与活动相关的数据库操作。

#### 功能说明

- **保存活动**: 接收前端传来的活动信息，保存到数据库。
- **编辑活动**: 根据活动ID更新活动信息。
- **查询活动**: 支持根据活动ID查询单个活动详情，也支持分页查询活动列表。
- **删除活动**: 根据活动ID删除指定活动。
- **修改活动状态**: 根据活动ID和新的状态值更新活动状态。
- **删除公司/个人/线索/供应商的全部活动**: 根据公司ID、个人ID、线索ID或供应商ID删除相关联的所有活动。

#### 交接事项
- **后续开发**: 建议新开发者先从阅读`ActivityServiceImpl.java`的实现开始，理解活动管理的业务逻辑。


### 线索管理（Leads）

#### 模块结构
线索管理功能主要包含以下几个部分：

1. **实体类** (`Lead`): 位于 `module-customer/customer-service-api/src/main/java/com/greatway/customer/entity` 目录下，用于映射数据库中的 `cus_leads` 表。

2. **数据访问接口** (`LeadMapper`): 位于 `module-customer/customer-service-api/src/main/java/com/greatway/customer/mapper` 目录下，继承自 MyBatis Plus 的 `BaseMapper`，用于定义对 `Lead` 实体的数据库操作。

3. **业务对象** (BO): 包括 `LeadSaveBO`, `LeadEditBO`, `LeadQueryPageBO`, `LeadChangeStatusBO` 等，位于 `module-customer/customer-service-api/src/main/java/com/greatway/customer/bo` 目录下，用于封装不同业务操作的请求数据。

4. **数据传输对象** (`LeadDTO`): 位于 `module-customer/customer-service-api/src/main/java/com/greatway/customer/dto` 目录下，用于封装从服务层传输到前端的数据。

5. **服务接口** (`LeadService`): 位于 `module-customer/customer-service-api/src/main/java/com/greatway/customer/service` 目录下，定义了线索管理相关的业务逻辑接口。

6. **服务实现类** (`LeadServiceImpl`): 位于 `module-customer/customer-service-api/src/main/java/com/greatway/customer/service/impl` 目录下，实现了 `LeadService` 接口，包含线索管理的具体业务逻辑。

#### 核心功能
- **保存线索**: 接收一个 `LeadSaveBO` 对象，将其转换为 `Lead` 实体并保存到数据库。
- **编辑线索**: 根据提供的 `LeadEditBO` 对象更新特定的线索信息。
- **查询线索**: 支持通过 ID 查询单个线索详情以及分页查询线索列表。
- **删除线索**: 根据线索 ID 删除特定线索。
- **更改线索状态**: 根据提供的 `LeadChangeStatusBO` 对象更新线索的状态。


### 发送邮件

#### 概述
本文旨在交接邮件发送功能的相关代码和配置。该功能支持发送设置密码邮件、重置密码邮件以及使用Thymeleaf模板发送HTML邮件。

#### 项目结构
- `EmailService` 接口定义了邮件发送的核心方法。
- `EmailServiceImpl` 类实现了 `EmailService` 接口，包含具体的邮件发送逻辑。
- `EmailController` 类提供了REST API接口，用于触发邮件发送操作。
- `EmailConfig` 类包含了邮件发送功能所需的配置，如Thymeleaf模板引擎配置。

#### 核心组件
1. **EmailService 接口**
   - 定义了邮件发送的基本方法，包括发送设置密码邮件、重置密码邮件和基于Thymeleaf模板的HTML邮件。

2. **EmailServiceImpl 类**
   - 实现了 `EmailService` 接口，使用 `JavaMailSenderImpl` 发送邮件。
   - 利用Thymeleaf模板引擎生成HTML邮件内容。
   - 配置文件中需设置 `change-password-url` 属性，用于生成密码更改链接。

3. **EmailController 类**
   - 提供了三个REST API接口，分别用于发送设置密码邮件、重置密码邮件和HTML邮件。
   - 使用 `@Validated` 注解确保请求体的数据有效性。

4. **EmailConfig 类**
   - 配置Thymeleaf模板引擎和邮件消息源。
   - 指定了邮件模板的位置和编码格式。

#### 配置说明
- 邮件发送功能依赖于Spring Mail和Thymeleaf，需在 `pom.xml` 中添加相应依赖。
- `application.properties` 文件中需要配置邮件服务器的相关属性，如服务器地址、端口、用户名和密码。
- `change-password-url` 属性需设置为允许用户更改密码的URL。

#### 错误处理
- `EmailServiceImpl` 类中对可能发生的异常进行了捕获和处理，包括SMTP地址失败异常和消息异常。
- 使用自定义的 `BizException` 类封装异常信息，便于错误追踪和前端显示。

#### 维护和扩展
- 如需添加新的邮件发送功能，可在 `EmailService` 接口中定义新的方法，并在 `EmailServiceImpl` 类中实现。
- 对于新的邮件模板，需在 `mail-templates/` 目录下添加相应的HTML文件，并在发送邮件时指定模板名称。


## 注意事项

- **事务管理**: 在编辑和删除操作中使用了`@Transactional`注解来管理事务，确保数据的一致性。
- **数据验证**: 在控制器层使用`@Validated`注解对前端传来的数据进行验证。
- **日志记录**: 使用自定义注解`@NeedLog`记录关键操作的日志。
- 所有的数据操作都应该考虑事务管理，特别是在进行删除和编辑操作时。
- 在进行标签的删除操作前，需要检查是否有资源正在使用该标签。
- 分页查询功能需要注意SQL性能，尤其是在数据量大时。

## 交接事项

- **数据库迁移**: 确保新开发者有数据库的访问权限，并且了解数据库结构。
- **环境搭建**: 新开发者需要根据项目的`pom.xml`配置好Maven依赖。
- **代码理解**: 新开发者应当熟悉Spring Boot和MyBatis Plus的使用，以便能够快速上手项目开发。

------
