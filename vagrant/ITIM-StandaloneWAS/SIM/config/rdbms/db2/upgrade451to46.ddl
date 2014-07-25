CREATE INDEX RS_REQ_PID_X ON REMOTE_SERVICES_REQUESTS(PROVIDER_ID);
CREATE INDEX RS_REQ_RTIME_X ON REMOTE_SERVICES_REQUESTS(REQUEST_TIME);

CREATE TABLE LCR_INPROGRESS_TABLE (
  TENANT VARCHAR(256) NOT NULL,
  RULE_ID BIGINT NOT NULL,
  RULE_OP VARCHAR(256),
  CHILD_ID BIGINT,
  START_TIME BIGINT,
  ENTITY_ID VARCHAR(256) NOT NULL,
  CONSTRAINT Unique_RuleEntity PRIMARY KEY(RULE_ID,ENTITY_ID)
) IN ENROLE_DATA INDEX IN ENROLE_INDEXES;
COMMIT;

CREATE TABLE PO_TOPIC_TABLE (
  TENANT      VARCHAR(256)   NOT NULL,
  TOPIC       VARCHAR(256)   NOT NULL,
  SERVER      VARCHAR(20),
  CHECKPOINT_TIME BIGINT,
  TOPIC_ID       BIGINT      NOT NULL,
  CONSTRAINT Unique_TenantTopic PRIMARY KEY(TENANT,TOPIC),
  CONSTRAINT Unique_TopicID UNIQUE(TOPIC_ID)
) IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE TABLE PO_NOTIFICATION_TABLE (
  NOTIFICATION_ID   BIGINT  NOT NULL,
  TOPIC_ID        BIGINT      NOT NULL,
  SUBJECT     VARCHAR(2000),
  TEXTBODY       CLOB(100K),
  RECEIVE_TIME    BIGINT       NOT NULL,
  RECIPIENT_EADDR VARCHAR(320)  NOT NULL,
  RECIPIENT_LOCALE   VARCHAR(256),
  CONSTRAINT TenantTopic_parent
  FOREIGN KEY(TOPIC_ID) REFERENCES PO_TOPIC_TABLE(TOPIC_ID) ON DELETE RESTRICT,
  CONSTRAINT NOTIFICATION_ID_PK PRIMARY KEY(NOTIFICATION_ID)
) IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE INDEX PO_NotifyIndex ON PO_NOTIFICATION_TABLE(TOPIC_ID);


CREATE TABLE PO_NOTIFICATION_HTMLBODY_TABLE (
  NOTIFICATION_ID        BIGINT NOT NULL,
  HTMLBODY            CLOB(100K),
  CONSTRAINT NotificationIDHTML FOREIGN KEY(NOTIFICATION_ID) REFERENCES PO_NOTIFICATION_TABLE(NOTIFICATION_ID) ON DELETE CASCADE,
  CONSTRAINT NOTIFI_ID_HTML_PK PRIMARY KEY(NOTIFICATION_ID)
 ) IN ENROLE_DATA INDEX IN ENROLE_INDEXES;


ALTER TABLE PROCESS ADD SUBJECT_PROFILE VARCHAR(100);
COMMIT;

ALTER TABLE PROCESS ADD SUBJECT_SERVICE VARCHAR(100);
COMMIT;

ALTER TABLE PROCESS ADD ROOT_PROCESS_ID BIGINT DEFAULT 0 NOT NULL;
COMMIT;

ALTER TABLE ACTIVITY ALTER COLUMN RESULT_SUMMARY SET DATA TYPE VARCHAR(5);
COMMIT;

ALTER TABLE PROCESSDATA ADD VALUE_LAST_MODIFIED BIGINT DEFAULT 0;
COMMIT;

ALTER TABLE SCHEDULED_MESSAGE ADD REFERENCE2_ID VARCHAR(50);
COMMIT;

CREATE INDEX SCHEDULED_MSG_X ON SCHEDULED_MESSAGE (REFERENCE2_ID ASC);
COMMIT;

ALTER TABLE RESOURCE_PROVIDERS ADD RESTART_TIME TIMESTAMP;
COMMIT;

CREATE TABLE WI_PARTICIPANT (
  ID  BIGINT NOT NULL ,
  WORKITEM_ID   BIGINT  NOT NULL,
  PARTICIPANT   VARCHAR (512)  NOT NULL,
  PARTICIPANT_TYPE   VARCHAR (2)    NOT NULL,
  CONSTRAINT WI_PARTICIPANT_PK PRIMARY KEY(ID)
)IN ENROLE_DATA INDEX IN ENROLE_INDEXES;
COMMIT;

