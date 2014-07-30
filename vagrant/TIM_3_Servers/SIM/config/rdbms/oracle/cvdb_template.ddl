-- %L% %M% %I% %W% %G% %U%
--
-- --------------- Begin Copyright - Do not add comments here --------------
--
--  Component Name: cv.server
-- 
--  IBM Confidential
--  Object Code Only Source Materials
--  
--  (c) Copyright International Business Machines Corp. 2009, 2010
--  The source code for this program is not published or otherwise divested
--  of its trade secrets, irrespective of what has been deposited with the
--  U.S. Copyright Office.
--
-- ----------------------------- End Copyright -----------------------------

-- Oracle Create CVDB Schema sql --

CREATE TABLESPACE CVDB_data
DATAFILE 'CVDB.dbf'
SIZE 50M
AUTOEXTEND ON
NEXT 10M
MAXSIZE unlimited
DEFAULT STORAGE (INITIAL 10M
   NEXT 1M
   PCTINCREASE 10)
PERMANENT
ONLINE
LOGGING;

CREATE USER CVDB IDENTIFIED BY i1t2m3l4
   DEFAULT TABLESPACE CVDB_data
   QuOTA UNLIMITED ON CVDB_data;

CREATE TABLE CVDB.LObject (
  uuid                  VARCHAR2(36) PRIMARY KEY NOT NULL, 
  type                  VARCHAR2(512),                     
  algorithm             VARCHAR2(512),      
  length                NUMBER(11,0),           
  certType             VARCHAR2(512),     
  issuer                VARCHAR2(512),     
  serialNumber          VARCHAR2(64),    
  subjectDN               VARCHAR2(512),    
  usage                 VARCHAR2(256), 
  leaseTime             NUMBER(11,0), 
  limitBytesTotal        NUMBER(18,0), 
  limitBytesCurrent     NUMBER(18,0),
  limitObjectsTotal     NUMBER(18,0),
  limitObjectsCurrent   NUMBER(18,0),
  state                 NUMBER(11,0), 
  initialization        TIMESTAMP,     
  activation            TIMESTAMP,    
  processstart          TIMESTAMP,    
  protectstop           TIMESTAMP,    
  deactivation          TIMESTAMP, 
  destruction           TIMESTAMP, 
  compromiseOccurrence  TIMESTAMP, 
  compromise            TIMESTAMP, 
  revocationReasonCode  NUMBER(11,0), 
  revocationReasonText  VARCHAR2(1024), 
  archivalDate          TIMESTAMP, 
  contactInfo           VARCHAR2(512), 
  modifyDate            TIMESTAMP,      
  format                VARCHAR2(256),   
  datatype              NUMBER(11,0),   
  encoding              BLOB, 
  version               NUMBER(19,0),
  owner                 VARCHAR2(1024)
)TABLESPACE CVDB_data;

CREATE TABLE CVDB.Name (
  uuid      VARCHAR2(36),
  name      VARCHAR2(512) NOT NULL,
  nameType  NUMBER(11,0) NOT NULL,
  index_Name     NUMBER(11,0),
  PRIMARY KEY (name, nameType)
)TABLESPACE CVDB_data;

CREATE INDEX NAMEUUIDX on CVDB.NAME (UUID ASC) TABLESPACE CVDB_data; 

CREATE TABLE CVDB.CryptoParams (
 uuid VARCHAR2(36) NOT NULL,                            
 blockCipherMode NUMBER(11,0),										 
 paddingMethod NUMBER(11,0), 											 
 hashingAlgorithm NUMBER(11,0),		    						 
 roleType NUMBER(11,0),
 index_CryptoParams NUMBER(11,0) NOT NULL,
 PRIMARY KEY (uuid, index_CryptoParams) 		    						         
)TABLESPACE CVDB_data;

CREATE TABLE CVDB.Link (
  uuid      VARCHAR2(36) NOT NULL,
  linkType  VARCHAR2(100),
  linkUuid  VARCHAR2(36),
  index_Link NUMBER(11,0) NOT NULL,
  PRIMARY KEY (uuid, index_Link)
)TABLESPACE CVDB_data;

