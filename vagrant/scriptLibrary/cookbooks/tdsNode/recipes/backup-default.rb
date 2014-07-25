# Cookbook Name:: tdiNode
# Recipe:: default
#
# Copyright 2014, Dennis English <devop@nomoreheroes.org.uk>
#

directory "/installFiles" do
  owner "root"
  group "root"
  mode 00644
  action :create
end

execute "Copy archive files to VM" do
  command "cp /installs/TDS61Linux32/* /installFiles/"
  ignore_failure false
end

bash "Unpack archive files on VM" do
	cwd "/installFiles/"
	user "root"
	group "root"
	code <<-EOH
		tar xvf tds61-linux-ia32-CD1_w_entitlement.tar > /dev/null
		tar xvf tds61-linux-ia32-CD2.tar > /dev/null
		tar xvf tds61-linux-ia32-CD3.tar > /dev/null
		EOH
end

yum_package "ksh" do
  action :install
end

yum_package "compat-libstdc++-33" do
  action :install
end

template "db2RSP" do
  path "/installFiles/db2.rsp"
  source "db2.rsp"
  mode 00755
  owner "root"
  group "root"
  not_if do ::File.exists?('/installFiles/db2.rsp') end
end

bash "install DB2" do
	cwd "/installFiles/tdsV6.1/"
	user "root"
	group "root"
	code <<-EOH
		db2/db2setup -r /installFiles/db2.rsp
		EOH
	ignore_failure false
end

bash "install TDS" do
	cwd "/installFiles/tdsV6.1/tdsfiles/"
	user "root"
	group "root"
	code <<-EOH
		rpm -ivh *.rpm > /dev/null
		EOH
	ignore_failure false
end

template "db2" do
  path "/etc/init.d/db2.sh"
  source "initdScript.txt"
  variables({
	:start => node[:db2Node][:start],
	:stop => node[:db2Node][:stop]
  })
  mode 0755
  owner "root"
  group "root"
end

template "tds" do
  path "/etc/init.d/tds.sh"
  source "initdScript.txt"
  variables({
	:start => node[:tdsNode][:start],
	:stop => node[:tdsNode][:stop]
  })
  mode 0755
  owner "root"
  group "root"
end

template "tdsAdmin" do
  path "/etc/init.d/tdsAdmin.sh"
  source "initdScript.txt"
  variables({
	:start => node[:tdsAdminNode][:start],
	:stop => node[:tdsAdminNode][:stop]
  })
  mode 0755
  owner "root"
  group "root"
end

template "WASServer" do
  path "/etc/init.d/WASServer.sh"
  source "initdScript.txt"
  variables({
	:start => node[:WASServer][:start],
	:stop => node[:WASServer][:stop]
  })
  mode 0755
  owner "root"
  group "root"
end

template "tdsLogRotate" do
  path "/etc/logrotate.d/tdsLogRotate"
  source "tdsLogRotate"
  mode 0644
  owner "root"
  group "root"
end

# Look for a better way, I want to enable and disable using a chef service resource
bash "Enable services autostart" do
	cwd "/etc/"
	user "root"
	group "root"
	code <<-EOH
		ln -s /etc/init.d/db2.sh /etc/rc.d/rc3.d/S99db2.sh
		ln -s /etc/init.d/db2.sh /etc/rc.d/rc5.d/S99db2.sh
		ln -s /etc/init.d/tds.sh /etc/rc.d/rc3.d/S99tds.sh
		ln -s /etc/init.d/tds.sh /etc/rc.d/rc5.d/S99tds.sh
		ln -s /etc/init.d/tdsAdmin.sh /etc/rc.d/rc3.d/S99tdsAdmin.sh
		ln -s /etc/init.d/tdsAdmin.sh /etc/rc.d/rc5.d/S99tdsAdmin.sh
		ln -s /etc/init.d/WASServer.sh /etc/rc.d/rc3.d/S99WASServer
		ln -s /etc/init.d/WASServer.sh /etc/rc.d/rc5.d/S99WASServer
		chmod 755 /etc/init.d/db2.sh
		chmod 755 /etc/init.d/tds.sh
		chmod 755 /etc/init.d/tdsAdmin.sh
		chmod 755 /etc/init.d/WASServer.sh
		EOH
		ignore_failure true
end

#userdel idsldap
#idsadduser -u idsldap -w iamanalien -g idsldap -n
#echo "Minimum config needed to create an instance"
#idsicrt -I idsldap -b /root/tds-install.txt -e madeinchelsea
#echo "create DB2 database"
#idscfgdb -I idsldap -t idsldap -a idsldap -l /home/idsldap -w iamanalien -n
#echo "set cn=root password. It is possible to choose a custom admin user if desired"
#idsdnpw -I idsldap -p password -n
#idscfgsuf -I idsldap -s dc=com -n
#ibmslapd -I idsldap -n
#sleep 10
#idsldapadd -D cn=root -w password -f /vagrant/com.ldif

#echo "Configure TDS WAS App"
#/tds_install/tdsV6.1/appsrv/install.sh -installRoot /opt/TDS_WAS/
#cd /opt/ibm/ldap/V6.1/idstools/
#./deploy_IDSWebApp -w /opt/ibm/ldap/V6.1/idstools/IDSWebApp.war -p /opt/TDS_WAS/




service "tdsAdmin.sh" do
  action	:start
  not_if "ps auxww | grep dmgr | grep -v grep"
end

service "tds.sh" do
  action	:start
  not_if "ps auxww | grep dmgr | grep -v grep"
end

service "WASServer.sh" do
  action	:start
  not_if "ps auxww | grep dmgr | grep -v grep"
end