---
title: "CRM System Code Handover Documentation"
date: "2024-07-25"
tags: ["CRM"]
description: ""
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true 
---

# CRM System Code Handover Documentation

## Project Description

The CRM system is GreatWay's customer management system, and I was mainly involved in the development of the following functions:

 - SysUser
 - Label
 - Activity
 - Leads
 - Sending emails

## Technology Stack

- **Programming language**: Java
- **Framework**: Spring Boot, MyBatis Plus
- **Database**: SQL (specific database type unspecified, to be adjusted according to the actual situation)
- **Dependency Management**: Maven
- **Other libraries**: Hutool, Apache Commons Lang3

## Development Modules

### System User Management (SysUser)

#### Module Structure

The SysUser functionality consists of the following parts:

1. **Entity class** (`SysUser`): located under `com.greatway.rbac.entity` package, represents the basic information of system user.

2. **Data access layer** (`SysUserMapper`): located under `com.greatway.rbac.mapper` package, inherits from `BaseMapper`, and is used to define the basic operations for interacting with the database.

3. **Service Interface** (`SysUserService`): located under the `com.greatway.rbac.service` package, defines the business logic interface related to user management.

4. **Service implementation class** (`SysUserServiceImpl`): located in `com.greatway.rbac.service.impl` package, implements the `SysUserService` interface, which contains the specific business logic for user management.

5. **Controller** (`SysUserController`): located under the `com.greatway.rbac.controller` package, handles user management related requests from the front-end and calls methods in the service layer.

#### Main Features

- **User Save**: add new user information.
- **User Edit**: modify existing user information.
- **User Query**: Queries user information based on user ID, user IDs, department IDs, etc.
- **User Delete**: Delete a user based on user ID.
- **Change Password**: Allow users to change their password.
- **Modify User Status**: Enables or disables the user account.
- **User Login**: User login verification.
- **Query Department Users**: Queries all users under the department based on the department ID.
- **Query Simple User Dictionary**: Get a list of short information about a user, usually used in a drop-down selection box.

#### Development Notes

- **Transaction Management**: When modifying database content, make sure to use the `@Transactional` annotation to ensure the atomicity of the operation.
- **Security**: The user password should be encrypted before saving.
- **Exception Handling**: Use custom exceptions (e.g. `BizException`) for error handling and friendly error messages.
- **Code specification**: Follow the existing coding specification in the project to keep the code neat and consistent.

### Label

#### Overview

The Label Management function allows users to add, delete, change and check labels, including saving labels, editing labels, querying labels by ID, querying labels by module, querying labels by module and resource IDs, querying labels by module and resource IDs, querying resource IDs by label ID, deleting labels, paging labels, and mapping and deleting mapping relationships for labels.

#### Main Classes and Interfaces

- `Label.java`: Label entity class containing basic information about the label such as ID, name, module, colour style, creation and update information.
- `LabelDTO.java`: Label data transfer object, used for data transfer between service and control layers.
- `LabelService.java`: Label service interface that defines business logic methods related to label management.
- `LabelServiceImpl.java`: Label service interface implementation class, implements the business logic of label management.
- `LabelController.java`: Label controller class that handles front-end requests for label management functionality.
- `LabelMapper.java`: Label MyBatis Mapper interface that defines methods for manipulating the label table in the database.

#### Functionality

- **Save Label** (`save`): Checks if a label with the same name and module exists, if it doesn't, it saves the new label.
- **Edit tags** (`edit`): check if tags with the same name and module exist except the current tag, if not, update the tag information.
- **Query tag by ID** (`queryById`): query tag information according to tag ID.
- **Query tag by module** (`queryByModule`): query related tags by module.
- **Query tags by module and resource id** (`queryByModuleAndResourceId`): Queries related tags by module and resource id.
- **Query tags by module and resource IDs** (`queryByModuleAndResourceIds`): queries for related tags by module and resource IDs and returns a mapping of resource IDs to a list of tags.
- **Query Resource IDs by Label ID** (`queryResourceIdsByLabelId`): queries for Resource IDs that use the label by its label ID.
- **Delete Label** (`deleteById`): deletes a label by label ID, provided that the label is not used by any resource.
- **Query tag by page** (`queryPage`): query a tag by page based on the query criteria.
- **Mapping Label** (`mappingLabel`): Creates a mapping between a resource and a label.
- **Delete Mapping Label** (`deleteMapping`): Deletes a mapping between a resource and a label.

