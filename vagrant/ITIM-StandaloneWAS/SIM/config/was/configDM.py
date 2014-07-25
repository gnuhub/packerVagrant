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
# Script to update the JVM Path and any other settings for deployment manager

nodeName = sys.argv[0]
path =     sys.argv[1]

AdminTask.setJVMProperties('[-serverName dmgr -nodeName '+ nodeName +' -classpath '+path+']]')
AdminConfig.save()