CREATE INDEX WIPART_WIID_X ON WI_PARTICIPANT (WORKITEM_ID);
CREATE INDEX WIPART_DN_X ON WI_PARTICIPANT (PARTICIPANT);
COMMIT;

INSERT INTO WI_PARTICIPANT (ID,WORKITEM_ID, PARTICIPANT, PARTICIPANT_TYPE)
SELECT ID,ID, PARTICIPANT, PARTICIPANT_TYPE FROM WORKITEM;
COMMIT;

CREATE TABLE enrole.Tmp_WORKITEM (
  ID BIGINT NOT NULL,
  PROCESS_ID BIGINT NOT NULL,
  ACTIVITY_ID BIGINT NOT NULL,
  CREATED VARCHAR(50),
  INPUT_PARAMETERS CLOB(10M),
  LOCK_OWNER VARCHAR(512),
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
 )IN ENROLE_DATA INDEX IN ENROLE_INDEXES;
 COMMIT;

 INSERT INTO enrole.Tmp_WORKITEM (ID, PROCESS_ID, ACTIVITY_ID, CREATED, INPUT_PARAMETERS,
 PROCESS_DEFINITION_ID, ACTIVITY_DEFINITION_ID, ACTIVITY_TYPE, ACTIVITY_SUBTYPE, ACTIVITY_NAME,
 REQUESTEE_NAME, REQUESTER_NAME, SUBJECT)
 SELECT workitem.ID, workitem.PROCESS_ID, workitem.ACTIVITY_ID, workitem.CREATED, workitem.INPUT_PARAMETERS,
 process.DEFINITION_ID, activity.DEFINITION_ID, activity.TYPE, activity.SUBTYPE, activity.NAME,
 process.REQUESTEE_NAME, process.REQUESTER_NAME, process.SUBJECT
 FROM enrole.WORKITEM, enrole.PROCESS, enrole.ACTIVITY
 where workitem.PROCESS_ID=process.ID and workitem.ACTIVITY_ID=activity.ID;
 COMMIT;

 DROP TABLE enrole.WORKITEM;
 COMMIT;

 RENAME TABLE Tmp_WORKITEM TO WORKITEM;
 COMMIT;


 ALTER TABLE enrole.WORKITEM ADD CONSTRAINT
   WORKITEM_PK PRIMARY KEY (ID);
 COMMIT;


 ALTER TABLE enrole.WORKITEM ADD CONSTRAINT
   WORKITEM2_FK FOREIGN KEY
   (ACTIVITY_ID) REFERENCES enrole.ACTIVITY (ID);
 COMMIT;

 ALTER TABLE enrole.WORKITEM ADD CONSTRAINT
   WORKITEM_FK FOREIGN KEY
   (PROCESS_ID) REFERENCES enrole.PROCESS (ID);
 COMMIT;

 ALTER TABLE enrole.WI_PARTICIPANT ADD CONSTRAINT
   WORKITEM_ID_FK FOREIGN KEY
   (WORKITEM_ID) REFERENCES enrole.WORKITEM(ID) ON DELETE CASCADE;
 COMMIT;

CREATE INDEX WORKITEM_PID_X ON WORKITEM (PROCESS_ID);
COMMIT;
CREATE INDEX WORKITEM_AID_X ON WORKITEM (ACTIVITY_ID);
COMMIT;
CREATE INDEX WORKITEM_ADEF_X ON WORKITEM (ACTIVITY_DEFINITION_ID);
COMMIT;
CREATE INDEX WORKITEM_PDEF_X ON WORKITEM (PROCESS_DEFINITION_ID);
COMMIT;

CREATE TABLE WORKFLOW_CALLBACK (
  ID BIGINT NOT NULL,
  PROCESS_ID BIGINT NOT NULL,
  MESSAGE_OBJECT VARCHAR(2000) NOT NULL,
  EVENT_TRIGGER  CHAR(1),
  CONSTRAINT WF_CALLBACK_FK FOREIGN KEY(PROCESS_ID) REFERENCES PROCESS(ID),
  CONSTRAINT WF_CALLBACK_PK PRIMARY KEY(ID)
) IN ENROLE_DATA INDEX IN ENROLE_INDEXES;
COMMIT;

