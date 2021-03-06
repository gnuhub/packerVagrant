CREATE INDEX RS_REQ_PID_X ON REMOTE_SERVICES_REQUESTS(PROVIDER_ID)

CREATE INDEX RS_REQ_RTIME_X ON REMOTE_SERVICES_REQUESTS(REQUEST_TIME)

CREATE TABLE LCR_INPROGRESS_TABLE
  (
  TENANT NVARCHAR(256) NOT NULL,
  RULE_ID BIGINT NOT NULL,
  RULE_OP NVARCHAR(256),
  CHILD_ID BIGINT,
  START_TIME BIGINT,
  ENTITY_ID NVARCHAR(256) NOT NULL,
  CONSTRAINT Unique_RuleEntity PRIMARY KEY(RULE_ID,ENTITY_ID)
  )

CREATE TABLE PO_TOPIC_TABLE
  (
  TENANT            NVARCHAR(256) NOT NULL,
  TOPIC            NVARCHAR(256) NOT NULL,
  SERVER            NVARCHAR(20),
  CHECKPOINT_TIME        BIGINT,
  TOPIC_ID            BIGINT NOT NULL,
  CONSTRAINT Unique_TenantTopic PRIMARY KEY(TENANT,
                      TOPIC),
  CONSTRAINT Unique_TopicID UNIQUE(TOPIC_ID)
  )

CREATE INDEX PO_TopicIndex ON PO_TOPIC_TABLE(TOPIC_ID)

CREATE TABLE PO_NOTIFICATION_TABLE
  (
  NOTIFICATION_ID   BIGINT NOT NULL,
  TOPIC_ID    BIGINT NOT NULL,
  SUBJECT  NVARCHAR(2000),
  TEXTBODY    NTEXT,
  RECEIVE_TIME    BIGINT NOT NULL,
  RECIPIENT_EADDR   NVARCHAR(320) NOT NULL,
  RECIPIENT_LOCALE  NVARCHAR(256),
  CONSTRAINT TenantTopic_parent FOREIGN KEY(TOPIC_ID) REFERENCES PO_TOPIC_TABLE(TOPIC_ID),
  CONSTRAINT NOTIFICATION_ID_PK PRIMARY KEY(NOTIFICATION_ID)
  )

CREATE INDEX PO_NotifyIndex ON PO_NOTIFICATION_TABLE(TOPIC_ID)

CREATE TABLE PO_NOTIFICATION_HTMLBODY_TABLE (
  NOTIFICATION_ID   BIGINT NOT NULL,
  HTMLBODY    NTEXT,
  CONSTRAINT NOTIF_IDHTML FOREIGN KEY(NOTIFICATION_ID) REFERENCES PO_NOTIFICATION_TABLE(NOTIFICATION_ID) ON DELETE CASCADE,
  CONSTRAINT NOTIFI_ID_HTML_PK PRIMARY KEY(NOTIFICATION_ID)
)
CREATE INDEX PO_NOTIF_HTML ON PO_NOTIFICATION_HTMLBODY_TABLE(NOTIFICATION_ID)

ALTER TABLE PROCESS ADD SUBJECT_PROFILE NVARCHAR(100)

ALTER TABLE PROCESS ADD SUBJECT_SERVICE NVARCHAR(100)

ALTER TABLE PROCESS ADD ROOT_PROCESS_ID BIGINT DEFAULT 0 NOT NULL

ALTER TABLE RESOURCE_PROVIDERS ADD RESTART_TIME DATETIME

ALTER TABLE enrole.ACTIVITY
  ALTER COLUMN  RESULT_SUMMARY VARCHAR (5);

ALTER TABLE PROCESSDATA ADD VALUE_LAST_MODIFIED BIGINT DEFAULT 0

ALTER TABLE enrole.SCHEDULED_MESSAGE
  ADD REFERENCE2_ID NVARCHAR(50);

CREATE INDEX SCHEDULED_MSG_X ON SCHEDULED_MESSAGE (REFERENCE2_ID ASC);

