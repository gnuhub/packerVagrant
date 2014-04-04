#!/usr/bin/env bash
echo "Add ldap sbin and bin locations to the path"
export PATH=$PATH:/opt/ibm/ldap/V6.1/bin:/opt/ibm/ldap/V6.1/sbin
echo "PATH=$PATH:/opt/ibm/ldap/V6.1/sbin:/opt/ibm/ldap/V6.1/bin" >> /etc/profile.d/paths.sh

echo "Copying install files on to VM and Decompressing"
mkdir /tds_install
cp /installs/* /tds_install/
cd /tds_install
tar xvf tds61-linux-ia32-CD1_w_entitlement.tar > /dev/null
tar xvf tds61-linux-ia32-CD2.tar > /dev/null
tar xvf tds61-linux-ia32-CD3.tar > /dev/null

echo "Installing dependencies"
yum install -y compat-libstdc++-33
yum install -y ksh

echo "Installing DB2"
echo "Create very basic response file, with bare minimum install, not even a DB2 instance."
printf "PROD = ENTERPRISE_SERVER_EDITION\nFILE = /opt/ibm/db2/V9.1\nLIC_AGREEMENT = ACCEPT\nINSTALL_TYPE = TYPICAL" > ~/tds-db2.rsp
/tds_install/tdsV6.1/db2/db2setup -r ~/tds-db2.rsp

echo "Installing TDS"
cd /tds_install/tdsV6.1/tdsfiles/
rpm -ivh *.rpm &> /dev/null

echo "Configuring TDS"
# delete previously created idsldap user and re-create
# necessary because I don't know password for use created during rpm install
# and it seems unnecessarily hard to update it and use it!
userdel idsldap
idsadduser -u idsldap -w iamanalien -g idsldap -n
echo "Minimum config needed to create an instance"
idsicrt -I idsldap -b /root/tds-install.txt -e madeinchelsea
echo "create DB2 database"
idscfgdb -I idsldap -t idsldap -a idsldap -l /home/idsldap -w iamanalien -n
echo "set cn=root password. It is possible to choose a custom admin user if desired"
idsdnpw -I idsldap -p password -n
idscfgsuf -I idsldap -s dc=com -n
ibmslapd -I idsldap -n
sleep 10
idsldapadd -D cn=root -w password -f /vagrant/com.ldif

echo "Configure TDS WAS App"
/tds_install/tdsV6.1/appsrv/install.sh -installRoot /opt/TDS_WAS/
cd /opt/ibm/ldap/V6.1/idstools/
./deploy_IDSWebApp -w /opt/ibm/ldap/V6.1/idstools/IDSWebApp.war -p /opt/TDS_WAS/


# http://127.0.0.1:12100/IDSWebApp/IDSjsp/LDAPLogin.jsp
# To do list
# * Create an dc=com suffix + ou=company + ou=users,ou=company + ou=groups,ou=company	- done
# * Add paths to shell login permanently, for all users.							 	- done
# * Add ldap start/stop script and make it auto start.									- done
# * Install the embedded WAS instance.													- done
#    ----- Find out URL and port, add to VM so I can access it locally. 				- done
#   This is: http://127.0.0.1:12100/IDSWebApp/IDSjsp/LDAPLogin.jsp						- done
# * Add a script to auto start the WAS instance ...										- <tested-add-to-automated-process>
# * Set-up TDI to do log rotation or, more likely, install logrotate to do the job.
# * Configure and start the TDS proxy in front of ldap on different port.
# * Find out to script configure IDS WAS APP so I can use it.