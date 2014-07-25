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

server = sys.argv[0]
node = sys.argv[1]
# Check if the server has an SD associated with it

servername = 'Cell=:Node='+node+':Server='+server
print servername

SD = AdminTask.getSecurityDomainForResource('-resourceName '+servername+'')

print 'sd is '+SD

if(SD == ''):
#No existing SD. Create the security domain as copy of Global Security Domain 

 SDs = AdminTask.listSecurityDomains()	
 if SDs.find('ISIMSecurityDomain') != -1:
  print 'ISIMSecurityDomain already exists. It will be configured for ITIM Registry.'
  sys.exit()
  
 opt = ["-securityDomainName" , "ISIMSecurityDomain" ]
 opt += [ "-securityDomainDescription" , " ISIM Security Domain"]
 secdomain = AdminTask.copySecurityDomainFromGlobalSecurity(opt)
elif(SD == 'ISIMSecurityDomain') :
 # do nothing
 #exit
 print 'existing ISIMSecurityDomain'
else :
 #Create clone of existig security domain 
 AdminTask.copySecurityDomain('[-securityDomainName ISIMSecurityDomain -securityDomainDescription -copyFromSecurityDomainName "'+SD+'"]') 
 #Remove resource from the earlier SD so that it can be configured later
 AdminTask.removeResourceFromSecurityDomain('[-securityDomainName "'+SD+'" -resourceName Cell=:Node=' + node +':Server='+ server +']') 
 
#AdminTask.removeResourceFromSecurityDomain('[-securityDomainName ISIMSecurityDomain -resourceName Cell=:Node=' + node +':Server='+ server +']') 
AdminConfig.save()

