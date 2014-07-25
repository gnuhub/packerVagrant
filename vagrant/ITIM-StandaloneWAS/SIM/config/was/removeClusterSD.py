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
# Script is to remove the mapped cluster and itim bus from the Security domain

node = sys.argv[0]
appCluster = sys.argv[1]
jmsCluster = sys.argv[2]


resources = AdminTask.listResourcesInSecurityDomain('[-securityDomainName ISIMSecurityDomain]')
sdList = AdminUtilities.convertToList(resources)

# Check if bus is existing
mappedBus= 'false'
busName = 'Cell='+node+':SIBus=itim_bus'
#print "bus"+busName
for sd in sdList:
 #print sd
 if (sd == busName):
  mappedBus = 'true'
  break

# Check if  is existing
mappedAppClus= 'false'
clusName = 'Cell='+node+':Cluster='+appCluster
#print "App"+clusName
for sd in sdList:
 #print sd
 if (sd ==clusName):  
  mappedAppClus = 'true'
  break

# Check if bus is existing
mappedMessClus= 'false'
jmsclusName = 'Cell='+node+':Cluster='+jmsCluster
#print jmsclusName 
for sd in sdList:
 print sd
 if (sd ==jmsclusName):  
  mappedMessClus = 'true'
  break

serverApp =':ServerCluster=' +appCluster+ ''
serverMess=':ServerCluster=' +jmsCluster + ''

if(mappedBus == 'true'):
 AdminTask.removeResourceFromSecurityDomain('[-securityDomainName ISIMSecurityDomain -resourceName Cell=:SIBus=itim_bus]') 

if(mappedAppClus == 'true'):
 AdminTask.removeResourceFromSecurityDomain('[-securityDomainName ISIMSecurityDomain -resourceName "Cell='+serverApp+'"]')

if(mappedMessClus == 'true'):
 AdminTask.removeResourceFromSecurityDomain('[-securityDomainName ISIMSecurityDomain -resourceName "Cell='+serverMess+'"]') 


AdminConfig.save()