CREATE TABLE enrole.WI_PARTICIPANT (
  ID    BIGINT  NOT NULL,
  WORKITEM_ID   BIGINT  NOT NULL,
  PARTICIPANT   NVARCHAR (512) NOT NULL,
    PARTICIPANT_TYPE   VARCHAR (2)      NOT NULL,
    CONSTRAINT WI_PARTICIPANT_PK PRIMARY KEY(ID)
   );

CREATE INDEX WIPART_WIID_X ON WI_PARTICIPANT (WORKITEM_ID)
CREATE INDEX WIPART_DN_X ON WI_PARTICIPANT (PARTICIPANT)

INSERT INTO enrole.WI_PARTICIPANT (ID, WORKITEM_ID, PARTICIPANT, PARTICIPANT_TYPE)
SELECT ID,ID, PARTICIPANT, PARTICIPANT_TYPE FROM WORKITEM;


CREATE TABLE enrole.Tmp_WORKITEM (
  ID BIGINT NOT NULL,
  PROCESS_ID BIGINT NOT NULL,
  ACTIVITY_ID BIGINT NOT NULL,
  CREATED NVARCHAR(50),
  INPUT_PARAMETERS NTEXT,
  LOCK_OWNER NVARCHAR(512),
  DUE_DATE BIGINT,
  DESCRIPTION VARCHAR(4000),
  PROCESS_DEFINITION_ID VARCHAR(512) NOT NULL,
  ACTIVITY_DEFINITION_ID VARCHAR(100) NOT NULL,
  ACTIVITY_TYPE VARCHAR(1),
  ACTIVITY_SUBTYPE VARCHAR(2),  
  ACTIVITY_NAME VARCHAR(100),
  REQUESTEE_NAME VARCHAR(100),
  REQUESTER_NAME VARCHAR(100),
  SUBJECT VARCHAR(2000) 
 );
 
 INSERT INTO enrole.Tmp_WORKITEM (ID, PROCESS_ID, ACTIVITY_ID, CREATED, INPUT_PARAMETERS,
 PROCESS_DEFINITION_ID, ACTIVITY_DEFINITION_ID, ACTIVITY_TYPE, ACTIVITY_SUBTYPE, ACTIVITY_NAME, 
 REQUESTEE_NAME, REQUESTER_NAME, SUBJECT)
 SELECT workitem.ID, workitem.PROCESS_ID, workitem.ACTIVITY_ID, workitem.CREATED, workitem.INPUT_PARAMETERS,
 process.DEFINITION_ID, activity.DEFINITION_ID, activity.TYPE, activity.SUBTYPE, activity.NAME, 
 process.REQUESTEE_NAME, process.REQUESTER_NAME, process.SUBJECT
 FROM enrole.WORKITEM, enrole.PROCESS, enrole.ACTIVITY
 where workitem.PROCESS_ID=process.ID and workitem.ACTIVITY_ID=activity.ID;
 
 DROP TABLE enrole.WORKITEM;
 EXECUTE sp_rename N'enrole.Tmp_WORKITEM', N'WORKITEM', 'OBJECT';

 ALTER TABLE enrole.WORKITEM ADD CONSTRAINT
  WORKITEM_PK PRIMARY KEY CLUSTERED
  (
  ID
  ) ON [PRIMARY]


 ALTER TABLE enrole.WORKITEM WITH NOCHECK ADD CONSTRAINT
  WORKITEM2_FK FOREIGN KEY
  (
  ACTIVITY_ID
  ) REFERENCES enrole.ACTIVITY
  (
  ID
  )

 ALTER TABLE enrole.WORKITEM WITH NOCHECK ADD CONSTRAINT
  WORKITEM_FK FOREIGN KEY
  (
  PROCESS_ID
  ) REFERENCES enrole.PROCESS
  (
  ID
  )

CREATE INDEX WORKITEM_PID_X ON WORKITEM (PROCESS_ID)
CREATE INDEX WORKITEM_AID_X ON WORKITEM (ACTIVITY_ID)
CREATE INDEX WORKITEM_ADEF_X ON WORKITEM (ACTIVITY_DEFINITION_ID)
CREATE INDEX WORKITEM_PDEF_X ON WORKITEM (PROCESS_DEFINITION_ID)

