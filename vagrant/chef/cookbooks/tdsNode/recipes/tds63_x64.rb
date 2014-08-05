# Cookbook Name:: tdiNode
# Recipe:: default
#
# Copyright 2014, Dennis English <devop@nomoreheroes.org.uk>
#

yum_package "ksh" do
  action :install
end

yum_package "compat-libstdc++-33" do
  action :install
end

yum_package "glibc.i686" do
  action :install
end

yum_package "libstdc++.i686" do
  action :install
end

directory "/installFiles" do
  owner "root"
  group "root"
  mode 00644
  action :create
end

execute "Copy archive files to VM" do
  command "cp /installs/TDS63Linux64/tds63-linux-x86-64.tar /installFiles/"
  ignore_failure false
  not_if do ::File.exists?('/installFiles/tds63-linux-x86-64.tar') end
end

bash "Unpack archive files on VM" do
	cwd "/installFiles/"
	user "root"
	group "root"
	code <<-EOH
		tar xvf tds63-linux-x86-64.tar > /dev/null
	EOH
	not_if do :: File.directory?('/installFiles/tds63-linux-x86-64') end
end

template "db2RSP" do
  path "/installFiles/db2TDS_TIM.rsp"
  source "db2TDS_TIM.rsp"
  mode 00755
  owner "vagrant"
  group "vagrant"
  not_if do ::File.exists?('/installFiles/db2TDS_TIM.rsp') end
end

bash "install DB2" do
	cwd "/installFiles/tds63-linux-x86-64/"
	user "root"
	group "root"
	code <<-EOH
		db2/db2setup -r /installFiles/db2TDS_TIM.rsp
		EOH
	ignore_failure false
	not_if do :: File.directory?('/opt/ibm/db2/') end
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

template "tdsLogRotate" do
  path "/etc/logrotate.d/tdsLogRotate"
  source "tdsLogRotate"
  mode 0644
  owner "root"
  group "root"
end

template "create com.ldif" do
  path "/installFiles/com.ldif"
  source "com.ldif"
  mode 0644
  owner "root"
  group "root"
end

bash "install TDS" do
	cwd "/installFiles/tds63-linux-x86-64/tdsfiles/"
	user "root"
	group "root"
	code <<-EOH
		./idsLicense -q
		rpm -ivh *.rpm > /dev/null
		EOH
	ignore_failure false
	not_if do :: File.directory?('/opt/IBM/ldap/V6.3/') end
end

# openssl passwd -1 "theplaintextpassword"
user "db2sdfe1" do
  action :create
  username "db2sdfe1"
  password "$1$pOrCLtof$ckkB0vSWzSyIQJAmzpVdW1"
end

# openssl passwd -1 "theplaintextpassword"
user "idsldap" do
  action :create
  username "idsldap"
  password "$1$CkdXMaEj$ZcmxwDStoG.Kff13SM8el1"
end

bash "Configure TDS 1 - Configure LDAP instance" do
	cwd "/opt/IBM/ldap/V6.3/sbin"
	user "root"
	group "root"
	code <<-EOH
		#echo "Minimum config needed to create an instance"
		./idsicrt -I idsldap -b /installFiles/tds-install.txt -e madeinchelsea
		EOH
end

bash "Configure TDS 2 - Configure DB2 settings into LDAP config" do
	cwd "/opt/IBM/ldap/V6.3/sbin"
	user "root"
	group "root"
	code <<-EOH
		#echo "create DB2 database"
		./idscfgdb -I idsldap -t idsldap -a idsldap -l /home/idsldap -w idsldap -n	
	EOH
end

bash "Configure TDS 3 - Set cn=root password" do
	cwd "/opt/IBM/ldap/V6.3/sbin"
	user "root"
	group "root"
	code <<-EOH
		#echo "set cn=root password. It is possible to choose a custom admin user if desired"
		./idsdnpw -I idsldap -p idsldap -n
	EOH
end

bash "Configure TDS 4 - Configure com suffix" do
	cwd "/opt/IBM/ldap/V6.3/sbin"
	user "root"
	group "root"
	code <<-EOH
		./idscfgsuf -I idsldap -s dc=com -n
	EOH
end

bash "Configure TDS 5 - Start LDAP and add com entry" do
	cwd "/opt/IBM/ldap/V6.3/sbin"
	user "root"
	group "root"
	code <<-EOH
		./ibmslapd -I idsldap -n
		sleep 10
		../bin/idsldapadd -D cn=root -w idsldap -f /installFiles/com.ldif		
	EOH
end


# Look for a better way, I want to enable and disable using a chef service resource
bash "Enable services autostart" do
	cwd "/etc/"
	user "root"
	group "root"
	code <<-EOH
		ln -s /etc/init.d/tds.sh /etc/rc.d/rc3.d/S99tds.sh
		ln -s /etc/init.d/tds.sh /etc/rc.d/rc5.d/S99tds.sh
		ln -s /etc/init.d/tdsAdmin.sh /etc/rc.d/rc3.d/S99tdsAdmin.sh
		ln -s /etc/init.d/tdsAdmin.sh /etc/rc.d/rc5.d/S99tdsAdmin.sh
		chmod 755 /etc/init.d/tds.sh
		chmod 755 /etc/init.d/tdsAdmin.sh
		EOH
		ignore_failure false
		not_if do ::File.exists?('/etc/rc.d/rc5.d/S99tdsAdmin.sh') end
end

service "tdsAdmin.sh" do
  action	:start
  not_if "ps auxww | grep ibmdiradm | grep -v grep"
end

service "tds.sh" do
  action	:start
  not_if "ps auxww | grep ibmslapd | grep -v grep"
end