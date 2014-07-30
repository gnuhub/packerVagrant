drop view itimuserTag.ROOTPROCESSVIEW;
drop view itimuserTag.SUBPROCESSVIEW;
drop view itimuserTag.PENDING_APPROVAL;
drop view itimuserTag.SUSPENDED_USERS;
drop view itimuserTag.SUSPENDED_ACCOUNT_OPERATIONS;
drop view itimuserTag.PROCESS_VIEW;
drop view itimuserTag.V_SAPOLICY_ENTITLEMENT_DETAIL;

drop table itimuserTag.REMOTE_SERVICES_REQUESTS;
drop table itimuserTag.REMOTE_RESOURCES_RECON_QUERIES;
drop table itimuserTag.SCHEDULED_MESSAGE;
drop table itimuserTag.NEXTVALUE;
drop table itimuserTag.ACTIVITY_LOCK;
drop table itimuserTag.SYNCH_POINT;
drop table itimuserTag.PROCESSDATA;
drop table itimuserTag.PROCESSLOG;
ALTER TABLE itimuserTag.WORKITEM DROP WORKITEM2_FK;
ALTER TABLE itimuserTag.WORKITEM DROP WORKITEM_FK;
ALTER TABLE itimuserTag.WI_PARTICIPANT DROP WORKITEM_ID_FK;
drop table itimuserTag.WI_PARTICIPANT;
drop table itimuserTag.WORKITEM;
drop table itimuserTag.PASSWORD_TRANSACTION;
drop table itimuserTag.PENDING;
drop table itimuserTag.LISTDATA;
drop table itimuserTag.AUTH_KEY;

drop TABLE itimuserTag.PO_NOTIFICATION_HTMLBODY_TABLE;
drop TABLE itimuserTag.PO_NOTIFICATION_TABLE;
drop TABLE itimuserTag.PO_TOPIC_TABLE;
drop TABLE itimuserTag.WORKFLOW_CALLBACK;
drop table itimuserTag.LCR_INPROGRESS_TABLE;

drop table itimuserTag.POLICY_ANALYSIS_ERROR;
drop table itimuserTag.ATTR_CHANGE;
drop table itimuserTag.ACCT_CHANGE;
drop table itimuserTag.POLICY_ANALYSIS;
drop table itimuserTag.COMPLIANCE_ALERT;

drop TABLE itimuserTag.COLUMN_REPORT;
drop TABLE itimuserTag.REPORT;
drop TABLE itimuserTag.ENTITY_COLUMN;
drop TABLE itimuserTag.RESOURCES_SYNCHRONIZATIONS;
drop TABLE itimuserTag.SYNCHRONIZATION_HISTORY;
drop TABLE itimuserTag.SYNCHRONIZATION_LOCK;
drop TABLE itimuserTag.ENTITLEMENT_PROVISIONINGPARAMS;
drop TABLE itimuserTag.ENTITLEMENT;
drop TABLE itimuserTag.ACI_PERMISSION_CLASSRIGHT;
drop TABLE itimuserTag.ACI_PERMISSION_ATTRIBUTERIGHT;
drop TABLE itimuserTag.ACI_PRINCIPALS;
drop TABLE itimuserTag.ACI_ROLEDNS;
drop TABLE itimuserTag.ACI;
drop TABLE itimuserTag.AUTHORIZATION_OWNERS;
drop TABLE itimuserTag.CHANGELOG;
drop TABLE itimuserTag.SERVICE_ACCOUNT_MAPPING;
drop TABLE itimuserTag.RECONCILIATION_INFO;
drop TABLE itimuserTag.RECONCILIATION;

drop table itimuserTag.REMOTE_RESOURCES_RECONS;
drop table itimuserTag.RESOURCE_PROVIDERS;
drop table itimuserTag.SUMMARY_ORDER;