CREATE TABLE SYNCH_POINT (
  PROCESS_ID BIGINT NOT NULL,
  DEFINITION_ID VARCHAR(100) NOT NULL,
  ACTIVITY_INDEX INTEGER NOT NULL,
  WAIT_LOCK INTEGER NOT NULL,
  JOIN_ENABLED SMALLINT NOT NULL,
  CONSTRAINT SYNCH_POINT_PK PRIMARY KEY(PROCESS_ID, DEFINITION_ID, ACTIVITY_INDEX)
) IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE INDEX SYNCH_POINT_PID_X ON SYNCH_POINT (PROCESS_ID DESC);
COMMIT;

ALTER TABLE REPORT ADD REPORTCATEGORY VARCHAR(255) NOT NULL DEFAULT 'customReports';
COMMIT;
ALTER TABLE REPORT ADD REPORTSUBTYPE VARCHAR(255) NOT NULL DEFAULT 'custom';
COMMIT;
ALTER TABLE REPORT ADD EDITABLE CHAR(1);
COMMIT;

UPDATE REPORT SET EDITABLE='Y';
COMMIT;

ALTER TABLE ACI ADD OBJECTFILTER VARCHAR(1023);
COMMIT;
ALTER TABLE ACI ADD CATEGORY VARCHAR(255);
COMMIT;
UPDATE ACI SET OBJECTFILTER='', CATEGORY='';
COMMIT;

ALTER TABLE ENTITY_COLUMN ADD IMPLICITLY_MAPPED CHAR(1);
COMMIT;
UPDATE ENTITY_COLUMN SET IMPLICITLY_MAPPED='N';
COMMIT;

CREATE TABLE AUTHORIZATION_OWNERS (
  USERDN VARCHAR(255) NOT NULL,
  CONTAINERDN VARCHAR(255) NOT NULL,
  PRIMARY KEY(USERDN, CONTAINERDN)
)IN ENROLE_DATA;
COMMIT;

CREATE TABLE RECONCILIATION (
  RECONID VARCHAR(255) NOT NULL,
  SERVICEDN VARCHAR(2000) NOT NULL,
  PROCESSEDACCOUNTS INTEGER NOT NULL,
  LOCALACCOUNTS INTEGER NOT NULL,
  TIMUSERACCOUNTS INTEGER NOT NULL,
  POLICYVIOLATIONS INTEGER NOT NULL,
  STARTED TIMESTAMP NOT NULL,
  COMPLETED TIMESTAMP NOT NULL,
  PRIMARY KEY (RECONID)
)IN ENROLE_DATA;
COMMIT;

CREATE TABLE RECONCILIATION_INFO (
  RECONID VARCHAR(255) NOT NULL,
  ACCOUNTID VARCHAR(255),
  POLICYCOMPLIANCESTATUS VARCHAR(20),
  USERNAME VARCHAR(255),
  OPERATION VARCHAR(20),
  REMARKS VARCHAR(1000),
  FOREIGN KEY (RECONID) REFERENCES RECONCILIATION (RECONID)
)IN ENROLE_DATA;
COMMIT;

