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
# Script to set custom property in WSLOGIN

AdminTask.configureLoginModule('[-loginType application -loginEntryAlias WSLogin -loginModule com.ibm.ws.security.common.auth.module.WSLoginModuleImpl -useLoginModuleProxy true -authStrategy REQUIRED -customProperties ["use_realm_callback=true","use_appcontext_callback=false"] ]') 

AdminConfig.save()
