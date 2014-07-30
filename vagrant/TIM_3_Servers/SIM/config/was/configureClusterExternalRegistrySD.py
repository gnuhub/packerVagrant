#####################################################################
#
#  Licensed Materials  Property of IBM
#
#  (c) Copyright IBM Corp. 2012 All Rights Reserved
#
#  US Government Users Restricted Rights - Use, duplication or
#  disclosure restricted by GSA ADP Schedule Contract with
#  IBM Corp.
#####################################################################
# Script to configure the security domain which uses external registries.

from javax.swing import JOptionPane as jo
import javax.swing as swing

appCluster = sys.argv[0]
jmsCluster = sys.argv[1]

cellName = AdminControl.getCell()

appClustername = 'Cell=:ServerCluster=' + appCluster
jmsClustername = 'Cell=:ServerCluster=' + jmsCluster

appClusterSD = AdminTask.getSecurityDomainForResource('-resourceName "'+appClustername+'"')
print appClusterSD

if(appClusterSD == ''):
#No existing SD. Use the Global Security Domain. Assign itim bus and check for application security settings. 
 
 #This is to check if the Application Security is enabled for the Global security.
 appSetting = AdminTask.getActiveSecuritySettings()
 if appSetting.find('appSecurityEnabled true') != -1:
  print "Application security is enabled."
 else:
  print "Error: Application security is disabled"
  jo.showMessageDialog(None, "IBM Security Identity Manager requires Application security to be enabled. \nIn WebSphere Global security, enable Application security and then click 'OK' to continue with the installation.", "Application security is disabled", jo.WARNING_MESSAGE) 
 
 #This check is to make sure that the itim_bus is not assigned a security domain by default of the Cell and the
 # server has been removed from it.
 SDbus = AdminTask.getSecurityDomainForResource('-resourceName Cell=:SIBus=itim_bus')
 if(SDbus != ''):
  AdminTask.createSecurityDomain('[-securityDomainName PassThroughToGlobalSecurity -securityDomainDescription ]') 
  AdminTask.mapResourceToSecurityDomain('[-securityDomainName PassThroughToGlobalSecurity -resourceName SIBus="itim_bus"]')
 
else:
 #Configure existing security domain for itim bus and set application security
 AdminTask.mapResourceToSecurityDomain('[-securityDomainName "'+appClusterSD+'" -resourceName SIBus=itim_bus]') 
 AdminTask.setAppActiveSecuritySettings('[-securityDomainName "'+appClusterSD+'" -appSecurityEnabled true]')
 

AdminConfig.save()






 






