drop view db2inst1.ROOTPROCESSVIEW;
drop view db2inst1.SUBPROCESSVIEW;
drop view db2inst1.PENDING_APPROVAL;
drop view db2inst1.SUSPENDED_USERS;
drop view db2inst1.SUSPENDED_ACCOUNT_OPERATIONS;
drop view db2inst1.PROCESS_VIEW;
drop view db2inst1.V_SAPOLICY_ENTITLEMENT_DETAIL;

drop table db2inst1.REMOTE_SERVICES_REQUESTS;
drop table db2inst1.REMOTE_RESOURCES_RECON_QUERIES;
drop table db2inst1.SCHEDULED_MESSAGE;
drop table db2inst1.NEXTVALUE;
drop table db2inst1.ACTIVITY_LOCK;
drop table db2inst1.SYNCH_POINT;
drop table db2inst1.PROCESSDATA;
drop table db2inst1.PROCESSLOG;
drop table db2inst1.WI_PARTICIPANT;
drop table db2inst1.WORKITEM;
drop table db2inst1.PASSWORD_TRANSACTION;
drop table db2inst1.PENDING;
drop table db2inst1.LISTDATA;
drop table db2inst1.AUTH_KEY;

drop table db2inst1.REMOTE_RESOURCES_RECONS;
drop table db2inst1.RESOURCE_PROVIDERS;
drop table db2inst1.ACTIVITY;
drop table db2inst1.PROCESS;
drop table db2inst1.SUMMARY_ORDER;

drop TABLE db2inst1.COLUMN_REPORT;
drop TABLE db2inst1.REPORT;
drop TABLE db2inst1.ENTITY_COLUMN;
drop TABLE db2inst1.RESOURCES_SYNCHRONIZATIONS;
drop TABLE db2inst1.SYNCHRONIZATION_HISTORY;
drop TABLE db2inst1.SYNCHRONIZATION_LOCK;
drop TABLE db2inst1.ENTITLEMENT_PROVISIONINGPARAMS;
drop TABLE db2inst1.ENTITLEMENT;
drop TABLE db2inst1.ACI_PERMISSION_CLASSRIGHT;
drop TABLE db2inst1.ACI_PERMISSION_ATTRIBUTERIGHT;
drop TABLE db2inst1.ACI_PRINCIPALS;
drop TABLE db2inst1.ACI_ROLEDNS;
drop TABLE db2inst1.ACI;
drop TABLE db2inst1.AUTHORIZATION_OWNERS;
drop TABLE db2inst1.CHANGELOG;
drop TABLE db2inst1.SERVICE_ACCOUNT_MAPPING;
drop TABLE db2inst1.RECONCILIATION_INFO;
drop TABLE db2inst1.RECONCILIATION;
drop TABLE db2inst1.PO_NOTIFICATION_TABLE;
drop TABLE db2inst1.PO_NOTIFICATION_HTMLBODY_TABLE;
drop TABLE db2inst1.PO_TOPIC_TABLE;
drop TABLE db2inst1.WORKFLOW_CALLBACK;
drop TABLE db2inst1.LCR_INPROGRESS_TABLE;
drop TABLE db2inst1.POLICY_ANALYSIS_ERROR;
drop TABLE db2inst1.ATTR_CHANGE;
drop TABLE db2inst1.ACCT_CHANGE;
drop TABLE db2inst1.POLICY_ANALYSIS;
drop TABLE db2inst1.COMPLIANCE_ALERT;

