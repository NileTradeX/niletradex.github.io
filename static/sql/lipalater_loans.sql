/*
 Navicat Premium Data Transfer

 Source Server         : azure-dev
 Source Server Type    : MySQL
 Source Server Version : 50744 (5.7.44-log)
 Source Host           : lipalater-mysql-dev.mysql.database.azure.com:3306
 Source Schema         : lipalater_loans

 Target Server Type    : MySQL
 Target Server Version : 50744 (5.7.44-log)
 File Encoding         : 65001

 Date: 25/07/2024 15:53:12
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for application_extra_docs
-- ----------------------------
DROP TABLE IF EXISTS `application_extra_docs`;
CREATE TABLE `application_extra_docs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `application_no` varchar(255) NOT NULL,
  `extra_doc` tinyint(4) DEFAULT NULL,
  `uploaded` tinyint(4) DEFAULT '0',
  `uploaded_doc` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100321 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for astra_auth
-- ----------------------------
DROP TABLE IF EXISTS `astra_auth`;
CREATE TABLE `astra_auth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `expires_epoch_secs` int(11) DEFAULT NULL,
  `header_name` varchar(255) DEFAULT NULL,
  `header_value` text,
  `session_id` varchar(255) DEFAULT NULL,
  `tenant_id` varchar(255) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `date_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for bank_verification_numbers
-- ----------------------------
DROP TABLE IF EXISTS `bank_verification_numbers`;
CREATE TABLE `bank_verification_numbers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `request_id` varchar(255) DEFAULT NULL,
  `bvn` varchar(32) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `marital_status` varchar(255) DEFAULT NULL,
  `watch_listed` varchar(255) DEFAULT NULL,
  `level_of_account` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `date_of_birth` varchar(255) DEFAULT NULL,
  `phone_number1` varchar(255) DEFAULT NULL,
  `phone_number2` varchar(255) DEFAULT NULL,
  `registration_date` varchar(255) DEFAULT NULL,
  `enrollment_bank` varchar(255) DEFAULT NULL,
  `enrollment_branch` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `lga_of_origin` varchar(255) DEFAULT NULL,
  `lga_of_residence` varchar(255) DEFAULT NULL,
  `nin` varchar(255) DEFAULT NULL,
  `name_on_card` varchar(255) DEFAULT NULL,
  `nationality` varchar(255) DEFAULT NULL,
  `residential_address` varchar(255) DEFAULT NULL,
  `state_of_origin` varchar(255) DEFAULT NULL,
  `state_of_residence` varchar(255) DEFAULT NULL,
  `photo` longtext,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `bvn` (`bvn`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=102198 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for charges
-- ----------------------------
DROP TABLE IF EXISTS `charges`;
CREATE TABLE `charges` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `active` bit(1) DEFAULT NULL,
  `penalty` bit(1) DEFAULT NULL,
  `allow_override` bit(1) DEFAULT NULL,
  `currency` varchar(255) DEFAULT NULL,
  `amount` decimal(16,2) DEFAULT NULL,
  `charge_time_type` int(11) DEFAULT NULL,
  `charge_applies_to` varchar(255) DEFAULT NULL,
  `charge_calculation_type` int(11) DEFAULT NULL,
  `charge_payment_mode` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for client_status_change
-- ----------------------------
DROP TABLE IF EXISTS `client_status_change`;
CREATE TABLE `client_status_change` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` int(11) NOT NULL,
  `command` varchar(255) DEFAULT NULL,
  `result` tinyint(1) DEFAULT NULL,
  `remark` varchar(1024) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for credit_limit_adjustment_applications
-- ----------------------------
DROP TABLE IF EXISTS `credit_limit_adjustment_applications`;
CREATE TABLE `credit_limit_adjustment_applications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country_id` int(11) NOT NULL,
  `adjustment_application_no` varchar(255) DEFAULT NULL,
  `credit_limit_no` varchar(255) DEFAULT NULL,
  `customer_no` varchar(255) DEFAULT NULL,
  `product_no` varchar(255) DEFAULT NULL,
  `credit_limit` decimal(16,2) DEFAULT NULL,
  `available_limit` decimal(16,2) DEFAULT NULL,
  `currency` varchar(255) DEFAULT NULL,
  `credit_limit_status` tinyint(4) DEFAULT NULL,
  `credit_option` tinyint(4) DEFAULT NULL,
  `application_type` tinyint(4) DEFAULT NULL,
  `application_status` tinyint(4) DEFAULT NULL,
  `application_time` timestamp NULL DEFAULT NULL,
  `application_source` tinyint(4) DEFAULT NULL,
  `approval_status` tinyint(4) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(255) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100054 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for credit_limit_adjustment_approvals
-- ----------------------------
DROP TABLE IF EXISTS `credit_limit_adjustment_approvals`;
CREATE TABLE `credit_limit_adjustment_approvals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `adjustment_application_no` varchar(255) NOT NULL,
  `approval_status` tinyint(4) DEFAULT NULL,
  `approval_method` tinyint(4) DEFAULT NULL,
  `adjusted_credit_limit` decimal(16,2) DEFAULT NULL,
  `adjusted_worthiness` int(11) DEFAULT NULL,
  `adjusted_credit_option` tinyint(4) DEFAULT NULL,
  `currency` varchar(255) DEFAULT NULL,
  `reject_reason` tinyint(4) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `approval_by` varchar(255) DEFAULT NULL,
  `approval_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100045 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for credit_limit_application_histories
-- ----------------------------
DROP TABLE IF EXISTS `credit_limit_application_histories`;
CREATE TABLE `credit_limit_application_histories` (
  `id` int(11) NOT NULL,
  `country_id` int(11) NOT NULL,
  `application_no` varchar(255) NOT NULL,
  `customer_no` varchar(36) NOT NULL,
  `product_no` varchar(32) NOT NULL,
  `application_time` timestamp NULL DEFAULT NULL,
  `application_status` tinyint(4) DEFAULT '0',
  `approval_status` tinyint(4) DEFAULT '0',
  `application_source` tinyint(4) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `application_no` (`application_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for credit_limit_applications
-- ----------------------------
DROP TABLE IF EXISTS `credit_limit_applications`;
CREATE TABLE `credit_limit_applications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country_id` int(11) NOT NULL,
  `application_no` varchar(255) NOT NULL,
  `customer_no` varchar(36) NOT NULL,
  `product_no` varchar(32) NOT NULL,
  `application_time` timestamp NULL DEFAULT NULL,
  `application_status` tinyint(4) DEFAULT '0',
  `approval_status` tinyint(4) DEFAULT '0',
  `application_source` tinyint(4) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(255) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `shop_now_data` text,
  `application_type` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `application_no` (`application_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=291952 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for credit_limit_approval_histories
-- ----------------------------
DROP TABLE IF EXISTS `credit_limit_approval_histories`;
CREATE TABLE `credit_limit_approval_histories` (
  `id` int(11) NOT NULL,
  `application_no` varchar(255) NOT NULL,
  `approval_status` tinyint(4) DEFAULT NULL,
  `credit_scoring_method` tinyint(4) DEFAULT NULL,
  `credit_option` tinyint(4) DEFAULT NULL,
  `worthiness` int(11) DEFAULT NULL,
  `credit_limit` decimal(16,2) DEFAULT NULL,
  `currency` varchar(8) DEFAULT NULL,
  `limit_validity_period` tinyint(4) DEFAULT NULL,
  `reject_reason` tinyint(4) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `approval_by` varchar(255) DEFAULT NULL,
  `approval_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `application_no` (`application_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for credit_limit_approvals
-- ----------------------------
DROP TABLE IF EXISTS `credit_limit_approvals`;
CREATE TABLE `credit_limit_approvals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `application_no` varchar(255) NOT NULL,
  `approval_status` tinyint(4) DEFAULT NULL,
  `credit_scoring_method` tinyint(4) DEFAULT NULL,
  `credit_option` tinyint(4) DEFAULT NULL,
  `worthiness` int(11) DEFAULT NULL,
  `credit_limit` decimal(16,2) DEFAULT NULL,
  `currency` varchar(8) DEFAULT NULL,
  `limit_validity_period` tinyint(4) DEFAULT NULL,
  `reject_reason` tinyint(4) DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL,
  `approval_by` varchar(255) DEFAULT NULL,
  `approval_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `application_no` (`application_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=244963 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for credit_limit_detail_histories
-- ----------------------------
DROP TABLE IF EXISTS `credit_limit_detail_histories`;
CREATE TABLE `credit_limit_detail_histories` (
  `id` int(11) NOT NULL,
  `country_id` int(10) NOT NULL,
  `credit_limit_no` varchar(64) NOT NULL,
  `application_no` varchar(64) NOT NULL,
  `customer_no` varchar(64) NOT NULL,
  `product_no` varchar(64) NOT NULL,
  `credit_limit` decimal(16,2) NOT NULL,
  `frozen_limit` decimal(16,2) NOT NULL,
  `available_limit` decimal(16,2) NOT NULL,
  `currency` varchar(8) DEFAULT NULL,
  `credit_limit_status` tinyint(4) NOT NULL,
  `credit_option` tinyint(4) DEFAULT NULL,
  `limit_activated_at` timestamp NULL DEFAULT NULL,
  `limit_deactivated_at` timestamp NULL DEFAULT NULL,
  `last_changed_by` varchar(64) DEFAULT NULL,
  `last_changed_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `application_no_uni` (`application_no`),
  UNIQUE KEY `credit_limit_no_uni` (`credit_limit_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for credit_limit_details
-- ----------------------------
DROP TABLE IF EXISTS `credit_limit_details`;
CREATE TABLE `credit_limit_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country_id` int(10) NOT NULL,
  `credit_limit_no` varchar(64) NOT NULL,
  `application_no` varchar(64) NOT NULL,
  `customer_no` varchar(64) NOT NULL,
  `product_no` varchar(64) NOT NULL,
  `credit_limit` decimal(16,2) NOT NULL,
  `frozen_limit` decimal(16,2) NOT NULL DEFAULT '0.00',
  `available_limit` decimal(16,2) NOT NULL,
  `currency` varchar(8) DEFAULT NULL,
  `credit_limit_status` tinyint(4) NOT NULL,
  `credit_option` tinyint(4) DEFAULT NULL,
  `limit_activated_at` timestamp NULL DEFAULT NULL,
  `limit_deactivated_at` timestamp NULL DEFAULT NULL,
  `last_changed_by` varchar(64) DEFAULT NULL,
  `last_changed_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `credit_limit_type` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `application_no_uni` (`application_no`),
  UNIQUE KEY `credit_limit_no_uni` (`credit_limit_no`)
) ENGINE=InnoDB AUTO_INCREMENT=146072 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for credit_limit_products
-- ----------------------------
DROP TABLE IF EXISTS `credit_limit_products`;
CREATE TABLE `credit_limit_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country_id` int(11) NOT NULL,
  `product_no` varchar(255) NOT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `product_status` tinyint(4) DEFAULT '0',
  `currency` varchar(255) DEFAULT NULL,
  `min_limit` decimal(16,2) DEFAULT NULL,
  `max_limit` decimal(16,2) DEFAULT NULL,
  `deposit` decimal(10,6) DEFAULT '0.000000',
  `limit_validity` tinyint(4) DEFAULT NULL,
  `effective_date` timestamp NULL DEFAULT NULL,
  `expiry_date` timestamp NULL DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(255) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_no` (`product_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=100025 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for credit_limit_status_change_applications
-- ----------------------------
DROP TABLE IF EXISTS `credit_limit_status_change_applications`;
CREATE TABLE `credit_limit_status_change_applications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `application_no` varchar(64) NOT NULL,
  `credit_limit_no` varchar(64) NOT NULL,
  `previous_credit_limit_status` tinyint(4) NOT NULL,
  `subsequent_credit_limit_status` tinyint(4) NOT NULL,
  `application_status` tinyint(4) NOT NULL DEFAULT '0',
  `remarks` varchar(255) DEFAULT NULL,
  `applicant` varchar(255) DEFAULT NULL,
  `approver` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=169 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for customer_basic_info
-- ----------------------------
DROP TABLE IF EXISTS `customer_basic_info`;
CREATE TABLE `customer_basic_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country_id` int(11) NOT NULL,
  `customer_no` varchar(64) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `id_type` tinyint(4) DEFAULT NULL,
  `id_number` varchar(64) DEFAULT NULL,
  `gender` tinyint(4) DEFAULT NULL,
  `marital_status` tinyint(4) DEFAULT NULL,
  `calling_code` varchar(8) DEFAULT NULL,
  `phone_number` varchar(32) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `customer_type` tinyint(4) DEFAULT NULL,
  `referral_source` tinyint(4) DEFAULT NULL,
  `step_reached` tinyint(4) DEFAULT '10' COMMENT '10:"id_verification" , 11:"personal_details" , 12:"facial_verification" , 13:"manual_review" , 14:"occupational_details" , 15:"next_of_kin" , 20:"verify_income" , 21:"under_review" , 22:"limit_reject" , 23:"extra_docs" , 24:"got_limit" , \r\n',
  `connected_bank` tinyint(4) DEFAULT '0',
  `musoni_client_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `risk_level` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_no` (`customer_no`) USING BTREE,
  UNIQUE KEY `email` (`email`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=305923 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for customer_documents
-- ----------------------------
DROP TABLE IF EXISTS `customer_documents`;
CREATE TABLE `customer_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_no` varchar(64) NOT NULL,
  `application_no` varchar(64) DEFAULT NULL,
  `doc_name` varchar(255) DEFAULT NULL,
  `doc_type` tinyint(4) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `file_url` varchar(2048) DEFAULT NULL,
  `file_password` varchar(255) DEFAULT NULL,
  `is_delete` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_extra_doc` tinyint(1) DEFAULT '0',
  `module` varchar(255) DEFAULT NULL,
  `file_type` varchar(255) DEFAULT NULL,
  `spin_mobile_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=933 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for customer_update_log
-- ----------------------------
DROP TABLE IF EXISTS `customer_update_log`;
CREATE TABLE `customer_update_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_no` varchar(255) NOT NULL,
  `field_name` varchar(255) NOT NULL,
  `old_value` varchar(255) NOT NULL,
  `new_value` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4695 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for customer_verification_reports
-- ----------------------------
DROP TABLE IF EXISTS `customer_verification_reports`;
CREATE TABLE `customer_verification_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_no` varchar(36) NOT NULL,
  `verification_type` tinyint(4) DEFAULT NULL,
  `result` tinyint(4) DEFAULT NULL,
  `request_data` varchar(255) DEFAULT NULL,
  `request_id` varchar(36) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_by_useremail` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=102970 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for employed_occupational_details
-- ----------------------------
DROP TABLE IF EXISTS `employed_occupational_details`;
CREATE TABLE `employed_occupational_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_no` varchar(36) NOT NULL,
  `employer` varchar(255) DEFAULT NULL,
  `industry` tinyint(4) DEFAULT NULL,
  `salary_payment_type` tinyint(4) DEFAULT NULL,
  `monthly_income` decimal(16,2) DEFAULT NULL,
  `monthly_expenses` decimal(16,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=222164 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for extra_doc_requests
-- ----------------------------
DROP TABLE IF EXISTS `extra_doc_requests`;
CREATE TABLE `extra_doc_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `application_no` varchar(255) NOT NULL,
  `extra_doc_type` int(11) NOT NULL,
  `date_created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=162 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for facial_result
-- ----------------------------
DROP TABLE IF EXISTS `facial_result`;
CREATE TABLE `facial_result` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_no` varchar(36) NOT NULL,
  `transaction_id` varchar(36) DEFAULT NULL,
  `match_result` tinyint(4) DEFAULT NULL,
  `channel` tinyint(4) DEFAULT NULL,
  `result_json` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100530 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for facial_result_document
-- ----------------------------
DROP TABLE IF EXISTS `facial_result_document`;
CREATE TABLE `facial_result_document` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_no` varchar(36) NOT NULL,
  `transaction_id` varchar(36) DEFAULT NULL,
  `module` varchar(255) DEFAULT NULL,
  `document_type` varchar(255) DEFAULT NULL,
  `document` longtext,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for facial_result_history
-- ----------------------------
DROP TABLE IF EXISTS `facial_result_history`;
CREATE TABLE `facial_result_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_no` varchar(36) NOT NULL,
  `transaction_id` varchar(36) DEFAULT NULL,
  `match_result` tinyint(4) DEFAULT NULL,
  `channel` tinyint(4) DEFAULT NULL,
  `result_json` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100055 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for facial_result_test
-- ----------------------------
DROP TABLE IF EXISTS `facial_result_test`;
CREATE TABLE `facial_result_test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_no` varchar(36) NOT NULL,
  `transaction_id` varchar(36) DEFAULT NULL,
  `match_result` tinyint(4) DEFAULT NULL,
  `channel` tinyint(4) DEFAULT NULL,
  `result_json` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `customer` (`customer_no`),
  CONSTRAINT `customer` FOREIGN KEY (`customer_no`) REFERENCES `customer_basic_info` (`customer_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for hyperverge_profiles
-- ----------------------------
DROP TABLE IF EXISTS `hyperverge_profiles`;
CREATE TABLE `hyperverge_profiles` (
  `transaction_id` varchar(36) NOT NULL,
  `customer_no` varchar(36) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `date_of_birth` varchar(255) DEFAULT NULL,
  `date_of_issue` varchar(255) DEFAULT NULL,
  `date_of_expiry` varchar(255) DEFAULT NULL,
  `country_code` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `address` text,
  `gender` varchar(255) DEFAULT NULL,
  `id_number` varchar(255) DEFAULT NULL,
  `place_of_birth` varchar(255) DEFAULT NULL,
  `place_of_issue` varchar(255) DEFAULT NULL,
  `year_of_birth` varchar(255) DEFAULT NULL,
  `age` varchar(255) DEFAULT NULL,
  `father_name` varchar(255) DEFAULT NULL,
  `mother_name` varchar(255) DEFAULT NULL,
  `husband_name` varchar(255) DEFAULT NULL,
  `spouse_name` varchar(255) DEFAULT NULL,
  `nationality` varchar(255) DEFAULT NULL,
  `home_town` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for invoice_payee
-- ----------------------------
DROP TABLE IF EXISTS `invoice_payee`;
CREATE TABLE `invoice_payee` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `country_id` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime DEFAULT NULL,
  `payee_type` smallint(6) DEFAULT NULL,
  `payee_name` varchar(255) DEFAULT NULL,
  `payee_number` varchar(255) DEFAULT NULL,
  `payee_code` varchar(255) DEFAULT NULL,
  `account_number` varchar(255) DEFAULT NULL,
  `delete_status` int(11) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for invoice_payment_notes
-- ----------------------------
DROP TABLE IF EXISTS `invoice_payment_notes`;
CREATE TABLE `invoice_payment_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country_id` int(11) DEFAULT NULL,
  `invoice_no` varchar(255) NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  `created_by_id` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for invoice_payments
-- ----------------------------
DROP TABLE IF EXISTS `invoice_payments`;
CREATE TABLE `invoice_payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country_id` int(11) DEFAULT NULL,
  `invoice_no` varchar(255) DEFAULT NULL,
  `invoice_payment_no` varchar(255) DEFAULT NULL,
  `customer_no` varchar(255) NOT NULL,
  `amount` decimal(10,0) DEFAULT NULL,
  `supplier_name` varchar(255) DEFAULT NULL,
  `approved_by_id` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `approval_time` datetime DEFAULT NULL,
  `payee_number` varchar(255) DEFAULT NULL,
  `transaction_no` varchar(255) DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `payment_due_date` datetime DEFAULT NULL,
  `payment_confirmation_no` varchar(255) DEFAULT NULL,
  `loan_product_id` int(11) DEFAULT NULL,
  `loan_application_no` varchar(255) DEFAULT NULL,
  `topup_fee` int(11) DEFAULT NULL,
  `payment_option` varchar(50) DEFAULT NULL,
  `paid_by` varchar(255) DEFAULT NULL,
  `proof_of_payment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for invoice_prepayment_info
-- ----------------------------
DROP TABLE IF EXISTS `invoice_prepayment_info`;
CREATE TABLE `invoice_prepayment_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country_id` int(11) DEFAULT NULL,
  `customer_no` varchar(255) DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `reference_no` varchar(25) DEFAULT NULL,
  `transaction_type` int(11) DEFAULT NULL,
  `transaction_id` varchar(255) DEFAULT NULL,
  `total_fee` decimal(10,0) NOT NULL,
  `amount_paid` decimal(10,0) DEFAULT NULL,
  `date_paid` datetime DEFAULT NULL,
  `payment_ref` varchar(255) DEFAULT NULL,
  `pay_method` int(11) DEFAULT NULL,
  `pay_channel` int(11) DEFAULT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `request_json` text,
  `error_msg` varchar(255) DEFAULT NULL,
  `response_json` text,
  `callback_json` text,
  `retry_counter` int(11) DEFAULT '0',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for invoices
-- ----------------------------
DROP TABLE IF EXISTS `invoices`;
CREATE TABLE `invoices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country_id` int(11) DEFAULT NULL,
  `invoice_no` varchar(255) NOT NULL,
  `customer_no` varchar(255) NOT NULL,
  `document_url` varchar(255) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `date_updated` datetime DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `supplier_name` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `payment_due_date` datetime DEFAULT NULL,
  `invoice_ref` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `financing_option` varchar(255) DEFAULT NULL,
  `rejection_reason` varchar(500) DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for lendiron_loan_products
-- ----------------------------
DROP TABLE IF EXISTS `lendiron_loan_products`;
CREATE TABLE `lendiron_loan_products` (
  `id` int(11) NOT NULL,
  `product_code` varchar(255) NOT NULL,
  `currency` varchar(16) DEFAULT 'KES',
  `number_of_installments` int(11) DEFAULT NULL,
  `interest_rate` decimal(10,6) DEFAULT NULL,
  `upfront_fee` decimal(10,6) DEFAULT '0.000000',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for limit_related_loan
-- ----------------------------
DROP TABLE IF EXISTS `limit_related_loan`;
CREATE TABLE `limit_related_loan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `limit_product_no` varchar(255) DEFAULT NULL,
  `loan_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `min_principal` decimal(10,0) DEFAULT NULL,
  `max_principal` decimal(10,0) DEFAULT NULL,
  `interest_rate_period` decimal(10,0) DEFAULT NULL,
  `no_of_repayments` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ll_limit_loan` (`limit_product_no`,`loan_id`),
  KEY `ll_loan_id` (`loan_id`),
  CONSTRAINT `ll_limit_product_no` FOREIGN KEY (`limit_product_no`) REFERENCES `credit_limit_products` (`product_no`),
  CONSTRAINT `ll_loan_id` FOREIGN KEY (`loan_id`) REFERENCES `loan_products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100094 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for loan_application_details
-- ----------------------------
DROP TABLE IF EXISTS `loan_application_details`;
CREATE TABLE `loan_application_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country_id` int(11) NOT NULL,
  `loan_application_no` varchar(64) NOT NULL,
  `customer_no` varchar(64) NOT NULL,
  `credit_limit_no` varchar(64) DEFAULT NULL,
  `credit_limit` decimal(16,2) DEFAULT NULL,
  `available_limit` decimal(16,2) DEFAULT NULL,
  `principal_amount` decimal(16,2) NOT NULL,
  `deposit_amount` decimal(16,2) NOT NULL DEFAULT '0.00',
  `upfront_fee` decimal(16,2) NOT NULL DEFAULT '0.00',
  `currency` varchar(8) DEFAULT NULL,
  `loan_application_status` tinyint(4) NOT NULL DEFAULT '0',
  `loan_id` int(11) DEFAULT NULL,
  `loan_product_id` int(11) DEFAULT NULL,
  `interest_rate` decimal(16,6) DEFAULT NULL,
  `disbursement_date` date DEFAULT NULL,
  `loan_term_frequency` int(11) DEFAULT NULL COMMENT 'Used together with loanTermFrequencyType to indicate the term of the loan.',
  `loan_term_frequency_type` tinyint(4) DEFAULT '2' COMMENT 'Used together with loanTermFrequency to indicate the term of the loan.\r\nSupported options are: 0=Days 1=Weeks 2=Months 3=Years',
  `amortization_type` tinyint(4) DEFAULT '1' COMMENT 'Selecting 0=Equal Principal ensures that the principal of the loan installment remains the same through the loan term (with the interest and installment size therefore declining).\r\nSelecting 1=Equal Installments ensures the principal is adjusted to ensure equal installment sizes.',
  `transaction_processing_strategy_id` tinyint(4) DEFAULT '1' COMMENT 'Supported options are: 1=Standard (Penalties, Fees, Interest, Principal order) 5=Principal, Interest, Penalties, Fees Order 6=Interest, Principal, Penalties, Fees Order',
  `order_no` varchar(255) DEFAULT NULL,
  `referral_source` tinyint(4) DEFAULT NULL,
  `is_lendiron` bit(1) DEFAULT b'0',
  `remark` varchar(255) DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101951 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for loan_charges
-- ----------------------------
DROP TABLE IF EXISTS `loan_charges`;
CREATE TABLE `loan_charges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `loan_application_no` varchar(255) NOT NULL,
  `loan_id` int(11) DEFAULT NULL,
  `charge_type` tinyint(4) DEFAULT NULL,
  `charge_amount` varchar(255) DEFAULT NULL,
  `is_charged` bit(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101083 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for loan_products
-- ----------------------------
DROP TABLE IF EXISTS `loan_products`;
CREATE TABLE `loan_products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `short_name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `fund_id` int(11) DEFAULT NULL,
  `fund_name` varchar(255) DEFAULT NULL,
  `include_in_borrower_cycle` bit(1) DEFAULT NULL,
  `use_borrower_cycle` bit(1) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `product_group` varchar(255) DEFAULT NULL,
  `currency` varchar(255) DEFAULT NULL,
  `principal` decimal(16,6) DEFAULT NULL,
  `min_principal` decimal(16,6) DEFAULT NULL,
  `max_principal` decimal(16,6) DEFAULT NULL,
  `number_of_repayments` int(11) DEFAULT NULL,
  `min_number_of_repayments` int(11) DEFAULT NULL,
  `max_number_of_repayments` int(11) DEFAULT NULL,
  `repayment_every` int(11) DEFAULT NULL,
  `repayment_frequency_type` int(11) DEFAULT NULL,
  `interest_rate_per_period` decimal(16,6) DEFAULT NULL,
  `min_interest_rate_per_period` decimal(16,6) DEFAULT NULL,
  `max_interest_rate_per_period` decimal(16,6) DEFAULT NULL,
  `interest_rate_frequency_type` varchar(255) DEFAULT NULL,
  `annual_interest_rate` decimal(16,6) DEFAULT NULL,
  `is_linked_to_floating_interest_rates` bit(1) DEFAULT NULL,
  `is_floating_interest_rate_calculation_allowed` bit(1) DEFAULT NULL,
  `allow_variable_installments` bit(1) DEFAULT NULL,
  `minimum_gap` int(11) DEFAULT NULL,
  `maximum_gap` int(11) DEFAULT NULL,
  `amortization_type` int(11) DEFAULT NULL,
  `interest_type` int(11) DEFAULT NULL,
  `interest_calculation_period_type` int(11) DEFAULT NULL,
  `allow_partial_period_interest_calcualtion` bit(1) DEFAULT NULL,
  `in_arrears_tolerance` int(11) DEFAULT NULL,
  `transaction_processing_strategy_id` int(11) DEFAULT NULL,
  `transaction_processing_strategy_name` varchar(255) DEFAULT NULL,
  `overdue_days_for_npa` int(11) DEFAULT NULL,
  `days_in_month_type` varchar(255) DEFAULT NULL,
  `days_in_year_type` varchar(255) DEFAULT NULL,
  `is_interest_recalculation_enabled` bit(1) DEFAULT NULL,
  `minimum_days_between_disbursal_and_first_repayment` int(11) DEFAULT NULL,
  `can_define_installment_amount` bit(1) DEFAULT NULL,
  `installment_amount_in_multiples_of` int(11) DEFAULT NULL,
  `reverse_overdue_days_npainterest` bit(1) DEFAULT NULL,
  `can_auto_allocate_overpayments` bit(1) DEFAULT NULL,
  `in_duplum` bit(1) DEFAULT NULL,
  `auto_disburse` bit(1) DEFAULT NULL,
  `requires_mandatory_savings` bit(1) DEFAULT NULL,
  `requires_linked_savings_account` bit(1) DEFAULT NULL,
  `check_number` varchar(255) DEFAULT NULL,
  `receipt_number` varchar(255) DEFAULT NULL,
  `accounting_rule` varchar(255) DEFAULT NULL,
  `can_use_for_topup` bit(1) DEFAULT NULL,
  `multi_disburse_loan` bit(1) DEFAULT NULL,
  `max_tranche_count` int(11) DEFAULT NULL,
  `principal_threshold_for_last_installment` decimal(16,2) DEFAULT NULL,
  `hold_guarantee_funds` bit(1) DEFAULT NULL,
  `account_moves_out_of_npaonly_on_arrears_completion` bit(1) DEFAULT NULL,
  `sync_expected_with_disbursement_date` bit(1) DEFAULT NULL,
  `repay_principal_every` int(11) DEFAULT NULL,
  `repay_interest_every` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for loan_related_charge
-- ----------------------------
DROP TABLE IF EXISTS `loan_related_charge`;
CREATE TABLE `loan_related_charge` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `loan_id` int(11) DEFAULT NULL,
  `charge_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lc_loan_charge` (`loan_id`,`charge_id`),
  KEY `lc_charge_id` (`charge_id`),
  CONSTRAINT `lc_charge_id` FOREIGN KEY (`charge_id`) REFERENCES `charges` (`id`),
  CONSTRAINT `lc_loan_id` FOREIGN KEY (`loan_id`) REFERENCES `loan_products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100196 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for loan_repayment_in_lieu
-- ----------------------------
DROP TABLE IF EXISTS `loan_repayment_in_lieu`;
CREATE TABLE `loan_repayment_in_lieu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) DEFAULT NULL,
  `loan_id` int(11) DEFAULT NULL,
  `loan_product_id` int(11) DEFAULT NULL,
  `loan_product_name` varchar(255) DEFAULT NULL,
  `number_of_repayments` int(11) DEFAULT NULL,
  `disbursement_date` date DEFAULT NULL,
  `maturity_date` date DEFAULT NULL,
  `outstanding_balance` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10070 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for mono_detail
-- ----------------------------
DROP TABLE IF EXISTS `mono_detail`;
CREATE TABLE `mono_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_no` varchar(32) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `account_id` varchar(255) DEFAULT NULL,
  `data_status` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `balance` varchar(255) DEFAULT NULL,
  `currency` varchar(255) DEFAULT NULL,
  `account_number` varchar(255) DEFAULT NULL,
  `bank_name` varchar(255) DEFAULT NULL,
  `bank_code` varchar(255) DEFAULT NULL,
  `bank_type` varchar(255) DEFAULT NULL,
  `transactions` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for mono_statement_detail
-- ----------------------------
DROP TABLE IF EXISTS `mono_statement_detail`;
CREATE TABLE `mono_statement_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mono_detail_id` int(11) DEFAULT NULL,
  `_id` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `narration` varchar(255) DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL,
  `balance` int(11) DEFAULT NULL,
  `currency` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mono_detail_id` (`mono_detail_id`),
  CONSTRAINT `mono_statement_detail_ibfk_1` FOREIGN KEY (`mono_detail_id`) REFERENCES `mono_detail` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20453 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for musoni_account_transfer
-- ----------------------------
DROP TABLE IF EXISTS `musoni_account_transfer`;
CREATE TABLE `musoni_account_transfer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from_office_id` int(11) DEFAULT NULL,
  `from_client_id` int(11) DEFAULT NULL,
  `from_account_type` int(11) DEFAULT NULL,
  `from_account_id` int(11) DEFAULT NULL,
  `to_office_id` int(11) DEFAULT NULL,
  `to_client_id` int(11) DEFAULT NULL,
  `to_account_type` int(11) DEFAULT NULL,
  `to_account_id` int(11) DEFAULT NULL,
  `resource_id` int(11) DEFAULT NULL,
  `transfer_date` date DEFAULT NULL,
  `transfer_amount` decimal(10,2) DEFAULT NULL,
  `transfer_description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10647 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for musoni_clients
-- ----------------------------
DROP TABLE IF EXISTS `musoni_clients`;
CREATE TABLE `musoni_clients` (
  `id` int(11) NOT NULL,
  `account_no` varchar(255) DEFAULT NULL,
  `external_id` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `active` tinyint(4) DEFAULT NULL,
  `activation_date` date DEFAULT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `middlename` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `mobile_no` varchar(255) DEFAULT NULL,
  `mobile_no_secondary` varchar(255) DEFAULT NULL,
  `email_address` varchar(255) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `office_id` int(11) DEFAULT NULL,
  `office_name` varchar(255) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `staff_name` varchar(255) DEFAULT NULL,
  `country_iso_code` varchar(255) DEFAULT NULL,
  `origin_channel` varchar(255) DEFAULT NULL,
  `is_staff` tinyint(4) DEFAULT NULL,
  `created_on_timestamp` timestamp NULL DEFAULT NULL,
  `created_by_username` varchar(255) DEFAULT NULL,
  `last_modified_on_timestamp` timestamp NULL DEFAULT NULL,
  `last_modified_by_username` varchar(255) DEFAULT NULL,
  `submitted_on_date` date DEFAULT NULL,
  `submitted_by_username` varchar(255) DEFAULT NULL,
  `submitted_by_firstname` varchar(255) DEFAULT NULL,
  `submitted_by_lastname` varchar(255) DEFAULT NULL,
  `activated_on_date` date DEFAULT NULL,
  `activated_by_username` varchar(255) DEFAULT NULL,
  `activated_by_firstname` varchar(255) DEFAULT NULL,
  `activated_by_lastname` varchar(255) DEFAULT NULL,
  `closed_on_date` date DEFAULT NULL,
  `closed_by_username` varchar(255) DEFAULT NULL,
  `closed_by_firstname` varchar(255) DEFAULT NULL,
  `closed_by_lastname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for musoni_loan_charges
-- ----------------------------
DROP TABLE IF EXISTS `musoni_loan_charges`;
CREATE TABLE `musoni_loan_charges` (
  `id` int(11) NOT NULL,
  `loan_id` int(11) DEFAULT NULL,
  `charge_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `charge_time_type` varchar(255) DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `charge_calculation_type` varchar(255) DEFAULT NULL,
  `percentage` decimal(16,6) DEFAULT NULL,
  `amount_percentage_applied_to` decimal(16,6) DEFAULT NULL,
  `currency` varchar(255) DEFAULT NULL,
  `amount` decimal(16,6) DEFAULT '0.000000',
  `amount_paid` decimal(16,6) DEFAULT '0.000000',
  `amount_waived` decimal(16,6) DEFAULT '0.000000',
  `amount_written_off` decimal(16,6) DEFAULT '0.000000',
  `amount_outstanding` decimal(16,6) DEFAULT '0.000000',
  `amount_or_percentage` decimal(16,6) DEFAULT '0.000000',
  `penalty` tinyint(4) DEFAULT NULL,
  `charge_payment_mode` varchar(255) DEFAULT NULL,
  `paid` tinyint(4) DEFAULT NULL,
  `waived` tinyint(4) DEFAULT NULL,
  `charge_payable` tinyint(4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for musoni_loan_period
-- ----------------------------
DROP TABLE IF EXISTS `musoni_loan_period`;
CREATE TABLE `musoni_loan_period` (
  `loan_id` int(11) NOT NULL,
  `period` int(11) NOT NULL DEFAULT '0',
  `from_date` date DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `complete` tinyint(4) DEFAULT NULL,
  `days_in_period` int(11) DEFAULT NULL,
  `principal_original_due` decimal(16,6) DEFAULT '0.000000',
  `principal_due` decimal(16,6) DEFAULT '0.000000',
  `principal_paid` decimal(16,6) DEFAULT '0.000000',
  `principal_written_off` decimal(16,6) DEFAULT '0.000000',
  `principal_outstanding` decimal(16,6) DEFAULT '0.000000',
  `principal_loan_balance_outstanding` decimal(16,6) DEFAULT '0.000000',
  `interest_original_due` decimal(16,6) DEFAULT '0.000000',
  `interest_due` decimal(16,6) DEFAULT '0.000000',
  `interest_paid` decimal(16,6) DEFAULT '0.000000',
  `interest_waived` decimal(16,6) DEFAULT '0.000000',
  `interest_written_off` decimal(16,6) DEFAULT '0.000000',
  `interest_outstanding` decimal(16,6) DEFAULT '0.000000',
  `fee_charges_due` decimal(16,6) DEFAULT '0.000000',
  `fee_charges_paid` decimal(16,6) DEFAULT '0.000000',
  `fee_charges_waived` decimal(16,6) DEFAULT '0.000000',
  `fee_charges_written_off` decimal(16,6) DEFAULT '0.000000',
  `fee_charges_outstanding` decimal(16,6) DEFAULT '0.000000',
  `penalty_charges_due` decimal(16,6) DEFAULT '0.000000',
  `penalty_charges_paid` decimal(16,6) DEFAULT '0.000000',
  `penalty_charges_waived` decimal(16,6) DEFAULT '0.000000',
  `penalty_charges_written_off` decimal(16,6) DEFAULT '0.000000',
  `penalty_charges_outstanding` decimal(16,6) DEFAULT '0.000000',
  `total_original_due_for_period` decimal(16,6) DEFAULT '0.000000',
  `total_due_for_period` decimal(16,6) DEFAULT '0.000000',
  `total_paid_for_period` decimal(16,6) DEFAULT '0.000000',
  `total_paid_in_advance_for_period` decimal(16,6) DEFAULT '0.000000',
  `total_paid_late_for_period` decimal(16,6) DEFAULT '0.000000',
  `total_waived_for_period` decimal(16,6) DEFAULT '0.000000',
  `total_written_off_for_period` decimal(16,6) DEFAULT '0.000000',
  `total_outstanding_for_period` decimal(16,6) DEFAULT '0.000000',
  `total_overdue` decimal(16,6) DEFAULT '0.000000',
  `total_actual_cost_of_loan_for_period` decimal(16,6) DEFAULT '0.000000',
  `total_installment_amount_for_period` decimal(16,6) DEFAULT '0.000000',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`loan_id`,`period`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for musoni_loan_repayment
-- ----------------------------
DROP TABLE IF EXISTS `musoni_loan_repayment`;
CREATE TABLE `musoni_loan_repayment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `office_id` int(11) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `loan_id` int(11) DEFAULT NULL,
  `resource_id` int(11) DEFAULT NULL,
  `loan_transaction_id` int(11) DEFAULT NULL,
  `transaction_date` date DEFAULT NULL,
  `transaction_amount` decimal(10,2) DEFAULT NULL,
  `is_loan_prepayment` tinyint(1) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100070 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for musoni_loan_transactions
-- ----------------------------
DROP TABLE IF EXISTS `musoni_loan_transactions`;
CREATE TABLE `musoni_loan_transactions` (
  `id` int(11) NOT NULL,
  `loan_id` int(11) NOT NULL,
  `office_id` int(11) DEFAULT NULL,
  `office_name` varchar(255) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  `type_code` varchar(255) DEFAULT NULL,
  `type_value` varchar(255) DEFAULT NULL,
  `type_disbursement` tinyint(4) DEFAULT NULL,
  `type_repayment_at_disbursement` tinyint(4) DEFAULT NULL,
  `type_repayment` tinyint(4) DEFAULT NULL,
  `type_contra` tinyint(4) DEFAULT NULL,
  `type_waive_interest` tinyint(4) DEFAULT NULL,
  `type_waive_charges` tinyint(4) DEFAULT NULL,
  `type_accrual` tinyint(4) DEFAULT NULL,
  `type_write_off` tinyint(4) DEFAULT NULL,
  `type_recovery_repayment` tinyint(4) DEFAULT NULL,
  `type_initiate_transfer` tinyint(4) DEFAULT NULL,
  `type_approve_transfer` tinyint(4) DEFAULT NULL,
  `type_withdraw_transfer` tinyint(4) DEFAULT NULL,
  `type_reject_transfer` tinyint(4) DEFAULT NULL,
  `type_charge_payment` tinyint(4) DEFAULT NULL,
  `type_refund` tinyint(4) DEFAULT NULL,
  `type_refund_for_active_loans` tinyint(4) DEFAULT NULL,
  `type_suspended_income` tinyint(4) DEFAULT NULL,
  `type_reverse_suspended_income` tinyint(4) DEFAULT NULL,
  `transaction_date` date DEFAULT NULL,
  `currency` varchar(255) DEFAULT NULL,
  `amount` decimal(16,6) DEFAULT NULL,
  `principal_portion` decimal(16,6) DEFAULT NULL,
  `interest_portion` decimal(16,6) DEFAULT NULL,
  `fee_charges_portion` decimal(16,6) DEFAULT NULL,
  `penalty_charges_portion` decimal(16,6) DEFAULT NULL,
  `overpayment_portion` decimal(16,6) DEFAULT NULL,
  `unrecognized_income_portion` decimal(16,6) DEFAULT NULL,
  `outstanding_loan_balance` decimal(16,6) DEFAULT NULL,
  `submitted_on_date` date DEFAULT NULL,
  `manually_reversed` tinyint(4) DEFAULT NULL,
  `is_reversed` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for musoni_loans
-- ----------------------------
DROP TABLE IF EXISTS `musoni_loans`;
CREATE TABLE `musoni_loans` (
  `id` int(11) NOT NULL,
  `account_no` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `client_account_no` varchar(255) DEFAULT NULL,
  `client_name` varchar(255) DEFAULT NULL,
  `client_office_id` int(11) DEFAULT NULL,
  `loan_product_id` int(11) DEFAULT NULL,
  `loan_product_name` varchar(255) DEFAULT NULL,
  `loan_product_description` varchar(255) DEFAULT NULL,
  `is_loan_product_linked_to_floating_rate` tinyint(4) DEFAULT NULL,
  `fund_id` int(11) DEFAULT NULL,
  `fund_name` varchar(255) DEFAULT NULL,
  `loan_officer_id` int(11) DEFAULT NULL,
  `loan_officer_name` varchar(255) DEFAULT NULL,
  `loan_type` varchar(255) DEFAULT NULL,
  `currency` varchar(255) DEFAULT NULL,
  `principal` decimal(16,6) DEFAULT NULL,
  `approved_principal` decimal(16,6) DEFAULT NULL,
  `proposed_principal` decimal(16,6) DEFAULT NULL,
  `term_frequency` int(11) DEFAULT NULL,
  `term_period_frequency_type` varchar(255) DEFAULT NULL,
  `number_of_repayments` int(11) DEFAULT NULL,
  `repayment_every` int(11) DEFAULT NULL,
  `repayment_frequency_type` varchar(255) DEFAULT NULL,
  `interest_rate_per_period` decimal(10,6) DEFAULT NULL,
  `interest_rate_frequency_type` varchar(255) DEFAULT NULL,
  `annual_interest_rate` decimal(10,6) DEFAULT NULL,
  `is_floating_interest_rate` tinyint(4) DEFAULT NULL,
  `amortization_type` varchar(255) DEFAULT NULL,
  `interest_type` varchar(255) DEFAULT NULL,
  `interest_calculation_period_type` varchar(255) DEFAULT NULL,
  `allow_partial_period_interest_calcualtion` tinyint(4) DEFAULT NULL,
  `transaction_processing_strategy_id` int(11) DEFAULT NULL,
  `transaction_processing_strategy_name` varchar(255) DEFAULT NULL,
  `expected_first_repayment_on_date` date DEFAULT NULL,
  `sync_disbursement_with_meeting` tinyint(4) DEFAULT NULL,
  `principal_disbursed` decimal(16,6) DEFAULT NULL,
  `principal_paid` decimal(16,6) DEFAULT NULL,
  `principal_written_off` decimal(16,6) DEFAULT NULL,
  `principal_outstanding` decimal(16,6) DEFAULT NULL,
  `principal_overdue` int(11) DEFAULT NULL,
  `interest_charged` decimal(16,6) DEFAULT NULL,
  `interest_paid` decimal(16,6) DEFAULT NULL,
  `interest_waived` decimal(16,6) DEFAULT NULL,
  `interest_written_off` decimal(16,6) DEFAULT NULL,
  `interest_outstanding` decimal(16,6) DEFAULT NULL,
  `interest_overdue` int(11) DEFAULT NULL,
  `fee_charges_charged` decimal(16,6) DEFAULT NULL,
  `fee_charges_due_at_disbursement_charged` decimal(16,6) DEFAULT NULL,
  `fee_charges_paid` decimal(16,6) DEFAULT NULL,
  `fee_charges_waived` decimal(16,6) DEFAULT NULL,
  `fee_charges_written_off` decimal(16,6) DEFAULT NULL,
  `fee_charges_outstanding` decimal(16,6) DEFAULT NULL,
  `fee_charges_overdue` int(11) DEFAULT NULL,
  `penalty_charges_charged` decimal(16,6) DEFAULT NULL,
  `penalty_charges_paid` decimal(16,6) DEFAULT NULL,
  `penalty_charges_waived` decimal(16,6) DEFAULT NULL,
  `penalty_charges_written_off` decimal(16,6) DEFAULT NULL,
  `penalty_charges_outstanding` decimal(16,6) DEFAULT NULL,
  `penalty_charges_overdue` decimal(16,6) DEFAULT NULL,
  `total_expected_repayment` decimal(16,6) DEFAULT NULL,
  `total_repayment` decimal(16,6) DEFAULT NULL,
  `total_expected_cost_of_loan` decimal(16,6) DEFAULT NULL,
  `total_cost_of_loan` decimal(16,6) DEFAULT NULL,
  `total_waived` decimal(16,6) DEFAULT NULL,
  `total_written_off` decimal(16,6) DEFAULT NULL,
  `total_recovered` int(11) DEFAULT NULL,
  `total_outstanding` decimal(16,6) DEFAULT NULL,
  `total_overdue` int(11) DEFAULT NULL,
  `fee_charges_at_disbursement_charged` decimal(16,6) DEFAULT NULL,
  `loan_counter` int(11) DEFAULT NULL,
  `loan_product_counter` int(11) DEFAULT NULL,
  `multi_disburse_loan` tinyint(4) DEFAULT NULL,
  `can_define_installment_amount` tinyint(4) DEFAULT NULL,
  `can_disburse` tinyint(4) DEFAULT NULL,
  `can_use_for_topup` tinyint(4) DEFAULT NULL,
  `is_topup` tinyint(4) DEFAULT NULL,
  `closure_loan_id` int(11) DEFAULT NULL,
  `in_arrears` tinyint(4) DEFAULT NULL,
  `is_npa` tinyint(4) DEFAULT NULL,
  `days_in_month_type` varchar(255) DEFAULT NULL,
  `days_in_year_type` varchar(255) DEFAULT NULL,
  `is_interest_recalculation_enabled` tinyint(4) DEFAULT NULL,
  `create_standing_instruction_at_disbursement` tinyint(4) DEFAULT NULL,
  `is_variable_installments_allowed` tinyint(4) DEFAULT NULL,
  `minimum_gap` int(11) DEFAULT NULL,
  `maximum_gap` int(11) DEFAULT NULL,
  `internal_rate_of_return` decimal(16,6) DEFAULT NULL,
  `effective_interest_rate` decimal(16,6) DEFAULT NULL,
  `repay_principal_every` int(11) DEFAULT NULL,
  `repay_interest_every` int(11) DEFAULT NULL,
  `is_in_duplum` tinyint(4) DEFAULT NULL,
  `origin_channel` varchar(255) DEFAULT NULL,
  `office_id` int(11) DEFAULT NULL,
  `office_name` varchar(255) DEFAULT NULL,
  `created_on_timestamp` timestamp NULL DEFAULT NULL,
  `created_by_username` varchar(255) DEFAULT NULL,
  `last_modified_on_timestamp` timestamp NULL DEFAULT NULL,
  `last_modified_by_username` varchar(255) DEFAULT NULL,
  `stop_applying_penalty` tinyint(4) DEFAULT NULL,
  `submitted_on_date` date DEFAULT NULL,
  `submitted_by_username` varchar(255) DEFAULT NULL,
  `submitted_by_firstname` varchar(255) DEFAULT NULL,
  `submitted_by_lastname` varchar(255) DEFAULT NULL,
  `approved_on_date` date DEFAULT NULL,
  `approved_by_username` varchar(255) DEFAULT NULL,
  `approved_by_firstname` varchar(255) DEFAULT NULL,
  `approved_by_lastname` varchar(255) DEFAULT NULL,
  `expected_disbursement_date` date DEFAULT NULL,
  `actual_disbursement_date` date DEFAULT NULL,
  `disbursed_by_username` varchar(255) DEFAULT NULL,
  `disbursed_by_firstname` varchar(255) DEFAULT NULL,
  `disbursed_by_lastname` varchar(255) DEFAULT NULL,
  `closed_on_date` date DEFAULT NULL,
  `expected_maturity_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for musoni_offices
-- ----------------------------
DROP TABLE IF EXISTS `musoni_offices`;
CREATE TABLE `musoni_offices` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `name_decorated` varchar(255) DEFAULT NULL,
  `external_id` varchar(255) DEFAULT NULL,
  `opening_date` date DEFAULT NULL,
  `hierarchy` varchar(255) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `parent_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for musoni_repayment_schedule
-- ----------------------------
DROP TABLE IF EXISTS `musoni_repayment_schedule`;
CREATE TABLE `musoni_repayment_schedule` (
  `loan_id` int(11) NOT NULL,
  `currency` varchar(255) DEFAULT NULL,
  `loan_term_in_days` int(11) DEFAULT '0',
  `total_principal_disbursed` decimal(16,6) DEFAULT '0.000000',
  `total_principal_expected` decimal(16,6) DEFAULT '0.000000',
  `total_principal_paid` decimal(16,6) DEFAULT '0.000000',
  `total_interest_charged` decimal(16,6) DEFAULT '0.000000',
  `total_fee_charges_charged` decimal(16,6) DEFAULT '0.000000',
  `total_penalty_charges_charged` decimal(16,6) DEFAULT '0.000000',
  `total_waived` decimal(16,6) DEFAULT '0.000000',
  `total_written_off` decimal(16,6) DEFAULT '0.000000',
  `total_repayment_expected` decimal(16,6) DEFAULT '0.000000',
  `total_repayment` decimal(16,6) DEFAULT '0.000000',
  `total_paid_in_advance` decimal(16,6) DEFAULT '0.000000',
  `total_paid_late` decimal(16,6) DEFAULT '0.000000',
  `total_outstanding` decimal(16,6) DEFAULT '0.000000',
  `internal_rate_of_return` decimal(16,6) DEFAULT '0.000000',
  `effective_rate_of_return` decimal(16,6) DEFAULT '0.000000',
  `total_fee_charged_added_to_principal` decimal(16,6) DEFAULT '0.000000',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`loan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for musoni_staff
-- ----------------------------
DROP TABLE IF EXISTS `musoni_staff`;
CREATE TABLE `musoni_staff` (
  `id` int(11) NOT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `office_id` int(11) DEFAULT NULL,
  `office_name` varchar(255) DEFAULT NULL,
  `is_loan_officer` tinyint(4) DEFAULT NULL,
  `is_active` tinyint(4) DEFAULT NULL,
  `joining_date` date DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for next_of_kin_details
-- ----------------------------
DROP TABLE IF EXISTS `next_of_kin_details`;
CREATE TABLE `next_of_kin_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_no` varchar(36) DEFAULT NULL,
  `relationship` tinyint(4) DEFAULT NULL COMMENT '0:"father" , 1:"mother" , 2:"grandfather" , 3:"grandmother" , 4:"aunty" , 5:"uncle" , 6:"guardian" , 7:"partner" , 8:"spouse" , 9:"friend" , 10:"son" , 11:"daughter" , 12:"niece" , 13:"nephew" , 14:"cousin"',
  `full_name` varchar(255) DEFAULT NULL,
  `calling_code` varchar(8) DEFAULT NULL,
  `phone_number` varchar(24) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=190635 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for operate_log
-- ----------------------------
DROP TABLE IF EXISTS `operate_log`;
CREATE TABLE `operate_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `log_type` int(10) DEFAULT NULL COMMENT '0-add 1-modifiy',
  `business_type` int(10) DEFAULT NULL COMMENT 'business type',
  `business_id` varchar(200) DEFAULT NULL COMMENT 'business id',
  `create_by` varchar(50) DEFAULT NULL COMMENT 'create by user id',
  `create_name` varchar(200) DEFAULT NULL COMMENT 'create by username',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `remarks` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for operate_log_detail
-- ----------------------------
DROP TABLE IF EXISTS `operate_log_detail`;
CREATE TABLE `operate_log_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `field` varchar(255) DEFAULT NULL,
  `operate_id` bigint(20) DEFAULT NULL,
  `old_value` varchar(255) DEFAULT NULL,
  `new_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for repayment_order_info
-- ----------------------------
DROP TABLE IF EXISTS `repayment_order_info`;
CREATE TABLE `repayment_order_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country_id` int(11) NOT NULL COMMENT '国家ID',
  `order_no` varchar(64) NOT NULL COMMENT '订单号',
  `pay_order_no` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL,
  `repayment_no` varchar(64) DEFAULT NULL COMMENT '还款订单号',
  `order_type` tinyint(2) NOT NULL COMMENT '订单类型 1 线上2 线下',
  `member_id` varchar(64) CHARACTER SET utf8mb4 NOT NULL COMMENT '会员ID',
  `total_fee` decimal(16,2) DEFAULT '0.00' COMMENT '订单金额',
  `redirect_url` varchar(1024) CHARACTER SET utf8mb4 DEFAULT NULL,
  `order_status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '订单状态 1 待支付 2 paySuccess 3 repaymentSuccess 4repaymentFai 5closedl',
  `pay_method` tinyint(2) DEFAULT '0' COMMENT '支付方式',
  `pay_status` int(2) NOT NULL DEFAULT '1' COMMENT '1toPay 2PaySuccess 3payClose',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `create_time` datetime DEFAULT NULL COMMENT '下单时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `close_time` datetime DEFAULT NULL COMMENT '关单时间',
  `close_reason` varchar(128) DEFAULT NULL COMMENT '关单原因',
  `repayment_type` varchar(16) DEFAULT NULL COMMENT 'repayment type :due, toPeriod, period, outstading',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `order_no` (`order_no`) USING BTREE,
  KEY `memberId` (`country_id`,`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36009 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='还款订单表';

-- ----------------------------
-- Table structure for repayment_order_period
-- ----------------------------
DROP TABLE IF EXISTS `repayment_order_period`;
CREATE TABLE `repayment_order_period` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country_id` int(11) NOT NULL COMMENT '国家ID',
  `member_id` varchar(64) CHARACTER SET utf8mb4 NOT NULL COMMENT '会员ID',
  `loan_id` int(11) NOT NULL COMMENT 'loan id',
  `repayment_no` varchar(64) DEFAULT NULL COMMENT 'repayment_no',
  `order_no` varchar(64) DEFAULT NULL COMMENT '锁定的订单号',
  `pay_method` tinyint(2) DEFAULT '0' COMMENT '支付方式',
  `order_repayment_fee` decimal(16,2) DEFAULT NULL,
  `order_repayment_no` varchar(64) DEFAULT NULL COMMENT 'order_repayment_no',
  `order_repayment_status` tinyint(4) DEFAULT '0' COMMENT '0 default 1repayment success2repayment fail3repayment close',
  `order_repayment_time` datetime DEFAULT NULL COMMENT '支付时间',
  `order_repayment_response` text COMMENT 'repayment msg',
  `order_repayment_result` text COMMENT 'order repayment result',
  `return_principal_status` tinyint(4) DEFAULT NULL COMMENT '0 default 1success 2fail',
  `return_principal_time` datetime DEFAULT NULL COMMENT 'return time',
  `create_time` datetime DEFAULT NULL COMMENT 'create时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `principal_fee` decimal(16,2) DEFAULT NULL COMMENT '本金部分',
  `interest_fee` decimal(16,2) DEFAULT NULL COMMENT '利息(废弃)',
  `charge_fee` decimal(16,2) DEFAULT NULL COMMENT '费用(废弃)',
  `due_date` date DEFAULT NULL COMMENT '还款账单日(废弃)',
  `due_fee` decimal(16,2) DEFAULT NULL COMMENT '本期金额(废弃)',
  `paid_fee` decimal(16,2) DEFAULT NULL COMMENT '本期已还金额(废弃)',
  `period` int(10) DEFAULT NULL COMMENT '期数(废弃)',
  `error_msg` text,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `orderNo` (`country_id`,`order_no`) USING BTREE,
  KEY `repaymentNo` (`country_id`,`repayment_no`)
) ENGINE=InnoDB AUTO_INCREMENT=661 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='还款计划表';

-- ----------------------------
-- Table structure for repayment_period
-- ----------------------------
DROP TABLE IF EXISTS `repayment_period`;
CREATE TABLE `repayment_period` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country_id` int(11) NOT NULL COMMENT '国家ID',
  `member_id` varchar(64) CHARACTER SET utf8mb4 NOT NULL COMMENT '会员ID',
  `loan_id` int(11) NOT NULL COMMENT 'loan id',
  `start_date` date NOT NULL COMMENT '开始时间',
  `total_fee` decimal(16,2) NOT NULL COMMENT '总额度',
  `period` int(10) NOT NULL COMMENT '期数',
  `from_date` date NOT NULL,
  `due_date` date NOT NULL COMMENT '还款账单日',
  `principal_fee` decimal(16,2) DEFAULT NULL COMMENT '本金',
  `interest_fee` decimal(16,2) DEFAULT NULL COMMENT '利息',
  `charge_fee` decimal(16,2) DEFAULT NULL COMMENT '费用',
  `due_fee` decimal(16,2) NOT NULL COMMENT '本期金额',
  `paid_fee` decimal(16,2) NOT NULL COMMENT '本期已还金额',
  `repayment_status` tinyint(3) NOT NULL COMMENT '还款状态1、还款成功2、未还款',
  `out_standing_fee` decimal(16,2) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '下单时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `loan_id` (`loan_id`,`period`)
) ENGINE=InnoDB AUTO_INCREMENT=352 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='还款计划表';

-- ----------------------------
-- Table structure for self_employed_occupational_details
-- ----------------------------
DROP TABLE IF EXISTS `self_employed_occupational_details`;
CREATE TABLE `self_employed_occupational_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_no` varchar(36) NOT NULL,
  `business_name` varchar(255) DEFAULT NULL,
  `business_type` tinyint(4) DEFAULT NULL,
  `industry` tinyint(4) DEFAULT NULL,
  `business_payment_type` tinyint(4) DEFAULT NULL,
  `monthly_income` decimal(16,2) DEFAULT NULL,
  `monthly_expenses` decimal(16,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=117960 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for smile_identity
-- ----------------------------
DROP TABLE IF EXISTS `smile_identity`;
CREATE TABLE `smile_identity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `smile_job_id` varchar(64) DEFAULT NULL,
  `user_id` varchar(64) DEFAULT NULL,
  `job_id` varchar(64) DEFAULT NULL,
  `result_type` varchar(64) DEFAULT NULL,
  `result_text` varchar(64) DEFAULT NULL,
  `result_code` varchar(16) DEFAULT NULL,
  `country` varchar(16) DEFAULT NULL,
  `id_type` varchar(64) DEFAULT NULL,
  `id_number` varchar(64) DEFAULT NULL,
  `expiration_date` varchar(64) DEFAULT NULL,
  `full_name` varchar(64) DEFAULT NULL,
  `dob` varchar(64) DEFAULT NULL,
  `phone_number` varchar(64) DEFAULT NULL,
  `phone_number2` varchar(64) DEFAULT NULL,
  `gender` varchar(16) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `photo` text,
  `response_time` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for spin_mobile_auth
-- ----------------------------
DROP TABLE IF EXISTS `spin_mobile_auth`;
CREATE TABLE `spin_mobile_auth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(500) DEFAULT NULL,
  `expires` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for table_change_data
-- ----------------------------
DROP TABLE IF EXISTS `table_change_data`;
CREATE TABLE `table_change_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operation_id` varchar(255) NOT NULL,
  `field_name` varchar(255) DEFAULT NULL,
  `previous_value` varchar(255) DEFAULT NULL,
  `changed_value` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `operation_id` (`operation_id`),
  CONSTRAINT `operation_id` FOREIGN KEY (`operation_id`) REFERENCES `table_change_records` (`operation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for table_change_records
-- ----------------------------
DROP TABLE IF EXISTS `table_change_records`;
CREATE TABLE `table_change_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operation_id` varchar(255) NOT NULL,
  `operation_type` tinyint(4) NOT NULL,
  `table_name` varchar(255) DEFAULT NULL,
  `data_id` varchar(255) DEFAULT NULL,
  `operator` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `operation_id` (`operation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for telesign_score
-- ----------------------------
DROP TABLE IF EXISTS `telesign_score`;
CREATE TABLE `telesign_score` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `request_id` varchar(255) DEFAULT NULL,
  `phone_number` varchar(32) NOT NULL,
  `phone_type` varchar(255) DEFAULT NULL,
  `carrier` varchar(255) DEFAULT NULL,
  `risk_level` varchar(255) DEFAULT NULL,
  `risk_recommendation` varchar(255) DEFAULT NULL,
  `risk_score` int(11) DEFAULT NULL,
  `risk_insights_category` varchar(255) DEFAULT NULL,
  `risk_insights_a2p` varchar(255) DEFAULT NULL,
  `risk_insights_p2p` varchar(255) DEFAULT NULL,
  `risk_insights_number_type` varchar(255) DEFAULT NULL,
  `risk_insights_ip` varchar(255) DEFAULT NULL,
  `risk_insights_email` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone_number` (`phone_number`)
) ENGINE=InnoDB AUTO_INCREMENT=102524 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for third_party_data
-- ----------------------------
DROP TABLE IF EXISTS `third_party_data`;
CREATE TABLE `third_party_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_no` varchar(64) DEFAULT NULL,
  `request_id` varchar(64) DEFAULT NULL,
  `request_data` json DEFAULT NULL,
  `response_data` json DEFAULT NULL,
  `service_provider` tinyint(4) DEFAULT NULL,
  `service_type` tinyint(4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=105835 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for wallet
-- ----------------------------
DROP TABLE IF EXISTS `wallet`;
CREATE TABLE `wallet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country_id` int(11) DEFAULT NULL,
  `customer_no` varchar(255) NOT NULL,
  `wallet_no` varchar(255) NOT NULL,
  `status` smallint(6) DEFAULT NULL,
  `type` smallint(6) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `currency` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `available_balance` decimal(10,0) DEFAULT NULL,
  `ledger_balance` decimal(10,0) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `wallet_pin` int(11) DEFAULT NULL,
  `transaction_pin` int(11) DEFAULT NULL,
  `provider_customer_id` varchar(255) DEFAULT NULL,
  `provider_wallet_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_wallet_wallet_no` (`wallet_no`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for wallet_account
-- ----------------------------
DROP TABLE IF EXISTS `wallet_account`;
CREATE TABLE `wallet_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_type_id` int(11) NOT NULL,
  `wallet_id` int(11) NOT NULL,
  `available_balance` decimal(10,0) DEFAULT NULL,
  `ledger_balance` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_WALLET_ACCOUNT_ON_ACCOUNT_TYPE` (`account_type_id`),
  KEY `FK_WALLET_ACCOUNT_ON_WALLET` (`wallet_id`),
  CONSTRAINT `FK_WALLET_ACCOUNT_ON_ACCOUNT_TYPE` FOREIGN KEY (`account_type_id`) REFERENCES `wallet_account_type` (`id`),
  CONSTRAINT `FK_WALLET_ACCOUNT_ON_WALLET` FOREIGN KEY (`wallet_id`) REFERENCES `wallet` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for wallet_account_type
-- ----------------------------
DROP TABLE IF EXISTS `wallet_account_type`;
CREATE TABLE `wallet_account_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_type` smallint(6) NOT NULL,
  `transaction_fee` decimal(10,0) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for wallet_application
-- ----------------------------
DROP TABLE IF EXISTS `wallet_application`;
CREATE TABLE `wallet_application` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wallet_id` int(11) NOT NULL,
  `country_id` int(11) DEFAULT NULL,
  `customer_no` varchar(255) NOT NULL,
  `status` smallint(6) DEFAULT NULL,
  `sub_status` smallint(6) DEFAULT NULL,
  `ocr_transaction_id` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_wallet_application_wallet` (`wallet_id`),
  CONSTRAINT `FK_WALLET_APPLICATION_ON_WALLET` FOREIGN KEY (`wallet_id`) REFERENCES `wallet` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for wallet_transaction
-- ----------------------------
DROP TABLE IF EXISTS `wallet_transaction`;
CREATE TABLE `wallet_transaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country_id` int(11) DEFAULT NULL,
  `transaction_ref` varchar(255) NOT NULL,
  `transfer_id` int(11) NOT NULL,
  `narration` varchar(255) NOT NULL,
  `currency` varchar(255) DEFAULT NULL,
  `amount` decimal(10,0) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `account_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_WALLET_TRANSACTION_ON_ACCOUNT` (`account_id`),
  KEY `FK_WALLET_TRANSACTION_ON_TRANSFER` (`transfer_id`),
  CONSTRAINT `FK_WALLET_TRANSACTION_ON_ACCOUNT` FOREIGN KEY (`account_id`) REFERENCES `wallet_account` (`id`),
  CONSTRAINT `FK_WALLET_TRANSACTION_ON_TRANSFER` FOREIGN KEY (`transfer_id`) REFERENCES `wallet_transfer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=189 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for wallet_transfer
-- ----------------------------
DROP TABLE IF EXISTS `wallet_transfer`;
CREATE TABLE `wallet_transfer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country_id` int(11) DEFAULT NULL,
  `source_account` int(11) NOT NULL,
  `destination_account` int(11) NOT NULL,
  `amount` decimal(10,0) NOT NULL,
  `currency` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_WALLET_TRANSFER_ON_DESTINATION_ACCOUNT` (`destination_account`),
  KEY `FK_WALLET_TRANSFER_ON_SOURCE_ACCOUNT` (`source_account`),
  CONSTRAINT `FK_WALLET_TRANSFER_ON_DESTINATION_ACCOUNT` FOREIGN KEY (`destination_account`) REFERENCES `wallet_account` (`id`),
  CONSTRAINT `FK_WALLET_TRANSFER_ON_SOURCE_ACCOUNT` FOREIGN KEY (`source_account`) REFERENCES `wallet_account` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Triggers structure for table customer_basic_info
-- ----------------------------
DROP TRIGGER IF EXISTS `customer_basic_info_before_update_trigger`;
delimiter ;;
CREATE TRIGGER `customer_basic_info_before_update_trigger` BEFORE UPDATE ON `customer_basic_info` FOR EACH ROW BEGIN
        IF NEW.first_name != OLD.first_name THEN
            INSERT INTO customer_update_log (customer_no, field_name, old_value, new_value)
            VALUES (OLD.customer_no, 'first_name', OLD.first_name, NEW.first_name);
        END IF;
				IF NEW.last_name != OLD.last_name THEN
            INSERT INTO customer_update_log (customer_no, field_name, old_value, new_value)
            VALUES (OLD.customer_no, 'last_name', OLD.last_name, NEW.last_name);
        END IF;
				IF NEW.full_name != OLD.full_name THEN
            INSERT INTO customer_update_log (customer_no, field_name, old_value, new_value)
            VALUES (OLD.customer_no, 'full_name', OLD.full_name, NEW.full_name);
        END IF;
				IF NEW.date_of_birth != OLD.date_of_birth THEN
            INSERT INTO customer_update_log (customer_no, field_name, old_value, new_value)
            VALUES (OLD.customer_no, 'date_of_birth', DATE_FORMAT(OLD.date_of_birth, '%d-%m-%Y'), DATE_FORMAT(NEW.date_of_birth, '%d-%m-%Y'));
        END IF;
				IF NEW.id_type != OLD.id_type THEN
            INSERT INTO customer_update_log (customer_no, field_name, old_value, new_value)
            VALUES (OLD.customer_no, 'id_type', OLD.id_type, NEW.id_type);
        END IF;
				IF NEW.id_number != OLD.id_number THEN
            INSERT INTO customer_update_log (customer_no, field_name, old_value, new_value)
            VALUES (OLD.customer_no, 'id_number', OLD.id_number, NEW.id_number);
        END IF;
				IF NEW.gender != OLD.gender THEN
            INSERT INTO customer_update_log (customer_no, field_name, old_value, new_value)
            VALUES (OLD.customer_no, 'gender', OLD.gender, NEW.gender);
        END IF;
				IF NEW.marital_status != OLD.marital_status THEN
            INSERT INTO customer_update_log (customer_no, field_name, old_value, new_value)
            VALUES (OLD.customer_no, 'marital_status', OLD.marital_status, NEW.marital_status);
        END IF;
				IF NEW.calling_code != OLD.calling_code THEN
            INSERT INTO customer_update_log (customer_no, field_name, old_value, new_value)
            VALUES (OLD.customer_no, 'calling_code', OLD.calling_code, NEW.calling_code);
        END IF;
				IF NEW.phone_number != OLD.phone_number THEN
            INSERT INTO customer_update_log (customer_no, field_name, old_value, new_value)
            VALUES (OLD.customer_no, 'phone_number', OLD.phone_number, NEW.phone_number);
        END IF;
				IF NEW.email != OLD.email THEN
            INSERT INTO customer_update_log (customer_no, field_name, old_value, new_value)
            VALUES (OLD.customer_no, 'email', OLD.email, NEW.email);
        END IF;
				IF NEW.customer_type != OLD.customer_type THEN
            INSERT INTO customer_update_log (customer_no, field_name, old_value, new_value)
            VALUES (OLD.customer_no, 'customer_type', OLD.customer_type, NEW.customer_type);
        END IF;
				IF NEW.referral_source != OLD.referral_source THEN
            INSERT INTO customer_update_log (customer_no, field_name, old_value, new_value)
            VALUES (OLD.customer_no, 'referral_source', OLD.referral_source, NEW.referral_source);
        END IF;
				IF NEW.step_reached != OLD.step_reached THEN
            INSERT INTO customer_update_log (customer_no, field_name, old_value, new_value)
            VALUES (OLD.customer_no, 'step_reached', OLD.step_reached, NEW.step_reached);
        END IF;
				IF NEW.musoni_client_id != OLD.musoni_client_id THEN
            INSERT INTO customer_update_log (customer_no, field_name, old_value, new_value)
            VALUES (OLD.customer_no, 'musoni_client_id', OLD.musoni_client_id, NEW.musoni_client_id);
        END IF;
    END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