CREATE TABLE POLICY_ANALYSIS (
  ANALYSIS_ID VARCHAR(32) NOT NULL,
  TENANT_NAME VARCHAR(64),
  STATUS INTEGER NOT NULL,
  REASON INTEGER NOT NULL,
  CONTEXT INTEGER NOT NULL,
  CHANGE_TYPE INTEGER NOT NULL,
  LAST_ACCESSED TIMESTAMP NOT NULL,
  WORKERS_STARTED INTEGER DEFAULT 0 NOT NULL,
  WORKERS_COMPLETED INTEGER DEFAULT 0 NOT NULL,
  WORKERS_TOTAL INTEGER DEFAULT 0 NOT NULL,
  ACCOUNTS_EVALUATED INTEGER DEFAULT 0 NOT NULL,
  CONSTRAINT PK_POLICY_ANALYSIS PRIMARY KEY(ANALYSIS_ID)
)
IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE TABLE ACCT_CHANGE (
  CHANGE_ID VARCHAR(32) NOT NULL,
  ACCT_UID VARCHAR(60) NOT NULL,
  ACCT_IDENTIFIER VARCHAR(255) NOT NULL,
  SERVICE_NAME VARCHAR(200) NOT NULL,
  SERVICE_IDENTIFIER VARCHAR(255) NOT NULL,
  OWNER_NAME VARCHAR(200) NOT NULL,
  OWNER_IDENTIFIER VARCHAR(255) NOT NULL,
  OPERATION_TYPE INTEGER NOT NULL,
  PROVISION_PRIORITY INTEGER,
  SEQUENCE_NR INTEGER,
  REASON INTEGER NOT NULL,
  REVOKE_CHANGE INTEGER NOT NULL,
  STATUS SMALLINT,
  POLICY_ANALYSIS_ID VARCHAR(32) NOT NULL,
  CONSTRAINT FK_POLICY_ANALYSIS FOREIGN KEY(POLICY_ANALYSIS_ID) REFERENCES POLICY_ANALYSIS(ANALYSIS_ID)
  ON DELETE CASCADE,
  CONSTRAINT PK_ACCT_CHANGE PRIMARY KEY(POLICY_ANALYSIS_ID, CHANGE_ID)
)
IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE TABLE ATTR_CHANGE (
  CHANGE_ID VARCHAR(32) NOT NULL,
  ATTR_NAME VARCHAR(100) NOT NULL,
  ATTR_VALUE VARCHAR(2000),
  OPERATION_TYPE INTEGER NOT NULL,
  PRIVILEGE_ACTION_TYPE INTEGER NOT NULL,
  ATTR_VALUE_PRESENCE INTEGER NOT NULL,
  POLICY_ANALYSIS_ID VARCHAR(32) NOT NULL,
  ACCT_CHANGE_ID VARCHAR(32) NOT NULL,
  CONSTRAINT FK_ATTR_CHANGE FOREIGN KEY(POLICY_ANALYSIS_ID, ACCT_CHANGE_ID)
  REFERENCES ACCT_CHANGE(POLICY_ANALYSIS_ID, CHANGE_ID)
  ON DELETE CASCADE,
  CONSTRAINT PK_ATTR_CHANGE PRIMARY KEY(POLICY_ANALYSIS_ID, ACCT_CHANGE_ID, CHANGE_ID)
)
IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE TABLE POLICY_ANALYSIS_ERROR (
  ERROR_ID  VARCHAR(32) NOT NULL,
  ENTITY_NAME VARCHAR(100),
  ENTITY_IDENTIFIER VARCHAR(255),
  ENTITY_TYPE  INTEGER,
  SERVICE_NAME VARCHAR(200),
  SERVICE_IDENTIFIER VARCHAR(255),
  PERSON_NAME  VARCHAR(200),
  PERSON_IDENTIFIER VARCHAR(255),
  POLICY_NAME VARCHAR(100),
  POLICY_IDENTIFIER VARCHAR(255),
  ATTR_NAME VARCHAR(100),
  ERROR_TYPE INTEGER NOT NULL,
  ENTITY_ERROR_TYPE  INTEGER,
  ERROR_MESSAGE CLOB NOT NULL,
  POLICY_ANALYSIS_ID VARCHAR(32) NOT NULL,
  CONSTRAINT FK_ANALYSIS_ERROR FOREIGN KEY(POLICY_ANALYSIS_ID) REFERENCES POLICY_ANALYSIS(ANALYSIS_ID)
  ON DELETE CASCADE,
  CONSTRAINT PK_ANALYSIS_ERROR PRIMARY KEY(ERROR_ID)
)
IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE TABLE COMPLIANCE_ALERT (
  CA_PROC_ID   BIGINT,
  CA_ISSUE_DN VARCHAR(512) NOT NULL,
  ACTIVITY_ID   BIGINT,
  ACCOUNT_DN  VARCHAR(512) NOT NULL,
  PARTICIPANT_DN  VARCHAR(512),
  STARTED   CHAR(1),
  CONSTRAINT PK_CA PRIMARY KEY(CA_ISSUE_DN)
)
IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE INDEX CA_PID_X ON COMPLIANCE_ALERT(CA_PROC_ID);
CREATE INDEX CA_ACCDN_X ON COMPLIANCE_ALERT(ACCOUNT_DN);
CREATE INDEX CA_ACTID_X ON COMPLIANCE_ALERT(ACTIVITY_ID);


