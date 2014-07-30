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
# Script to configure the ISIM bus that has been setup to use the Security domain

domain= sys.argv[0]
node = sys.argv[1]

resources = AdminTask.listResourcesInSecurityDomain('[-securityDomainName ISIMSecurityDomain]')
busName = 'Cell='+node+':SIBus=itim_bus'
#print busName

rsList = AdminUtilities.convertToList(resources)
mapped = 'false'

for rs in rsList:
 print rs
 if(rs == busName):
  mapped = 'true'
  

# Add the itim bus to the ISIM Security Domain
if(mapped == 'false'):
 AdminTask.mapResourceToSecurityDomain('[-securityDomainName '+domain+' -resourceName Cell=:SIBus=itim_bus]') 

AdminConfig.save()
