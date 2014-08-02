create tablespace enrole_rbsspace
    datafile 'enrole_rbs01.dbf' size 5M reuse autoextend on
      next 5M maxsize 150M;

CREATE PUBLIC ROLLBACK SEGMENT enrole_rbs_01
                 TABLESPACE enrole_rbsspace
                 STORAGE (
      INITIAL 100K
      NEXT 100K
      OPTIMAL 4M
      MINEXTENTS 20
      MAXEXTENTS 100 );
ALTER ROLLBACK SEGMENT enrole_rbs_01 ONLINE;
      
CREATE PUBLIC ROLLBACK SEGMENT enrole_rbs_02
                 TABLESPACE enrole_rbsspace
                 STORAGE (
      INITIAL 100K
      NEXT 100K
      OPTIMAL 4M
      MINEXTENTS 20
      MAXEXTENTS 100 );
ALTER ROLLBACK SEGMENT enrole_rbs_02 ONLINE;

CREATE PUBLIC ROLLBACK SEGMENT enrole_rbs_03
                 TABLESPACE enrole_rbsspace
                 STORAGE (
      INITIAL 100K
      NEXT 100K
      OPTIMAL 4M
      MINEXTENTS 20
      MAXEXTENTS 100 );
ALTER ROLLBACK SEGMENT enrole_rbs_03 ONLINE;

CREATE PUBLIC ROLLBACK SEGMENT enrole_rbs_04
                 TABLESPACE enrole_rbsspace
                 STORAGE (
      INITIAL 100K
      NEXT 100K
      OPTIMAL 4M
      MINEXTENTS 20
      MAXEXTENTS 100 );
ALTER ROLLBACK SEGMENT enrole_rbs_04 ONLINE;

CREATE PUBLIC ROLLBACK SEGMENT enrole_rbs_05
                 TABLESPACE enrole_rbsspace
                 STORAGE (
      INITIAL 100K
      NEXT 100K
      OPTIMAL 4M
      MINEXTENTS 20
      MAXEXTENTS 100 );
ALTER ROLLBACK SEGMENT enrole_rbs_05 ONLINE;

CREATE PUBLIC ROLLBACK SEGMENT enrole_rbs_06
                 TABLESPACE enrole_rbsspace
                 STORAGE (
      INITIAL 100K
      NEXT 100K
      OPTIMAL 4M
      MINEXTENTS 20
      MAXEXTENTS 100 );
ALTER ROLLBACK SEGMENT enrole_rbs_06 ONLINE;

CREATE PUBLIC ROLLBACK SEGMENT enrole_rbs_07
                 TABLESPACE enrole_rbsspace
                 STORAGE (
      INITIAL 100K
      NEXT 100K
      OPTIMAL 4M
      MINEXTENTS 20
      MAXEXTENTS 100 );
ALTER ROLLBACK SEGMENT enrole_rbs_07 ONLINE;

CREATE PUBLIC ROLLBACK SEGMENT enrole_rbs_08
                 TABLESPACE enrole_rbsspace
                 STORAGE (
      INITIAL 100K
      NEXT 100K
      OPTIMAL 4M
      MINEXTENTS 20
      MAXEXTENTS 100 );
ALTER ROLLBACK SEGMENT enrole_rbs_08 ONLINE;

CREATE PUBLIC ROLLBACK SEGMENT enrole_rbs_09
                 TABLESPACE enrole_rbsspace
                 STORAGE (
      INITIAL 100K
      NEXT 100K
      OPTIMAL 4M
      MINEXTENTS 20
      MAXEXTENTS 100 );
ALTER ROLLBACK SEGMENT enrole_rbs_09 ONLINE;

CREATE PUBLIC ROLLBACK SEGMENT enrole_rbs_10
                 TABLESPACE enrole_rbsspace
                 STORAGE (
      INITIAL 100K
      NEXT 100K
      OPTIMAL 4M
      MINEXTENTS 20
      MAXEXTENTS 100 );
ALTER ROLLBACK SEGMENT enrole_rbs_10 ONLINE;