create table enrole.AUDIT_EVENT
(
  id BIGINT NOT NULL,
  itim_event_category VARCHAR(50) NOT NULL,
  entity_name VARCHAR(1000),
  entity_dn VARCHAR(1000),
  entity_type VARCHAR(50),
  action VARCHAR(25) NOT NULL,
  workflow_process_id BIGINT,
  initiator_name VARCHAR(1000),
  initiator_dn VARCHAR(1000),
  container_name VARCHAR(1000),
  container_dn VARCHAR(1000),
  result_summary VARCHAR(25),
  timestamp VARCHAR(50) NOT NULL,
  comments VARCHAR(1000),
CONSTRAINT AUDIT_EVENT_PK PRIMARY KEY(id)
)
IN ENROLE_DATA INDEX IN ENROLE_INDEXES;


create table enrole.AUDIT_MGMT_TARGET
(
  event_id BIGINT NOT NULL,
  target_entity_name VARCHAR(1000),
  target_entity_dn VARCHAR(1000),
  target_entity_type VARCHAR(50),
  CONSTRAINT AUDIT_TARGET_FK FOREIGN KEY(event_id)
  REFERENCES enrole.AUDIT_EVENT(id)
)
IN ENROLE_DATA INDEX IN ENROLE_INDEXES;


create table enrole.AUDIT_MGMT_PROVISIONING
(
  event_id BIGINT NOT NULL,
  owner_name VARCHAR(1000),
  owner_dn VARCHAR(1000),
  service_name VARCHAR(1000) NOT NULL,
  service_dn VARCHAR(1000) NOT NULL,
  CONSTRAINT AUDIT_PROV_FK FOREIGN KEY(event_id)
  REFERENCES enrole.AUDIT_EVENT(id)
)
IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

create table enrole.AUDIT_MGMT_DELEGATE
(
  event_id BIGINT NOT NULL,
  delegate_name VARCHAR(1000),
  delegate_dn VARCHAR(1000),
  delegate_start_time VARCHAR(1000),
  delegate_end_time VARCHAR(1000),
  CONSTRAINT AUDIT_DELEGATE_FK FOREIGN KEY(event_id)
  REFERENCES enrole.AUDIT_EVENT(id)
)
IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE TABLE enrole.I18NMESSAGES (
  PROFILE VARCHAR(256),
  NAME VARCHAR(256) NOT NULL,
  MESSAGEKEY VARCHAR(256) NOT NULL,
  MESSAGE VARCHAR(2000)
)IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE TABLE ENROLE.BULK_DATA_SERVICE
(
  ID BIGINT NOT NULL,
  STARTTIME TIMESTAMP,
  ENDTIME TIMESTAMP,
  MIMETYPE VARCHAR(50),
  NAME VARCHAR(50),
  DATA BLOB(50M),
  FILESIZE INTEGER,
  CONSTRAINT BULK_DATA_SRC_PK PRIMARY KEY(ID)
)
IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE TABLE ENROLE.BULK_DATA_STORE
(
  ID BIGINT NOT NULL,
  SERVICEID BIGINT NOT NULL,
  XML BLOB(1M),
  CONSTRAINT BULK_DATA_STORE_FK FOREIGN KEY (SERVICEID)
  REFERENCES BULK_DATA_SERVICE (ID) ON DELETE CASCADE,
  CONSTRAINT BULK_DATA_STORE_PK PRIMARY KEY(ID)
)
IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE INDEX BDS_SID ON ENROLE.BULK_DATA_STORE (SERVICEID DESC);

CREATE TABLE ENROLE.BULK_DATA_INDEX
(
  ID BIGINT NOT NULL,
  STOREID BIGINT NOT NULL,
  DATAOBJECTID VARCHAR(10),
  CONSTRAINT BULK_DATA_INDEX_FK FOREIGN KEY (STOREID)
  REFERENCES BULK_DATA_STORE (ID) ON DELETE CASCADE,
  CONSTRAINT BULK_DATA_INDEX_PK PRIMARY KEY(ID)
)
IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE INDEX BDI_SID ON ENROLE.BULK_DATA_INDEX (STOREID DESC);
CREATE INDEX BDI_DOID ON ENROLE.BULK_DATA_INDEX (DATAOBJECTID DESC);

create table enrole.MIGRATION_STATUS (
  ID BIGINT NOT NULL,
  processCount INTEGER,
  processStatus VARCHAR(50),
  CONSTRAINT MIG_STATUS_PK PRIMARY KEY(ID)
) IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

COMMIT;

