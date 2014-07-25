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
# Script to configure the security domain.

node       = sys.argv[0]
server     = sys.argv[1]
itimdomain = sys.argv[2]
cellName   = sys.argv[3]

# Set the scope of the Security domain to server
#itimdomain='ISIMSecurityDomain'

#Check if the server has been mapped to the Security domian already

resources = AdminTask.listResourcesInSecurityDomain('[-securityDomainName '+itimdomain+']')
serverName = 'Cell='+cellName+':Node=' + node +':Server='+ server +''
#print serverName
rsList = AdminUtilities.convertToList(resources)
mapped = 'false'

for rs in rsList:
 print rs
 if (rs == serverName):
  mapped = 'true'


# if not mapped add to the security domain
if(mapped == 'false'):
 AdminTask.mapResourceToSecurityDomain('[-securityDomainName ' +itimdomain+' -resourceName Cell=:Node=' + node +':Server='+ server +']') 

# Enable the application security
AdminTask.setAppActiveSecuritySettings('[-securityDomainName ' +itimdomain+' -appSecurityEnabled true]') 

# Configure the user registry to use ITIM custom user registry
AdminTask.configureAppCustomUserRegistry('[-customRegClass com.ibm.itim.authentication.registry.ItimUserRegistry -ignoreCase true -securityDomainName '+itimdomain+' -realmName itimCustomRealm ]')
AdminTask.setAppActiveSecuritySettings('[-securityDomainName '+itimdomain+' -activeUserRegistry CustomUserRegistry]')
## Fix for Defect#61635 L3 reports Java 2 Security Enabled in Global Security Causes Runconfig failure on configure Security domain script. Disable the Java 2 security for ISIM Security domain.
## This command disables the Java 2 security for ISIM Security domain. It doens't fail even if Java 2 security is disabled.  
AdminTask.setAppActiveSecuritySettings('[-securityDomainName '+itimdomain+' -enforceJava2Security false]')

AdminConfig.save()




