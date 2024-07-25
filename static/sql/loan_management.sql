/*
 Navicat Premium Data Transfer

 Source Server         : azure-dev
 Source Server Type    : MySQL
 Source Server Version : 50744 (5.7.44-log)
 Source Host           : lipalater-mysql-dev.mysql.database.azure.com:3306
 Source Schema         : loan_management

 Target Server Type    : MySQL
 Target Server Version : 50744 (5.7.44-log)
 File Encoding         : 65001

 Date: 25/07/2024 16:01:35
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for acc_accounting_rule
-- ----------------------------
DROP TABLE IF EXISTS `acc_accounting_rule`;
CREATE TABLE `acc_accounting_rule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(512) NOT NULL,
  `office_id` bigint(20) DEFAULT NULL,
  `debit_account_id` bigint(20) DEFAULT NULL,
  `credit_account_id` bigint(20) DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  `system_defined` bit(1) NOT NULL,
  `allow_multiple_credits` bit(1) NOT NULL,
  `allow_multiple_debits` bit(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for acc_gl_account
-- ----------------------------
DROP TABLE IF EXISTS `acc_gl_account`;
CREATE TABLE `acc_gl_account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `name_decorated` varchar(255) DEFAULT NULL,
  `gl_code` varchar(255) NOT NULL,
  `disabled` bit(1) NOT NULL,
  `manual_entries_allowed` bit(1) NOT NULL,
  `tag_id` bigint(20) DEFAULT NULL,
  `account_type` varchar(32) NOT NULL,
  `account_usage` varchar(32) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `reconciliation_enabled` bit(1) NOT NULL,
  `external_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=203 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for acc_gl_closure
-- ----------------------------
DROP TABLE IF EXISTS `acc_gl_closure`;
CREATE TABLE `acc_gl_closure` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `office_id` bigint(20) NOT NULL,
  `is_deleted` bit(1) NOT NULL,
  `closing_date` date NOT NULL,
  `comments` varchar(512) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for acc_gl_financial_activity_account
-- ----------------------------
DROP TABLE IF EXISTS `acc_gl_financial_activity_account`;
CREATE TABLE `acc_gl_financial_activity_account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `gl_account_id` bigint(20) NOT NULL,
  `financial_activity_type` varchar(64) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for acc_gl_journal_entry
-- ----------------------------
DROP TABLE IF EXISTS `acc_gl_journal_entry`;
CREATE TABLE `acc_gl_journal_entry` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `office_id` bigint(20) NOT NULL,
  `payment_details_id` bigint(20) DEFAULT NULL,
  `account_id` bigint(20) NOT NULL,
  `entry_date` date NOT NULL,
  `currency_code` varchar(8) NOT NULL,
  `reversal_id` bigint(20) DEFAULT NULL,
  `transaction_id` varchar(64) DEFAULT NULL,
  `reversed` bit(1) NOT NULL DEFAULT b'0',
  `manual_entry` bit(1) NOT NULL DEFAULT b'0',
  `loan_transaction_id` bigint(20) DEFAULT NULL,
  `savings_transaction_id` bigint(20) DEFAULT NULL,
  `client_transaction_id` bigint(20) DEFAULT NULL,
  `share_transaction_id` bigint(20) DEFAULT NULL,
  `journal_entry_type` varchar(32) NOT NULL,
  `amount` decimal(16,6) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `entity_type` varchar(32) DEFAULT NULL,
  `entity_id` bigint(20) DEFAULT NULL,
  `ref_num` varchar(64) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for acc_product_mapping
-- ----------------------------
DROP TABLE IF EXISTS `acc_product_mapping`;
CREATE TABLE `acc_product_mapping` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `gl_account_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `payment_type` bigint(20) DEFAULT NULL,
  `charge_product_id` bigint(20) DEFAULT NULL,
  `product_type` varchar(255) DEFAULT NULL,
  `financial_account_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `financial_action` (`product_id`,`product_type`,`financial_account_type`,`payment_type`),
  KEY `FK_ACC_PRODUCT_MAPPING_ON_CHARGE_PRODUCT` (`charge_product_id`),
  KEY `FK_ACC_PRODUCT_MAPPING_ON_GL_ACCOUNT` (`gl_account_id`),
  KEY `FK_ACC_PRODUCT_MAPPING_ON_PAYMENT_TYPE` (`payment_type`),
  CONSTRAINT `FK_ACC_PRODUCT_MAPPING_ON_CHARGE_PRODUCT` FOREIGN KEY (`charge_product_id`) REFERENCES `m_product_charge` (`id`),
  CONSTRAINT `FK_ACC_PRODUCT_MAPPING_ON_GL_ACCOUNT` FOREIGN KEY (`gl_account_id`) REFERENCES `acc_gl_account` (`id`),
  CONSTRAINT `FK_ACC_PRODUCT_MAPPING_ON_PAYMENT_TYPE` FOREIGN KEY (`payment_type`) REFERENCES `org_payment_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for acc_rule_tags
-- ----------------------------
DROP TABLE IF EXISTS `acc_rule_tags`;
CREATE TABLE `acc_rule_tags` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `acc_rule_id` bigint(20) NOT NULL,
  `tag_id` bigint(20) NOT NULL,
  `journal_type` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_no` varchar(255) DEFAULT NULL,
  `external_id` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) NOT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) NOT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `marital_status` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `customer_type` varchar(255) DEFAULT NULL,
  `country_iso_code` varchar(255) DEFAULT NULL,
  `origin_channel` varchar(255) DEFAULT NULL,
  `office_id` bigint(20) DEFAULT NULL,
  `staff_id` bigint(20) DEFAULT NULL,
  `activation_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_email` (`email`) USING HASH,
  UNIQUE KEY `customer_phone_number` (`phone_number`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for customer_blacklist
-- ----------------------------
DROP TABLE IF EXISTS `customer_blacklist`;
CREATE TABLE `customer_blacklist` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `identifier_type` varchar(255) NOT NULL,
  `document_key` varchar(64) NOT NULL,
  `note` varchar(2048) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for customer_identification
-- ----------------------------
DROP TABLE IF EXISTS `customer_identification`;
CREATE TABLE `customer_identification` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) NOT NULL,
  `identifier_type` varchar(255) NOT NULL,
  `document_key` varchar(64) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `identification_customer_id` (`customer_id`),
  CONSTRAINT `identification_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for databasechangelog
-- ----------------------------
DROP TABLE IF EXISTS `databasechangelog`;
CREATE TABLE `databasechangelog` (
  `ID` varchar(255) NOT NULL,
  `AUTHOR` varchar(255) NOT NULL,
  `FILENAME` varchar(255) NOT NULL,
  `DATEEXECUTED` datetime NOT NULL,
  `ORDEREXECUTED` int(11) NOT NULL,
  `EXECTYPE` varchar(10) NOT NULL,
  `MD5SUM` varchar(35) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `COMMENTS` varchar(255) DEFAULT NULL,
  `TAG` varchar(255) DEFAULT NULL,
  `LIQUIBASE` varchar(20) DEFAULT NULL,
  `CONTEXTS` varchar(255) DEFAULT NULL,
  `LABELS` varchar(255) DEFAULT NULL,
  `DEPLOYMENT_ID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for databasechangeloglock
-- ----------------------------
DROP TABLE IF EXISTS `databasechangeloglock`;
CREATE TABLE `databasechangeloglock` (
  `ID` int(11) NOT NULL,
  `LOCKED` tinyint(1) NOT NULL,
  `LOCKGRANTED` datetime DEFAULT NULL,
  `LOCKEDBY` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for glim_accounts
-- ----------------------------
DROP TABLE IF EXISTS `glim_accounts`;
CREATE TABLE `glim_accounts` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` bigint(20) NOT NULL,
  `account_number` varchar(255) NOT NULL,
  `principal_amount` decimal(10,0) DEFAULT NULL,
  `child_accounts_count` bigint(20) DEFAULT NULL,
  `accepting_child` bit(1) DEFAULT NULL,
  `loan_status_id` int(11) NOT NULL,
  `application_id` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `FK_glim_id` (`account_number`),
  KEY `FK_GLIM_ACCOUNTS_ON_GROUP` (`group_id`),
  CONSTRAINT `FK_GLIM_ACCOUNTS_ON_GROUP` FOREIGN KEY (`group_id`) REFERENCES `m_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for glim_accounts_child_loan
-- ----------------------------
DROP TABLE IF EXISTS `glim_accounts_child_loan`;
CREATE TABLE `glim_accounts_child_loan` (
  `group_loan_individual_monitoring_account_id` bigint(20) NOT NULL,
  `child_loan_id` bigint(20) NOT NULL,
  PRIMARY KEY (`group_loan_individual_monitoring_account_id`,`child_loan_id`),
  UNIQUE KEY `uc_glim_accounts_child_loan_childloan` (`child_loan_id`),
  CONSTRAINT `fk_gliaccchiloa_on_group_loan_individual_monitoring_account` FOREIGN KEY (`group_loan_individual_monitoring_account_id`) REFERENCES `glim_accounts` (`id`),
  CONSTRAINT `fk_gliaccchiloa_on_loan` FOREIGN KEY (`child_loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for gsim_accounts
-- ----------------------------
DROP TABLE IF EXISTS `gsim_accounts`;
CREATE TABLE `gsim_accounts` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` bigint(20) NOT NULL,
  `account_number` varchar(255) NOT NULL,
  `parent_deposit` decimal(10,0) DEFAULT NULL,
  `child_accounts_count` bigint(20) DEFAULT NULL,
  `accepting_child` bit(1) DEFAULT NULL,
  `savings_status_id` int(11) NOT NULL,
  `application_id` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `gsim_id` (`account_number`),
  KEY `FK_GSIM_ACCOUNTS_ON_GROUP` (`group_id`),
  CONSTRAINT `FK_GSIM_ACCOUNTS_ON_GROUP` FOREIGN KEY (`group_id`) REFERENCES `m_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for gsim_accounts_child_saving
-- ----------------------------
DROP TABLE IF EXISTS `gsim_accounts_child_saving`;
CREATE TABLE `gsim_accounts_child_saving` (
  `group_savings_individual_monitoring_id` bigint(20) NOT NULL,
  `child_saving_id` bigint(20) NOT NULL,
  PRIMARY KEY (`group_savings_individual_monitoring_id`,`child_saving_id`),
  UNIQUE KEY `uc_gsim_accounts_child_saving_childsaving` (`child_saving_id`),
  CONSTRAINT `fk_gsiaccchisav_on_group_savings_individual_monitoring` FOREIGN KEY (`group_savings_individual_monitoring_id`) REFERENCES `gsim_accounts` (`id`),
  CONSTRAINT `fk_gsiaccchisav_on_savings_account` FOREIGN KEY (`child_saving_id`) REFERENCES `m_savings_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for interop_identifier
-- ----------------------------
DROP TABLE IF EXISTS `interop_identifier`;
CREATE TABLE `interop_identifier` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` bigint(20) NOT NULL,
  `type` varchar(32) NOT NULL,
  `a_value` varchar(128) NOT NULL,
  `sub_value_or_type` varchar(128) DEFAULT NULL,
  `created_by` varchar(32) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_by` varchar(32) DEFAULT NULL,
  `modified_on` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_hathor_identifier_account` (`account_id`,`type`),
  UNIQUE KEY `uk_hathor_identifier_value` (`type`,`a_value`,`sub_value_or_type`),
  CONSTRAINT `FK_INTEROP_IDENTIFIER_ON_ACCOUNT` FOREIGN KEY (`account_id`) REFERENCES `m_savings_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_account_transfer_details
-- ----------------------------
DROP TABLE IF EXISTS `m_account_transfer_details`;
CREATE TABLE `m_account_transfer_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `from_office_id` bigint(20) NOT NULL,
  `from_client_id` bigint(20) NOT NULL,
  `from_savings_account_id` bigint(20) DEFAULT NULL,
  `to_office_id` bigint(20) NOT NULL,
  `to_client_id` bigint(20) NOT NULL,
  `to_savings_account_id` bigint(20) DEFAULT NULL,
  `to_loan_account_id` bigint(20) DEFAULT NULL,
  `from_loan_account_id` bigint(20) DEFAULT NULL,
  `transfer_type` varchar(64) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_account_transfer_transaction
-- ----------------------------
DROP TABLE IF EXISTS `m_account_transfer_transaction`;
CREATE TABLE `m_account_transfer_transaction` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_transfer_details_id` bigint(20) DEFAULT NULL,
  `from_savings_transaction_id` bigint(20) DEFAULT NULL,
  `to_savings_transaction_id` bigint(20) DEFAULT NULL,
  `to_loan_transaction_id` bigint(20) DEFAULT NULL,
  `from_loan_transaction_id` bigint(20) DEFAULT NULL,
  `is_reversed` bit(1) NOT NULL DEFAULT b'0',
  `transaction_date` date DEFAULT NULL,
  `currency_code` varchar(8) NOT NULL,
  `currency_digits` int(11) NOT NULL,
  `currency_multiples_of` int(11) DEFAULT NULL,
  `amount` decimal(16,6) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `created_by` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` bigint(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_calendar
-- ----------------------------
DROP TABLE IF EXISTS `m_calendar`;
CREATE TABLE `m_calendar` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_by` bigint(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` bigint(20) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `title` varchar(50) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `calendar_type_enum` int(11) NOT NULL,
  `repeating` bit(1) NOT NULL,
  `recurrence` varchar(100) DEFAULT NULL,
  `remind_by_enum` int(11) DEFAULT NULL,
  `first_reminder` int(11) DEFAULT NULL,
  `second_reminder` int(11) DEFAULT NULL,
  `meeting_time` time DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_calendar_history
-- ----------------------------
DROP TABLE IF EXISTS `m_calendar_history`;
CREATE TABLE `m_calendar_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `calendar_id` bigint(20) NOT NULL,
  `title` varchar(50) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `calendar_type_enum` int(11) NOT NULL,
  `repeating` bit(1) NOT NULL,
  `recurrence` varchar(100) DEFAULT NULL,
  `remind_by_enum` int(11) DEFAULT NULL,
  `first_reminder` int(11) DEFAULT NULL,
  `second_reminder` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_M_CALENDAR_HISTORY_ON_CALENDAR` (`calendar_id`),
  CONSTRAINT `FK_M_CALENDAR_HISTORY_ON_CALENDAR` FOREIGN KEY (`calendar_id`) REFERENCES `m_calendar` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_calendar_instance
-- ----------------------------
DROP TABLE IF EXISTS `m_calendar_instance`;
CREATE TABLE `m_calendar_instance` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `calendar_id` bigint(20) NOT NULL,
  `entity_id` bigint(20) NOT NULL,
  `entity_type_enum` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_M_CALENDAR_INSTANCE_ON_CALENDAR` (`calendar_id`),
  CONSTRAINT `FK_M_CALENDAR_INSTANCE_ON_CALENDAR` FOREIGN KEY (`calendar_id`) REFERENCES `m_calendar` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_client_collateral_management
-- ----------------------------
DROP TABLE IF EXISTS `m_client_collateral_management`;
CREATE TABLE `m_client_collateral_management` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `quantity` decimal(20,5) NOT NULL,
  `client_id` bigint(20) NOT NULL,
  `collateral_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_M_CLIENT_COLLATERAL_MANAGEMENT_ON_CLIENT` (`client_id`),
  CONSTRAINT `FK_M_CLIENT_COLLATERAL_MANAGEMENT_ON_CLIENT` FOREIGN KEY (`client_id`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_collateral_management
-- ----------------------------
DROP TABLE IF EXISTS `m_collateral_management`;
CREATE TABLE `m_collateral_management` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `quality` varchar(40) NOT NULL,
  `base_price` decimal(20,5) NOT NULL,
  `unit_type` varchar(10) NOT NULL,
  `pct_to_base` decimal(20,5) NOT NULL,
  `currency` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_M_COLLATERAL_MANAGEMENT_ON_CURRENCY` (`currency`),
  CONSTRAINT `FK_M_COLLATERAL_MANAGEMENT_ON_CURRENCY` FOREIGN KEY (`currency`) REFERENCES `org_currency` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_deposit_account_on_hold_transaction
-- ----------------------------
DROP TABLE IF EXISTS `m_deposit_account_on_hold_transaction`;
CREATE TABLE `m_deposit_account_on_hold_transaction` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `savings_account_id` bigint(20) DEFAULT NULL,
  `amount` decimal(19,6) NOT NULL,
  `transaction_type_enum` int(11) NOT NULL,
  `transaction_date` date NOT NULL,
  `is_reversed` bit(1) NOT NULL,
  `created_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_M_DEPOSIT_ACCOUNT_ON_HOLD_TRANSACTION_ON_SAVINGS_ACCOUNT` (`savings_account_id`),
  CONSTRAINT `FK_M_DEPOSIT_ACCOUNT_ON_HOLD_TRANSACTION_ON_SAVINGS_ACCOUNT` FOREIGN KEY (`savings_account_id`) REFERENCES `m_savings_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_floating_rates
-- ----------------------------
DROP TABLE IF EXISTS `m_floating_rates`;
CREATE TABLE `m_floating_rates` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_by` bigint(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` bigint(20) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(200) NOT NULL,
  `is_base_lending_rate` bit(1) NOT NULL,
  `is_active` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unq_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_floating_rates_periods
-- ----------------------------
DROP TABLE IF EXISTS `m_floating_rates_periods`;
CREATE TABLE `m_floating_rates_periods` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_by` bigint(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` bigint(20) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `floating_rates_id` bigint(20) NOT NULL,
  `from_date` date NOT NULL,
  `interest_rate` decimal(19,6) NOT NULL,
  `is_differential_to_base_lending_rate` bit(1) NOT NULL,
  `is_active` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_M_FLOATING_RATES_PERIODS_ON_FLOATING_RATES` (`floating_rates_id`),
  CONSTRAINT `FK_M_FLOATING_RATES_PERIODS_ON_FLOATING_RATES` FOREIGN KEY (`floating_rates_id`) REFERENCES `m_floating_rates` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_fund
-- ----------------------------
DROP TABLE IF EXISTS `m_fund`;
CREATE TABLE `m_fund` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fund_name_org` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_group
-- ----------------------------
DROP TABLE IF EXISTS `m_group`;
CREATE TABLE `m_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `external_id` varchar(100) DEFAULT NULL,
  `status_enum` int(11) NOT NULL,
  `activation_date` date DEFAULT NULL,
  `activatedon_userid` bigint(20) DEFAULT NULL,
  `office_id` bigint(20) NOT NULL,
  `staff_id` bigint(20) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `level_id` bigint(20) NOT NULL,
  `display_name` varchar(100) DEFAULT NULL,
  `hierarchy` varchar(100) DEFAULT NULL,
  `closure_reason_cv_id` bigint(20) DEFAULT NULL,
  `closedon_date` date DEFAULT NULL,
  `closedon_userid` bigint(20) DEFAULT NULL,
  `submittedon_date` date DEFAULT NULL,
  `submittedon_userid` bigint(20) DEFAULT NULL,
  `account_no` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_m_group_account_no` (`account_no`),
  UNIQUE KEY `uc_m_group_display_name` (`display_name`),
  UNIQUE KEY `uc_m_group_external` (`external_id`),
  KEY `FK_M_GROUP_ON_ACTIVATEDON_USERID` (`activatedon_userid`),
  KEY `FK_M_GROUP_ON_CLOSEDON_USERID` (`closedon_userid`),
  KEY `FK_M_GROUP_ON_CLOSURE_REASON_CV` (`closure_reason_cv_id`),
  KEY `FK_M_GROUP_ON_LEVEL` (`level_id`),
  KEY `FK_M_GROUP_ON_OFFICE` (`office_id`),
  KEY `FK_M_GROUP_ON_PARENT` (`parent_id`),
  KEY `FK_M_GROUP_ON_STAFF` (`staff_id`),
  KEY `FK_M_GROUP_ON_SUBMITTEDON_USERID` (`submittedon_userid`),
  CONSTRAINT `FK_M_GROUP_ON_ACTIVATEDON_USERID` FOREIGN KEY (`activatedon_userid`) REFERENCES `org_user` (`id`),
  CONSTRAINT `FK_M_GROUP_ON_CLOSEDON_USERID` FOREIGN KEY (`closedon_userid`) REFERENCES `org_user` (`id`),
  CONSTRAINT `FK_M_GROUP_ON_CLOSURE_REASON_CV` FOREIGN KEY (`closure_reason_cv_id`) REFERENCES `sys_code_value` (`id`),
  CONSTRAINT `FK_M_GROUP_ON_LEVEL` FOREIGN KEY (`level_id`) REFERENCES `m_group_level` (`id`),
  CONSTRAINT `FK_M_GROUP_ON_OFFICE` FOREIGN KEY (`office_id`) REFERENCES `org_office` (`id`),
  CONSTRAINT `FK_M_GROUP_ON_PARENT` FOREIGN KEY (`parent_id`) REFERENCES `m_group` (`id`),
  CONSTRAINT `FK_M_GROUP_ON_STAFF` FOREIGN KEY (`staff_id`) REFERENCES `org_staff` (`id`),
  CONSTRAINT `FK_M_GROUP_ON_SUBMITTEDON_USERID` FOREIGN KEY (`submittedon_userid`) REFERENCES `org_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_group_client
-- ----------------------------
DROP TABLE IF EXISTS `m_group_client`;
CREATE TABLE `m_group_client` (
  `client_id` bigint(20) NOT NULL,
  `group_id` bigint(20) NOT NULL,
  PRIMARY KEY (`client_id`,`group_id`),
  KEY `fk_mgrocli_on_group` (`group_id`),
  CONSTRAINT `fk_mgrocli_on_customer` FOREIGN KEY (`client_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `fk_mgrocli_on_group` FOREIGN KEY (`group_id`) REFERENCES `m_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_group_level
-- ----------------------------
DROP TABLE IF EXISTS `m_group_level`;
CREATE TABLE `m_group_level` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL,
  `super_parent` bit(1) NOT NULL,
  `level_name` varchar(100) NOT NULL,
  `recursable` bit(1) NOT NULL,
  `can_have_clients` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_m_group_level_level_name` (`level_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_group_roles
-- ----------------------------
DROP TABLE IF EXISTS `m_group_roles`;
CREATE TABLE `m_group_roles` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` bigint(20) DEFAULT NULL,
  `client_id` bigint(20) DEFAULT NULL,
  `role_cv_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_M_GROUP_ROLES_ON_CLIENT` (`client_id`),
  KEY `FK_M_GROUP_ROLES_ON_GROUP` (`group_id`),
  KEY `FK_M_GROUP_ROLES_ON_ROLE_CV` (`role_cv_id`),
  CONSTRAINT `FK_M_GROUP_ROLES_ON_CLIENT` FOREIGN KEY (`client_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `FK_M_GROUP_ROLES_ON_GROUP` FOREIGN KEY (`group_id`) REFERENCES `m_group` (`id`),
  CONSTRAINT `FK_M_GROUP_ROLES_ON_ROLE_CV` FOREIGN KEY (`role_cv_id`) REFERENCES `sys_code_value` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_guarantor
-- ----------------------------
DROP TABLE IF EXISTS `m_guarantor`;
CREATE TABLE `m_guarantor` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `client_reln_cv_id` bigint(20) NOT NULL,
  `guarantor_type` varchar(32) NOT NULL,
  `entity_id` bigint(20) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `address_line_1` varchar(500) DEFAULT NULL,
  `address_line_2` varchar(500) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `zip` varchar(20) DEFAULT NULL,
  `house_phone_number` varchar(20) DEFAULT NULL,
  `mobile_number` varchar(20) DEFAULT NULL,
  `comment` varchar(500) DEFAULT NULL,
  `is_active` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_M_GUARANTOR_ON_CLIENT_RELN_CV` (`client_reln_cv_id`),
  KEY `FK_M_GUARANTOR_ON_LOAN` (`loan_id`),
  CONSTRAINT `FK_M_GUARANTOR_ON_CLIENT_RELN_CV` FOREIGN KEY (`client_reln_cv_id`) REFERENCES `sys_code_value` (`id`),
  CONSTRAINT `FK_M_GUARANTOR_ON_LOAN` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_guarantor_funding_details
-- ----------------------------
DROP TABLE IF EXISTS `m_guarantor_funding_details`;
CREATE TABLE `m_guarantor_funding_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `guarantor_id` bigint(20) NOT NULL,
  `account_associations_id` bigint(20) NOT NULL,
  `status_enum` int(11) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `amount_released_derived` decimal(19,6) DEFAULT NULL,
  `amount_remaining_derived` decimal(19,6) DEFAULT NULL,
  `amount_transferred_derived` decimal(19,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_M_GUARANTOR_FUNDING_DETAILS_ON_ACCOUNT_ASSOCIATIONS` (`account_associations_id`),
  KEY `FK_M_GUARANTOR_FUNDING_DETAILS_ON_GUARANTOR` (`guarantor_id`),
  CONSTRAINT `FK_M_GUARANTOR_FUNDING_DETAILS_ON_ACCOUNT_ASSOCIATIONS` FOREIGN KEY (`account_associations_id`) REFERENCES `m_portfolio_account_associations` (`id`),
  CONSTRAINT `FK_M_GUARANTOR_FUNDING_DETAILS_ON_GUARANTOR` FOREIGN KEY (`guarantor_id`) REFERENCES `m_guarantor` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_guarantor_transaction
-- ----------------------------
DROP TABLE IF EXISTS `m_guarantor_transaction`;
CREATE TABLE `m_guarantor_transaction` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `guarantor_fund_detail_id` bigint(20) NOT NULL,
  `loan_transaction_id` bigint(20) DEFAULT NULL,
  `deposit_on_hold_transaction_id` bigint(20) NOT NULL,
  `is_reversed` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_m_guarantor_transaction_deposit_on_hold_transaction` (`deposit_on_hold_transaction_id`),
  KEY `FK_M_GUARANTOR_TRANSACTION_ON_GUARANTOR_FUND_DETAIL` (`guarantor_fund_detail_id`),
  KEY `FK_M_GUARANTOR_TRANSACTION_ON_LOAN_TRANSACTION` (`loan_transaction_id`),
  CONSTRAINT `FK_M_GUARANTOR_TRANSACTION_ON_DEPOSIT_ON_HOLD_TRANSACTION` FOREIGN KEY (`deposit_on_hold_transaction_id`) REFERENCES `m_deposit_account_on_hold_transaction` (`id`),
  CONSTRAINT `FK_M_GUARANTOR_TRANSACTION_ON_GUARANTOR_FUND_DETAIL` FOREIGN KEY (`guarantor_fund_detail_id`) REFERENCES `m_guarantor_funding_details` (`id`),
  CONSTRAINT `FK_M_GUARANTOR_TRANSACTION_ON_LOAN_TRANSACTION` FOREIGN KEY (`loan_transaction_id`) REFERENCES `m_loan_transaction` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_holiday
-- ----------------------------
DROP TABLE IF EXISTS `m_holiday`;
CREATE TABLE `m_holiday` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  `repayments_rescheduled_to` date DEFAULT NULL,
  `rescheduling_type` int(11) NOT NULL,
  `status_enum` int(11) NOT NULL,
  `processed` bit(1) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `holiday_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_holiday_office
-- ----------------------------
DROP TABLE IF EXISTS `m_holiday_office`;
CREATE TABLE `m_holiday_office` (
  `holiday_id` bigint(20) NOT NULL,
  `office_id` bigint(20) NOT NULL,
  PRIMARY KEY (`holiday_id`,`office_id`),
  KEY `fk_mholoff_on_office_entity` (`office_id`),
  CONSTRAINT `fk_mholoff_on_holiday_entity` FOREIGN KEY (`holiday_id`) REFERENCES `m_holiday` (`id`),
  CONSTRAINT `fk_mholoff_on_office_entity` FOREIGN KEY (`office_id`) REFERENCES `org_office` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_interest_incentives
-- ----------------------------
DROP TABLE IF EXISTS `m_interest_incentives`;
CREATE TABLE `m_interest_incentives` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `interest_rate_slab_id` bigint(20) NOT NULL,
  `entiry_type` int(11) NOT NULL,
  `attribute_name` int(11) NOT NULL,
  `condition_type` int(11) NOT NULL,
  `attribute_value` varchar(255) NOT NULL,
  `incentive_type` int(11) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_M_INTEREST_INCENTIVES_ON_INTEREST_RATE_SLAB` (`interest_rate_slab_id`),
  CONSTRAINT `FK_M_INTEREST_INCENTIVES_ON_INTEREST_RATE_SLAB` FOREIGN KEY (`interest_rate_slab_id`) REFERENCES `m_interest_rate_slab` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_interest_rate_chart
-- ----------------------------
DROP TABLE IF EXISTS `m_interest_rate_chart`;
CREATE TABLE `m_interest_rate_chart` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `from_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `is_primary_grouping_by_amount` bit(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_interest_rate_slab
-- ----------------------------
DROP TABLE IF EXISTS `m_interest_rate_slab`;
CREATE TABLE `m_interest_rate_slab` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `interest_rate_chart_id` bigint(20) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `period_type_enum` int(11) DEFAULT NULL,
  `from_period` int(11) DEFAULT NULL,
  `to_period` int(11) DEFAULT NULL,
  `amount_range_from` decimal(19,6) DEFAULT NULL,
  `amount_range_to` decimal(19,6) DEFAULT NULL,
  `annual_interest_rate` decimal(19,6) NOT NULL,
  `currency_code` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_M_INTEREST_RATE_SLAB_ON_INTEREST_RATE_CHART` (`interest_rate_chart_id`),
  CONSTRAINT `FK_M_INTEREST_RATE_SLAB_ON_INTEREST_RATE_CHART` FOREIGN KEY (`interest_rate_chart_id`) REFERENCES `m_interest_rate_chart` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_loan
-- ----------------------------
DROP TABLE IF EXISTS `m_loan`;
CREATE TABLE `m_loan` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` int(11) DEFAULT NULL,
  `account_no` varchar(20) NOT NULL,
  `external_id` varchar(255) DEFAULT NULL,
  `client_id` bigint(20) DEFAULT NULL,
  `loan_type` varchar(255) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `fund_id` bigint(20) DEFAULT NULL,
  `loan_officer_id` bigint(20) DEFAULT NULL,
  `loanpurpose_cv_id` bigint(20) DEFAULT NULL,
  `loan_transaction_strategy` varchar(255) DEFAULT NULL,
  `term_frequency` int(11) NOT NULL,
  `term_period_frequency` varchar(255) NOT NULL,
  `loan_status` varchar(255) NOT NULL,
  `sync_disbursement_with_meeting` bit(1) DEFAULT NULL,
  `submittedon_date` date DEFAULT NULL,
  `rejectedon_date` date DEFAULT NULL,
  `rejectedon_userid` bigint(20) DEFAULT NULL,
  `withdrawnon_date` date DEFAULT NULL,
  `withdrawnon_userid` bigint(20) DEFAULT NULL,
  `approvedon_date` date DEFAULT NULL,
  `approvedon_userid` bigint(20) DEFAULT NULL,
  `expected_disbursedon_date` date DEFAULT NULL,
  `disbursedon_date` date DEFAULT NULL,
  `disbursedon_userid` bigint(20) DEFAULT NULL,
  `closedon_date` date DEFAULT NULL,
  `closedon_userid` bigint(20) DEFAULT NULL,
  `writtenoffon_date` date DEFAULT NULL,
  `rescheduledon_date` date DEFAULT NULL,
  `rescheduledon_userid` bigint(20) DEFAULT NULL,
  `expected_maturedon_date` date DEFAULT NULL,
  `maturedon_date` date DEFAULT NULL,
  `expected_firstrepaymenton_date` date DEFAULT NULL,
  `interest_calculated_from_date` date DEFAULT NULL,
  `total_overpaid_derived` decimal(16,6) DEFAULT NULL,
  `loan_counter` int(11) DEFAULT NULL,
  `loan_product_counter` int(11) DEFAULT NULL,
  `principal_amount_proposed` decimal(16,6) NOT NULL,
  `approved_principal` decimal(16,6) NOT NULL,
  `net_disbursal_amount` decimal(16,6) NOT NULL,
  `fixed_emi_amount` decimal(16,6) DEFAULT NULL,
  `max_outstanding_loan_balance` decimal(16,6) DEFAULT NULL,
  `total_recovered_derived` decimal(16,6) DEFAULT NULL,
  `is_npa` bit(1) NOT NULL,
  `accrued_till` date DEFAULT NULL,
  `create_standing_instruction_at_disbursement` bit(1) DEFAULT NULL,
  `guarantee_amount_derived` decimal(16,6) DEFAULT NULL,
  `interest_recalcualated_on` date DEFAULT NULL,
  `is_floating_interest_rate` bit(1) DEFAULT NULL,
  `interest_rate_differential` decimal(16,6) DEFAULT NULL,
  `writeoff_reason_cv_id` bigint(20) DEFAULT NULL,
  `loan_sub_status` varchar(255) DEFAULT NULL,
  `is_topup` bit(1) NOT NULL,
  `fixed_principal_percentage_per_installment` decimal(5,2) DEFAULT NULL,
  `currency_code` varchar(8) NOT NULL,
  `currency_digits` int(11) NOT NULL,
  `currency_multiples_of` int(11) DEFAULT NULL,
  `principal_amount` decimal(16,6) DEFAULT NULL,
  `nominal_interest_rate_per_period` decimal(16,6) DEFAULT NULL,
  `interest_period_frequency` varchar(255) DEFAULT NULL,
  `annual_nominal_interest_rate` decimal(16,6) DEFAULT NULL,
  `interest_method` varchar(255) NOT NULL,
  `interest_calculated_in_period` varchar(255) NOT NULL,
  `allow_partial_period_interest_calculation` bit(1) NOT NULL,
  `repay_every` int(11) NOT NULL,
  `repayment_period_frequency` varchar(255) NOT NULL,
  `number_of_repayments` int(11) NOT NULL,
  `grace_on_principal_periods` int(11) DEFAULT NULL,
  `recurring_moratorium_principal_periods` int(11) DEFAULT NULL,
  `grace_on_interest_periods` int(11) DEFAULT NULL,
  `grace_interest_free_periods` int(11) DEFAULT NULL,
  `amortization_method` varchar(255) NOT NULL,
  `in_arrears_tolerance_amount` decimal(16,6) DEFAULT NULL,
  `grace_on_arrears_ageing` int(11) DEFAULT NULL,
  `days_in_month` varchar(255) NOT NULL,
  `days_in_year` varchar(255) NOT NULL,
  `interest_recalculation_enabled` bit(1) DEFAULT NULL,
  `is_equal_amortization` bit(1) NOT NULL,
  `principal_disbursed_derived` decimal(16,6) DEFAULT NULL,
  `principal_repaid_derived` decimal(16,6) DEFAULT NULL,
  `principal_writtenoff_derived` decimal(16,6) DEFAULT NULL,
  `principal_outstanding_derived` decimal(16,6) DEFAULT NULL,
  `interest_charged_derived` decimal(16,6) DEFAULT NULL,
  `interest_repaid_derived` decimal(16,6) DEFAULT NULL,
  `interest_waived_derived` decimal(16,6) DEFAULT NULL,
  `interest_writtenoff_derived` decimal(16,6) DEFAULT NULL,
  `interest_outstanding_derived` decimal(16,6) DEFAULT NULL,
  `fee_charges_charged_derived` decimal(16,6) DEFAULT NULL,
  `total_charges_due_at_disbursement_derived` decimal(16,6) DEFAULT NULL,
  `fee_charges_repaid_derived` decimal(16,6) DEFAULT NULL,
  `fee_charges_waived_derived` decimal(16,6) DEFAULT NULL,
  `fee_charges_writtenoff_derived` decimal(16,6) DEFAULT NULL,
  `fee_charges_outstanding_derived` decimal(16,6) DEFAULT NULL,
  `penalty_charges_charged_derived` decimal(16,6) DEFAULT NULL,
  `penalty_charges_repaid_derived` decimal(16,6) DEFAULT NULL,
  `penalty_charges_waived_derived` decimal(16,6) DEFAULT NULL,
  `penalty_charges_writtenoff_derived` decimal(16,6) DEFAULT NULL,
  `penalty_charges_outstanding_derived` decimal(16,6) DEFAULT NULL,
  `total_expected_repayment_derived` decimal(16,6) DEFAULT NULL,
  `total_repayment_derived` decimal(16,6) DEFAULT NULL,
  `total_expected_costofloan_derived` decimal(16,6) DEFAULT NULL,
  `total_costofloan_derived` decimal(16,6) DEFAULT NULL,
  `total_waived_derived` decimal(16,6) DEFAULT NULL,
  `total_writtenoff_derived` decimal(16,6) DEFAULT NULL,
  `total_outstanding_derived` decimal(16,6) DEFAULT NULL,
  `created_by` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` bigint(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `loan_account_no_UNIQUE` (`account_no`),
  UNIQUE KEY `loan_external_id_UNIQUE` (`external_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_loan_arrears_aging
-- ----------------------------
DROP TABLE IF EXISTS `m_loan_arrears_aging`;
CREATE TABLE `m_loan_arrears_aging` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `principal_overdue_derived` decimal(16,6) NOT NULL,
  `interest_overdue_derived` decimal(16,6) NOT NULL,
  `fee_charges_overdue_derived` decimal(16,6) NOT NULL,
  `penalty_charges_overdue_derived` decimal(16,6) NOT NULL,
  `total_overdue_derived` decimal(16,6) NOT NULL,
  `overdue_since_date_derived` date NOT NULL,
  `created_by` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` bigint(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `m_loan_arrears_aging_ibfk` (`loan_id`),
  CONSTRAINT `m_loan_arrears_aging_ibfk` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_loan_charge
-- ----------------------------
DROP TABLE IF EXISTS `m_loan_charge`;
CREATE TABLE `m_loan_charge` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `charge_id` bigint(20) NOT NULL,
  `charge_time_type` varchar(255) NOT NULL,
  `due_for_collection_as_of_date` date DEFAULT NULL,
  `charge_calculation_type` varchar(255) DEFAULT NULL,
  `charge_payment_mode` varchar(255) DEFAULT NULL,
  `calculation_percentage` decimal(16,6) DEFAULT NULL,
  `calculation_on_amount` decimal(16,6) DEFAULT NULL,
  `charge_amount_or_percentage` decimal(16,6) NOT NULL,
  `amount` decimal(16,6) NOT NULL,
  `amount_paid_derived` decimal(16,6) DEFAULT NULL,
  `amount_waived_derived` decimal(16,6) DEFAULT NULL,
  `amount_writtenoff_derived` decimal(16,6) DEFAULT NULL,
  `amount_outstanding_derived` decimal(16,6) NOT NULL,
  `is_penalty` bit(1) NOT NULL,
  `is_paid_derived` bit(1) NOT NULL,
  `waived` bit(1) NOT NULL,
  `min_cap` decimal(16,6) DEFAULT NULL,
  `max_cap` decimal(16,6) DEFAULT NULL,
  `is_active` bit(1) NOT NULL,
  `external_id` varchar(255) DEFAULT NULL,
  `created_by` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` bigint(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `external_id` (`external_id`),
  KEY `FK_M_LOAN_CHARGE_ON_CHARGE` (`charge_id`),
  KEY `FK_M_LOAN_CHARGE_ON_LOAN` (`loan_id`),
  CONSTRAINT `FK_M_LOAN_CHARGE_ON_CHARGE` FOREIGN KEY (`charge_id`) REFERENCES `m_product_charge` (`id`),
  CONSTRAINT `FK_M_LOAN_CHARGE_ON_LOAN` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_loan_charge_paid_by
-- ----------------------------
DROP TABLE IF EXISTS `m_loan_charge_paid_by`;
CREATE TABLE `m_loan_charge_paid_by` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_transaction_id` bigint(20) NOT NULL,
  `loan_charge_id` bigint(20) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `installment_number` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_M_LOAN_CHARGE_PAID_BY_ON_LOAN_CHARGE` (`loan_charge_id`),
  KEY `FK_M_LOAN_CHARGE_PAID_BY_ON_LOAN_TRANSACTION` (`loan_transaction_id`),
  CONSTRAINT `FK_M_LOAN_CHARGE_PAID_BY_ON_LOAN_CHARGE` FOREIGN KEY (`loan_charge_id`) REFERENCES `m_loan_charge` (`id`),
  CONSTRAINT `FK_M_LOAN_CHARGE_PAID_BY_ON_LOAN_TRANSACTION` FOREIGN KEY (`loan_transaction_id`) REFERENCES `m_loan_transaction` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_loan_collateral_management
-- ----------------------------
DROP TABLE IF EXISTS `m_loan_collateral_management`;
CREATE TABLE `m_loan_collateral_management` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `quantity` decimal(20,5) NOT NULL,
  `transaction_id` bigint(20) DEFAULT NULL,
  `loan_id` bigint(20) NOT NULL,
  `is_released` bit(1) NOT NULL,
  `client_collateral_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_M_LOAN_COLLATERAL_MANAGEMENT_ON_CLIENT_COLLATERAL` (`client_collateral_id`),
  KEY `FK_M_LOAN_COLLATERAL_MANAGEMENT_ON_LOAN` (`loan_id`),
  KEY `FK_M_LOAN_COLLATERAL_MANAGEMENT_ON_TRANSACTION` (`transaction_id`),
  CONSTRAINT `FK_M_LOAN_COLLATERAL_MANAGEMENT_ON_CLIENT_COLLATERAL` FOREIGN KEY (`client_collateral_id`) REFERENCES `m_client_collateral_management` (`id`),
  CONSTRAINT `FK_M_LOAN_COLLATERAL_MANAGEMENT_ON_LOAN` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `FK_M_LOAN_COLLATERAL_MANAGEMENT_ON_TRANSACTION` FOREIGN KEY (`transaction_id`) REFERENCES `m_loan_transaction` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_loan_disbursement_detail
-- ----------------------------
DROP TABLE IF EXISTS `m_loan_disbursement_detail`;
CREATE TABLE `m_loan_disbursement_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `expected_disburse_date` date DEFAULT NULL,
  `disbursedon_date` date DEFAULT NULL,
  `principal` decimal(19,6) NOT NULL,
  `net_disbursal_amount` decimal(19,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_M_LOAN_DISBURSEMENT_DETAIL_ON_LOAN` (`loan_id`),
  CONSTRAINT `FK_M_LOAN_DISBURSEMENT_DETAIL_ON_LOAN` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_loan_installment_charge
-- ----------------------------
DROP TABLE IF EXISTS `m_loan_installment_charge`;
CREATE TABLE `m_loan_installment_charge` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_by` bigint(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` bigint(20) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `loan_charge_id` bigint(20) NOT NULL,
  `loan_schedule_id` bigint(20) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `amount_paid_derived` decimal(19,6) DEFAULT NULL,
  `amount_waived_derived` decimal(19,6) DEFAULT NULL,
  `amount_writtenoff_derived` decimal(19,6) DEFAULT NULL,
  `amount_outstanding_derived` decimal(19,6) NOT NULL,
  `amount_through_charge_payment` decimal(19,6) DEFAULT NULL,
  `is_paid_derived` bit(1) NOT NULL,
  `waived` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_M_LOAN_INSTALLMENT_CHARGE_ON_LOAN_CHARGE` (`loan_charge_id`),
  KEY `FK_M_LOAN_INSTALLMENT_CHARGE_ON_LOAN_SCHEDULE` (`loan_schedule_id`),
  CONSTRAINT `FK_M_LOAN_INSTALLMENT_CHARGE_ON_LOAN_CHARGE` FOREIGN KEY (`loan_charge_id`) REFERENCES `m_loan_charge` (`id`),
  CONSTRAINT `FK_M_LOAN_INSTALLMENT_CHARGE_ON_LOAN_SCHEDULE` FOREIGN KEY (`loan_schedule_id`) REFERENCES `m_loan_repayment_schedule` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_loan_interest_recalculation_additional_details
-- ----------------------------
DROP TABLE IF EXISTS `m_loan_interest_recalculation_additional_details`;
CREATE TABLE `m_loan_interest_recalculation_additional_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_repayment_schedule_id` bigint(20) NOT NULL,
  `effective_date` date DEFAULT NULL,
  `amount` decimal(19,6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_MLOANINTERESTRECALCULATIONADDITIONA_ON_LOANREPAYMENTSCHEDULE` (`loan_repayment_schedule_id`),
  CONSTRAINT `FK_MLOANINTERESTRECALCULATIONADDITIONA_ON_LOANREPAYMENTSCHEDULE` FOREIGN KEY (`loan_repayment_schedule_id`) REFERENCES `m_loan_repayment_schedule` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_loan_officer_assignment_history
-- ----------------------------
DROP TABLE IF EXISTS `m_loan_officer_assignment_history`;
CREATE TABLE `m_loan_officer_assignment_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `loan_officer_id` bigint(20) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_M_LOAN_OFFICER_ASSIGNMENT_HISTORY_ON_LOAN` (`loan_id`),
  KEY `FK_M_LOAN_OFFICER_ASSIGNMENT_HISTORY_ON_LOAN_OFFICER` (`loan_officer_id`),
  CONSTRAINT `FK_M_LOAN_OFFICER_ASSIGNMENT_HISTORY_ON_LOAN` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `FK_M_LOAN_OFFICER_ASSIGNMENT_HISTORY_ON_LOAN_OFFICER` FOREIGN KEY (`loan_officer_id`) REFERENCES `org_staff` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_loan_overdue_installment_charge
-- ----------------------------
DROP TABLE IF EXISTS `m_loan_overdue_installment_charge`;
CREATE TABLE `m_loan_overdue_installment_charge` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_charge_id` bigint(20) NOT NULL,
  `loan_schedule_id` bigint(20) NOT NULL,
  `frequency_number` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_m_loan_overdue_installment_charge_loan_charge` (`loan_charge_id`),
  KEY `FK_M_LOAN_OVERDUE_INSTALLMENT_CHARGE_ON_LOAN_SCHEDULE` (`loan_schedule_id`),
  CONSTRAINT `FK_M_LOAN_OVERDUE_INSTALLMENT_CHARGE_ON_LOAN_CHARGE` FOREIGN KEY (`loan_charge_id`) REFERENCES `m_loan_charge` (`id`),
  CONSTRAINT `FK_M_LOAN_OVERDUE_INSTALLMENT_CHARGE_ON_LOAN_SCHEDULE` FOREIGN KEY (`loan_schedule_id`) REFERENCES `m_loan_repayment_schedule` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_loan_product_payment_allocation_rule
-- ----------------------------
DROP TABLE IF EXISTS `m_loan_product_payment_allocation_rule`;
CREATE TABLE `m_loan_product_payment_allocation_rule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_product_id` bigint(20) DEFAULT NULL,
  `transaction_type` varchar(255) DEFAULT NULL,
  `allocation_types` text,
  `future_installment_allocation_rule` varchar(255) DEFAULT NULL,
  `created_by` bigint(20) DEFAULT NULL,
  `last_modified_by` bigint(20) DEFAULT NULL,
  `created_on` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_modified_on` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_loan_product_payment_allocation_rule` (`loan_product_id`,`transaction_type`) USING HASH,
  CONSTRAINT `lppar_loan_product_id` FOREIGN KEY (`loan_product_id`) REFERENCES `m_product_loan` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_loan_rate
-- ----------------------------
DROP TABLE IF EXISTS `m_loan_rate`;
CREATE TABLE `m_loan_rate` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `rate_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_m_loan_rate_rate` (`rate_id`),
  KEY `fk_mloarat_on_loan_entity` (`loan_id`),
  CONSTRAINT `fk_mloarat_on_loan_entity` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `fk_mloarat_on_rate_entity` FOREIGN KEY (`rate_id`) REFERENCES `m_rate` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_loan_recalculation_details
-- ----------------------------
DROP TABLE IF EXISTS `m_loan_recalculation_details`;
CREATE TABLE `m_loan_recalculation_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `compound_type` varchar(255) NOT NULL,
  `reschedule_strategy` varchar(255) NOT NULL,
  `rest_frequency_type` smallint(6) NOT NULL,
  `rest_frequency_interval` int(11) NOT NULL,
  `rest_frequency_nth_day_enum` int(11) DEFAULT NULL,
  `rest_frequency_weekday_enum` int(11) DEFAULT NULL,
  `rest_frequency_on_day` int(11) DEFAULT NULL,
  `compounding_frequency_type` varchar(255) DEFAULT NULL,
  `compounding_frequency_interval` int(11) DEFAULT NULL,
  `compounding_frequency_nth_day_enum` int(11) DEFAULT NULL,
  `compounding_frequency_weekday_enum` int(11) DEFAULT NULL,
  `compounding_frequency_on_day` int(11) DEFAULT NULL,
  `is_compounding_to_be_posted_as_transaction` bit(1) DEFAULT NULL,
  `allow_compounding_on_eod` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_m_loan_recalculation_details_loan` (`loan_id`),
  CONSTRAINT `FK_M_LOAN_RECALCULATION_DETAILS_ON_LOAN` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_loan_repayment_schedule
-- ----------------------------
DROP TABLE IF EXISTS `m_loan_repayment_schedule`;
CREATE TABLE `m_loan_repayment_schedule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `installment` int(11) NOT NULL,
  `fromdate` date DEFAULT NULL,
  `duedate` date NOT NULL,
  `principal_amount` decimal(16,6) DEFAULT NULL,
  `principal_completed_derived` decimal(16,6) DEFAULT NULL,
  `principal_writtenoff_derived` decimal(16,6) DEFAULT NULL,
  `interest_amount` decimal(16,6) DEFAULT NULL,
  `interest_completed_derived` decimal(16,6) DEFAULT NULL,
  `interest_waived_derived` decimal(16,6) DEFAULT NULL,
  `interest_writtenoff_derived` decimal(16,6) DEFAULT NULL,
  `accrual_interest_derived` decimal(16,6) DEFAULT NULL,
  `reschedule_interest_portion` decimal(16,6) DEFAULT NULL,
  `fee_charges_amount` decimal(16,6) DEFAULT NULL,
  `fee_charges_completed_derived` decimal(16,6) DEFAULT NULL,
  `fee_charges_writtenoff_derived` decimal(16,6) DEFAULT NULL,
  `fee_charges_waived_derived` decimal(16,6) DEFAULT NULL,
  `accrual_fee_charges_derived` decimal(16,6) DEFAULT NULL,
  `penalty_charges_amount` decimal(16,6) DEFAULT NULL,
  `penalty_charges_completed_derived` decimal(16,6) DEFAULT NULL,
  `penalty_charges_writtenoff_derived` decimal(16,6) DEFAULT NULL,
  `penalty_charges_waived_derived` decimal(16,6) DEFAULT NULL,
  `accrual_penalty_charges_derived` decimal(16,6) DEFAULT NULL,
  `total_paid_in_advance_derived` decimal(16,6) DEFAULT NULL,
  `total_paid_late_derived` decimal(16,6) DEFAULT NULL,
  `completed_derived` bit(1) NOT NULL,
  `obligations_met_on_date` date DEFAULT NULL,
  `recalculated_interest_component` bit(1) NOT NULL,
  `created_by` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` bigint(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_M_LOAN_REPAYMENT_SCHEDULE_ON_LOAN` (`loan_id`),
  CONSTRAINT `FK_M_LOAN_REPAYMENT_SCHEDULE_ON_LOAN` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=551 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_loan_repayment_schedule_history
-- ----------------------------
DROP TABLE IF EXISTS `m_loan_repayment_schedule_history`;
CREATE TABLE `m_loan_repayment_schedule_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_by_db_field` datetime(6) DEFAULT NULL,
  `created_at_db_field` bigint(20) DEFAULT NULL,
  `duedate` date NOT NULL,
  `fee_charges_amount` decimal(19,6) DEFAULT NULL,
  `fromdate` date DEFAULT NULL,
  `installment` int(11) NOT NULL,
  `interest_amount` decimal(19,6) DEFAULT NULL,
  `penalty_charges_amount` decimal(19,6) DEFAULT NULL,
  `principal_amount` decimal(19,6) DEFAULT NULL,
  `updated_at_db_field` datetime(6) DEFAULT NULL,
  `updated_by_db_field` bigint(20) DEFAULT NULL,
  `loan_id` bigint(20) NOT NULL,
  `loan_reschedule_request_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_hk6qh1xpy23qowgudjnu4esne` (`loan_reschedule_request_id`),
  KEY `FK353lqs2lbevrf25wyu4nfuxe2` (`loan_id`),
  CONSTRAINT `FK353lqs2lbevrf25wyu4nfuxe2` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `FKd9qhyfb71kd1iqq1srm347b8h` FOREIGN KEY (`loan_reschedule_request_id`) REFERENCES `m_loan_reschedule_request_term_variations_mapping` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_loan_reschedule_request_term_variations_mapping
-- ----------------------------
DROP TABLE IF EXISTS `m_loan_reschedule_request_term_variations_mapping`;
CREATE TABLE `m_loan_reschedule_request_term_variations_mapping` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `status_enum` int(11) NOT NULL,
  `reschedule_from_installment` int(11) DEFAULT NULL,
  `reschedule_from_date` date DEFAULT NULL,
  `recalculate_interest` bit(1) DEFAULT NULL,
  `reschedule_reason_cv_id` bigint(20) DEFAULT NULL,
  `reschedule_reason_comment` varchar(255) DEFAULT NULL,
  `submitted_on_date` date DEFAULT NULL,
  `submitted_by_user_id` bigint(20) DEFAULT NULL,
  `approved_on_date` date DEFAULT NULL,
  `approved_by_user_id` bigint(20) DEFAULT NULL,
  `rejected_on_date` date DEFAULT NULL,
  `rejected_by_user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_MLOANRESCHEDULEREQUESTTERMVARIATIONSMAPPIN_ON_APPROVEDBYUSER` (`approved_by_user_id`),
  KEY `FK_MLOANRESCHEDULEREQUESTTERMVARIATIONSMAPPIN_ON_REJECTEDBYUSER` (`rejected_by_user_id`),
  KEY `FK_MLOANRESCHEDULEREQUESTTERMVARIATIONSMAPPI_ON_SUBMITTEDBYUSER` (`submitted_by_user_id`),
  KEY `FK_MLOANRESCHEDULEREQUESTTERMVARIATIONSMA_ON_RESCHEDULEREASONCV` (`reschedule_reason_cv_id`),
  KEY `FK_M_LOAN_RESCHEDULE_REQUEST_TERM_VARIATIONS_MAPPING_ON_LOAN` (`loan_id`),
  CONSTRAINT `FK_MLOANRESCHEDULEREQUESTTERMVARIATIONSMAPPIN_ON_APPROVEDBYUSER` FOREIGN KEY (`approved_by_user_id`) REFERENCES `org_user` (`id`),
  CONSTRAINT `FK_MLOANRESCHEDULEREQUESTTERMVARIATIONSMAPPIN_ON_REJECTEDBYUSER` FOREIGN KEY (`rejected_by_user_id`) REFERENCES `org_user` (`id`),
  CONSTRAINT `FK_MLOANRESCHEDULEREQUESTTERMVARIATIONSMAPPI_ON_SUBMITTEDBYUSER` FOREIGN KEY (`submitted_by_user_id`) REFERENCES `org_user` (`id`),
  CONSTRAINT `FK_MLOANRESCHEDULEREQUESTTERMVARIATIONSMA_ON_RESCHEDULEREASONCV` FOREIGN KEY (`reschedule_reason_cv_id`) REFERENCES `sys_code_value` (`id`),
  CONSTRAINT `FK_M_LOAN_RESCHEDULE_REQUEST_TERM_VARIATIONS_MAPPING_ON_LOAN` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_loan_term_variations
-- ----------------------------
DROP TABLE IF EXISTS `m_loan_term_variations`;
CREATE TABLE `m_loan_term_variations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `term_type` varchar(255) NOT NULL,
  `applicable_date` date NOT NULL,
  `decimal_value` decimal(19,6) DEFAULT NULL,
  `date_value` date DEFAULT NULL,
  `is_specific_to_installment` bit(1) NOT NULL,
  `applied_on_loan_status` int(11) NOT NULL,
  `is_active` bit(1) NOT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_m_loan_term_variations_parent` (`parent_id`),
  KEY `FK_M_LOAN_TERM_VARIATIONS_ON_LOAN` (`loan_id`),
  CONSTRAINT `FK_M_LOAN_TERM_VARIATIONS_ON_LOAN` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `FK_M_LOAN_TERM_VARIATIONS_ON_PARENT` FOREIGN KEY (`parent_id`) REFERENCES `m_loan_term_variations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_loan_topup
-- ----------------------------
DROP TABLE IF EXISTS `m_loan_topup`;
CREATE TABLE `m_loan_topup` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `closure_loan_id` bigint(20) NOT NULL,
  `account_transfer_details_id` bigint(20) DEFAULT NULL,
  `topup_amount` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_m_loan_topup_loan` (`loan_id`),
  CONSTRAINT `FK_M_LOAN_TOPUP_ON_LOAN` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_loan_tranche_charges
-- ----------------------------
DROP TABLE IF EXISTS `m_loan_tranche_charges`;
CREATE TABLE `m_loan_tranche_charges` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `charge_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_M_LOAN_TRANCHE_CHARGES_ON_CHARGE` (`charge_id`),
  KEY `FK_M_LOAN_TRANCHE_CHARGES_ON_LOAN` (`loan_id`),
  CONSTRAINT `FK_M_LOAN_TRANCHE_CHARGES_ON_CHARGE` FOREIGN KEY (`charge_id`) REFERENCES `m_product_charge` (`id`),
  CONSTRAINT `FK_M_LOAN_TRANCHE_CHARGES_ON_LOAN` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_loan_tranche_disbursement_charge
-- ----------------------------
DROP TABLE IF EXISTS `m_loan_tranche_disbursement_charge`;
CREATE TABLE `m_loan_tranche_disbursement_charge` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_charge_id` bigint(20) NOT NULL,
  `disbursement_detail_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_M_LOAN_TRANCHE_DISBURSEMENT_CHARGE_ON_DISBURSEMENT_DETAIL` (`disbursement_detail_id`),
  KEY `FK_M_LOAN_TRANCHE_DISBURSEMENT_CHARGE_ON_LOAN_CHARGE` (`loan_charge_id`),
  CONSTRAINT `FK_M_LOAN_TRANCHE_DISBURSEMENT_CHARGE_ON_DISBURSEMENT_DETAIL` FOREIGN KEY (`disbursement_detail_id`) REFERENCES `m_loan_disbursement_detail` (`id`),
  CONSTRAINT `FK_M_LOAN_TRANCHE_DISBURSEMENT_CHARGE_ON_LOAN_CHARGE` FOREIGN KEY (`loan_charge_id`) REFERENCES `m_loan_charge` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_loan_transaction
-- ----------------------------
DROP TABLE IF EXISTS `m_loan_transaction`;
CREATE TABLE `m_loan_transaction` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `office_id` bigint(20) NOT NULL,
  `payment_detail_id` bigint(20) DEFAULT NULL,
  `transaction_type` varchar(255) NOT NULL,
  `transaction_date` date NOT NULL,
  `submitted_on_date` date NOT NULL,
  `amount` decimal(16,6) NOT NULL,
  `principal_portion_derived` decimal(16,6) DEFAULT NULL,
  `interest_portion_derived` decimal(16,6) DEFAULT NULL,
  `fee_charges_portion_derived` decimal(16,6) DEFAULT NULL,
  `penalty_charges_portion_derived` decimal(16,6) DEFAULT NULL,
  `overpayment_portion_derived` decimal(16,6) DEFAULT NULL,
  `unrecognized_income_portion` decimal(16,6) DEFAULT NULL,
  `is_reversed` bit(1) NOT NULL,
  `external_id` varchar(100) DEFAULT NULL,
  `outstanding_loan_balance_derived` decimal(16,6) DEFAULT NULL,
  `manually_adjusted_or_reversed` bit(1) NOT NULL DEFAULT b'0',
  `created_by` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` bigint(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `external_id_UNIQUE` (`external_id`),
  KEY `FK_M_LOAN_TRANSACTION_ON_LOAN` (`loan_id`),
  KEY `FK_M_LOAN_TRANSACTION_ON_OFFICE` (`office_id`),
  KEY `FK_M_LOAN_TRANSACTION_ON_PAYMENT_DETAIL` (`payment_detail_id`),
  CONSTRAINT `FK_M_LOAN_TRANSACTION_ON_LOAN` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `FK_M_LOAN_TRANSACTION_ON_OFFICE` FOREIGN KEY (`office_id`) REFERENCES `org_office` (`id`),
  CONSTRAINT `FK_M_LOAN_TRANSACTION_ON_PAYMENT_DETAIL` FOREIGN KEY (`payment_detail_id`) REFERENCES `m_payment_detail` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_loan_transaction_repayment_schedule_mapping
-- ----------------------------
DROP TABLE IF EXISTS `m_loan_transaction_repayment_schedule_mapping`;
CREATE TABLE `m_loan_transaction_repayment_schedule_mapping` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_transaction_id` bigint(20) NOT NULL,
  `loan_repayment_schedule_id` bigint(20) NOT NULL,
  `principal_portion_derived` decimal(19,6) DEFAULT NULL,
  `interest_portion_derived` decimal(19,6) DEFAULT NULL,
  `fee_charges_portion_derived` decimal(19,6) DEFAULT NULL,
  `penalty_charges_portion_derived` decimal(19,6) DEFAULT NULL,
  `amount` decimal(19,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_MLOANTRANSACTIONREPAYMENTSCHEDULEMAPPING_ON_LOANTRANSACTION` (`loan_transaction_id`),
  KEY `FK_MLOANTRANSACTIONREPAYMENTSCHEDULEMA_ON_LOANREPAYMENTSCHEDULE` (`loan_repayment_schedule_id`),
  CONSTRAINT `FK_MLOANTRANSACTIONREPAYMENTSCHEDULEMAPPING_ON_LOANTRANSACTION` FOREIGN KEY (`loan_transaction_id`) REFERENCES `m_loan_transaction` (`id`),
  CONSTRAINT `FK_MLOANTRANSACTIONREPAYMENTSCHEDULEMA_ON_LOANREPAYMENTSCHEDULE` FOREIGN KEY (`loan_repayment_schedule_id`) REFERENCES `m_loan_repayment_schedule` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_note
-- ----------------------------
DROP TABLE IF EXISTS `m_note`;
CREATE TABLE `m_note` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_by` bigint(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` bigint(20) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `client_id` bigint(20) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `loan_id` bigint(20) DEFAULT NULL,
  `loan_transaction_id` bigint(20) DEFAULT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `note_type_enum` varchar(64) DEFAULT NULL,
  `savings_account_id` bigint(20) DEFAULT NULL,
  `savings_account_transaction_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_M_NOTE_ON_CLIENT` (`client_id`),
  KEY `FK_M_NOTE_ON_GROUP` (`group_id`),
  KEY `FK_M_NOTE_ON_LOAN` (`loan_id`),
  KEY `FK_M_NOTE_ON_LOAN_TRANSACTION` (`loan_transaction_id`),
  KEY `FK_M_NOTE_ON_SAVINGS_ACCOUNT` (`savings_account_id`),
  KEY `FK_M_NOTE_ON_SAVINGS_ACCOUNT_TRANSACTION` (`savings_account_transaction_id`),
  CONSTRAINT `FK_M_NOTE_ON_CLIENT` FOREIGN KEY (`client_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `FK_M_NOTE_ON_GROUP` FOREIGN KEY (`group_id`) REFERENCES `m_group` (`id`),
  CONSTRAINT `FK_M_NOTE_ON_LOAN` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `FK_M_NOTE_ON_LOAN_TRANSACTION` FOREIGN KEY (`loan_transaction_id`) REFERENCES `m_loan_transaction` (`id`),
  CONSTRAINT `FK_M_NOTE_ON_SAVINGS_ACCOUNT` FOREIGN KEY (`savings_account_id`) REFERENCES `m_savings_account` (`id`),
  CONSTRAINT `FK_M_NOTE_ON_SAVINGS_ACCOUNT_TRANSACTION` FOREIGN KEY (`savings_account_transaction_id`) REFERENCES `m_savings_account_transaction` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_payment_detail
-- ----------------------------
DROP TABLE IF EXISTS `m_payment_detail`;
CREATE TABLE `m_payment_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `payment_type_id` bigint(20) NOT NULL,
  `account_number` varchar(64) DEFAULT NULL,
  `check_number` varchar(64) DEFAULT NULL,
  `routing_code` varchar(64) DEFAULT NULL,
  `receipt_number` varchar(64) DEFAULT NULL,
  `bank_number` varchar(64) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_portfolio_account_associations
-- ----------------------------
DROP TABLE IF EXISTS `m_portfolio_account_associations`;
CREATE TABLE `m_portfolio_account_associations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_account_id` bigint(20) DEFAULT NULL,
  `savings_account_id` bigint(20) DEFAULT NULL,
  `linked_loan_account_id` bigint(20) DEFAULT NULL,
  `linked_savings_account_id` bigint(20) DEFAULT NULL,
  `association_type_enum` int(11) NOT NULL,
  `is_active` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_M_PORTFOLIO_ACCOUNT_ASSOCIATIONS_ON_LINKED_LOAN_ACCOUNT` (`linked_loan_account_id`),
  KEY `FK_M_PORTFOLIO_ACCOUNT_ASSOCIATIONS_ON_LINKED_SAVINGS_ACCOUNT` (`linked_savings_account_id`),
  KEY `FK_M_PORTFOLIO_ACCOUNT_ASSOCIATIONS_ON_LOAN_ACCOUNT` (`loan_account_id`),
  KEY `FK_M_PORTFOLIO_ACCOUNT_ASSOCIATIONS_ON_SAVINGS_ACCOUNT` (`savings_account_id`),
  CONSTRAINT `FK_M_PORTFOLIO_ACCOUNT_ASSOCIATIONS_ON_LINKED_LOAN_ACCOUNT` FOREIGN KEY (`linked_loan_account_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `FK_M_PORTFOLIO_ACCOUNT_ASSOCIATIONS_ON_LINKED_SAVINGS_ACCOUNT` FOREIGN KEY (`linked_savings_account_id`) REFERENCES `m_savings_account` (`id`),
  CONSTRAINT `FK_M_PORTFOLIO_ACCOUNT_ASSOCIATIONS_ON_LOAN_ACCOUNT` FOREIGN KEY (`loan_account_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `FK_M_PORTFOLIO_ACCOUNT_ASSOCIATIONS_ON_SAVINGS_ACCOUNT` FOREIGN KEY (`savings_account_id`) REFERENCES `m_savings_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_product_charge
-- ----------------------------
DROP TABLE IF EXISTS `m_product_charge`;
CREATE TABLE `m_product_charge` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `active` bit(1) NOT NULL DEFAULT b'0',
  `penalty` bit(1) NOT NULL DEFAULT b'0',
  `allowed_override` bit(1) NOT NULL DEFAULT b'0',
  `currency_code` varchar(16) NOT NULL,
  `amount` decimal(16,6) NOT NULL,
  `min_cap` decimal(16,6) DEFAULT NULL,
  `max_cap` decimal(16,6) DEFAULT NULL,
  `charge_calculation_type` varchar(64) DEFAULT NULL,
  `charge_time_type` varchar(64) DEFAULT NULL,
  `charge_applies_to` varchar(64) DEFAULT NULL,
  `charge_payment_mode` varchar(64) DEFAULT NULL,
  `fee_on_day` int(11) DEFAULT NULL,
  `fee_interval` int(11) DEFAULT NULL,
  `fee_on_month` int(11) DEFAULT NULL,
  `fee_frequency` int(11) DEFAULT NULL,
  `is_free_withdrawal` bit(1) NOT NULL DEFAULT b'0',
  `free_withdrawal_charge_frequency` int(11) DEFAULT NULL,
  `restart_frequency` int(11) DEFAULT NULL,
  `restart_frequency_enum` varchar(64) DEFAULT NULL,
  `is_payment_type` bit(1) NOT NULL DEFAULT b'0',
  `payment_type_id` bigint(20) DEFAULT NULL,
  `income_or_liability_account_id` bigint(20) DEFAULT NULL,
  `tax_group_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint(20) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_product_loan
-- ----------------------------
DROP TABLE IF EXISTS `m_product_loan`;
CREATE TABLE `m_product_loan` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_by` bigint(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` bigint(20) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(128) NOT NULL,
  `short_name` varchar(32) NOT NULL,
  `product_group_id` bigint(20) DEFAULT NULL,
  `external_id` varchar(128) DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  `overdue_days_for_npa` int(11) DEFAULT NULL,
  `min_days_between_disbursal_and_first_repayment` int(11) DEFAULT NULL,
  `instalment_amount_in_multiples_of` int(11) DEFAULT NULL,
  `over_applied_number` int(11) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `close_date` date DEFAULT NULL,
  `principal_threshold_for_last_installment` decimal(10,6) NOT NULL,
  `fixed_principal_percentage_per_installment` decimal(5,2) DEFAULT NULL,
  `loan_transaction_strategy` varchar(255) NOT NULL,
  `accounting_rule` varchar(32) DEFAULT NULL,
  `hold_guarantee_funds` bit(1) DEFAULT NULL,
  `account_moves_out_of_npa_only_on_arrears_completion` bit(1) DEFAULT NULL,
  `can_define_fixed_emi_amount` bit(1) DEFAULT NULL,
  `allow_variable_installments` bit(1) NOT NULL,
  `sync_expected_with_disbursement_date` bit(1) DEFAULT NULL,
  `can_use_for_top_up` bit(1) NOT NULL,
  `disallow_expected_disbursements` bit(1) NOT NULL,
  `allow_approved_disbursed_amounts_over_applied` bit(1) NOT NULL,
  `include_in_borrower_cycle` bit(1) DEFAULT NULL,
  `use_borrower_cycle` bit(1) DEFAULT NULL,
  `is_linked_to_floating_interest_rates` bit(1) NOT NULL,
  `over_applied_calculation_type` varchar(255) DEFAULT NULL,
  `fund_id` bigint(20) DEFAULT NULL,
  `currency_code` varchar(8) NOT NULL,
  `currency_digits` int(11) NOT NULL,
  `currency_multiples_of` int(11) DEFAULT NULL,
  `principal_amount` decimal(16,6) DEFAULT NULL,
  `nominal_interest_rate_per_period` decimal(16,6) DEFAULT NULL,
  `interest_period_frequency` varchar(255) DEFAULT NULL,
  `annual_nominal_interest_rate` decimal(16,6) DEFAULT NULL,
  `interest_method` varchar(255) NOT NULL,
  `interest_calculated_in_period` varchar(255) NOT NULL,
  `allow_partial_period_interest_calculation` bit(1) NOT NULL,
  `repay_every` int(11) NOT NULL,
  `repayment_period_frequency` varchar(255) NOT NULL,
  `number_of_repayments` int(11) NOT NULL,
  `grace_on_principal_periods` int(11) DEFAULT NULL,
  `recurring_moratorium_principal_periods` int(11) DEFAULT NULL,
  `grace_on_interest_periods` int(11) DEFAULT NULL,
  `grace_interest_free_periods` int(11) DEFAULT NULL,
  `amortization_method` varchar(255) NOT NULL,
  `in_arrears_tolerance_amount` decimal(19,6) DEFAULT NULL,
  `grace_on_arrears_ageing` int(11) DEFAULT NULL,
  `days_in_month` varchar(255) NOT NULL,
  `days_in_year` varchar(255) NOT NULL,
  `interest_recalculation_enabled` bit(1) DEFAULT NULL,
  `is_equal_amortization` bit(1) NOT NULL,
  `min_principal_amount` decimal(19,6) DEFAULT NULL,
  `max_principal_amount` decimal(19,6) DEFAULT NULL,
  `min_nominal_interest_rate_per_period` decimal(19,6) DEFAULT NULL,
  `max_nominal_interest_rate_per_period` decimal(19,6) DEFAULT NULL,
  `min_number_of_repayments` int(11) DEFAULT NULL,
  `max_number_of_repayments` int(11) DEFAULT NULL,
  `allow_multiple_disbursals` bit(1) DEFAULT NULL,
  `max_disbursals` int(11) DEFAULT NULL,
  `max_outstanding_loan_balance` decimal(19,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unq_name` (`name`),
  UNIQUE KEY `unq_short_name` (`short_name`),
  UNIQUE KEY `uc_m_product_loan_external` (`external_id`),
  KEY `FK_M_PRODUCT_LOAN_ON_FUND` (`fund_id`),
  CONSTRAINT `FK_M_PRODUCT_LOAN_ON_FUND` FOREIGN KEY (`fund_id`) REFERENCES `m_fund` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_product_loan_configurable_attributes
-- ----------------------------
DROP TABLE IF EXISTS `m_product_loan_configurable_attributes`;
CREATE TABLE `m_product_loan_configurable_attributes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_product_id` bigint(20) NOT NULL,
  `amortization_method_enum` bit(1) DEFAULT NULL,
  `interest_method_enum` bit(1) DEFAULT NULL,
  `loan_transaction_strategy_code` bit(1) DEFAULT NULL,
  `interest_calculated_in_period_enum` bit(1) DEFAULT NULL,
  `in_arrears_tolerance_amount` bit(1) DEFAULT NULL,
  `repay_every` bit(1) DEFAULT NULL,
  `moratorium` bit(1) DEFAULT NULL,
  `grace_on_arrears_ageing` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_m_product_loan_configurable_attributes_loan_product` (`loan_product_id`),
  CONSTRAINT `FK_M_PRODUCT_LOAN_CONFIGURABLE_ATTRIBUTES_ON_LOAN_PRODUCT` FOREIGN KEY (`loan_product_id`) REFERENCES `m_product_loan` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_product_loan_floating_rates
-- ----------------------------
DROP TABLE IF EXISTS `m_product_loan_floating_rates`;
CREATE TABLE `m_product_loan_floating_rates` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_product_id` bigint(20) NOT NULL,
  `floating_rates_id` bigint(20) NOT NULL,
  `interest_rate_differential` decimal(10,0) NOT NULL,
  `min_differential_lending_rate` decimal(10,0) NOT NULL,
  `default_differential_lending_rate` decimal(10,0) NOT NULL,
  `max_differential_lending_rate` decimal(10,0) NOT NULL,
  `is_floating_interest_rate_calculation_allowed` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_m_product_loan_floating_rates_loan_product` (`loan_product_id`),
  KEY `FK_M_PRODUCT_LOAN_FLOATING_RATES_ON_FLOATING_RATES` (`floating_rates_id`),
  CONSTRAINT `FK_M_PRODUCT_LOAN_FLOATING_RATES_ON_FLOATING_RATES` FOREIGN KEY (`floating_rates_id`) REFERENCES `m_floating_rates` (`id`),
  CONSTRAINT `FK_M_PRODUCT_LOAN_FLOATING_RATES_ON_LOAN_PRODUCT` FOREIGN KEY (`loan_product_id`) REFERENCES `m_product_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_product_loan_guarantee_details
-- ----------------------------
DROP TABLE IF EXISTS `m_product_loan_guarantee_details`;
CREATE TABLE `m_product_loan_guarantee_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_product_id` bigint(20) NOT NULL,
  `mandatory_guarantee` decimal(19,6) NOT NULL,
  `minimum_guarantee_from_own_funds` decimal(19,6) DEFAULT NULL,
  `minimum_guarantee_from_guarantor_funds` decimal(19,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_m_product_loan_guarantee_details_loan_product` (`loan_product_id`),
  CONSTRAINT `FK_M_PRODUCT_LOAN_GUARANTEE_DETAILS_ON_LOAN_PRODUCT` FOREIGN KEY (`loan_product_id`) REFERENCES `m_product_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_product_loan_recalculation_details
-- ----------------------------
DROP TABLE IF EXISTS `m_product_loan_recalculation_details`;
CREATE TABLE `m_product_loan_recalculation_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) NOT NULL,
  `compound_type` varchar(255) NOT NULL,
  `reschedule_strategy` varchar(255) NOT NULL,
  `rest_frequency_type` varchar(255) NOT NULL,
  `rest_frequency_interval` int(11) NOT NULL,
  `rest_frequency_nth_day_enum` int(11) DEFAULT NULL,
  `rest_frequency_weekday_enum` int(11) DEFAULT NULL,
  `rest_frequency_on_day` int(11) DEFAULT NULL,
  `compounding_frequency_type` varchar(255) DEFAULT NULL,
  `compounding_frequency_interval` int(11) DEFAULT NULL,
  `compounding_frequency_nth_day_enum` int(11) DEFAULT NULL,
  `compounding_frequency_weekday_enum` int(11) DEFAULT NULL,
  `compounding_frequency_on_day` int(11) DEFAULT NULL,
  `arrears_based_on_original_schedule` bit(1) DEFAULT NULL,
  `pre_close_interest_calculation_strategy` varchar(255) DEFAULT NULL,
  `is_compounding_to_be_posted_as_transaction` bit(1) DEFAULT NULL,
  `allow_compounding_on_eod` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_m_product_loan_recalculation_details_product` (`product_id`),
  CONSTRAINT `FK_M_PRODUCT_LOAN_RECALCULATION_DETAILS_ON_PRODUCT` FOREIGN KEY (`product_id`) REFERENCES `m_product_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_product_loan_related_charge
-- ----------------------------
DROP TABLE IF EXISTS `m_product_loan_related_charge`;
CREATE TABLE `m_product_loan_related_charge` (
  `loan_product_id` bigint(20) NOT NULL,
  `charge_product_id` bigint(20) NOT NULL,
  KEY `fk_mproloarelcha_on_charge_product_entity` (`charge_product_id`),
  KEY `fk_mproloarelcha_on_loan_product_entity` (`loan_product_id`),
  CONSTRAINT `fk_mproloarelcha_on_charge_product_entity` FOREIGN KEY (`charge_product_id`) REFERENCES `m_product_charge` (`id`),
  CONSTRAINT `fk_mproloarelcha_on_loan_product_entity` FOREIGN KEY (`loan_product_id`) REFERENCES `m_product_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_product_loan_related_rate
-- ----------------------------
DROP TABLE IF EXISTS `m_product_loan_related_rate`;
CREATE TABLE `m_product_loan_related_rate` (
  `loan_product_id` bigint(20) NOT NULL,
  `rate_id` bigint(20) NOT NULL,
  KEY `fk_mproloarelrat_on_loan_product_entity` (`loan_product_id`),
  KEY `fk_mproloarelrat_on_rate_entity` (`rate_id`),
  CONSTRAINT `fk_mproloarelrat_on_loan_product_entity` FOREIGN KEY (`loan_product_id`) REFERENCES `m_product_loan` (`id`),
  CONSTRAINT `fk_mproloarelrat_on_rate_entity` FOREIGN KEY (`rate_id`) REFERENCES `m_rate` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_product_loan_variable_installment_config
-- ----------------------------
DROP TABLE IF EXISTS `m_product_loan_variable_installment_config`;
CREATE TABLE `m_product_loan_variable_installment_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_product_id` bigint(20) NOT NULL,
  `minimum_gap` int(11) DEFAULT NULL,
  `maximum_gap` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_m_product_loan_variable_installment_config_loan_product` (`loan_product_id`),
  CONSTRAINT `FK_M_PRODUCT_LOAN_VARIABLE_INSTALLMENT_CONFIG_ON_LOAN_PRODUCT` FOREIGN KEY (`loan_product_id`) REFERENCES `m_product_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_product_loan_variations_borrower_cycle
-- ----------------------------
DROP TABLE IF EXISTS `m_product_loan_variations_borrower_cycle`;
CREATE TABLE `m_product_loan_variations_borrower_cycle` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_product_id` bigint(20) NOT NULL,
  `borrower_cycle_number` int(11) NOT NULL,
  `param_type` varchar(255) NOT NULL,
  `value_condition` varchar(255) NOT NULL,
  `min_value` decimal(19,6) DEFAULT NULL,
  `max_value` decimal(19,6) DEFAULT NULL,
  `default_value` decimal(19,6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_M_PRODUCT_LOAN_VARIATIONS_BORROWER_CYCLE_ON_LOAN_PRODUCT` (`loan_product_id`),
  CONSTRAINT `FK_M_PRODUCT_LOAN_VARIATIONS_BORROWER_CYCLE_ON_LOAN_PRODUCT` FOREIGN KEY (`loan_product_id`) REFERENCES `m_product_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_rate
-- ----------------------------
DROP TABLE IF EXISTS `m_rate`;
CREATE TABLE `m_rate` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_by` bigint(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` bigint(20) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(250) DEFAULT NULL,
  `percentage` decimal(10,2) NOT NULL,
  `product_apply` varchar(16) DEFAULT NULL,
  `active` bit(1) NOT NULL,
  `approve_user` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_repayment_with_post_dated_checks
-- ----------------------------
DROP TABLE IF EXISTS `m_repayment_with_post_dated_checks`;
CREATE TABLE `m_repayment_with_post_dated_checks` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `repayment_id` bigint(20) NOT NULL,
  `account_no` bigint(20) NOT NULL,
  `bank_name` varchar(100) NOT NULL,
  `amount` decimal(19,6) DEFAULT NULL,
  `repayment_date` date NOT NULL,
  `status` int(11) DEFAULT NULL,
  `check_no` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_m_repayment_with_post_dated_checks_check_no` (`check_no`),
  KEY `FK_M_REPAYMENT_WITH_POST_DATED_CHECKS_ON_LOAN` (`loan_id`),
  KEY `FK_M_REPAYMENT_WITH_POST_DATED_CHECKS_ON_REPAYMENT` (`repayment_id`),
  CONSTRAINT `FK_M_REPAYMENT_WITH_POST_DATED_CHECKS_ON_LOAN` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `FK_M_REPAYMENT_WITH_POST_DATED_CHECKS_ON_REPAYMENT` FOREIGN KEY (`repayment_id`) REFERENCES `m_loan_repayment_schedule` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_savings_account
-- ----------------------------
DROP TABLE IF EXISTS `m_savings_account`;
CREATE TABLE `m_savings_account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` int(11) NOT NULL,
  `account_no` varchar(20) NOT NULL,
  `external_id` varchar(255) DEFAULT NULL,
  `client_id` bigint(20) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `gsim_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) NOT NULL,
  `field_officer_id` bigint(20) DEFAULT NULL,
  `status_enum` int(11) NOT NULL,
  `sub_status_enum` int(11) NOT NULL,
  `account_type_enum` int(11) NOT NULL,
  `submittedon_date` date DEFAULT NULL,
  `submittedon_userid` bigint(20) DEFAULT NULL,
  `rejectedon_date` date DEFAULT NULL,
  `rejectedon_userid` bigint(20) DEFAULT NULL,
  `withdrawnon_date` date DEFAULT NULL,
  `withdrawnon_userid` bigint(20) DEFAULT NULL,
  `approvedon_date` date DEFAULT NULL,
  `approvedon_userid` bigint(20) DEFAULT NULL,
  `activatedon_date` date DEFAULT NULL,
  `activatedon_userid` bigint(20) DEFAULT NULL,
  `closedon_date` date DEFAULT NULL,
  `closedon_userid` bigint(20) DEFAULT NULL,
  `reason_for_block` varchar(255) DEFAULT NULL,
  `nominal_annual_interest_rate` decimal(19,6) NOT NULL,
  `interest_compounding_period_enum` int(11) NOT NULL,
  `interest_posting_period_enum` int(11) NOT NULL,
  `interest_calculation_type_enum` int(11) NOT NULL,
  `interest_calculation_days_in_year_type_enum` int(11) NOT NULL,
  `min_required_opening_balance` decimal(19,6) DEFAULT NULL,
  `lockin_period_frequency` int(11) DEFAULT NULL,
  `lockin_period_frequency_enum` int(11) DEFAULT NULL,
  `lockedin_until_date_derived` date DEFAULT NULL,
  `withdrawal_fee_for_transfer` bit(1) DEFAULT NULL,
  `allow_overdraft` bit(1) DEFAULT NULL,
  `overdraft_limit` decimal(19,6) DEFAULT NULL,
  `nominal_annual_interest_rate_overdraft` decimal(19,6) DEFAULT NULL,
  `min_overdraft_for_interest_calculation` decimal(19,6) DEFAULT NULL,
  `enforce_min_required_balance` bit(1) DEFAULT NULL,
  `min_required_balance` decimal(19,6) DEFAULT NULL,
  `is_lien_allowed` bit(1) NOT NULL,
  `max_allowed_lien_limit` decimal(19,6) DEFAULT NULL,
  `on_hold_funds_derived` decimal(19,6) DEFAULT NULL,
  `start_interest_calculation_date` date DEFAULT NULL,
  `deposit_type_enum` int(11) DEFAULT NULL,
  `min_balance_for_interest_calculation` decimal(19,6) DEFAULT NULL,
  `withhold_tax` bit(1) NOT NULL,
  `tax_group_id` bigint(20) DEFAULT NULL,
  `total_savings_amount_on_hold` decimal(19,6) DEFAULT NULL,
  `currency_code` varchar(8) NOT NULL,
  `currency_digits` int(11) NOT NULL,
  `currency_multiples_of` int(11) DEFAULT NULL,
  `total_deposits_derived` decimal(19,6) DEFAULT NULL,
  `total_withdrawals_derived` decimal(19,6) DEFAULT NULL,
  `total_interest_earned_derived` decimal(19,6) DEFAULT NULL,
  `total_interest_posted_derived` decimal(19,6) DEFAULT NULL,
  `total_withdrawal_fees_derived` decimal(19,6) DEFAULT NULL,
  `total_fees_charge_derived` decimal(19,6) DEFAULT NULL,
  `total_penalty_charge_derived` decimal(19,6) DEFAULT NULL,
  `total_annual_fees_derived` decimal(19,6) DEFAULT NULL,
  `account_balance_derived` decimal(19,6) DEFAULT NULL,
  `total_overdraft_interest_derived` decimal(19,6) DEFAULT NULL,
  `total_withhold_tax_derived` decimal(19,6) DEFAULT NULL,
  `last_interest_calculation_date` date DEFAULT NULL,
  `interest_posted_till_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sa_account_no_UNIQUE` (`account_no`),
  UNIQUE KEY `sa_external_id_UNIQUE` (`external_id`),
  KEY `FK_M_SAVINGS_ACCOUNT_ON_ACTIVATEDON_USERID` (`activatedon_userid`),
  KEY `FK_M_SAVINGS_ACCOUNT_ON_APPROVEDON_USERID` (`approvedon_userid`),
  KEY `FK_M_SAVINGS_ACCOUNT_ON_CLIENT` (`client_id`),
  KEY `FK_M_SAVINGS_ACCOUNT_ON_CLOSEDON_USERID` (`closedon_userid`),
  KEY `FK_M_SAVINGS_ACCOUNT_ON_FIELD_OFFICER` (`field_officer_id`),
  KEY `FK_M_SAVINGS_ACCOUNT_ON_GROUP` (`group_id`),
  KEY `FK_M_SAVINGS_ACCOUNT_ON_GSIM` (`gsim_id`),
  KEY `FK_M_SAVINGS_ACCOUNT_ON_PRODUCT` (`product_id`),
  KEY `FK_M_SAVINGS_ACCOUNT_ON_REJECTEDON_USERID` (`rejectedon_userid`),
  KEY `FK_M_SAVINGS_ACCOUNT_ON_SUBMITTEDON_USERID` (`submittedon_userid`),
  KEY `FK_M_SAVINGS_ACCOUNT_ON_TAX_GROUP` (`tax_group_id`),
  KEY `FK_M_SAVINGS_ACCOUNT_ON_WITHDRAWNON_USERID` (`withdrawnon_userid`),
  CONSTRAINT `FK_M_SAVINGS_ACCOUNT_ON_ACTIVATEDON_USERID` FOREIGN KEY (`activatedon_userid`) REFERENCES `org_user` (`id`),
  CONSTRAINT `FK_M_SAVINGS_ACCOUNT_ON_APPROVEDON_USERID` FOREIGN KEY (`approvedon_userid`) REFERENCES `org_user` (`id`),
  CONSTRAINT `FK_M_SAVINGS_ACCOUNT_ON_CLIENT` FOREIGN KEY (`client_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `FK_M_SAVINGS_ACCOUNT_ON_CLOSEDON_USERID` FOREIGN KEY (`closedon_userid`) REFERENCES `org_user` (`id`),
  CONSTRAINT `FK_M_SAVINGS_ACCOUNT_ON_FIELD_OFFICER` FOREIGN KEY (`field_officer_id`) REFERENCES `org_staff` (`id`),
  CONSTRAINT `FK_M_SAVINGS_ACCOUNT_ON_GROUP` FOREIGN KEY (`group_id`) REFERENCES `m_group` (`id`),
  CONSTRAINT `FK_M_SAVINGS_ACCOUNT_ON_GSIM` FOREIGN KEY (`gsim_id`) REFERENCES `gsim_accounts` (`id`),
  CONSTRAINT `FK_M_SAVINGS_ACCOUNT_ON_PRODUCT` FOREIGN KEY (`product_id`) REFERENCES `m_savings_product` (`id`),
  CONSTRAINT `FK_M_SAVINGS_ACCOUNT_ON_REJECTEDON_USERID` FOREIGN KEY (`rejectedon_userid`) REFERENCES `org_user` (`id`),
  CONSTRAINT `FK_M_SAVINGS_ACCOUNT_ON_SUBMITTEDON_USERID` FOREIGN KEY (`submittedon_userid`) REFERENCES `org_user` (`id`),
  CONSTRAINT `FK_M_SAVINGS_ACCOUNT_ON_TAX_GROUP` FOREIGN KEY (`tax_group_id`) REFERENCES `m_tax_group` (`id`),
  CONSTRAINT `FK_M_SAVINGS_ACCOUNT_ON_WITHDRAWNON_USERID` FOREIGN KEY (`withdrawnon_userid`) REFERENCES `org_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_savings_account_charge
-- ----------------------------
DROP TABLE IF EXISTS `m_savings_account_charge`;
CREATE TABLE `m_savings_account_charge` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `amount` decimal(19,6) NOT NULL,
  `amount_outstanding_derived` decimal(19,6) NOT NULL,
  `amount_paid_derived` decimal(19,6) DEFAULT NULL,
  `calculation_on_amount` decimal(19,6) DEFAULT NULL,
  `amount_waived_derived` decimal(19,6) DEFAULT NULL,
  `amount_writtenoff_derived` decimal(19,6) DEFAULT NULL,
  `charge_calculation` enum('INVALID','FLAT','PERCENT_OF_AMOUNT','PERCENT_OF_AMOUNT_AND_INTEREST','PERCENT_OF_INTEREST','PERCENT_OF_DISBURSEMENT_AMOUNT') DEFAULT NULL,
  `charge_reset_date` date DEFAULT NULL,
  `charge_time_enum` enum('INVALID','DISBURSEMENT','SPECIFIED_DUE_DATE','SAVINGS_ACTIVATION','SAVINGS_CLOSURE','WITHDRAWAL_FEE','ANNUAL_FEE','MONTHLY_FEE','INSTALMENT_FEE','OVERDUE_INSTALLMENT','OVERDRAFT_FEE','WEEKLY_FEE','TRANCHE_DISBURSEMENT','SHARE_ACCOUNT_ACTIVATION','SHARE_PURCHASE','SHARE_REDEEM','SAVINGS_NO_ACTIVITY_FEE','DISBURSEMENT_PAID_WITH_REPAYMENT','LOAN_RESCHEDULING_FEE','OVERDUE_ON_MATURITY','LAST_INSTALLMENT_FEE','QUARTERLY_FEE','DISBURSEMENT_ADDED_TO_PRINCIPAL') NOT NULL,
  `charge_due_date` date DEFAULT NULL,
  `fee_interval` int(11) DEFAULT NULL,
  `fee_on_day` int(11) DEFAULT NULL,
  `fee_on_month` int(11) DEFAULT NULL,
  `free_withdrawal_count` int(11) DEFAULT NULL,
  `inactivated_on_date` date DEFAULT NULL,
  `is_paid_derived` bit(1) NOT NULL,
  `is_penalty` bit(1) NOT NULL,
  `calculation_percentage` decimal(19,6) DEFAULT NULL,
  `is_active` bit(1) NOT NULL,
  `waived` bit(1) NOT NULL,
  `charge_id` bigint(20) NOT NULL,
  `savings_account_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKgj0v3dlmulcex42tv6se74cwm` (`charge_id`),
  KEY `FKsxw176qqmr0wm0n513mi3kl8d` (`savings_account_id`),
  CONSTRAINT `FKgj0v3dlmulcex42tv6se74cwm` FOREIGN KEY (`charge_id`) REFERENCES `m_product_charge` (`id`),
  CONSTRAINT `FKsxw176qqmr0wm0n513mi3kl8d` FOREIGN KEY (`savings_account_id`) REFERENCES `m_savings_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_savings_account_charge_paid_by
-- ----------------------------
DROP TABLE IF EXISTS `m_savings_account_charge_paid_by`;
CREATE TABLE `m_savings_account_charge_paid_by` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `amount` decimal(19,6) NOT NULL,
  `savings_account_charge_id` bigint(20) NOT NULL,
  `savings_account_transaction_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKhr16mjfd6ogulswc05f4h7wpm` (`savings_account_charge_id`),
  KEY `FKkmwl0lmaybsf8f1m9r9h3j98i` (`savings_account_transaction_id`),
  CONSTRAINT `FKhr16mjfd6ogulswc05f4h7wpm` FOREIGN KEY (`savings_account_charge_id`) REFERENCES `m_savings_account_charge` (`id`),
  CONSTRAINT `FKkmwl0lmaybsf8f1m9r9h3j98i` FOREIGN KEY (`savings_account_transaction_id`) REFERENCES `m_savings_account_transaction` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_savings_account_transaction
-- ----------------------------
DROP TABLE IF EXISTS `m_savings_account_transaction`;
CREATE TABLE `m_savings_account_transaction` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `savings_account_id` bigint(20) NOT NULL,
  `office_id` bigint(20) NOT NULL,
  `payment_detail_id` bigint(20) DEFAULT NULL,
  `transaction_type_enum` int(11) NOT NULL,
  `transaction_date` date NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `is_reversed` bit(1) NOT NULL,
  `running_balance_derived` decimal(19,6) DEFAULT NULL,
  `cumulative_balance_derived` decimal(19,6) DEFAULT NULL,
  `balance_end_date_derived` date DEFAULT NULL,
  `balance_number_of_days_derived` int(11) DEFAULT NULL,
  `overdraft_amount_derived` decimal(19,6) DEFAULT NULL,
  `created_date` datetime NOT NULL,
  `appuser_id` bigint(20) DEFAULT NULL,
  `is_manual` bit(1) DEFAULT NULL,
  `is_loan_disbursement` bit(1) DEFAULT NULL,
  `release_id_of_hold_amount` bigint(20) DEFAULT NULL,
  `reason_for_block` varchar(255) DEFAULT NULL,
  `is_reversal` bit(1) NOT NULL,
  `original_transaction_id` bigint(20) DEFAULT NULL,
  `is_lien_transaction` bit(1) DEFAULT NULL,
  `ref_no` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_M_SAVINGS_ACCOUNT_TRANSACTION_ON_APPUSER` (`appuser_id`),
  KEY `FK_M_SAVINGS_ACCOUNT_TRANSACTION_ON_OFFICE` (`office_id`),
  KEY `FK_M_SAVINGS_ACCOUNT_TRANSACTION_ON_PAYMENT_DETAIL` (`payment_detail_id`),
  KEY `FK_M_SAVINGS_ACCOUNT_TRANSACTION_ON_SAVINGS_ACCOUNT` (`savings_account_id`),
  CONSTRAINT `FK_M_SAVINGS_ACCOUNT_TRANSACTION_ON_APPUSER` FOREIGN KEY (`appuser_id`) REFERENCES `org_user` (`id`),
  CONSTRAINT `FK_M_SAVINGS_ACCOUNT_TRANSACTION_ON_OFFICE` FOREIGN KEY (`office_id`) REFERENCES `org_office` (`id`),
  CONSTRAINT `FK_M_SAVINGS_ACCOUNT_TRANSACTION_ON_PAYMENT_DETAIL` FOREIGN KEY (`payment_detail_id`) REFERENCES `m_payment_detail` (`id`),
  CONSTRAINT `FK_M_SAVINGS_ACCOUNT_TRANSACTION_ON_SAVINGS_ACCOUNT` FOREIGN KEY (`savings_account_id`) REFERENCES `m_savings_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_savings_account_transaction_tax_details
-- ----------------------------
DROP TABLE IF EXISTS `m_savings_account_transaction_tax_details`;
CREATE TABLE `m_savings_account_transaction_tax_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `amount` decimal(19,6) NOT NULL,
  `savings_transaction_id` bigint(20) NOT NULL,
  `tax_component_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKaw0y140l33rjtoo125djb9laa` (`savings_transaction_id`),
  KEY `FKlskhwrn7x3mxjs88kngtt55wo` (`tax_component_id`),
  CONSTRAINT `FKaw0y140l33rjtoo125djb9laa` FOREIGN KEY (`savings_transaction_id`) REFERENCES `m_savings_account_transaction` (`id`),
  CONSTRAINT `FKlskhwrn7x3mxjs88kngtt55wo` FOREIGN KEY (`tax_component_id`) REFERENCES `m_tax_component` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_savings_officer_assignment_history
-- ----------------------------
DROP TABLE IF EXISTS `m_savings_officer_assignment_history`;
CREATE TABLE `m_savings_officer_assignment_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint(20) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` bigint(20) NOT NULL,
  `end_date` date DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `account_id` bigint(20) NOT NULL,
  `savings_officer_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK40tsot2ee4lnjksn92t0rcsur` (`account_id`),
  KEY `FK8d4cy7602fo76cx3p5dqsvwim` (`savings_officer_id`),
  CONSTRAINT `FK40tsot2ee4lnjksn92t0rcsur` FOREIGN KEY (`account_id`) REFERENCES `m_savings_account` (`id`),
  CONSTRAINT `FK8d4cy7602fo76cx3p5dqsvwim` FOREIGN KEY (`savings_officer_id`) REFERENCES `org_staff` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_savings_product
-- ----------------------------
DROP TABLE IF EXISTS `m_savings_product`;
CREATE TABLE `m_savings_product` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deposit_type_enum` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `short_name` varchar(255) NOT NULL,
  `description` varchar(500) NOT NULL,
  `nominal_annual_interest_rate` decimal(19,6) NOT NULL,
  `interest_compounding_period_enum` int(11) NOT NULL,
  `interest_posting_period_enum` int(11) NOT NULL,
  `interest_calculation_type_enum` int(11) NOT NULL,
  `interest_calculation_days_in_year_type_enum` int(11) NOT NULL,
  `min_required_opening_balance` decimal(19,6) DEFAULT NULL,
  `lockin_period_frequency` int(11) DEFAULT NULL,
  `lockin_period_frequency_enum` int(11) DEFAULT NULL,
  `accounting_type` int(11) NOT NULL,
  `withdrawal_fee_for_transfer` bit(1) DEFAULT NULL,
  `allow_overdraft` bit(1) DEFAULT NULL,
  `overdraft_limit` decimal(19,6) DEFAULT NULL,
  `nominal_annual_interest_rate_overdraft` decimal(19,6) DEFAULT NULL,
  `min_overdraft_for_interest_calculation` decimal(19,6) DEFAULT NULL,
  `enforce_min_required_balance` bit(1) DEFAULT NULL,
  `min_required_balance` decimal(19,6) DEFAULT NULL,
  `is_lien_allowed` bit(1) NOT NULL,
  `max_allowed_lien_limit` decimal(19,6) DEFAULT NULL,
  `min_balance_for_interest_calculation` decimal(19,6) DEFAULT NULL,
  `withhold_tax` bit(1) NOT NULL,
  `tax_group_id` bigint(20) DEFAULT NULL,
  `is_dormancy_tracking_active` bit(1) DEFAULT NULL,
  `days_to_inactive` bigint(20) DEFAULT NULL,
  `days_to_dormancy` bigint(20) DEFAULT NULL,
  `days_to_escheat` bigint(20) DEFAULT NULL,
  `currency_code` varchar(8) NOT NULL,
  `currency_digits` int(11) NOT NULL,
  `currency_multiples_of` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sp_unq_name` (`name`),
  UNIQUE KEY `sp_unq_short_name` (`short_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_savings_product_charge
-- ----------------------------
DROP TABLE IF EXISTS `m_savings_product_charge`;
CREATE TABLE `m_savings_product_charge` (
  `charge_id` bigint(20) NOT NULL,
  `savings_product_id` bigint(20) NOT NULL,
  PRIMARY KEY (`charge_id`,`savings_product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_staff_assignment_history
-- ----------------------------
DROP TABLE IF EXISTS `m_staff_assignment_history`;
CREATE TABLE `m_staff_assignment_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `centre_id` bigint(20) DEFAULT NULL,
  `staff_id` bigint(20) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_M_STAFF_ASSIGNMENT_HISTORY_ON_CENTRE` (`centre_id`),
  KEY `FK_M_STAFF_ASSIGNMENT_HISTORY_ON_STAFF` (`staff_id`),
  CONSTRAINT `FK_M_STAFF_ASSIGNMENT_HISTORY_ON_CENTRE` FOREIGN KEY (`centre_id`) REFERENCES `m_group` (`id`),
  CONSTRAINT `FK_M_STAFF_ASSIGNMENT_HISTORY_ON_STAFF` FOREIGN KEY (`staff_id`) REFERENCES `org_staff` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_tax_component
-- ----------------------------
DROP TABLE IF EXISTS `m_tax_component`;
CREATE TABLE `m_tax_component` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_by` bigint(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` bigint(20) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(100) DEFAULT NULL,
  `percentage` decimal(19,6) NOT NULL,
  `debit_account_type_enum` int(11) DEFAULT NULL,
  `debit_account_id` bigint(20) DEFAULT NULL,
  `credit_account_type_enum` int(11) DEFAULT NULL,
  `credit_account_id` bigint(20) DEFAULT NULL,
  `start_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_M_TAX_COMPONENT_ON_CREDIT_ACCOUNT` (`credit_account_id`),
  KEY `FK_M_TAX_COMPONENT_ON_DEBIT_ACCOUNT` (`debit_account_id`),
  CONSTRAINT `FK_M_TAX_COMPONENT_ON_CREDIT_ACCOUNT` FOREIGN KEY (`credit_account_id`) REFERENCES `acc_gl_account` (`id`),
  CONSTRAINT `FK_M_TAX_COMPONENT_ON_DEBIT_ACCOUNT` FOREIGN KEY (`debit_account_id`) REFERENCES `acc_gl_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_tax_component_history
-- ----------------------------
DROP TABLE IF EXISTS `m_tax_component_history`;
CREATE TABLE `m_tax_component_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_by` bigint(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` bigint(20) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `percentage` decimal(19,6) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `tax_component_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_M_TAX_COMPONENT_HISTORY_ON_TAX_COMPONENT` (`tax_component_id`),
  CONSTRAINT `FK_M_TAX_COMPONENT_HISTORY_ON_TAX_COMPONENT` FOREIGN KEY (`tax_component_id`) REFERENCES `m_tax_component` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_tax_group
-- ----------------------------
DROP TABLE IF EXISTS `m_tax_group`;
CREATE TABLE `m_tax_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_tax_group_mappings
-- ----------------------------
DROP TABLE IF EXISTS `m_tax_group_mappings`;
CREATE TABLE `m_tax_group_mappings` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tax_group_id` bigint(20) NOT NULL,
  `tax_component_id` bigint(20) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_M_TAX_GROUP_MAPPINGS_ON_TAX_GROUP` (`tax_group_id`),
  KEY `FK_M_TAX_GROUP_MAPPINGS_ON_TAX_COMPONENT` (`tax_component_id`),
  CONSTRAINT `FK_M_TAX_GROUP_MAPPINGS_ON_TAX_COMPONENT` FOREIGN KEY (`tax_component_id`) REFERENCES `m_tax_component` (`id`),
  CONSTRAINT `FK_M_TAX_GROUP_MAPPINGS_ON_TAX_GROUP` FOREIGN KEY (`tax_group_id`) REFERENCES `m_tax_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for m_working_days
-- ----------------------------
DROP TABLE IF EXISTS `m_working_days`;
CREATE TABLE `m_working_days` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `recurrence` varchar(100) DEFAULT NULL,
  `repayment_rescheduling_enum` int(11) NOT NULL,
  `extend_term_daily_repayments` bit(1) NOT NULL,
  `extend_term_holiday_repayment` bit(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for org_all_currency
-- ----------------------------
DROP TABLE IF EXISTS `org_all_currency`;
CREATE TABLE `org_all_currency` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(16) NOT NULL,
  `name` varchar(32) NOT NULL,
  `name_code` varchar(64) NOT NULL,
  `decimal_places` int(11) NOT NULL,
  `currency_multiples_of` int(11) DEFAULT '1',
  `display_symbol` varchar(16) DEFAULT NULL,
  `display_label` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `curreny_code` (`code`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for org_currency
-- ----------------------------
DROP TABLE IF EXISTS `org_currency`;
CREATE TABLE `org_currency` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(16) NOT NULL,
  `name` varchar(32) NOT NULL,
  `name_code` varchar(64) NOT NULL,
  `decimal_places` int(11) NOT NULL,
  `currency_multiples_of` int(11) DEFAULT '1',
  `display_symbol` varchar(16) DEFAULT NULL,
  `display_label` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `curreny_code` (`code`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=142 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for org_office
-- ----------------------------
DROP TABLE IF EXISTS `org_office`;
CREATE TABLE `org_office` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `name_decorated` varchar(255) DEFAULT NULL,
  `opening_date` date NOT NULL,
  `hierarchy` int(11) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `org_office_parent` (`parent_id`),
  CONSTRAINT `office_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `org_office` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for org_payment_type
-- ----------------------------
DROP TABLE IF EXISTS `org_payment_type`;
CREATE TABLE `org_payment_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `is_cash_payment` tinyint(1) NOT NULL,
  `position` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for org_permission
-- ----------------------------
DROP TABLE IF EXISTS `org_permission`;
CREATE TABLE `org_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(32) NOT NULL,
  `url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_code` (`code`) USING BTREE,
  UNIQUE KEY `uk_type_url` (`type`,`url`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for org_role
-- ----------------------------
DROP TABLE IF EXISTS `org_role`;
CREATE TABLE `org_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `status` varchar(32) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for org_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `org_role_permission`;
CREATE TABLE `org_role_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) NOT NULL,
  `permission_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for org_staff
-- ----------------------------
DROP TABLE IF EXISTS `org_staff`;
CREATE TABLE `org_staff` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `office_id` bigint(20) NOT NULL,
  `first_name` varchar(64) NOT NULL,
  `last_name` varchar(64) NOT NULL,
  `account_nbr` varchar(64) DEFAULT NULL,
  `is_loan_officer` tinyint(1) NOT NULL,
  `joining_date` date DEFAULT NULL,
  `status` varchar(64) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `staff_office_id` (`office_id`),
  CONSTRAINT `staff_office_id` FOREIGN KEY (`office_id`) REFERENCES `org_office` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for org_user
-- ----------------------------
DROP TABLE IF EXISTS `org_user`;
CREATE TABLE `org_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `office_id` bigint(20) NOT NULL,
  `staff_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `user_office_id` (`office_id`),
  KEY `user_staff_id` (`staff_id`),
  CONSTRAINT `user_office_id` FOREIGN KEY (`office_id`) REFERENCES `org_office` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `user_staff_id` FOREIGN KEY (`staff_id`) REFERENCES `org_staff` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=146 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for org_user_role
-- ----------------------------
DROP TABLE IF EXISTS `org_user_role`;
CREATE TABLE `org_user_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `org_user_id` (`user_id`),
  KEY `org_role_id` (`role_id`),
  CONSTRAINT `org_role_id` FOREIGN KEY (`role_id`) REFERENCES `org_role` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `org_user_id` FOREIGN KEY (`user_id`) REFERENCES `org_user` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=150 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for product_group
-- ----------------------------
DROP TABLE IF EXISTS `product_group`;
CREATE TABLE `product_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` varchar(64) NOT NULL,
  `name` varchar(255) NOT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `hierarchy` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `group_parent_id` (`parent_id`),
  CONSTRAINT `group_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `product_group` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for scheduled_job_detail
-- ----------------------------
DROP TABLE IF EXISTS `scheduled_job_detail`;
CREATE TABLE `scheduled_job_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `group` varchar(255) DEFAULT NULL,
  `desc` varchar(255) DEFAULT NULL,
  `clazz` varchar(255) DEFAULT NULL,
  `cron` varchar(255) DEFAULT NULL,
  `concurrent` varchar(255) DEFAULT NULL,
  `method` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `json_param` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for scheduled_job_run_history
-- ----------------------------
DROP TABLE IF EXISTS `scheduled_job_run_history`;
CREATE TABLE `scheduled_job_run_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `job_id` bigint(20) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `error_message` varchar(255) DEFAULT NULL,
  `trigger_type` varchar(255) DEFAULT NULL,
  `error_log` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for sys_audit
-- ----------------------------
DROP TABLE IF EXISTS `sys_audit`;
CREATE TABLE `sys_audit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `global_unique_no` varchar(255) DEFAULT NULL,
  `action_name` varchar(255) DEFAULT NULL,
  `entity_name` varchar(255) DEFAULT NULL,
  `resource_id` bigint(20) DEFAULT NULL,
  `command_as_json` json DEFAULT NULL,
  `processing_result` varchar(255) DEFAULT NULL,
  `maker_ip` varchar(255) DEFAULT NULL,
  `maker_id` bigint(20) DEFAULT NULL,
  `made_on` timestamp NULL DEFAULT NULL,
  `response_at` timestamp NULL DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `loan_id` bigint(20) DEFAULT NULL,
  `office_id` bigint(20) DEFAULT NULL,
  `origin_channel` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=189 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for sys_code
-- ----------------------------
DROP TABLE IF EXISTS `sys_code`;
CREATE TABLE `sys_code` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code_name` varchar(128) NOT NULL,
  `is_system_defined` bit(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for sys_code_value
-- ----------------------------
DROP TABLE IF EXISTS `sys_code_value`;
CREATE TABLE `sys_code_value` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code_id` bigint(20) NOT NULL,
  `code_value` varchar(128) NOT NULL,
  `order_position` int(11) NOT NULL,
  `code_description` varchar(1024) DEFAULT NULL,
  `is_active` bit(1) NOT NULL,
  `is_default` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sys_code_id` (`code_id`),
  CONSTRAINT `sys_code_id` FOREIGN KEY (`code_id`) REFERENCES `sys_code` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for sys_configuration
-- ----------------------------
DROP TABLE IF EXISTS `sys_configuration`;
CREATE TABLE `sys_configuration` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(512) NOT NULL,
  `enabled` bit(1) NOT NULL,
  `value` bigint(20) DEFAULT NULL,
  `date_value` date DEFAULT NULL,
  `string_value` varchar(512) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `is_trap_door` bit(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for sys_control
-- ----------------------------
DROP TABLE IF EXISTS `sys_control`;
CREATE TABLE `sys_control` (
  `currrent_date` date NOT NULL,
  `next_date` date NOT NULL,
  `last_date` date NOT NULL,
  `default_currency_code` varchar(255) NOT NULL,
  `acc_ind` varchar(255) DEFAULT NULL,
  `last_modified_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_modified_by` bigint(20) NOT NULL,
  KEY `sys_control_user` (`last_modified_by`),
  CONSTRAINT `sys_control_user` FOREIGN KEY (`last_modified_by`) REFERENCES `org_user` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SET FOREIGN_KEY_CHECKS = 1;