#### Database Design

- `com_label` table: stores label information.
- `com_label_mapping` table: stores the mapping between resources and labels.

#### Notes

- Transaction management should be considered for all data operations, especially when performing delete and edit operations.
- Before performing the delete operation of a label, you need to check whether any resource is using the label.
- The paging query function needs to pay attention to SQL performance, especially when there is a large amount of data.


### Activity Management (Activity)

#### Overview
The event management function is designed to provide support for operations such as creating, editing, querying, and deleting event records. This function involves the management of basic information about an event, as well as operations related to event participants as well.

#### Description of major files and classes

1. **Entity class**
   - `Activity.java`: Activity entity class, contains the basic information of the activity such as activity ID, update time, etc.
   - `ActivityParticipant.java`: Activity participant entity class, records the information of the activity participant, such as participant ID, activity ID, etc.

2. **Controller**.
   - `ActivityController.java`: Activity related controller, handles requests from the front-end about activity management, such as saving activity, editing activity, querying activity, etc.

3. **Service Interface and Implementation**: `ActivityService.java`: Activity related controller.
   - `ActivityService.java`: defines the activity-related business logic interface.
   - `ActivityServiceImpl.java`: implements the `ActivityService` interface, which provides a specific business logic implementation for activity management.

4. **Data access object**
   - `ActivityMapper.java`: MyBatis Mapper interface for defining activity-related database operations.

#### Functionality

- **Save Activity**: Receives the activity information from the front-end and saves it to the database.
- **Edit Activity**: Updates the activity information according to the activity ID.
- **Query Activity**: Supports querying individual activity details according to activity ID, also supports querying activity list by page.
- **Delete Activity**: Delete an activity according to its ID.
- **Modify Activity Status**: Updates the activity status based on the activity ID and the new status value.
- **Delete all activities of company/person/lead/vendor**: Delete all activities associated with a company ID, person ID, lead ID or vendor ID.

#### Notes

- **Transaction Management**: `@Transactional` annotation is used to manage transactions in edit and delete operations to ensure data consistency.
- **Data Validation**: The `@Validated` annotation is used at the controller level to validate the data coming from the front-end.
- **Logging**: Use custom annotation `@NeedLog` to log critical operations.

#### Handover Matters

- **Database Migration**: Make sure the new developer has access to the database and understands the database structure.
- **Environment Setup**: The new developer needs to configure the Maven dependencies according to the `pom.xml` of the project.
- **Code Understanding**: New developers should be familiar with the use of Spring Boot and MyBatis Plus to be able to quickly get started with project development.
- **Follow-up development**: It is recommended that new developers start by reading the implementation of `ActivityServiceImpl.java` to understand the business logic of activity management.


### Clue Management (Leads)

#### Module Structure
The Leads Management functionality consists of the following main parts:

1. **Entity class** (`Lead`): located in `module-customer/customer-service-api/src/main/java/com/greatway/customer/entity` directory, it is used to map the `cus_leads` table in the database.

