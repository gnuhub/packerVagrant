#!/usr/bin/env bash
echo "Add TDI locations to the path"
#export PATH=$PATH:/opt/ibm/ldap/V6.1/bin:/opt/ibm/ldap/V6.1/sbin
#echo "PATH=$PATH:/opt/ibm/ldap/V6.1/sbin:/opt/ibm/ldap/V6.1/bin" >> /etc/profile.d/paths.sh

echo "Copying install files on to VM and Decompressing"
mkdir /tdi_install
cp /installs/* /tdi_install/
cd /tdi_install
tar xvf TDI_IDENTITY_E_7.1.1_LIN-X86.tar
/tdi_install/linux_x86/install_tdiv711_linux_x86.bin -i silent -f /vagrant/tdi.rsp &> /dev/null

# Look to improve configuration					- todo
# Configure VM for desktop use of TDI IDE		- todo
# Modify config to allow X forwarding			- todo