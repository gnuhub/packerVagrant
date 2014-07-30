CREATE SCHEMA CVDB;

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
  initialization        TIMESTAMP,    
  activation            TIMESTAMP,    
  processstart          TIMESTAMP,    
  protectstop           TIMESTAMP,    
  deactivation          TIMESTAMP, 
  destruction           TIMESTAMP, 
  compromiseOccurrence  TIMESTAMP, 
  compromise            TIMESTAMP, 
  revocationReasonCode  INTEGER, 
  revocationReasonText  VARCHAR(1024), 
  archivalDate          TIMESTAMP, 
  contactInfo           VARCHAR(512), 
  modifyDate            TIMESTAMP,      
  format                VARCHAR(256),   
  datatype              INTEGER,   
  encoding              LONG VARCHAR FOR BIT DATA, 
  version               BIGINT,
  owner                 VARCHAR(1024)
);

GRANT SELECT, INSERT, UPDATE, DELETE ON CVDB.LObject TO USER itimuserTag;

CREATE TABLE CVDB.Name (
  uuid      VARCHAR(36),
  name      VARCHAR(512) NOT NULL,
  nameType  INTEGER NOT NULL,
  index_Name     INTEGER,
  PRIMARY KEY (name, nameType)
);

GRANT SELECT, INSERT, UPDATE, DELETE ON CVDB.Name TO USER itimuserTag;

CREATE INDEX NAMEUUIDX on CVDB.NAME (UUID ASC) MINPCTUSED 10 ALLOW REVERSE SCANS; 

CREATE TABLE CVDB.CryptoParams (
 uuid VARCHAR(36) NOT NULL,                            
 blockCipherMode INTEGER,										 
 paddingMethod INTEGER, 											 
 hashingAlgorithm INTEGER,		    						 
 roleType INTEGER,
 index_CryptoParams INTEGER NOT NULL,
 PRIMARY KEY (uuid, index_CryptoParams) 		    						         
);

GRANT SELECT, INSERT, UPDATE, DELETE ON CVDB.CryptoParams TO USER itimuserTag;

CREATE TABLE CVDB.Link (
  uuid      VARCHAR(36) NOT NULL,
  linkType  VARCHAR(100),
  linkUuid  VARCHAR(36),
  index_Link INTEGER NOT NULL,
  PRIMARY KEY (uuid, index_Link)
);

GRANT SELECT, INSERT, UPDATE, DELETE ON CVDB.Link TO USER itimuserTag;

CREATE TABLE CVDB.AppID (
  uuid              VARCHAR(36) NOT NULL,
  applicationName   VARCHAR(1024),
  applicationID     VARCHAR(100),
  index_AppID    	    INTEGER NOT NULL,
  PRIMARY KEY (uuid, index_AppID)
);

GRANT SELECT, INSERT, UPDATE, DELETE ON CVDB.AppID TO USER itimuserTag;

CREATE TABLE CVDB.CustomAttr (
  uuid      VARCHAR(36) NOT NULL,
  name      VARCHAR(100) NOT NULL,
  value     CLOB,
  index_CustomAttr INTEGER NOT NULL,
  PRIMARY KEY (uuid, name, index_CustomAttr)
);

GRANT SELECT, INSERT, UPDATE, DELETE ON CVDB.CustomAttr TO USER itimuserTag;

CREATE TABLE CVDB.ObjectGroup (
  uuid          VARCHAR(36) NOT NULL,
  objectGroup   VARCHAR(100),
  index_ObjectGroup         INTEGER NOT NULL,
  PRIMARY KEY (uuid, index_ObjectGroup)
);

GRANT SELECT, INSERT, UPDATE, DELETE ON CVDB.ObjectGroup TO USER itimuserTag;

CREATE TABLE CVDB.SubjectAN (
  uuid       VARCHAR(36) NOT NULL,
  subjectAN  VARCHAR(1024) NOT NULL,
  index_subjectAN         INTEGER NOT NULL,
  PRIMARY KEY (uuid, index_subjectAN)
);

GRANT SELECT, INSERT, UPDATE, DELETE ON CVDB.SubjectAN TO USER itimuserTag;

CREATE TABLE CVDB.DIGEST (
  UUID VARCHAR(36) NOT NULL , 
  DIGESTVALUE VARCHAR(1024) NOT NULL , 
  ALGORITHM INTEGER NOT NULL , 
  INDEX_DIGEST INTEGER NOT NULL,
  PRIMARY KEY (UUID, INDEX_DIGEST)
  );  

GRANT SELECT, INSERT, UPDATE, DELETE ON CVDB.DIGEST TO USER itimuserTag;
		  
CREATE TABLE CVDB.CV_KEYSTORE (
    keystoreexist SMALLINT NOT NULL,
    keystorepwd VARCHAR(1024) NOT NULL
);

GRANT SELECT, INSERT, UPDATE, DELETE ON CVDB.CV_KEYSTORE TO USER itimuserTag;

CREATE TABLE CVDB.CV_METADATA (
    PROPERTY_NAME VARCHAR(254) NOT NULL,
    PROPERTY_VALUE VARCHAR(1024) NOT NULL
);

GRANT SELECT, INSERT, UPDATE, DELETE ON CVDB.CV_METADATA TO USER itimuserTag;

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
