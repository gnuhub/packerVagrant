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
# Script to find the realm name and update in the enrole.properties file

appCluster = sys.argv[0]
jmsCluster = sys.argv[1]
itimHome = sys.argv[2]
isDeploymentManager = sys.argv[3]

appClustername = 'Cell=:ServerCluster=' + appCluster
jmsClustername = 'Cell=:ServerCluster=' + jmsCluster

appClusterSD = AdminTask.getSecurityDomainForResource('-resourceName "'+appClustername+'"')

jmsClusterSD = AdminTask.getSecurityDomainForResource('-resourceName "'+jmsClustername+'"')

if(appClusterSD == jmsClusterSD):

 if(appClusterSD == ''):
  regInfo = AdminTask.getUserRegistryInfo() 
 else:
  regInfo = AdminTask.getUserRegistryInfo('-securityDomainName "'+appClusterSD+'"') 

else:
 print "Application and Messaging Cluster on different Security Domain."

print regInfo	

regInfoList=regInfo.split(']')

for n in regInfoList:
 print n
 if n.find('realm') != -1:
  m = n.split("[")
  print m
  break
 else:
  continue

print len(m)
 
i = 0
for o in m:
  print o
  i = i + 1
  if o.find('realm') != -1:
    break

if len(m) > 3:
  realm = m[i].strip()
  
else:
  p = o.split(" ")
  realm = p[1].strip()
  
print "Realm" + realm 
	
f = open (itimHome)
old_props = f.readlines()
f.close()

f = open(itimHome, 'w')
for i in range(len(old_props)):
 if old_props[i].find('enrole.appServer.realm=') != -1:
    f.write('%s%s\n'% ('enrole.appServer.realm=',realm))
 else:
    f.write(old_props[i])
f.close()	

#add enrole.appServer.realm of enRole.properties to trusted realm for Deployment Manager
if(isDeploymentManager == 'true'):
  print "Adding " + realm + " as trusted realm"
  AdminTask.addTrustedRealms('[-communicationType outbound -realmList '+ realm + ']')
  AdminConfig.save()
else:
  print "Cluster Member found. Skip Adding " + realm + " as trusted realm"
