#!/bin/env bash

echo "Starting DB2 install process"
echo "making local folder on VM"
mkdir /db2_install
echo "Copy archive to VM"
cp /installs/* /db2_install/
echo "cd to VM local install folder"
cd /db2_install
echo "Uncompressing archive"
gunzip DB2_ESE_10_Linux_x86-64.tar.gz
tar xvf DB2_ESE_10_Linux_x86-64.tar
echo "enter installer location"
cd ese/
echo "Create very basic response file, with bare minimum to create a non-root db2 instance with no databases"
su - vagrant -c "printf \"PROD = ENTERPRISE_SERVER_EDITION\nLIC_AGREEMENT = ACCEPT\" > ~/vagrant.rsp"
echo "Start install using db2ese.rsp response file"
su - vagrant -c "/db2_install/ese/db2setup -r ~/vagrant.rsp"