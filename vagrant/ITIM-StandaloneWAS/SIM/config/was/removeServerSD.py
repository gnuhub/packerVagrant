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
# Script is to remove the mapped server and itim bus from the Security domain

node = sys.argv[0]
server = sys.argv[1]
cell = sys.argv[2]

resources = AdminTask.listResourcesInSecurityDomain('[-securityDomainName ISIMSecurityDomain]')
sdList = AdminUtilities.convertToList(resources)


serverName = 'Cell='+cell+':Node=' + node +':Server='+ server +''
mappedServer = 'false'

for sd in sdList:
 print sd
 if (sd == serverName):
  mappedServer = 'true'
  break


mappedBus= 'false'
busName = 'Cell='+cell+':SIBus=itim_bus'
for sd in sdList:
 print sd
 if (sd == busName):
  mappedBus = 'true'
  break

if (mappedServer == 'true'):  
 AdminTask.removeResourceFromSecurityDomain('[-securityDomainName ISIMSecurityDomain -resourceName Cell=:Node=' + node +':Server='+ server +']') 

if(mappedBus == 'true'):
 AdminTask.removeResourceFromSecurityDomain('[-securityDomainName ISIMSecurityDomain -resourceName Cell=:SIBus=itim_bus]') 


AdminConfig.save()