ALTER TABLE enrole.WI_PARTICIPANT WITH NOCHECK ADD CONSTRAINT
  WORKITEM_ID_FK FOREIGN KEY
  (WORKITEM_ID) REFERENCES enrole.WORKITEM(ID) ON DELETE CASCADE



CREATE TABLE WORKFLOW_CALLBACK (
  ID BIGINT NOT NULL,
  PROCESS_ID BIGINT NOT NULL,
  MESSAGE_OBJECT NVARCHAR(2000) NOT NULL,
  EVENT_TRIGGER  CHAR(1),
  CONSTRAINT WF_CALLBACK_FK FOREIGN KEY(PROCESS_ID) REFERENCES PROCESS(ID),
  CONSTRAINT WF_CALLBACK_PK PRIMARY KEY(ID)
)

CREATE TABLE SYNCH_POINT (
  PROCESS_ID BIGINT NOT NULL,
  DEFINITION_ID NVARCHAR(100) NOT NULL,
  ACTIVITY_INDEX INT NOT NULL,
  WAIT_LOCK INT NOT NULL,
  JOIN_ENABLED SMALLINT NOT NULL,
  CONSTRAINT SYNCH_POINT_PK PRIMARY KEY(PROCESS_ID, DEFINITION_ID, ACTIVITY_INDEX)
) 

CREATE INDEX SYNCH_POINT_PID_X ON SYNCH_POINT (PROCESS_ID DESC)

/**
--
-- POLICY_ANALYSIS
--
-- This table is used to temporarily store information about policy change analysis.
-- session
--
--
*/
CREATE TABLE POLICY_ANALYSIS (
 ANALYSIS_ID VARCHAR ( 32 ) NOT NULL,
 TENANT_NAME NVARCHAR ( 64 ),
 STATUS SMALLINT DEFAULT 0 NOT NULL,
 REASON SMALLINT NOT NULL,
 CONTEXT SMALLINT NOT NULL,
 CHANGE_TYPE SMALLINT NOT NULL,
 LAST_ACCESSED DATETIME NOT NULL,
 WORKERS_STARTED INTEGER DEFAULT 0,
 WORKERS_COMPLETED INTEGER DEFAULT 0,
 WORKERS_TOTAL INTEGER DEFAULT 0,
 ACCOUNTS_EVALUATED INTEGER DEFAULT 0,
 CONSTRAINT PK_POLICY_ANALYSIS PRIMARY KEY (ANALYSIS_ID),
 CONSTRAINT UC_POLICY_ANALYSIS UNIQUE (ANALYSIS_ID)
 );
/**
--
-- ACCT_CHANGE
--
-- This table is used to temporarily store information about account changes found during
-- policy change analysis.
--
--
*/
CREATE TABLE ACCT_CHANGE (
 CHANGE_ID VARCHAR ( 32 ) NOT NULL,
 ACCT_UID NVARCHAR ( 60 ) NOT NULL,
 ACCT_IDENTIFIER VARCHAR ( 255 ) NOT NULL,
 SERVICE_NAME NVARCHAR ( 200 ) NOT NULL,
 SERVICE_IDENTIFIER VARCHAR ( 255 ) NOT NULL,
 OWNER_NAME NVARCHAR ( 200 ) NOT NULL,
 OWNER_IDENTIFIER VARCHAR ( 255 ) NOT NULL,
 OPERATION_TYPE SMALLINT NOT NULL,
 PROVISION_PRIORITY SMALLINT,
 SEQUENCE_NR SMALLINT,
 REASON SMALLINT NOT NULL,
 STATUS SMALLINT,
 REVOKE_CHANGE SMALLINT NOT NULL,
 POLICY_ANALYSIS_ID VARCHAR ( 32 ) NOT NULL,
 CONSTRAINT PK_ACCT_CHANGE PRIMARY KEY (POLICY_ANALYSIS_ID, CHANGE_ID)
 );
