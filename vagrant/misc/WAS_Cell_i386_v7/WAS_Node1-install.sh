#!/usr/bin/env bash
hostname REUXGBLS291
# Need to sort out autostart scripts so DM, Node and Server start!
echo "start install"
cd /WAS_install
WAS/install -options /vagrant/ndmgr.rsp -silent
echo "end install"
/etc/init.d/WASDM.sh start
/etc/init.d/WASNode.sh start
# 5 Second gap required - some file creation going on after DM & Node start?
sleep 5
/etc/init.d/WASServer.sh start