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


####### Remove ISIMSecurityDomain
securityDomainList = AdminTask.listSecurityDomains('[-listDescription false]') 
sdList = AdminUtilities.convertToList(securityDomainList)

for sd in sdList:
 if (sd == 'ISIMSecurityDomain'):
  AdminTask.deleteSecurityDomain('[-securityDomainName ISIMSecurityDomain]') 


AdminConfig.save()



