CREATE TABLESPACE enrole_data
DATAFILE 'enrole1_data_001.dbf'
SIZE 64M
AUTOEXTEND ON
NEXT 64M
MAXSIZE unlimited
DEFAULT STORAGE (INITIAL 10M
                                 NEXT 1M
                                 PCTINCREASE 10)
PERMANENT
ONLINE
LOGGING;

CREATE TABLESPACE enrole_indexes
DATAFILE 'enrole1_idx_001.dbf'
SIZE 32M
AUTOEXTEND ON
NEXT 32M
MAXSIZE unlimited
DEFAULT STORAGE (INITIAL 10M
                                 NEXT 1M
                                 PCTINCREASE 10)
PERMANENT
ONLINE
LOGGING;

CREATE USER itimuserTag IDENTIFIED BY itimuserPwdTag
  DEFAULT TABLESPACE enrole_data
  QUOTA UNLIMITED ON enrole_data
  QUOTA UNLIMITED ON enrole_indexes;
GRANT CREATE SESSION TO itimuserTag;
GRANT CREATE TABLE to itimuserTag;
GRANT CREATE ANY PROCEDURE to itimuserTag;
GRANT CREATE VIEW to itimuserTag;
