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
# Jython script to create and configure security domain
import sys

appCluster = sys.argv[0]
jmsCluster = sys.argv[1]

# Check if the cluster has an SD associated with it

cellName = AdminControl.getCell()

appClustername = 'Cell=:ServerCluster=' + appCluster
jmsClustername = 'Cell=:ServerCluster=' + jmsCluster

appClusterSD = AdminTask.getSecurityDomainForResource('-resourceName "'+appClustername+'"')

print 'AppClusterSD is '+appClusterSD

jmsClusterSD = AdminTask.getSecurityDomainForResource('-resourceName "'+jmsClustername+'"')

print 'JMSClusterSD is '+jmsClusterSD


if(appClusterSD == jmsClusterSD):

 if(appClusterSD == ''):
 #No existing appClusterSD. Create the security domain as copy of Global Security Domain 
  
  SDs = AdminTask.listSecurityDomains()	
  if SDs.find('ISIMSecurityDomain') != -1:
   print 'ISIMSecurityDomain already exists. It will be configured for ITIM Registry.'
   sys.exit()
 
  opt = ["-securityDomainName" , "ISIMSecurityDomain" ]
  opt += [ "-securityDomainDescription" , " ISIM Security Domain"]
  secdomain = AdminTask.copySecurityDomainFromGlobalSecurity(opt)
 elif(appClusterSD == 'ISIMSecurityDomain') :
  # do nothing
  #exit
  print 'test'
 else :
  #Create clone of existing security domain 
  AdminTask.copySecurityDomain('[-securityDomainName ISIMSecurityDomain -securityDomainDescription -copyFromSecurityDomainName "'+appClusterSD+'"]') 
  #Remove resource from the earlier SD so that it can be configured later
  AdminTask.removeResourceFromSecurityDomain('[-securityDomainName "'+appClusterSD+'" -resourceName "'+appClustername+'"]') 
  AdminTask.removeResourceFromSecurityDomain('[-securityDomainName "'+jmsClusterSD+'" -resourceName "'+jmsClustername+'"]') 	
	
 AdminConfig.save()

else:
 print "App. Cluster and Mssg. Cluster on different domain.. Creation of Security Domain for Cluster failed."
 	