/**
--
-- ATTR_CHANGE
--
-- This table is used to temporarily store information about attribute changes found during
-- policy change analysis.
--
--
*/
CREATE TABLE ATTR_CHANGE (
 CHANGE_ID VARCHAR ( 32 ) NOT NULL,
 ATTR_NAME NVARCHAR ( 100 ) NOT NULL,
 ATTR_VALUE NVARCHAR ( 2000 ),
 OPERATION_TYPE SMALLINT NOT NULL,
 PRIVILEGE_ACTION_TYPE SMALLINT NOT NULL,
 ATTR_VALUE_PRESENCE SMALLINT NOT NULL,
 POLICY_ANALYSIS_ID VARCHAR ( 32 ) NOT NULL,
 ACCT_CHANGE_ID VARCHAR ( 32 ) NOT NULL,
 CONSTRAINT PK_ATTR_CHANGE PRIMARY KEY (POLICY_ANALYSIS_ID, ACCT_CHANGE_ID, CHANGE_ID)
 );
/**
--
-- ATTR_CHANGE
--
-- This table is used to temporarily store information about errors encountered during
-- policy change analysis.
--
--
*/
CREATE TABLE POLICY_ANALYSIS_ERROR (
 ERROR_ID VARCHAR ( 32 ) NOT NULL,
 ENTITY_NAME NVARCHAR ( 100 ),
 ENTITY_IDENTIFIER VARCHAR ( 255 ),
 ENTITY_TYPE SMALLINT,
 SERVICE_NAME NVARCHAR ( 200 ),
 SERVICE_IDENTIFIER VARCHAR ( 255 ),
 PERSON_NAME NVARCHAR ( 200 ),
 PERSON_IDENTIFIER VARCHAR ( 255 ),
 POLICY_NAME NVARCHAR ( 100 ),
 POLICY_IDENTIFIER VARCHAR ( 255 ),
 ATTR_NAME NVARCHAR ( 100 ),
 ERROR_TYPE SMALLINT NOT NULL,
 ENTITY_ERROR_TYPE SMALLINT,
 ERROR_MESSAGE NTEXT NOT NULL,
 POLICY_ANALYSIS_ID VARCHAR ( 32 ) NOT NULL,
 CONSTRAINT PK_ANALYSIS_ERROR PRIMARY KEY (ERROR_ID)
 );
 
ALTER TABLE ACCT_CHANGE ADD CONSTRAINT FK_POLICY_ANALYSIS FOREIGN KEY (POLICY_ANALYSIS_ID) REFERENCES POLICY_ANALYSIS (ANALYSIS_ID)  ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE ATTR_CHANGE ADD CONSTRAINT FK_ATTR_CHANGE FOREIGN KEY (POLICY_ANALYSIS_ID, ACCT_CHANGE_ID) REFERENCES ACCT_CHANGE (POLICY_ANALYSIS_ID, CHANGE_ID)  ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE POLICY_ANALYSIS_ERROR ADD CONSTRAINT FK_ANALYSIS_ERROR FOREIGN KEY (POLICY_ANALYSIS_ID) REFERENCES POLICY_ANALYSIS (ANALYSIS_ID)  ON DELETE CASCADE ON UPDATE NO ACTION;

CREATE TABLE COMPLIANCE_ALERT (
  CA_PROC_ID  BIGINT,
  CA_ISSUE_DN VARCHAR(512) NOT NULL,
  ACTIVITY_ID BIGINT,
  ACCOUNT_DN  VARCHAR(512) NOT NULL,
  PARTICIPANT_DN  VARCHAR(512),
  STARTED   CHAR(1),
  CONSTRAINT PK_CA PRIMARY KEY(CA_ISSUE_DN)
)

CREATE INDEX CA_PID_X ON COMPLIANCE_ALERT(CA_PROC_ID)
CREATE INDEX CA_ACCDN_X ON COMPLIANCE_ALERT(ACCOUNT_DN)
CREATE INDEX CA_ACTID_X ON COMPLIANCE_ALERT(ACTIVITY_ID)


ALTER TABLE REPORT ADD REPORTCATEGORY VARCHAR(255) NOT NULL DEFAULT 'customReports';
ALTER TABLE REPORT ADD REPORTSUBTYPE VARCHAR(255) NOT NULL DEFAULT 'custom';
ALTER TABLE REPORT ADD EDITABLE CHAR(1);

