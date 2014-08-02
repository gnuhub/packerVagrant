/**********************************************************
 *
 *  The section below contains the SIB schema changes 
 *   		from ITIM 5.x to ISIM 6.0
 *
 **********************************************************/
CREATE TABLE ITIML000.SIBOWNERO (
  EMPTY_COLUMN INTEGER
)TABLESPACE ITIML000_data;

GRANT SELECT,INSERT,DELETE,UPDATE ON ITIML000.SIBOWNERO TO itimuserTag;
