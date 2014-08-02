/**********************************************************
 *
 *  The section below contains the database schema
 *  changes from the ITIM 5.0 FP01 to FP02
 *
 **********************************************************/

CREATE TABLE PASSWORD_SYNCH (
	ACTIVITY_ID BIGINT NOT NULL,
	ACCOUNT_DN VARCHAR(512),
	TIME_REQUESTED VARCHAR(50),
	PASSWORD VARCHAR(500),

	CONSTRAINT PWD_SYNCH_PK PRIMARY KEY(ACTIVITY_ID)
) IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE INDEX PS_ACCDN_X ON PASSWORD_SYNCH(ACCOUNT_DN);
CREATE INDEX PS_TIME_X ON PASSWORD_SYNCH(TIME_REQUESTED);


/**********************************************************
 *
 *  The section below contains the database schema
 *  changes in ITIM 5.1
 *
 **********************************************************/

CREATE TABLE ROLE_INHERITANCE (
  ASCENDENT VARCHAR(2000) NOT NULL,
  DESCENDENT VARCHAR(2000) NOT NULL,
  CONSTRAINT ROLE_INH_PK PRIMARY KEY(ASCENDENT, DESCENDENT)
) IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE INDEX ROLE_INH_ASC_IDX on ROLE_INHERITANCE (ASCENDENT ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;
CREATE INDEX ROLE_INH_DSC_IDX on ROLE_INHERITANCE (DESCENDENT ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;

CREATE TABLE USERRECERT_HISTORY (
  ID BIGINT NOT NULL,
  PROCESS_ID BIGINT NOT NULL,
  ACTIVITY_ID BIGINT NOT NULL,
  PERSON_DN VARCHAR(255),
  PERSON_NAME VARCHAR(240),
  PERSON_PROFILE VARCHAR(128),
  PERSON_EMAIL VARCHAR(240),
  PERSON_CUSTOM_DISPLAY VARCHAR(240),
  PERSON_STATUS INTEGER,
  PERSON_CONTAINER_DN VARCHAR(255),
  PERSON_CONTAINER_NAME VARCHAR(128),
  POLICY_DN VARCHAR(255),
  POLICY_NAME VARCHAR(240),
  SUBMITTED_DATE VARCHAR(50),
  TIMEOUT SMALLINT,
  CONSTRAINT USERRECERT_PK PRIMARY KEY (ID)
) IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

ALTER TABLE USERRECERT_HISTORY ADD CONSTRAINT USERRECERT_PROC_FK FOREIGN KEY (PROCESS_ID) REFERENCES PROCESS (ID) ON DELETE CASCADE;
ALTER TABLE USERRECERT_HISTORY ADD CONSTRAINT USERRECERT_ACTV_FK FOREIGN KEY (ACTIVITY_ID) REFERENCES ACTIVITY (ID) ON DELETE CASCADE;

CREATE INDEX URH_SUBMITTED ON USERRECERT_HISTORY (SUBMITTED_DATE ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;

CREATE TABLE USERRECERT_ROLE (
  ID BIGINT NOT NULL,
  RECERT_ID BIGINT NOT NULL,
  ROLE_DN VARCHAR(255) NOT NULL,
  ROLE_NAME VARCHAR(240),
  ROLE_DESCRIPTION VARCHAR(500),
  DECISION CHAR(2),
  CONSTRAINT USERRECERT_ROLE_PK PRIMARY KEY (ID)
) IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

ALTER TABLE USERRECERT_ROLE ADD CONSTRAINT USERRECERT_ROLE_FK FOREIGN KEY (RECERT_ID)	REFERENCES USERRECERT_HISTORY (ID) ON DELETE CASCADE;

CREATE INDEX URR_ID_DEC ON USERRECERT_ROLE (RECERT_ID ASC, DECISION ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;

CREATE TABLE USERRECERT_ACCOUNT (
  ID BIGINT NOT NULL,
  RECERT_ID BIGINT NOT NULL,
  ACCOUNT_DN VARCHAR(255) NOT NULL,
  ACCOUNT_UID VARCHAR(240) NOT NULL,
  SERVICE_DN VARCHAR(255) NOT NULL,
  SERVICE_NAME VARCHAR(240),
  SERVICE_DESCRIPTION VARCHAR(240),
  DECISION CHAR(2),
  CONSTRAINT USERRECERT_ACCT_PK PRIMARY KEY (ID)
) IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

ALTER TABLE USERRECERT_ACCOUNT ADD CONSTRAINT USERRECERT_ACCT_FK FOREIGN KEY (RECERT_ID)	REFERENCES USERRECERT_HISTORY (ID) ON DELETE CASCADE;

CREATE INDEX URA_ID_DEC ON USERRECERT_ACCOUNT (RECERT_ID ASC, DECISION ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;

CREATE TABLE USERRECERT_GROUP (
  ID BIGINT NOT NULL,
  RECERT_ID BIGINT NOT NULL,
  ACCOUNT_ID BIGINT NOT NULL,
  GROUP_DN VARCHAR(500) NOT NULL,
  GROUP_NAME VARCHAR(240),
  GROUP_DESCRIPTION VARCHAR(500),
  DECISION CHAR(2),
  CONSTRAINT USERRECERT_GRP_PK PRIMARY KEY (ID)
) IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

ALTER TABLE USERRECERT_GROUP ADD CONSTRAINT USERRECERT_GRP_FK FOREIGN KEY (RECERT_ID) REFERENCES USERRECERT_HISTORY (ID);
ALTER TABLE USERRECERT_GROUP ADD CONSTRAINT USERRECERT_GA_FK FOREIGN KEY (ACCOUNT_ID) REFERENCES USERRECERT_ACCOUNT (ID) ON DELETE CASCADE;

CREATE INDEX URG_ID_DEC ON USERRECERT_GROUP (RECERT_ID ASC, ACCOUNT_ID DESC, DECISION ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;

ALTER TABLE PROCESSLOG ADD REQUESTOR_DN VARCHAR(1000);

CREATE TABLE RECERTIFIER_DETAILS_INFO (
  DN VARCHAR(255) NOT NULL,
  RECERTIFIER_TYPE VARCHAR(255),
  RECERTIFIER_NAME VARCHAR(255),
  CONSTRAINT RECERT_DETAILS_PK PRIMARY KEY (DN)
)
IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE TABLE SOD_POLICY (
		ID BIGINT NOT NULL,
		GLOBAL_ID BIGINT NOT NULL,
		NAME VARCHAR(256),
		DESCRIPTION VARCHAR(500),
		BUSINESS_UNIT_NAME VARCHAR(256),
		ENABLED CHAR(1),
		DN VARCHAR(2000),
		VERSION BIGINT NOT NULL,
		CONSTRAINT SP_PK PRIMARY KEY (ID)
	)
	IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE TABLE SOD_RULE (
		ID BIGINT NOT NULL,
		POLICY_ID BIGINT NOT NULL,
		GLOBAL_ID BIGINT NOT NULL,
		NAME VARCHAR(500),
		DESCRIPTION VARCHAR(500),
		CARDINALITY SMALLINT,
		VERSION BIGINT NOT NULL,
		CONSTRAINT SPR_PK PRIMARY KEY (ID),
		CONSTRAINT SPR_FK FOREIGN KEY (POLICY_ID) REFERENCES SOD_POLICY (ID)
	)
	IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE TABLE SOD_OWNER (
		ID BIGINT NOT NULL,
		POLICY_ID BIGINT NOT NULL,
		OWNER_NAME VARCHAR(256),
		BUSINESS_UNIT_NAME VARCHAR(256),
		TYPE VARCHAR(2),
		DN VARCHAR(2000),
		CONSTRAINT SPO_PK PRIMARY KEY (ID),
		CONSTRAINT SPO_FK FOREIGN KEY (POLICY_ID) REFERENCES SOD_POLICY (ID)
	)
	IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE TABLE SOD_RULE_ROLE (
		ID BIGINT NOT NULL,
		POLICY_RULE_ID BIGINT NOT NULL,
		GLOBAL_ID BIGINT NOT NULL,
		NAME VARCHAR(256),
		DESCRIPTION VARCHAR(500),
		BUSINESS_UNIT_NAME VARCHAR(100),
		DN VARCHAR(2000),
		CONSTRAINT SPRR_PK PRIMARY KEY (ID),
		CONSTRAINT SPRR_FK FOREIGN KEY (POLICY_RULE_ID) REFERENCES SOD_RULE (ID)
	)
	IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE TABLE SOD_VIOLATION_HISTORY (
		ID BIGINT NOT NULL,
		POLICY_GLOBAL_ID BIGINT NOT NULL,
		RULE_GLOBAL_ID BIGINT NOT NULL,
		PERSON_GLOBAL_ID BIGINT NOT NULL,
		PERSON_NAME VARCHAR(256),
		PERSON_BU VARCHAR(256),
		PERSON_DN VARCHAR(2000),
		PROCESS_ID BIGINT,
		ADMIN_NAME VARCHAR(256),
		ADMIN_BU VARCHAR(256),
		ADMIN_DN VARCHAR(2000),
		ADMIN_NOTES VARCHAR(4000),
		STATUS CHAR(1),
		TS BIGINT NOT NULL,
		CONSTRAINT SVIOHIST_PK PRIMARY KEY (ID)
	)
	IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE TABLE SOD_VIOLATION_STATUS (
		ID BIGINT NOT NULL,
		POLICY_GLOBAL_ID BIGINT NOT NULL,
		RULE_GLOBAL_ID BIGINT NOT NULL,
		PERSON_GLOBAL_ID BIGINT NOT NULL,
		PERSON_NAME VARCHAR(256),
		PERSON_BU VARCHAR(256),
		PERSON_DN VARCHAR(2000),
		PROCESS_ID BIGINT,
		ADMIN_NAME VARCHAR(256),
		ADMIN_BU VARCHAR(256),
		ADMIN_DN VARCHAR(2000),
		ADMIN_NOTES VARCHAR(4000),
		STATUS CHAR(1),
		TS BIGINT NOT NULL,
		EVAL_TS BIGINT NOT NULL,
		CONSTRAINT SVIOSTAT_PK PRIMARY KEY (ID)
	)
	IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE TABLE SOD_VIOLATION_ROLE_MAP (
		ID BIGINT NOT NULL,
		VIOLATION_ID BIGINT NOT NULL,
		RULEROLE VARCHAR(2000),
		PERSONROLE VARCHAR(2000),
		CONSTRAINT SPRVR_PK PRIMARY KEY (ID),
		CONSTRAINT SPRVR_FK FOREIGN KEY (VIOLATION_ID) REFERENCES SOD_VIOLATION_HISTORY (ID)
	)
	IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE INDEX SP_1 ON SOD_POLICY (GLOBAL_ID ASC, VERSION DESC) MINPCTUSED 10 ALLOW REVERSE SCANS;
CREATE INDEX SR_1 ON SOD_RULE (GLOBAL_ID ASC, POLICY_ID ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;
CREATE INDEX SVS_1 ON SOD_VIOLATION_STATUS (POLICY_GLOBAL_ID ASC, EVAL_TS DESC) MINPCTUSED 10 ALLOW REVERSE SCANS;
CREATE INDEX SVS_2 ON SOD_VIOLATION_STATUS (PERSON_GLOBAL_ID ASC, RULE_GLOBAL_ID ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;
CREATE INDEX SVS_3 ON SOD_VIOLATION_STATUS (RULE_GLOBAL_ID ASC, STATUS ASC, ID ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;
CREATE INDEX SVRM_1 ON SOD_VIOLATION_ROLE_MAP (VIOLATION_ID ASC, PERSONROLE ASC, RULEROLE ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;
ALTER TABLE SOD_VIOLATION_STATUS ADD CONSTRAINT SVS_UC UNIQUE (RULE_GLOBAL_ID, PERSON_GLOBAL_ID);

ALTER TABLE SOD_POLICY ALTER COLUMN DESCRIPTION SET DATA TYPE VARCHAR(1024);
ALTER TABLE SOD_RULE_ROLE ALTER COLUMN DESCRIPTION SET DATA TYPE VARCHAR(1024);
ALTER TABLE USERRECERT_ROLE ALTER COLUMN ROLE_DESCRIPTION SET DATA TYPE VARCHAR(1024);
ALTER TABLE USERRECERT_GROUP ALTER COLUMN GROUP_DESCRIPTION SET DATA TYPE VARCHAR(1024);

/**********************************************************
 *
 *  The section below contains the database schema
 *  changes in ITIM 5.1 Fixpacks
 *
 **********************************************************/
CREATE INDEX ACCT_CHANGE_POL_ANAL_ID on ACCT_CHANGE (POLICY_ANALYSIS_ID) MINPCTUSED 10 ALLOW REVERSE SCANS;

ALTER TABLE ENTITLEMENT_PROVISIONINGPARAMS
   ADD COLUMN SERVICETARGETNAME VARCHAR (255)
   ADD COLUMN SERVICE_DN VARCHAR (255);
   
/**********************************************************
 *
 *  The section below contains the database schema
 *  changes in ISIM 6.0
 *
 **********************************************************/
CREATE TABLE ACI_CATEGORIES (
  ID SMALLINT NOT NULL,
  NAME VARCHAR(255) NOT NULL,
  CONSTRAINT ACI_CATEGORIES_PK PRIMARY KEY(NAME)
)IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE TABLE SA_POLICY (
		ID BIGINT NOT NULL,
		DN VARCHAR(2000),
		BU_DN VARCHAR(2000),
		SCOPE SMALLINT,
		STATUS SMALLINT,
		POLICY_NAME VARCHAR(255),
		CONSTRAINT SAP_PK PRIMARY KEY (ID)
	)
	IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE TABLE SA_POLICY_MEMBERSHIP (
		ID BIGINT NOT NULL,
		POLICY_ID BIGINT NOT NULL,
		ROLE_DN VARCHAR(2000),
		CONSTRAINT SAP_MEMBERSHIP_PK PRIMARY KEY (ID)
	)
	IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE INDEX SA_MEMBERSHIP_POLICY_ID_X ON SA_POLICY_MEMBERSHIP (POLICY_ID ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;

CREATE TABLE SA_POLICY_ENTITLEMENT (
		ID BIGINT NOT NULL,
		POLICY_ID BIGINT NOT NULL,
		TYPE SMALLINT,
		DEFINITION_TYPE SMALLINT,
	    NAME VARCHAR(256),		
		TARGET_NAME	VARCHAR(256),	
		SERVICE_TYPE VARCHAR(256),	
		SERVICE_NAME VARCHAR(256),	
		SERVICE_GROUP VARCHAR(500), 	
		TARGET_DN VARCHAR(2000),
		CONSTRAINT SAP_ENTITLEMENT_PK PRIMARY KEY (ID)
	)
	IN ENROLE_DATA INDEX IN ENROLE_INDEXES;
	
CREATE INDEX SA_ENTITLEMENT_POLICY_ID_X ON SA_POLICY_ENTITLEMENT (POLICY_ID ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;
CREATE INDEX SA_ENTITLEMENT_TYPE_X ON SA_POLICY_ENTITLEMENT (TYPE ASC, DEFINITION_TYPE) MINPCTUSED 10 ALLOW REVERSE SCANS;
CREATE INDEX SA_ENTITLEMENT_FILTER_X ON SA_POLICY_ENTITLEMENT (SERVICE_TYPE ASC, SERVICE_GROUP, TARGET_NAME, SERVICE_NAME) MINPCTUSED 10 ALLOW REVERSE SCANS;

CREATE TABLE SA_POLICY_DESCRIPTION (
		POLICY_ID BIGINT NOT NULL,
		DESCRIPTION VARCHAR (2000)
	)
	IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE INDEX SA_POLICY_DESC_POLICY_ID_X ON SA_POLICY_DESCRIPTION (POLICY_ID ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;

CREATE TABLE SA_POLICY_ERURI (
		POLICY_ID BIGINT NOT NULL,
		ERURI VARCHAR (2000)
	)
	IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE INDEX SA_POLICY_ERURI_POLICY_ID_X ON SA_POLICY_ERURI (POLICY_ID ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;

CREATE VIEW V_SAPOLICY_ENTITLEMENT_DETAIL 
(SAPENTITLE_DN, SAPENTITLE_TYPE, SAPENTITLE_DEFINITION_TYPE, SAPENTITLE_NAME, SAPENTITLE_TARGET_NAME, SAPENTITLE_SERVICE_TYPE, SAPENTITLE_SERVICE_NAME, SAPENTITLE_SERVICE_GROUP, SAPENTITLE_TARGET_DN) 
AS (SELECT SA_POLICY.DN, CASE SA_POLICY_ENTITLEMENT.TYPE WHEN 1 THEN '1' WHEN 0 THEN '0' END, CASE SA_POLICY_ENTITLEMENT.DEFINITION_TYPE WHEN 1 THEN '1' WHEN 0 THEN '0' END, SA_POLICY_ENTITLEMENT.NAME, SA_POLICY_ENTITLEMENT.TARGET_NAME, SA_POLICY_ENTITLEMENT.SERVICE_TYPE, SA_POLICY_ENTITLEMENT.SERVICE_NAME, SA_POLICY_ENTITLEMENT.SERVICE_GROUP, SA_POLICY_ENTITLEMENT.TARGET_DN 
FROM SA_POLICY, SA_POLICY_ENTITLEMENT 
WHERE SA_POLICY.ID=SA_POLICY_ENTITLEMENT.POLICY_ID);
	
CREATE TABLE SA_EVALUATION_CREDENTIAL  ( 
        DN VARCHAR(2000) NOT NULL,
		ACCOUNT_DN VARCHAR(2000),	 
		ACCOUNT_UID VARCHAR(256), 
		USE_GLOBAL_SETTINGS SMALLINT, 
		IS_SEARCHABLE SMALLINT, 
		IS_EXCLUSIVE SMALLINT,
		IS_PASSWORD_VIEWABLE SMALLINT,
		ACCOUNT_STATUS SMALLINT,
		SERVICE_DN VARCHAR(2000),
		RESET_PASSWORD SMALLINT,
		MAX_CHECKOUT_TIME INTEGER,
		OBJECTPROFILE_NAME VARCHAR(255),
		NAME VARCHAR(255),
		OWNERSHIP_TYPE VARCHAR(255),
		OWNER_DN VARCHAR(2000),
		CONSTRAINT SA_EVAL_CREDENTIAL_PK PRIMARY KEY (DN)
	)
	IN ENROLE_DATA INDEX IN ENROLE_INDEXES;
	
CREATE INDEX SA_EVAL_CRED_UID_X ON SA_EVALUATION_CREDENTIAL (ACCOUNT_UID ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;
CREATE INDEX SA_EVAL_CRED_ACCOUNT_DN_X ON SA_EVALUATION_CREDENTIAL (ACCOUNT_DN ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;
CREATE INDEX SA_EVAL_CRED_GLOBAL_X ON SA_EVALUATION_CREDENTIAL (USE_GLOBAL_SETTINGS ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;
CREATE INDEX SA_EVAL_CRED_SETTING_X ON SA_EVALUATION_CREDENTIAL (IS_EXCLUSIVE ASC, IS_SEARCHABLE, ACCOUNT_STATUS, IS_PASSWORD_VIEWABLE) MINPCTUSED 10 ALLOW REVERSE SCANS;

CREATE TABLE SA_EVAL_CRED_DESCRIPTION (
		DN VARCHAR (2000) NOT NULL,
		DESCRIPTION VARCHAR (2000)
	)
	IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE INDEX SA_EVAL_CRED_DESC_X ON SA_EVAL_CRED_DESCRIPTION (DN ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;	


CREATE TABLE SA_EVALUATION_CREDENTIAL_POOL (
        DN VARCHAR(2000) NOT NULL,
		NAME VARCHAR(256),
		SERVICE_DN VARCHAR(2000),
		BU_DN VARCHAR(2000),
		USE_GLOBAL_SETTINGS SMALLINT,
		OBJECTPROFILE_NAME VARCHAR(255),
		CONSTRAINT SA_EVAL_POOL_PK PRIMARY KEY (DN)
	)
	IN ENROLE_DATA INDEX IN ENROLE_INDEXES;
	
CREATE INDEX SA_EVAL_POOL_NAME_X ON SA_EVALUATION_CREDENTIAL_POOL (NAME ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;	

CREATE TABLE SA_CREDPOOL_DESCRIPTION (
		DN VARCHAR (2000) NOT NULL,
		DESCRIPTION VARCHAR (2000)
	)
	IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE INDEX SA_CREDPOOL_DESCRIPTION_DN_X ON SA_CREDPOOL_DESCRIPTION (DN ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;

CREATE TABLE SA_CREDPOOL_OWNER (
		DN VARCHAR (2000) NOT NULL,
		OWNER VARCHAR (2000)
	)
	IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE INDEX SA_CREDPOOL_OWNER_DN_X ON SA_CREDPOOL_OWNER (DN ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;

CREATE TABLE SA_CREDPOOL_GROUP (
		DN VARCHAR (2000) NOT NULL,
		ERSERVICEGROUP VARCHAR(2000)
	)
	IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE INDEX SA_CREDPOOL_GROUP_DN_X ON SA_CREDPOOL_GROUP (DN ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;

CREATE TABLE SA_EVALUATION_SERVICE (
        DN VARCHAR(2000) NOT NULL,
		NAME VARCHAR(256),
		TYPE VARCHAR(256),	
		BU_DN VARCHAR(2000),
		CONSTRAINT SA_EVAL_SERVICE_PK PRIMARY KEY (DN)
	)
	IN ENROLE_DATA INDEX IN ENROLE_INDEXES;
CREATE INDEX SA_EVAL_SERVICE_INFO_X ON SA_EVALUATION_SERVICE (TYPE ASC, NAME) MINPCTUSED 10 ALLOW REVERSE SCANS;

CREATE TABLE SA_EVALUATION_SERVICE_TAG (
        SERVICE_DN VARCHAR(2000),
		TAG VARCHAR(500)
	)
	IN ENROLE_DATA INDEX IN ENROLE_INDEXES;
	
CREATE TABLE SA_EVALUATION_BU_HIERARCHY (
		BU_DN VARCHAR(2000) NOT NULL,
		CHILD_DN VARCHAR(2000) NOT NULL,
		CONSTRAINT SA_EVAL_BU_HIERARCHY_PK PRIMARY KEY (BU_DN, CHILD_DN)
	)
	IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE TABLE SA_EVALUATION_BU (
		DN VARCHAR(2000) NOT NULL,
		NAME VARCHAR(256),
		CONSTRAINT SA_EVAL_BU_PK PRIMARY KEY (DN)
	)
	IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE TABLE erCredentialLease
(
        dn VARCHAR(2000) NOT NULL,
		erCVCatalog VARCHAR(2000) NOT NULL,
    	erLessee VARCHAR(2000) NOT NULL,
    	erLesseeName VARCHAR(256),
      	erLeaseExpirationTime TIMESTAMP,
      	erJustification VARCHAR(2000),
      	erLeaseStatus SMALLINT,
      	erCredentialPoolDN VARCHAR(2000),
  		erCustomAttribute1 VARCHAR(2000),
  		erCustomAttribute2 VARCHAR(2000),
  		erCustomAttribute3 VARCHAR(2000),
  		erCustomAttribute4 VARCHAR(2000),
  		erCustomAttribute5 VARCHAR(2000),
      	erLastNotification TIMESTAMP,
      	erLeaseCreateTime TIMESTAMP,
		CONSTRAINT CREDENTIAL_LEASE_PK PRIMARY KEY (dn)
	)
	IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE INDEX CRED_LEASE_LESSEE_X ON erCredentialLease (erLessee ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;
CREATE INDEX CRED_LEASE_EXPIRE_TIME_X ON erCredentialLease (erLeaseExpirationTime ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;

SET INTEGRITY FOR SA_POLICY OFF;
SET INTEGRITY FOR SA_POLICY_MEMBERSHIP OFF;
SET INTEGRITY FOR SA_POLICY_ENTITLEMENT OFF;
SET INTEGRITY FOR SA_EVALUATION_CREDENTIAL OFF;
SET INTEGRITY FOR SA_EVALUATION_CREDENTIAL_POOL OFF;
SET INTEGRITY FOR SA_EVALUATION_SERVICE OFF;
SET INTEGRITY FOR SA_EVALUATION_SERVICE_TAG OFF;
SET INTEGRITY FOR SA_EVALUATION_BU OFF;
SET INTEGRITY FOR SA_EVALUATION_BU_HIERARCHY OFF;
SET INTEGRITY FOR erCredentialLease OFF;
SET INTEGRITY FOR SA_EVAL_CRED_DESCRIPTION OFF;

ALTER TABLE SA_POLICY ADD COLUMN L_BU_DN VARCHAR(2000) GENERATED ALWAYS AS (LOWER(BU_DN));
ALTER TABLE SA_POLICY_ENTITLEMENT ADD COLUMN L_TARGET_DN VARCHAR(2000) GENERATED ALWAYS AS (LOWER(TARGET_DN));
ALTER TABLE SA_EVALUATION_CREDENTIAL ADD COLUMN L_SERVICE_DN VARCHAR(2000) GENERATED ALWAYS AS (LOWER(SERVICE_DN));
ALTER TABLE SA_EVALUATION_CREDENTIAL_POOL ADD COLUMN L_SERVICE_DN VARCHAR(2000) GENERATED ALWAYS AS (LOWER(SERVICE_DN));
ALTER TABLE SA_EVALUATION_CREDENTIAL_POOL ADD COLUMN L_BU_DN VARCHAR(2000) GENERATED ALWAYS AS (LOWER(BU_DN));
ALTER TABLE SA_EVALUATION_SERVICE ADD COLUMN L_DN VARCHAR(2000) GENERATED ALWAYS AS (LOWER(DN));
ALTER TABLE SA_EVALUATION_SERVICE ADD COLUMN L_BU_DN VARCHAR(2000) GENERATED ALWAYS AS (LOWER(BU_DN));
ALTER TABLE SA_EVALUATION_SERVICE_TAG ADD COLUMN L_SERVICE_DN VARCHAR(2000) GENERATED ALWAYS AS (LOWER(SERVICE_DN));
ALTER TABLE SA_EVALUATION_BU_HIERARCHY ADD COLUMN L_BU_DN VARCHAR(2000) GENERATED ALWAYS AS (LOWER(BU_DN));
ALTER TABLE SA_EVALUATION_BU ADD COLUMN L_DN VARCHAR(2000) GENERATED ALWAYS AS (LOWER(DN));
ALTER TABLE erCredentialLease ADD COLUMN L_erCVCatalog VARCHAR(2000) GENERATED ALWAYS AS (LOWER(erCVCatalog));
ALTER TABLE erCredentialLease ADD COLUMN L_DN VARCHAR(2000) GENERATED ALWAYS AS (LOWER(DN));
ALTER TABLE SA_EVALUATION_CREDENTIAL ADD COLUMN L_DN VARCHAR(2000) GENERATED ALWAYS AS (LOWER(DN));
ALTER TABLE SA_EVAL_CRED_DESCRIPTION ADD COLUMN L_DN VARCHAR(2000) GENERATED ALWAYS AS (LOWER(DN));

SET INTEGRITY FOR SA_POLICY IMMEDIATE CHECKED FORCE GENERATED;
SET INTEGRITY FOR SA_POLICY_MEMBERSHIP IMMEDIATE CHECKED FORCE GENERATED;
SET INTEGRITY FOR SA_POLICY_ENTITLEMENT IMMEDIATE CHECKED FORCE GENERATED;
SET INTEGRITY FOR SA_EVALUATION_CREDENTIAL IMMEDIATE CHECKED FORCE GENERATED;
SET INTEGRITY FOR SA_EVALUATION_CREDENTIAL_POOL IMMEDIATE CHECKED FORCE GENERATED;
SET INTEGRITY FOR SA_EVALUATION_SERVICE IMMEDIATE CHECKED FORCE GENERATED;
SET INTEGRITY FOR SA_EVALUATION_SERVICE_TAG IMMEDIATE CHECKED FORCE GENERATED;
SET INTEGRITY FOR SA_EVALUATION_BU IMMEDIATE CHECKED FORCE GENERATED;
SET INTEGRITY FOR SA_EVALUATION_BU_HIERARCHY IMMEDIATE CHECKED FORCE GENERATED;
SET INTEGRITY FOR erCredentialLease IMMEDIATE CHECKED FORCE GENERATED;
SET INTEGRITY FOR SA_EVAL_CRED_DESCRIPTION IMMEDIATE CHECKED FORCE GENERATED;

CREATE INDEX SA_POLICY_BU_SCOPE_X ON SA_POLICY (STATUS ASC, SCOPE, L_BU_DN) MINPCTUSED 10 ALLOW REVERSE SCANS;
CREATE INDEX SA_ENTITLEMENT_TARGET_DN_X ON SA_POLICY_ENTITLEMENT (L_TARGET_DN ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;
CREATE INDEX SA_EVAL_CRED_SERVICE_DN_X ON SA_EVALUATION_CREDENTIAL (L_SERVICE_DN ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;
CREATE INDEX SA_EVAL_POOL_SERVICE_DN_X ON SA_EVALUATION_CREDENTIAL_POOL (L_SERVICE_DN ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;
CREATE INDEX SA_EVAL_POOL_BU_DN_X ON SA_EVALUATION_CREDENTIAL_POOL (L_BU_DN ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;
CREATE INDEX SA_EVAL_SERVICE_DN_X ON SA_EVALUATION_SERVICE (L_DN ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;
CREATE INDEX SA_EVAL_SERVICE_BU_DN_X ON SA_EVALUATION_SERVICE (L_BU_DN ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;
CREATE INDEX SA_EVAL_SERVICE_TAG_X ON SA_EVALUATION_SERVICE_TAG (L_SERVICE_DN ASC, TAG ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;
CREATE INDEX SA_EVAL_BU_HIERARCHY_X ON SA_EVALUATION_BU_HIERARCHY (L_BU_DN ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;
CREATE INDEX SA_EVAL_BU_X ON SA_EVALUATION_BU (L_DN ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;
CREATE UNIQUE INDEX CRED_LEASE_CVCATALOG_X ON erCredentialLease (L_erCVCatalog ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;
CREATE INDEX L_CRED_LEASE_DN_X ON erCredentialLease (L_DN ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;
CREATE INDEX SA_EVAL_LDN_X ON SA_EVALUATION_CREDENTIAL (L_DN ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;
CREATE INDEX SA_EVAL_CRED_DESC_LDN_X ON SA_EVAL_CRED_DESCRIPTION (L_DN ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;

CREATE TABLE DB_REPLICATION_CONFIG (
		ID INT NOT NULL,
		OBJECT_CLASS_NAME VARCHAR(256) NOT NULL,
		ATTRIBUTE_NAME VARCHAR(256) NOT NULL,
		DB_TABLE_NAME VARCHAR(256) NOT NULL,
		KEY_COLUMN_NAME VARCHAR(256) NOT NULL,
	    REPLICATE_COLUMN_NAME VARCHAR(256) NOT NULL,
		MULTI_VALUE CHAR(1) NOT NULL,
		UPDATE_ONLY CHAR(1) NOT NULL,
		CASE_SENSITIVE CHAR(1),		
		CONSTRAINT DB_REPLICATION_CONFIG_PK PRIMARY KEY (ID)
	)
	IN ENROLE_DATA INDEX IN ENROLE_INDEXES;
	
create table AUDIT_MGMT_LEASE
(
  	event_id BIGINT NOT NULL,
  	lease_expiration_time VARCHAR(500),
  	justification VARCHAR(2000),
  	pool_name VARCHAR(256),
  	pool_dn VARCHAR(2000),
  	custom_attribute_1 VARCHAR(2000),
  	custom_attribute_2 VARCHAR(2000),
  	custom_attribute_3 VARCHAR(2000),
  	custom_attribute_4 VARCHAR(2000),
  	custom_attribute_5 VARCHAR(2000),
  	lease_dn VARCHAR(2000),
  	CONSTRAINT AUDIT_LEASE_FK FOREIGN KEY(event_id)
  	REFERENCES AUDIT_EVENT(id)
)
IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE INDEX ADT_MGMT_LEASE_ID_X ON AUDIT_MGMT_LEASE (EVENT_ID ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;
CREATE INDEX ADT_MGMT_LEASE_DN_X ON AUDIT_MGMT_LEASE (LEASE_DN ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;


CREATE TABLE SA_GLOBAL_CONFIGURATION ( 
		ID INT NOT NULL,
        ACCESS_MODE SMALLINT, 
        MAX_CHECKOUT_DURATION INT, 
		PASSWORD_VIEWABLE SMALLINT,
		SHAREDACCOUNTS_SEARCH SMALLINT,
		PASSWORD_RESET SMALLINT,
		OPERATION_NAME VARCHAR(256),
		LEASE_EXP_HANDLING CHAR(1) , 
		LEASE_EXP_HANDLING_OPTION SMALLINT , 
		VIOLATION_NOTIFY_PARTICIPANT VARCHAR(10) , 
		NOTIFICATION_PARTICIPANT_DN VARCHAR(256) , 
		SCHEDULE_FREQUENCY_MINUTES BIGINT , 
		NOTIFY_FREQUENCY_MINUTES BIGINT, 
        CONSTRAINT SA_GLOBAL_CONFIGURATION_PK PRIMARY KEY(ID) 
) 
IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE TABLE TASK_TREE (
      PARENT      VARCHAR(500) NOT NULL,   
      TASK_ID     VARCHAR(500) NOT NULL,    
      SEQUENCE_NO SMALLINT NOT NULL,
      ADMIN_ONLY  CHAR(1),
      CONSTRAINT TASK_TREE_PK PRIMARY KEY (TASK_ID)
)
IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE INDEX TASK_TREE_PARENT_X on TASK_TREE (PARENT ASC, SEQUENCE_NO ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;

CREATE TABLE SA_BULK_LOAD (
  LOAD_ID VARCHAR (255) NOT NULL,
  DATA CLOB(10M),
  CONSTRAINT SA_BULK_LOAD_PK PRIMARY KEY(LOAD_ID)
)  
IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

ALTER TABLE PROCESS ALTER COLUMN COMMENTS SET DATA TYPE VARCHAR(2000);		

CREATE TABLE ROLE_ASSIGNMENT_ATTRIBUTES (
	ROLE_DN VARCHAR(2000) NOT NULL,
	ATTRIBUTE_NAME VARCHAR(256) NOT NULL,
	ROLE_NAME VARCHAR(256),
	CONSTRAINT ROLE_ASSIGNMENT_ATTRIBUTES_PK PRIMARY KEY (ROLE_DN, ATTRIBUTE_NAME)
)
IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE TABLE PERSON_ROLE_ASSIGNMENT (
  ID BIGINT NOT NULL,
  PERSON_DN VARCHAR(2000) NOT NULL,
  ROLE_DEFINED_DN VARCHAR(2000) NOT NULL,
  ROLE_ASSIGNED_DN VARCHAR(2000) NOT NULL,
  CONSTRAINT ROLE_ASSIGNMENT_PK PRIMARY KEY(ID)
)IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE TABLE PERSON_ROLE_ASSIGNMENT_VALUES (
  RA_ID BIGINT NOT NULL,
  ATTRIBUTE_NAME VARCHAR(256) NOT NULL,
  ATTRIBUTE_VALUE VARCHAR(2000) NOT NULL
)IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE INDEX PERSON_ROLE_ASSIGN_X ON PERSON_ROLE_ASSIGNMENT (PERSON_DN ASC, ROLE_DEFINED_DN ASC, ROLE_ASSIGNED_DN ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;

CREATE TABLE SYNCH_OBJECT_LOCK (
  OBJ_ID VARCHAR(2000) NOT NULL,
  CONSTRAINT SYNCH_OBJECT_LOCK_PK PRIMARY KEY(OBJ_ID)
) IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

ALTER TABLE RESOURCE_PROVIDERS ADD COLUMN FIRST_RESOURCE_FAIL_TIME TIMESTAMP
  ADD COLUMN LAST_ERROR VARCHAR(2000);
  
CREATE INDEX RESPROVDNX on RESOURCE_PROVIDERS (RESOURCE_DN ASC) MINPCTUSED 10 ALLOW REVERSE SCANS;

CREATE INDEX RS_REQ_TYPE_ID_X ON REMOTE_SERVICES_REQUESTS (TYPE ASC, PROVIDER_ID DESC) MINPCTUSED 10 ALLOW REVERSE SCANS;  

CREATE VIEW V_AUTHORIZED_CREDENTIALS ( CRED_DN, CRED_ACCOUNT_DN, CRED_ACCOUNT_UID, Exclusice_Access, SA_MEMBER_ROLE_DN,Service_Dn, Service, Service_BUDN, 
Service_BU, SA_POLICY_ID, POLICY_NAME,SA_ENTITLEMENT_ID) AS (SELECT distinct cred.dn, cred.account_dn, cred.account_uid, cred.is_exclusive, member.ROLE_DN, 
service.dn, service.name, bu.dn, bu.name, p.id, p.POLICY_NAME ,ent.id     	FROM  sa_evaluation_credential cred, sa_policy  p, sa_policy_entitlement      
ent, sa_evaluation_bu bu, sa_policy_membership    member, SA_GLOBAL_CONFIGURATION global_config, sa_evaluation_service     service   LEFT OUTER JOIN  
sa_evaluation_service_tag service_tag on (service.dn = service_tag.service_dn)  WHERE  (p.status = 0)  AND  (ent.policy_id = p.id)   AND   (ent.type = 0)   
AND  (member.policy_id = p.id)     	  AND     	  (cred.service_dn = service.dn)  AND  (service.bu_dn = bu.dn) AND( ( (cred.use_global_settings = 1) AND 
(cred.is_exclusive != 2) ) OR ( (cred.use_global_settings = 0) AND (global_config.access_mode != 2) ) )  AND  ( ( (ent.definition_type = 0 AND ent.target_dn = 
cred.dn) )  OR   (       (ent.definition_type = 1) AND ( (ent.target_name  = '')  OR ( SUBSTR(ent.target_name, LENGTH(ent.target_name)) != '*'  AND   
LOWER(ent.target_name) = LOWER(cred.account_uid)  )  OR  ( SUBSTR(ent.target_name, LENGTH(ent.target_name)) = '*'  AND  LOCATE(LOWER(SUBSTR(ent.target_name, 1, 
LENGTH(ent.target_name)-1)), LOWER(cred.account_uid)) = 1 )  ) AND ( (ent.service_name  = '')  OR   ( SUBSTR(ent.service_name, LENGTH(ent.service_name)) != 
'*'  AND   LOWER(ent.service_name) = LOWER(service.NAME )  )   OR  ( 	SUBSTR(ent.service_name, LENGTH(ent.service_name)) = '*'  AND              
LOCATE(LOWER(SUBSTR(ent.service_name, 1, LENGTH(ent.service_name)-1)), LOWER(service.NAME) )= 1             )          )         AND 		( 		  
(ent.service_group  = '')  OR  ( 	SUBSTR(ent.service_group, LENGTH(ent.service_group)) != '*'  AND LOWER(ent.service_group) = LOWER(service_tag.tag) 		  )  
OR   ( SUBSTR(ent.service_group, LENGTH(ent.service_group)) = '*'  AND LOCATE(LOWER(SUBSTR(ent.service_group, 1, LENGTH(ent.service_group)-1)), 
LOWER(service_tag.tag) )= 1   )    )    AND (ent.service_type = '' OR ent.service_type = service.type)  AND ( (  	(p.scope = 1) AND (service.bu_dn = p.bu_dn)  
)  OR 	 (   (p.scope = 2) AND 	 ( (service.bu_dn = p.bu_dn)  OR (service.bu_dn in (SELECT child_dn FROM sa_evaluation_bu_hierarchy WHERE bu_dn = 
p.bu_dn) ) )  ) 	  )   )  )  );

CREATE VIEW V_AUTHORIZED_CREDENTIALPOOLS ( CREDPOOL_DN, CREDPOOL_NAME, GROUP_DN ,SA_MEMBER_ROLE_DN, Service_Dn, Service, Service_BUDN, Service_BU, 
SA_POLICY_ID, SA_POLICY_NAME, SA_ENTITLEMENT_ID) AS (SELECT distinct credpool.dn, credpool.name, poolgroup.ERSERVICEGROUP,member.ROLE_DN, 
service.dn, service.name, bu.dn, bu.name, p.id, p.POLICY_NAME, ent.id     	FROM    sa_evaluation_credential_pool credpool,  
sa_policy   p, sa_policy_entitlement      ent,  sa_evaluation_bu      bu,  sa_policy_membership    member,  sa_credpool_group  poolgroup,   
sa_evaluation_service     service   LEFT OUTER JOIN  sa_evaluation_service_tag service_tag on (service.dn = service_tag.service_dn) WHERE     	  (p.status = 
0) AND (ent.policy_id = p.id)  AND   (ent.type = 1)  AND (credpool.service_dn = service.dn)  AND ( service.bu_dn = bu.dn)  
AND (credpool.dn = poolgroup.dn) AND  (member.policy_id = p.id)  AND ( 	( (ent.definition_type = 0 AND ent.target_dn = credpool.dn) ) OR (  
(ent.definition_type = 1)  AND  ( (ent.target_name  = '') OR  (  SUBSTR(ent.target_name, LENGTH(ent.target_name)) != '*'  AND LOWER(ent.target_name) = 
LOWER(credpool.name)) OR (  SUBSTR(ent.target_name, LENGTH(ent.target_name)) = '*'  AND 	LOCATE(LOWER(SUBSTR(ent.target_name, 1, LENGTH(ent.target_name)-1)), 
LOWER(credpool.name)) = 1 )  )  AND  ( (ent.service_name  = '') OR  ( 	 SUBSTR(ent.service_name, LENGTH(ent.service_name)) != '*'   AND  
LOWER(ent.service_name) = LOWER(service.NAME ) )  OR 	( 	 SUBSTR(ent.service_name, LENGTH(ent.service_name)) = '*' AND 					  
LOCATE(LOWER(SUBSTR(ent.service_name, 1, LENGTH(ent.service_name)-1)), LOWER(service.NAME) )= 1 )   )  AND  ( (ent.service_group  = '') OR  ( 
SUBSTR(ent.service_group, LENGTH(ent.service_group)) != '*' AND  LOWER(ent.service_group) = LOWER(service_tag.tag) 	) OR (  SUBSTR(ent.service_group, 
LENGTH(ent.service_group)) = '*' AND   LOCATE(LOWER(SUBSTR(ent.service_group, 1, LENGTH(ent.service_group)-1)),LOWER(service_tag.tag)) = 1 )   )  AND  
(ent.service_type = '' OR ent.service_type = service.TYPE) AND ( (   (p.scope = 1) AND (service.bu_dn = p.bu_dn) ) OR (  (p.scope = 2)  AND  ( 	
(service.bu_dn = p.bu_dn) OR (service.bu_dn in (SELECT child_dn FROM sa_evaluation_bu_hierarchy WHERE bu_dn = p.bu_dn) ) ) )   )  ) ) );