UPDATE REPORT SET EDITABLE='Y'; 

ALTER TABLE ACI ADD OBJECTFILTER VARCHAR(1023);
ALTER TABLE ACI ADD CATEGORY VARCHAR(255);
UPDATE ACI SET OBJECTFILTER='', CATEGORY='';

ALTER TABLE ENTITY_COLUMN ADD IMPLICITLY_MAPPED CHAR(1);
UPDATE ENTITY_COLUMN SET IMPLICITLY_MAPPED='N';

CREATE TABLE AUTHORIZATION_OWNERS (
  USERDN VARCHAR(255) NOT NULL,
  CONTAINERDN VARCHAR(255) NOT NULL, 
  PRIMARY KEY(USERDN, CONTAINERDN)
); 

CREATE TABLE RECONCILIATION (
  RECONID VARCHAR(255) NOT NULL,
  SERVICEDN VARCHAR(2000) NOT NULL,
  PROCESSEDACCOUNTS INTEGER NOT NULL,
  LOCALACCOUNTS INTEGER NOT NULL,
  TIMUSERACCOUNTS INTEGER NOT NULL,
  POLICYVIOLATIONS INTEGER NOT NULL,
  STARTED DATETIME NOT NULL,
  COMPLETED DATETIME NOT NULL,
  PRIMARY KEY (RECONID)
);

CREATE TABLE RECONCILIATION_INFO (
  RECONID VARCHAR(255) NOT NULL,
  ACCOUNTID VARCHAR(255),
  POLICYCOMPLIANCESTATUS VARCHAR(20),
  USERNAME VARCHAR(255),
  OPERATION VARCHAR(20),
  REMARKS VARCHAR(1000),
  FOREIGN KEY (RECONID) REFERENCES RECONCILIATION (RECONID)
);

create table enrole.AUDIT_EVENT
(
  id BIGINT NOT NULL,
  itim_event_category NVARCHAR(50) NOT NULL,
  entity_name NVARCHAR(1000),
  entity_dn NVARCHAR(1000),
  entity_type NVARCHAR(50),
  action NVARCHAR(25) NOT NULL,
  initiator_name NVARCHAR(1000),
  initiator_dn NVARCHAR(1000),
  container_name NVARCHAR(1000),
  container_dn NVARCHAR(1000),
  workflow_process_id BIGINT,
  result_summary NVARCHAR(25),
  timestamp NVARCHAR(50) NOT NULL,
  comments NVARCHAR(1000),
CONSTRAINT AUDIT_EVENT_PK PRIMARY KEY(id)
);


create table enrole.AUDIT_MGMT_PROVISIONING
(
  event_id BIGINT NOT NULL,
  owner_name NVARCHAR(1000),
  owner_dn NVARCHAR(1000),
  service_name NVARCHAR(1000) NOT NULL,
  service_dn NVARCHAR(1000) NOT NULL,
  CONSTRAINT AUDIT_PROV_FK FOREIGN KEY(event_id)
  REFERENCES enrole.AUDIT_EVENT(id)
);


create table enrole.AUDIT_MGMT_TARGET
(
  event_id BIGINT NOT NULL,
  target_entity_name NVARCHAR(1000),
  target_entity_dn NVARCHAR(1000),
  target_entity_type NVARCHAR(50),
  CONSTRAINT AUDIT_TARGET_FK FOREIGN KEY(event_id)
  REFERENCES enrole.AUDIT_EVENT(id)
);

create table enrole.AUDIT_MGMT_DELEGATE
(
  event_id BIGINT NOT NULL,
  delegate_name NVARCHAR(1000),
  delegate_dn NVARCHAR(1000),
  delegate_start_time NVARCHAR(1000),
  delegate_end_time NVARCHAR(1000),
  CONSTRAINT AUDIT_DELEGATE_FK FOREIGN KEY(event_id)
  REFERENCES enrole.AUDIT_EVENT(id)
);

