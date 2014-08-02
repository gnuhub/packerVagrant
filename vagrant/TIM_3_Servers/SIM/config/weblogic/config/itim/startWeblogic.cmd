@rem *************************************************************************
@rem This script is used to start WebLogic Server for the domain in the 
@rem current working directory.  This script simply sets the SERVER_NAME 
@rem variable and calls the startWLS.cmd script under
@rem %WL_HOME%\server\bin.
@rem
@rem To create your own start script for your domain, all you need to set is 
@rem SERVER_NAME, then call %WL_HOME%\server\bin\startWLS.cmd
@rem
@rem Other variables that startWLS takes are:
@rem
@rem WLS_USER     - cleartext user for server startup
@rem WLS_PW       - cleartext password for server startup
@rem STARTMODE    - true for production mode servers, false for 
@rem                development mode
@rem JAVA_OPTIONS - Java command-line options for running the server. (These
@rem                will be tagged on to the end of the JAVA_VM and MEM_ARGS)
@rem JAVA_VM      - The java arg specifying the VM to run.  (i.e. -server, 
@rem                -hotspot, etc.)
@rem MEM_ARGS     - The variable to override the standard memory arguments
@rem                passed to java
@rem
@rem For additional information, refer to the WebLogic Server Administration 
@rem Guide (http://e-docs.bea.com/wls/docs70/adminguide/startstop.html).
@rem *************************************************************************

echo off
SETLOCAL

@REM Set user-defined variables.

set JAVA_HOME=%DEFINED_JAVA_HOME%
set ITIM_HOME=%DEFINED_ITIM_HOME%
set WLS_HOME=%DEFINED_WLS_HOME%
set SERVER_NAME=%DEFINED_SERVER_NAME%
set ADMIN_URL=%DEFINED_ADMIN_SERVER_URL%
set CRYSTAL_HOME=%ITIM_HOME%

@rem Set WLS_USER equal to your system username and WLS_PW equal  
@rem to your system password for no username and password prompt 
@rem during server startup.  Both are required to bypass the startup
@rem prompt.  This is not recomended for a production environment.
set WLS_USER=system
set WLS_PW=

@rem If password is empty, retrieve the password from password.ini if the file exists
if not %WLS_PW%/==/ goto setMode

if not exist password.ini goto promptUserForPwd
%ITIM_HOME%\bin\awk "{print \"set WLS_PW=\" $1}" password.ini >tmp_.bat
call tmp_.bat
del tmp_.bat >NUL

@rem if the password is empty, pompt the user for password
if not %WLS_PW%/==/ goto setMode

:promptUserForPwd
echo Enter the password to boot the Identity Manager Server: 
 awk "BEGIN{getline;print \"set WLS_PW=\"$0}" > }{.bat
 call }{
 del }{.bat

@rem Set Production Mode.  When this is set to true, the server starts up in 
@rem production mode.  When set to false, the server starts up in development 
@rem mode.  If it is not set, it will default to false.
:setMode
set STARTMODE=true

@rem Set JAVA_OPTIONS to the java flags you want to pass to the vm. i.e.: 
@rem set JAVA_OPTIONS=-Dweblogic.attribute=value -Djava.attribute=value
@rem set JAVA_OPTIONS=-Dweblogic.security.SSL.trustedCAKeyStore=C:\bea\weblogic700\server\lib\cacerts -Dweblogic.Domain=enrole -Dweblogic.Name=myserver
@rem set JAVA_OPTIONS= -Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5555 -ms256m -mx256m 
set JAVA_OPTIONS=-Djava.security.auth.login.config=jaas_login.conf

@rem Set JAVA_VM to the java virtual machine you want to run.  For instance:
@rem set JAVA_VM=-server
set JAVA_VM=-hotspot

@rem Set MEM_ARGS to the memory args you want to pass to java.  For instance:
@rem set MEM_ARGS=-Xms128m -Xmx256m
set MEM_ARGS=-XX:MaxPermSize=128m -Xms256m -Xmx256m

@REM Copy the agent dll files to system32 folder
:copy
copy %ITIM_HOME%\lib\nt\* %SystemRoot%\System32

@REM SET PATH
set PATH=%WLS_HOME%\server\bin;%WLS_HOME%\server\bin\oci920_8;%JAVA_HOME%\bin;%ITIM_HOME%\lib\nt;%PATH%

@echo off
set CP=%CP%;%ITIM_HOME%\lib\batik.jar
set CP=%CP%;%ITIM_HOME%\lib\fesi.jar
set CP=%CP%;%ITIM_HOME%\data
set CP=%CP%;%ITIM_HOME%\lib\enroleagent.jar
set CP=%CP%;%ITIM_HOME%\lib\activation.jar
set CP=%CP%;%ITIM_HOME%\lib\bsf.jar
set CP=%CP%;%ITIM_HOME%\lib\jaas.jar
set CP=%CP%;%ITIM_HOME%\lib\JGo.jar
set CP=%CP%;%ITIM_HOME%\lib\JGoLayout.jar
set CP=%CP%;%ITIM_HOME%\lib\jndi.jar
set CP=%CP%;%ITIM_HOME%\lib\ldap.jar
set CP=%CP%;%ITIM_HOME%\lib\ldapbp.jar
set CP=%CP%;%ITIM_HOME%\lib\ldapjdk.jar
set CP=%CP%;%ITIM_HOME%\lib\mail.jar
set CP=%CP%;%ITIM_HOME%\lib\providerutil.jar
set CP=%CP%;%ITIM_HOME%\lib\jsafe.jar
set CP=%CP%;%ITIM_HOME%\lib\avalon.jar
set CP=%CP%;%ITIM_HOME%\lib\fop.jar
set CP=%CP%;%ITIM_HOME%\lib\sdo.jar
set CP=%CP%;%ITIM_HOME%\lib\JSQLConnect.jar
set CP=%CP%;%ITIM_HOME%\lib\nls_charset12.zip
set CP=%CP%;%ITIM_HOME%\lib\sslj.jar
set CP=%CP%;%ITIM_HOME%\lib\log4j.jar
set CP=%CP%;%ITIM_HOME%\lib\regexp.jar
set CP=%CP%;%ITIM_HOME%\lib\enroleall.jar
set CP=%CP%;%ITIM_HOME%\lib\antlr-2.7.2.jar
set CP=%CP%;%ITIM_HOME%\lib\dsml2.jar
set CP=%CP%;%ITIM_HOME%\lib\castor-0.9.4.3-xml.jar
set CP=%CP%;%ITIM_HOME%\lib\Zql.jar
set CP=%CP%;%ITIM_HOME%\lib\jlog.jar
set CP=%CP%;%ITIM_HOME%\lib\jffdc.jar
set CP=%CP%;%ITIM_HOME%\lib\sdo.jar
set CP=%CP%;%ITIM_HOME%\lib\aspectjrt.jar
set CP=%CP%;%CRYSTAL_HOME%\lib\MetafileRenderer.jar
set CP=%CP%;%CRYSTAL_HOME%\lib\rasapp.jar
set CP=%CP%;%CRYSTAL_HOME%\lib\rascore.jar
set CP=%CP%;%CRYSTAL_HOME%\lib\ReportTemplate.jar
set CP=%CP%;%CRYSTAL_HOME%\lib\Serialization.jar
set CP=%CP%;%CRYSTAL_HOME%\lib\URIUtil.jar
set CP=%CP%;%CRYSTAL_HOME%\lib\webreporting-core.jar
set CP=%CP%;%CRYSTAL_HOME%\lib\webreporting-advanced.jar
set CP=%CP%;%CRYSTAL_HOME%\lib\WebReportWizard.jar
rem Additional jars for Crystal Enterprise 10
set CP=%CP%;%CRYSTAL_HOME%\lib\cecore.jar
set CP=%CP%;%CRYSTAL_HOME%\lib\celib.jar
set CP=%CP%;%CRYSTAL_HOME%\lib\ceplugins.jar
set CP=%CP%;%CRYSTAL_HOME%\lib\cereports.jar
set CP=%CP%;%CRYSTAL_HOME%\lib\cesession.jar
set CP=%CP%;%CRYSTAL_HOME%\lib\CorbaIDL.jar
set CP=%CP%;%CRYSTAL_HOME%\lib\ebus405.jar

set APACHE_XML_JARS=%ITIM_HOME%\lib\xml-apis.jar;%ITIM_HOME%\lib\xercesImpl.jar;%ITIM_HOME%\lib\xalan.jar

@rem *************************************************************
@rem * Add any custom jars files to CUSTOM_JARS. 
@rem * During upgrade, the value of CUSTOM_JARS will be preserved.
@rem * ex: set DEFINED_CUSTOM_JARS=%ITIM_HOME%\lib\test1.jar;%ITIM_HOME%\lib\test2.zip
@rem *************************************************************
set DEFINED_CUSTOM_JARS=%CUSTOM_JARS%

set CP=%CP%;%DEFINED_CUSTOM_JARS%

@echo on
set CLASSPATH=%JAVA_HOME%\lib\tools.jar;%ITIM_HOME%\lib\ojdbc.jar;%WLS_HOME%\server\lib\weblogic_sp.jar;%WLS_HOME%\server\lib\weblogic.jar;%APACHE_XML_JARS%;%CP%

@rem Start Server

@echo off
if "%ADMIN_URL%" == "" goto runAdmin
@echo on
"%JAVA_HOME%\bin\java" %JAVA_VM% %MEM_ARGS% %JAVA_OPTIONS% -Dweblogic.Name=%SERVER_NAME% -Dweblogic.management.username=%WLS_USER% -Dweblogic.management.password=%WLS_PW% -Dweblogic.management.server=%ADMIN_URL% -Dweblogic.ProductionModeEnabled=%STARTMODE% -Djava.security.policy="%WL_HOME%\server\lib\weblogic.policy" weblogic.Server 
goto finish

:runAdmin
@echo on
"%JAVA_HOME%\bin\java" %JAVA_VM% %MEM_ARGS% %JAVA_OPTIONS% -Dweblogic.Name=%SERVER_NAME% -Dweblogic.management.username=%WLS_USER% -Dweblogic.management.password=%WLS_PW% -Dweblogic.ProductionModeEnabled=%STARTMODE% -Djava.security.policy="%WL_HOME%\server\lib\weblogic.policy" weblogic.Server 

:finish

ENDLOCAL


