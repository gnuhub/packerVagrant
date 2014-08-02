sp_addlogin itimuserTag, itimuserPwdTag;
sp_adduser itimuserTag, itimuserTag, db_owner;
use master;
sp_grantdbaccess itimuserTag, itimuserTag;
sp_addrolemember [SqlJDBCXAUser], itimuserTag;
use itimdbTag;
