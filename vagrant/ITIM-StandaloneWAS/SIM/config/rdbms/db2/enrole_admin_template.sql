CREATE  REGULAR  TABLESPACE ENROLE_DATA 
  PAGESIZE 32 K  
  MANAGED BY DATABASE  
  USING ( FILE 'enrole_data' 64M)
  AUTORESIZE YES INCREASESIZE 64M 
  EXTENTSIZE 32 
  PREFETCHSIZE AUTOMATIC
  BUFFERPOOL ENROLEBP;

COMMENT ON TABLESPACE ENROLE_DATA IS 'itim tablespace used for storing itim tables';

CREATE  REGULAR  TABLESPACE ENROLE_INDEXES 
  PAGESIZE 32 K  
  MANAGED BY DATABASE  
  USING ( FILE 'enrole_indexes' 32M)
  AUTORESIZE YES INCREASESIZE 32M  
  EXTENTSIZE 32  
  PREFETCHSIZE AUTOMATIC
  BUFFERPOOL ENROLEBP;

COMMENT ON TABLESPACE ENROLE_INDEXES IS 'itim tablespace used for storing indexes';

CREATE  SYSTEM TEMPORARY  TABLESPACE TEMP_DATA 
  PAGESIZE 32 K  
  MANAGED BY DATABASE  
  USING ( FILE 'system_data' 32M) 
  AUTORESIZE YES INCREASESIZE 32M
  EXTENTSIZE 32 
  PREFETCHSIZE AUTOMATIC 
  BUFFERPOOL ENROLEBP;

COMMENT ON TABLESPACE TEMP_DATA IS 'Temporary tablespace managed by database system';

GRANT USE OF TABLESPACE ENROLE_DATA TO USER itimuserTag WITH GRANT OPTION;
GRANT USE OF TABLESPACE ENROLE_INDEXES TO USER itimuserTag WITH GRANT OPTION;
GRANT  CREATETAB, CONNECT,IMPLICIT_SCHEMA ON DATABASE TO USER itimuserTag;

