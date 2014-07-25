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
# Script is to remove itim bus from the Security domain

SDbus = AdminTask.getSecurityDomainForResource('-resourceName Cell=:SIBus=itim_bus')
print "SD domain is "+SDbus

if(SDbus != ''):
 AdminTask.removeResourceFromSecurityDomain('[-securityDomainName "'+SDbus+'" -resourceName Cell=:SIBus=itim_bus]') 


AdminConfig.save()
