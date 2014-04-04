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
echo "10.0.15.3 REUXGBLS291" >> /etc/hosts
echo "10.0.15.4 REUXGBLS292" >> /etc/hosts
# Bodge this Red Hat Linux file so that the version number is the 7th string
echo "Extra special CentOS Linux final release 6.5 Final" > /etc/redhat-release