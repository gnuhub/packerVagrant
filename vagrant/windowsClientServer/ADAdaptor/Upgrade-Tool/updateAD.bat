set JAVA=C:\Program Files\IBM\WebSphere\AppServer\java\bin\java
set TIM_HOME=C:\Program Files\IBM\itim
set TIM_DATA=%TIM_HOME%\data

"%JAVA%" -cp "%TIM_HOME%\lib\itim_common.jar";"%TIM_HOME%\lib\itim_server.jar";"%TIM_HOME%\lib\jlog.jar";upgradeGroups.jar;"%TIM_DATA%" upgradeGroups "%TIM_HOME%" AD