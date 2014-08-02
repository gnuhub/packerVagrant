#!/usr/bin/env bash
hostname REUXGBLS292
# Need to sort out autostart scripts so DM, Node and Server start!
cd /WAS_install
echo "start install"
WAS/install -options /vagrant/nd.rsp -silent
echo "end install"
# Start up the node
#/etc/init.d/WASServer.sh start