2. **Data Access Interface** (`LeadMapper`): located in `module-customer/customer-service-api/src/main/java/com/greatway/customer/mapper` directory, inherited from `BaseMapper` of MyBatis Plus. BaseMapper`, which is used to define database operations on the `Lead` entity.

3. **Business Objects** (BO): including `LeadSaveBO`, `LeadEditBO`, `LeadQueryPageBO`, `LeadChangeStatusBO`, etc., located in `module-customer/customer-service-api/src/ main/java/com/greatway/customer/bo` directory, which are used to encapsulate request data for different business operations.

4. **Data Transfer Object** (`LeadDTO`): located in `module-customer/customer-service-api/src/main/java/com/greatway/customer/dto` directory, used to encapsulate data transferred from the service tier to the front end.

5. **Service Interface** (`LeadService`): Located in the `module-customer/customer-service-api/src/main/java/com/greatway/customer/service` directory, it defines the business logic interfaces related to lead management. .

6. **Service implementation class** (`LeadServiceImpl`): located in the `module-customer/customer-service-api/src/main/java/com/greatway/customer/service/impl` directory, which implements the ` LeadService` interface, which contains specific business logic for lead management.

#### Core Functions
- **Save Lead**: Receive a `LeadSaveBO` object, convert it to a `Lead` entity and save it to the database.
- **Edit Leads**: Updates specific lead information based on the provided `LeadEditBO` object.
- **Query Leads**: Supports querying individual lead details by ID and paging through the list of leads.
- **Delete Lead**: Delete a specific lead based on the lead ID.
- **Change Lead Status**: Updates the status of a lead based on the provided `LeadChangeStatusBO` object.


### Send Mail

#### Overview
The purpose of this article is to hand over the code and configuration of the email sending feature. This feature supports sending set password emails, reset password emails and HTML emails using Thymeleaf templates.

#### Project Structure
- The `EmailService` interface defines the core methods for sending emails.
- The `EmailServiceImpl` class implements the `EmailService` interface and contains the specific email sending logic.
- The `EmailController` class provides a REST API interface for triggering email sending operations.
- The `EmailConfig` class contains the configuration required for the email sending functionality, such as the Thymeleaf template engine configuration.

#### Core Components
1. **EmailService interface**
   - Defines the basic methods for sending emails, including sending set password emails, reset password emails and HTML emails based on Thymeleaf templates.

2. **EmailServiceImpl class ** implements the `EmailService` class.
   - Implements the `EmailService` interface and uses `JavaMailSenderImpl` to send emails.
   - Use Thymeleaf template engine to generate HTML email content.
   - The `change-password-url` property needs to be set in the configuration file to generate a link to change the password.

3. **EmailController class
   - The **EmailController class** provides three REST API interfaces for sending password setting emails, password reset emails and HTML emails.
   - Use `@Validated` annotation to ensure the data validity of the request body.

4. **EmailConfig class
   - Configures the Thymeleaf template engine and email sources.
   - Specifies the location and encoding format of the email template.

#### Configuration Notes
- The mail sending function depends on Spring Mail and Thymeleaf. You need to add the corresponding dependency in `pom.xml`.
- The `application.properties` file needs to be configured with the properties of the mail server, such as server address, port, username and password.
- The `change-password-url` property should be set to the URL that allows the user to change the password.

#### Error Handling
- The `EmailServiceImpl` class catches and handles possible exceptions, including SMTP address failure exceptions and message exceptions.
- Exception information is encapsulated using a custom `BizException` class for easy error tracking and front-end display.

#### Maintenance and Extensions
- To add new email sending functionality, define new methods in the `EmailService` interface and implement them in the `EmailServiceImpl` class.
- For new email templates, you need to add the corresponding HTML file in the `mail-templates/` directory and specify the template name when sending emails.


## Notes

- **Transaction Management**: `@Transactional` annotation is used in edit and delete operations to manage transactions and ensure data consistency.
- **Data validation**: Uses `@Validated` annotation in the controller layer to validate the data coming from the front-end.
- **Logging**: Use custom annotation `@NeedLog` to log critical operations.
- Transaction management should be considered for all data operations, especially when performing delete and edit operations.
- Before performing delete operation on a tag, you need to check if any resource is using the tag.
- The paging query function needs to pay attention to SQL performance, especially when there is a large amount of data.

## Handover Matters

- **Database Migration**: Make sure the new developer has access to the database and understands the database structure.
- **Environment Setup**: New developers need to configure the Maven dependencies according to the project's `pom.xml`.
- **Code Understanding**: New developers should be familiar with the use of Spring Boot and MyBatis Plus to be able to quickly get started with project development.


------

