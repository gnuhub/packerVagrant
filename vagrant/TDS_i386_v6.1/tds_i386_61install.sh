#!/usr/bin/env bash

echo "Copying install files on to VM and Decompressing"
mkdir /tds_install
cp /installs/* /tds_install/
cd /tds_install
tar xvf tds61-linux-ia32-CD1_w_entitlement.tar > /dev/null
tar xvf tds61-linux-ia32-CD2.tar > /dev/null
tar xvf tds61-linux-ia32-CD3.tar > /dev/null
echo "Install files on VM and decompressed"

echo "Installing dependencies"
yum install -y compat-libstdc++-33
yum install -y ksh
echo "Dependencies installed"

echo "Installing DB2"
echo "Create very basic response file, with bare minimum to create a non-root db2 instance with no databases"
# Is it possible to not specifiy any instance? Just a vanilla install with zero instances and zero users ... just waiting for ldap install to come along and create a user + instance ?
#printf "PROD = ENTERPRISE_SERVER_EDITION\nFILE = /opt/ibm/db2/V9.1\nLIC_AGREEMENT = ACCEPT\nINSTALL_TYPE = TYPICAL\nINSTANCE = vagrant\nvagrant.NAME = vagrant" > ~/tds-db2.rsp
printf "PROD = ENTERPRISE_SERVER_EDITION\nFILE = /opt/ibm/db2/V9.1\nLIC_AGREEMENT = ACCEPT\nINSTALL_TYPE = TYPICAL" > ~/tds-db2.rsp
/tds_install/tdsV6.1/db2/db2setup -r ~/tds-db2.rsp > /dev/null
echo "DB2 installed"

echo "Installing TDS"
cd /tds_install/tdsV6.1/tdsfiles/
rpm -ivh *.rpm > /dev/null
echo "tds installed"

echo "Configuring TDS"
#
# Next phase goes here ... configure and play!
# Start with a command that creates an instance of TDS and DB2 together
# Then create a dc=com suffix, then create and use an LDIF to create an OU under it and a few entries ... basic install complete!
#
# After that, try to get the web console up and running, connected to instance
# then look into making some use of the proxy as well!
#
echo "TDS Configured"