drop table itimuserTag.AUDIT_MGMT_LEASE;
drop table itimuserTag.AUDIT_MGMT_PROVISIONING;
drop table itimuserTag.AUDIT_MGMT_TARGET;
drop table itimuserTag.AUDIT_MGMT_DELEGATE;
drop table itimuserTag.AUDIT_EVENT;
drop TABLE itimuserTag.I18NMESSAGES;
drop TABLE itimuserTag.BULK_DATA_INDEX;
drop TABLE itimuserTag.BULK_DATA_STORE;
drop TABLE itimuserTag.BULK_DATA_SERVICE;
drop TABLE itimuserTag.MIGRATION_STATUS;
drop table itimuserTag.MANUAL_SERVICE_RECON_ACCOUNTS;
drop table itimuserTag.TASKS_VIEWABLE;
drop table itimuserTag.VIEW_DEFINITION;
drop table itimuserTag.RECERTIFICATIONLOG;
drop table itimuserTag.SCRIPT;
drop table itimuserTag.COMMON_TASKS;
drop table itimuserTag.ROLE_INHERITANCE;

drop TABLE itimuserTag.PASSWORD_SYNCH;

DROP TABLE itimuserTag.SOD_OWNER;
DROP TABLE itimuserTag.SOD_RULE_ROLE;
DROP TABLE itimuserTag.SOD_RULE;
DROP TABLE itimuserTag.SOD_VIOLATION_STATUS;
DROP TABLE itimuserTag.SOD_VIOLATION_ROLE_MAP;
DROP TABLE itimuserTag.SOD_VIOLATION_HISTORY;
DROP TABLE itimuserTag.SOD_POLICY;

DROP TABLE itimuserTag.USERRECERT_GROUP;
DROP TABLE itimuserTag.USERRECERT_ACCOUNT;
DROP TABLE itimuserTag.USERRECERT_ROLE;
DROP TABLE itimuserTag.USERRECERT_HISTORY;
DROP TABLE itimuserTag.RECERTIFIER_DETAILS_INFO;

drop table itimuserTag.ACTIVITY;
drop table itimuserTag.PROCESS;

drop table itimuserTag.ACI_CATEGORIES;
drop table itimuserTag.SA_POLICY_DESCRIPTION;
drop table itimuserTag.SA_POLICY_ERURI;
drop table itimuserTag.SA_POLICY_MEMBERSHIP;
drop table itimuserTag.SA_POLICY_ENTITLEMENT;
drop table itimuserTag.SA_POLICY;
DROP TABLE itimuserTag.SA_EVALUATION_CREDENTIAL;
DROP TABLE itimuserTag.SA_EVAL_CRED_DESCRIPTION;
DROP TABLE itimuserTag.SA_EVALUATION_CREDENTIAL_POOL;
DROP TABLE itimuserTag.SA_CREDPOOL_DESCRIPTION;
DROP TABLE itimuserTag.SA_CREDPOOL_OWNER;
DROP TABLE itimuserTag.SA_CREDPOOL_GROUP;
DROP TABLE itimuserTag.SA_EVALUATION_SERVICE;
DROP TABLE itimuserTag.SA_EVALUATION_SERVICE_TAG;
DROP TABLE itimuserTag.SA_EVALUATION_BU_HIERARCHY;
DROP TABLE itimuserTag.SA_EVALUATION_BU;
DROP TABLE itimuserTag.erCredentialLease;
DROP TABLE itimuserTag.DB_REPLICATION_CONFIG;
DROP TABLE itimuserTag.SA_GLOBAL_CONFIGURATION;
DROP TABLE itimuserTag.TASK_TREE;
DROP TABLE itimuserTag.SA_BULK_LOAD;
DROP TABLE itimuserTag.ROLE_ASSIGNMENT_ATTRIBUTES;
DROP TABLE itimuserTag.PERSON_ROLE_ASSIGNMENT_VALUES;
DROP TABLE itimuserTag.PERSON_ROLE_ASSIGNMENT;
DROP TABLE itimuserTag.SYNCH_OBJECT_LOCK;
DROP VIEW itimuserTag.V_AUTHORIZED_CREDENTIALS;
DROP VIEW itimuserTag.V_AUTHORIZED_CREDENTIALPOOLS;

sp_dropuser itimuserTag;
sp_droplogin itimuserTag;

use master;
sp_droprolemember [SqlJDBCXAUser], itimuserTag;
sp_revokedbaccess itimuserTag;
use itimdbTag;