CREATE TABLE CVDB.AppID (
  uuid              VARCHAR2(36) NOT NULL,
  applicationName   VARCHAR2(1024),
  applicationID     VARCHAR2(100),
  index_AppID	    NUMBER(11,0) NOT NULL,
  PRIMARY KEY (uuid, index_AppID)
)TABLESPACE CVDB_data;

CREATE TABLE CVDB.CustomAttr (
  uuid      VARCHAR2(36) NOT NULL,
  name      VARCHAR2(100) NOT NULL,
  value     CLOB,
  index_CustomAttr NUMBER(11,0) NOT NULL,
  PRIMARY KEY (uuid, name, index_CustomAttr)
)TABLESPACE CVDB_data;

CREATE TABLE CVDB.ObjectGroup (
  uuid          VARCHAR2(36) NOT NULL,
  objectGroup   VARCHAR2(100),
  index_ObjectGroup         NUMBER(11,0) NOT NULL,
  PRIMARY KEY (uuid, index_ObjectGroup)
)TABLESPACE CVDB_data;

CREATE TABLE CVDB.SubjectAN (
  uuid       VARCHAR2(36) NOT NULL,
  subjectAN  VARCHAR2(1024) NOT NULL,
  index_subjectAN         NUMBER(11,0) NOT NULL,
  PRIMARY KEY (uuid, index_subjectAN)
)TABLESPACE CVDB_data;

CREATE TABLE CVDB.CV_KEYSTORE (
    keystoreexist NUMBER(1,0) NOT NULL,
    keystorepwd VARCHAR2(1024) NOT NULL
)TABLESPACE CVDB_data;

CREATE TABLE CVDB.DIGEST (
  UUID VARCHAR2(36) NOT NULL , 
  DIGESTVALUE VARCHAR2(1024) NOT NULL , 
  ALGORITHM NUMBER(11,0) NOT NULL , 
  INDEX_DIGEST NUMBER(11,0) NOT NULL,
  PRIMARY KEY (UUID, INDEX_DIGEST)
 )TABLESPACE CVDB_data; 

CREATE TABLE CVDB.CV_METADATA (
  PROPERTY_NAME       VARCHAR2(254) NOT NULL,
  PROPERTY_VALUE  VARCHAR2(1024) NOT NULL
)TABLESPACE CVDB_data;

INSERT INTO CVDB.CV_METADATA
(property_name,property_value)
VALUES
('SchemaMajorVersion','1');

INSERT INTO CVDB.CV_METADATA
(property_name,property_value)
VALUES
('SchemaMinorVersion','0');

INSERT INTO CVDB.CV_METADATA
(property_name,property_value)
VALUES
('SchemaPtfLevel','0');

GRANT SELECT,INSERT,DELETE,UPDATE ON CVDB.LObject TO itimuserTag;

GRANT SELECT,INSERT,DELETE,UPDATE ON CVDB.Name TO itimuserTag;

GRANT SELECT,INSERT,DELETE,UPDATE ON CVDB.CryptoParams TO itimuserTag;

GRANT SELECT,INSERT,DELETE,UPDATE ON CVDB.Link TO itimuserTag;

GRANT SELECT,INSERT,DELETE,UPDATE ON CVDB.AppID TO itimuserTag;

GRANT SELECT,INSERT,DELETE,UPDATE ON CVDB.CustomAttr TO itimuserTag;

GRANT SELECT,INSERT,DELETE,UPDATE ON CVDB.ObjectGroup TO itimuserTag;

GRANT SELECT,INSERT,DELETE,UPDATE ON CVDB.SubjectAN TO itimuserTag;

GRANT SELECT,INSERT,DELETE,UPDATE ON CVDB.CV_KEYSTORE TO itimuserTag;

GRANT SELECT,INSERT,DELETE,UPDATE ON CVDB.DIGEST TO itimuserTag;

GRANT SELECT,INSERT,DELETE,UPDATE ON CVDB.CV_METADATA TO itimuserTag;

GRANT DROP ANY TABLE TO itimuserTag;