drop table db2inst1.AUDIT_MGMT_LEASE;
drop table db2inst1.AUDIT_MGMT_PROVISIONING;
drop table db2inst1.AUDIT_MGMT_TARGET;
drop table db2inst1.AUDIT_MGMT_DELEGATE;
drop table db2inst1.AUDIT_EVENT;
drop table db2inst1.I18NMESSAGES;
drop table db2inst1.BULK_DATA_INDEX;
drop table db2inst1.BULK_DATA_STORE;
drop table db2inst1.BULK_DATA_SERVICE;
drop table db2inst1.MIGRATION_STATUS;
drop table db2inst1.MANUAL_SERVICE_RECON_ACCOUNTS;
drop table db2inst1.VIEW_DEFINITION;
drop table db2inst1.TASKS_VIEWABLE;
drop table db2inst1.RECERTIFICATIONLOG;
drop table db2inst1.SCRIPT;
drop table db2inst1.COMMON_TASKS;
drop table db2inst1.ROLE_INHERITANCE;

drop table db2inst1.PASSWORD_SYNCH;

DROP TABLE db2inst1.SOD_POLICY;
DROP TABLE db2inst1.SOD_OWNER;
DROP TABLE db2inst1.SOD_RULE;
DROP TABLE db2inst1.SOD_RULE_ROLE;
DROP TABLE db2inst1.SOD_VIOLATION_HISTORY;
DROP TABLE db2inst1.SOD_VIOLATION_STATUS;
DROP TABLE db2inst1.SOD_VIOLATION_ROLE_MAP;

DROP TABLE db2inst1.USERRECERT_GROUP;
DROP TABLE db2inst1.USERRECERT_ACCOUNT;
DROP TABLE db2inst1.USERRECERT_ROLE;
DROP TABLE db2inst1.USERRECERT_HISTORY;
DROP TABLE db2inst1.RECERTIFIER_DETAILS_INFO;

DROP TABLE db2inst1.ACI_CATEGORIES;
DROP TABLE db2inst1.SA_POLICY_DESCRIPTION;
DROP TABLE db2inst1.SA_POLICY_ERURI;
DROP TABLE db2inst1.SA_POLICY_MEMBERSHIP;
DROP TABLE db2inst1.SA_POLICY_ENTITLEMENT;
DROP TABLE db2inst1.SA_POLICY;
DROP TABLE db2inst1.SA_EVALUATION_CREDENTIAL;
DROP TABLE db2inst1.SA_EVAL_CRED_DESCRIPTION;
DROP TABLE db2inst1.SA_EVALUATION_CREDENTIAL_POOL;
DROP TABLE db2inst1.SA_CREDPOOL_DESCRIPTION;
DROP TABLE db2inst1.SA_CREDPOOL_OWNER;
DROP TABLE db2inst1.SA_CREDPOOL_GROUP;
DROP TABLE db2inst1.SA_EVALUATION_SERVICE;
DROP TABLE db2inst1.SA_EVALUATION_SERVICE_TAG;
DROP TABLE db2inst1.SA_EVALUATION_BU_HIERARCHY;
DROP TABLE db2inst1.SA_EVALUATION_BU;
DROP TABLE db2inst1.DB_REPLICATION_CONFIG;
DROP TABLE db2inst1.erCredentialLease;
DROP TABLE db2inst1.SA_GLOBAL_CONFIGURATION;
DROP TABLE db2inst1.TASK_TREE;
DROP TABLE db2inst1.SA_BULK_LOAD;
DROP TABLE db2inst1.ROLE_ASSIGNMENT_ATTRIBUTES;
DROP TABLE db2inst1.PERSON_ROLE_ASSIGNMENT_VALUES;
DROP TABLE db2inst1.PERSON_ROLE_ASSIGNMENT;
DROP TABLE db2inst1.SYNCH_OBJECT_LOCK;
DROP VIEW db2inst1.V_AUTHORIZED_CREDENTIALS;
DROP VIEW db2inst1.V_AUTHORIZED_CREDENTIALPOOLS;

REVOKE  CREATETAB,CONNECT,IMPLICIT_SCHEMA ON DATABASE  FROM USER db2inst1;

DROP TABLESPACE ENROLE_DATA;
DROP TABLESPACE ENROLE_INDEXES;
DROP TABLESPACE TEMP_DATA;