/**
--
-- I18NMESSAGES
--
-- This table is used to store ResourceBundles
--
-- profile - The name of a Service Profile, if any
-- name   - Full ResouceBundle name (e.g., CustomLabels_en)
-- messagekey   - The ResourceBundle key
-- message   - An I18N message mapped to a key
--
*/
CREATE TABLE enrole.I18NMESSAGES (
  profile NVARCHAR(256),
  name NVARCHAR(256) NOT NULL,
  messagekey NVARCHAR(256) NOT NULL,
  message NVARCHAR(2000)
);

create table enrole.BULK_DATA_SERVICE
(
  id BIGINT NOT NULL,
  starttime DATETIME,
  endtime DATETIME,
  mimetype NVARCHAR(50),
  name NVARCHAR(50),
  data IMAGE,
  filesize numeric(19, 0)
  CONSTRAINT BULK_DATA_SERVICE_PK PRIMARY KEY(id)
);

create table enrole.BULK_DATA_STORE
(
  id BIGINT NOT NULL,
  serviceid BIGINT NOT NULL,
  xml IMAGE
  CONSTRAINT BULK_DATA_STORE_FK FOREIGN KEY (serviceid)
  REFERENCES BULK_DATA_SERVICE (id) ON DELETE CASCADE,  
  CONSTRAINT BULK_DATA_STORE_PK PRIMARY KEY(id)
);

CREATE INDEX BDS_SID ON BULK_DATA_STORE (SERVICEID);

create table enrole.BULK_DATA_INDEX
(
  id BIGINT NOT NULL,
  storeid BIGINT NOT NULL,
  dataobjectid VARCHAR(10)
  CONSTRAINT BULK_DATA_INDEX_FK FOREIGN KEY (storeid)
  REFERENCES BULK_DATA_STORE (id) ON DELETE CASCADE,  
  CONSTRAINT BULK_DATA_INDEX_PK PRIMARY KEY(id)
);

CREATE INDEX BDI_SID ON BULK_DATA_INDEX (STOREID);
CREATE INDEX BDI_DOID ON BULK_DATA_INDEX (DATAOBJECTID);

create table enrole.MIGRATION_STATUS
(
  ID BIGINT NOT NULL,
  processCount INTEGER,
  processStatus VARCHAR(50),
  CONSTRAINT MIG_STATUS_PK PRIMARY KEY(ID)
);


CREATE VIEW enrole.ROOTPROCESSVIEW (ID, TYPE, REQUESTER) AS  
(
  (SELECT ID, TYPE, REQUESTER
  FROM PROCESS
  WHERE  PROCESS.ROOT_PROCESS_ID  = 0
  OR PROCESS.ROOT_PROCESS_ID  = PROCESS.ID
  AND PROCESS.TYPE IN ('OP','AA','AC','UA','UC','UD','US','UR','UO','SR','OA','OC','AD',
            'AS','AR','AP','LO','AO','LS','LR','LP','MS','MR','MD','DA','DC','DD',
            'PA','PC','PD','SA','SC','SD','PS','EN','RC','PE','LC','CP','EP','LD')
  )
  UNION
  (
  SELECT ID, 'AA', REQUESTER
  FROM PROCESS
  WHERE  PROCESS.ROOT_PROCESS_ID  = 0
  OR PROCESS.ROOT_PROCESS_ID  = PROCESS.ID
  AND PROCESS.TYPE IN ('OA')
  )

  UNION 
  (
  SELECT ID, 'AC', REQUESTER
  FROM PROCESS
  WHERE  PROCESS.ROOT_PROCESS_ID  = 0
  OR PROCESS.ROOT_PROCESS_ID  = PROCESS.ID
  AND PROCESS.TYPE IN ('OC')
  )
);

CREATE VIEW enrole.SUBPROCESSVIEW (ROOT_PROCESS_ID, SUBMITTED,COMPLETED, SUBJECT_PROFILE, SUBJECT_SERVICE, SUBJECT, 
  RESULT_SUMMARY, TYPE, REQUESTER)AS
