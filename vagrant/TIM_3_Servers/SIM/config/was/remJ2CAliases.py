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
####### Check if the J2C aliases exist
def checkExist(itimAlias):
 exist = 'false'
 authAlias = itimAlias
 jaasAuthData = AdminConfig.list("JAASAuthData")
 jaasAuthDataList = AdminUtilities.convertToList(jaasAuthData)
 for authDataEntry in jaasAuthDataList:
  authDataEntries = AdminConfig.showAttribute(authDataEntry, "alias")
  authDataEntries = AdminUtilities.convertToList(authDataEntries)
  for authAliasEntry in authDataEntries:
   print authAliasEntry 
   print authAlias
   if ( authAliasEntry == authAlias):
    exist = 'true'
    break 
   
 return exist

#####################################################

####### Remove itim_jms alias if it exists
val = checkExist('itim_jms')
#print val
if (val == 'true'):
 AdminTask.deleteAuthDataEntry('[-alias itim_jms ]')

####### Remove itim_init alias if it exists
val = checkExist('itim_init')
if (val == 'true'):
 AdminTask.deleteAuthDataEntry('[-alias itim_init ]') 
 
AdminConfig.save()