CREATE VIEW enrole.ROOTPROCESSVIEW (ID, TYPE, REQUESTER) AS
(
  (SELECT ID, TYPE, REQUESTER
  FROM enrole.PROCESS
  WHERE  PROCESS.ROOT_PROCESS_ID  = 0
  OR PROCESS.ROOT_PROCESS_ID  = PROCESS.ID
  AND PROCESS.TYPE IN ('OP','AA','AC','UA','UC','UD','US','UR','UO','SR','OA','OC','AD',
            'AS','AR','AP','LO','AO','LS','LR','LP','MS','MR','MD','DA','DC',
            'DD','PA','PC','PD','SA','SC','SD','PS','EN','RC','PE','LC','CP','EP','LD')
  )
  UNION
  (
  SELECT ID, 'AA', REQUESTER
  FROM enrole.PROCESS
  WHERE  PROCESS.ROOT_PROCESS_ID  = 0
  OR PROCESS.ROOT_PROCESS_ID  = PROCESS.ID
  AND PROCESS.TYPE IN ('OA')
  )

  UNION
  (
  SELECT ID, 'AC', REQUESTER
  FROM enrole.PROCESS
  WHERE  PROCESS.ROOT_PROCESS_ID  = 0
  OR PROCESS.ROOT_PROCESS_ID  = PROCESS.ID
  AND PROCESS.TYPE IN ('OC')
  )
);

COMMIT;

CREATE VIEW enrole.SUBPROCESSVIEW (ROOT_PROCESS_ID, SUBMITTED,COMPLETED, SUBJECT_PROFILE, SUBJECT_SERVICE, SUBJECT,
  RESULT_SUMMARY, TYPE, REQUESTER)AS
(
  SELECT ROOT_PROCESS_ID, SUBMITTED,
    COMPLETED, SUBJECT_PROFILE, SUBJECT_SERVICE, SUBJECT,
    RESULT_SUMMARY, TYPE, REQUESTER
  FROM enrole.PROCESS
  WHERE PROCESS.TYPE IN ('OA','OC', 'AD', 'AS', 'AR', 'AP')
);

COMMIT;

CREATE VIEW enrole.PENDING_APPROVAL
(PROCESSID, RESULT_SUMMARY)
AS
	(
		(
			SELECT PROCESS.ID, ACTIVITY.RESULT_SUMMARY
			FROM enrole.PROCESS, enrole.ACTIVITY, enrole.WORKITEM
			WHERE
				WORKITEM.PROCESS_ID = PROCESS.ID AND
				WORKITEM.ACTIVITY_ID = ACTIVITY.ID AND
				WORKITEM.LOCK_OWNER IS NULL
		)
		UNION
		(
			SELECT PROCESS.ID, 'LK'
			FROM enrole.PROCESS, enrole.ACTIVITY, enrole.WORKITEM
			WHERE
				WORKITEM.PROCESS_ID = PROCESS.ID AND
				WORKITEM.ACTIVITY_ID = ACTIVITY.ID AND
				WORKITEM.LOCK_OWNER IS NOT NULL
		)
);

COMMIT;

ALTER TABLE ENTITLEMENT_PROVISIONINGPARAMS
ALTER ATTRIBUTEVALUE SET DATA TYPE VARCHAR(4000);

ALTER TABLE RESOURCE_PROVIDERS ADD SERVER VARCHAR(20);

CREATE TABLE SUMMARY_ORDER (
    RESULT_SUMMARY VARCHAR(2) NOT NULL,
    RESULT_SEVERITY SMALLINT NOT NULL UNIQUE,
    CONSTRAINT Uni_ResultSummary PRIMARY KEY(RESULT_SUMMARY),
    CONSTRAINT Range_Value CHECK (RESULT_SEVERITY >= 0 AND RESULT_SEVERITY <= 100)
);

COMMIT;

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

COMMIT;

CREATE TABLE PASSWORD_SYNCH (
	ACTIVITY_ID BIGINT NOT NULL,
	ACCOUNT_DN VARCHAR(512),
	TIME_REQUESTED VARCHAR(50),
	PASSWORD VARCHAR(500),
	CONSTRAINT PWD_SYNCH_PK PRIMARY KEY(ACTIVITY_ID)
) IN ENROLE_DATA INDEX IN ENROLE_INDEXES;

CREATE INDEX PS_ACCDN_X ON PASSWORD_SYNCH(ACCOUNT_DN);
CREATE INDEX PS_TIME_X ON PASSWORD_SYNCH(TIME_REQUESTED);

COMMIT;