(
  SELECT ROOT_PROCESS_ID, SUBMITTED, 
    COMPLETED, SUBJECT_PROFILE, SUBJECT_SERVICE, SUBJECT, 
    RESULT_SUMMARY, TYPE, REQUESTER
  FROM PROCESS
  WHERE PROCESS.TYPE IN ('OA','OC', 'AD', 'AS', 'AR', 'AP')
);

CREATE VIEW enrole.PENDING_APPROVAL
(PROCESSID, RESULT_SUMMARY)
AS
	(
		(
			SELECT PROCESS.ID, ACTIVITY.RESULT_SUMMARY
			FROM PROCESS, ACTIVITY, WORKITEM
			WHERE 
				WORKITEM.PROCESS_ID = PROCESS.ID AND 
				WORKITEM.ACTIVITY_ID = ACTIVITY.ID AND 
				WORKITEM.LOCK_OWNER IS NULL
		)
		UNION
		(
			SELECT PROCESS.ID, 'LK'
			FROM PROCESS, ACTIVITY, WORKITEM
			WHERE 
				WORKITEM.PROCESS_ID = PROCESS.ID AND 
				WORKITEM.ACTIVITY_ID = ACTIVITY.ID AND 
				WORKITEM.LOCK_OWNER IS NOT NULL
		)
);

ALTER TABLE ENTITLEMENT_PROVISIONINGPARAMS 
ALTER COLUMN ATTRIBUTEVALUE VARCHAR(4000);

ALTER TABLE RESOURCE_PROVIDERS ADD SERVER NVARCHAR(20);

CREATE TABLE SUMMARY_ORDER (
    RESULT_SUMMARY NVARCHAR(2) NOT NULL,
    RESULT_SEVERITY SMALLINT NOT NULL UNIQUE,
    CONSTRAINT Uni_ResultSummary PRIMARY KEY(RESULT_SUMMARY),
    CONSTRAINT Range_Value CHECK (RESULT_SEVERITY >= 0 AND RESULT_SEVERITY <= 100)
);

INSERT INTO SUMMARY_ORDER(RESULT_SUMMARY, RESULT_SEVERITY) VALUES ('SF', 100);
INSERT INTO SUMMARY_ORDER(RESULT_SUMMARY, RESULT_SEVERITY) VALUES ('SW', 99);
INSERT INTO SUMMARY_ORDER(RESULT_SUMMARY, RESULT_SEVERITY) VALUES ('ST', 98);
INSERT INTO SUMMARY_ORDER(RESULT_SUMMARY, RESULT_SEVERITY) VALUES ('AR', 97);
INSERT INTO SUMMARY_ORDER(RESULT_SUMMARY, RESULT_SEVERITY) VALUES ('PF', 96);
INSERT INTO SUMMARY_ORDER(RESULT_SUMMARY, RESULT_SEVERITY) VALUES ('SK', 95);
INSERT INTO SUMMARY_ORDER(RESULT_SUMMARY, RESULT_SEVERITY) VALUES ('ES', 94);
INSERT INTO SUMMARY_ORDER(RESULT_SUMMARY, RESULT_SEVERITY) VALUES ('AA', 93);
INSERT INTO SUMMARY_ORDER(RESULT_SUMMARY, RESULT_SEVERITY) VALUES ('RS', 92);
INSERT INTO SUMMARY_ORDER(RESULT_SUMMARY, RESULT_SEVERITY) VALUES ('PE', 1);
INSERT INTO SUMMARY_ORDER(RESULT_SUMMARY, RESULT_SEVERITY) VALUES ('SS', 0);

CREATE TABLE PASSWORD_SYNCH (
	ACTIVITY_ID BIGINT NOT NULL,
	ACCOUNT_DN NVARCHAR(512),
	TIME_REQUESTED NVARCHAR(50),
	PASSWORD NVARCHAR(500),
	
	CONSTRAINT PWD_SYNCH_PK PRIMARY KEY(ACTIVITY_ID)
);

CREATE INDEX PS_ACCDN_X ON PASSWORD_SYNCH(ACCOUNT_DN);
CREATE INDEX PS_TIME_X ON PASSWORD_SYNCH(TIME_REQUESTED);
