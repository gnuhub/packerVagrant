#!/usr/bin/env bash
echo "Copying install files on to VM and Decompressing"
mkdir /WAS_install
cp /installs/* /WAS_install/
cd /WAS_install
gunzip *.gz > /dev/null

tar xvf C1G2CML.tar > /dev/null
tar xvf C1G32ML.tar > /dev/null
tar xvf C1G33ML.tar > /dev/null
tar xvf C1G34ML.tar > /dev/null
echo `ifconfig eth0 | grep "inet addr" | perl -ne 's/addr:([0-9\.]+)/$1/;print "$1\n"'` REUXGBLS291 >> /etc/hosts
echo `ifconfig eth0 | grep "inet addr" | perl -ne 's/addr:([0-9\.]+)/$1/;print "$1\n"'` REUXGBLS291 >> /etc/hosts
# Bodge this Red Hat Linux file so that the version number is the 7th string
echo "Extra special CentOS Linux final release 6.5 Final" > /etc/redhat-release
# Need to sort out autostart scripts so DM, Node and Server start!
WAS/install -options /vagrant/ndmgr.rsp -silent
/etc/init.d/WASDM.sh start
/etc/init.d/WASNode.sh start
# 5 Second gap required - some file creation going on after DM & Node start?
sleep 5
/etc/init.d/WASServer.sh start
