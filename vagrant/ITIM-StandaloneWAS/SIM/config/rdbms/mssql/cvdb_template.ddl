sp_addlogin CVDB, itimuserPwdTag;
sp_adduser CVDB, CVDB, db_owner;

CREATE TABLE CVDB.LObject (
  uuid                  VARCHAR(36) PRIMARY KEY NOT NULL, 
  type                  VARCHAR(512),                     
  algorithm             VARCHAR(512),      
  length                INTEGER,           
  certType             VARCHAR(512),     
  issuer                VARCHAR(512),     
  serialNumber          VARCHAR(64),    
  subjectDN               VARCHAR(512),    
  usage                 VARCHAR(256), 
  leaseTime             INTEGER, 
  limitBytesTotal        NUMERIC(18,0), 
  limitBytesCurrent     NUMERIC(18,0),
  limitObjectsTotal     NUMERIC(18,0),
  limitObjectsCurrent   NUMERIC(18,0),
  state                 INTEGER, 
  initialization        DATETIME,    
  activation            DATETIME,    
  processstart          DATETIME,    
  protectstop           DATETIME,    
  deactivation          DATETIME, 
  destruction           DATETIME, 
  compromiseOccurrence  DATETIME, 
  compromise            DATETIME, 
  revocationReasonCode  INTEGER, 
  revocationReasonText  VARCHAR(1024), 
  archivalDate          DATETIME, 
  contactInfo           VARCHAR(512), 
  modifyDate            DATETIME,      
  format                VARCHAR(256),   
  datatype              INTEGER,   
  encoding              VARBINARY(MAX),
  version               BIGINT,
  owner                 VARCHAR(1024)
);

CREATE TABLE CVDB.Name (
  uuid      VARCHAR(36),
  name      VARCHAR(512) NOT NULL,
  nameType  INTEGER NOT NULL,
  index_Name     INTEGER,
  PRIMARY KEY (name, nameType)
);

CREATE INDEX NAMEUUIDX on CVDB.NAME (UUID ASC);

CREATE TABLE CVDB.CryptoParams (
 uuid VARCHAR(36) NOT NULL,                            
 blockCipherMode INTEGER,										 
 paddingMethod INTEGER, 											 
 hashingAlgorithm INTEGER,		    						 
 roleType INTEGER,
 index_CryptoParams INTEGER NOT NULL,
 PRIMARY KEY (uuid, index_CryptoParams) 		    						         
);

CREATE TABLE CVDB.Link (
  uuid      VARCHAR(36) NOT NULL,
  linkType  VARCHAR(100),
  linkUuid  VARCHAR(36),
  index_Link INTEGER NOT NULL,
  PRIMARY KEY (uuid, index_Link)
);

CREATE TABLE CVDB.AppID (
  uuid              VARCHAR(36) NOT NULL,
  applicationName   VARCHAR(1024),
  applicationID     VARCHAR(100),
  index_AppID    	    INTEGER NOT NULL,
  PRIMARY KEY (uuid, index_AppID)
);

CREATE TABLE CVDB.CustomAttr (
  uuid      VARCHAR(36) NOT NULL,
  name      VARCHAR(100) NOT NULL,
  value     VARCHAR(MAX), /*Changed from CLOB*/
  index_CustomAttr INTEGER NOT NULL,
  PRIMARY KEY (uuid, name, index_CustomAttr)
);

CREATE TABLE CVDB.ObjectGroup (
  uuid          VARCHAR(36) NOT NULL,
  objectGroup   VARCHAR(100),
  index_ObjectGroup         INTEGER NOT NULL,
  PRIMARY KEY (uuid, index_ObjectGroup)
);

CREATE TABLE CVDB.SubjectAN (
  uuid       VARCHAR(36) NOT NULL,
  subjectAN  VARCHAR(1024) NOT NULL,
  index_subjectAN         INTEGER NOT NULL,
  PRIMARY KEY (uuid, index_subjectAN)
);

CREATE TABLE CVDB.DIGEST (
  UUID VARCHAR(36) NOT NULL , 
  DIGESTVALUE VARCHAR(1024) NOT NULL , 
  ALGORITHM INTEGER NOT NULL , 
  INDEX_DIGEST INTEGER NOT NULL,
  PRIMARY KEY (UUID, INDEX_DIGEST)
  );  

CREATE TABLE CVDB.CV_KEYSTORE (
    keystoreexist SMALLINT NOT NULL,
    keystorepwd VARCHAR(1024) NOT NULL
);
CREATE TABLE CVDB.CV_METADATA (
    PROPERTY_NAME VARCHAR(254) NOT NULL,
    PROPERTY_VALUE VARCHAR(1024) NOT NULL
);
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
