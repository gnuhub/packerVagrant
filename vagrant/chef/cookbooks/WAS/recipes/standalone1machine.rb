# Cookbook Name:: WAS
# Recipe:: default
#
# Copyright 2014, Dennis English <devop@nomoreheroes.org.uk>
#
# To do
# * Create hosts file from template, not executing shell commands.
# * Alternative way to tar/untar files and, generally, replace any use of bash commands where possible.
# * Add more "guards" and checks to make sure everything is working!
# * Ensure variables only work when the host has a specific name - needed as soon as install goes multi-node!
# * Use chef resources to enable/disable services, not bash shell commands.
# * Update SIM install so that archive is copied to VM, extracted there and then installed!

%w{compat-libstdc++-33 compat-db gtk2 gtk2-engines libXp libXmu libXtst pam rpm-build elfutils elfutils-libs libXft ksh libstdc++}.each do |pkg|
	package pkg do
		action :install
	end
end	

directory "/installFiles" do
  owner "root"
  group "root"
  mode 00644
  action :create
end

directory "/installFiles/rsp" do
  owner "root"
  group "root"
  mode 00644
  action :create
end

directory "/installFiles/customScripts" do
  owner "root"
  group "root"
  mode 00644
  action :create
end

template "updateInstaller" do
  path "/installFiles/rsp/updateInstaller.rsp"
  source "updateInstaller.rsp"
  mode 0755
  owner "root"
  group "root"
end

template "was-fp31" do
  path "/installFiles/rsp/was-fp31.rsp"
  source "was-fp31.rsp"
  mode 0755
  owner "root"
  group "root"
end

template "configResponse" do
  path "/installFiles/rsp/configResponse.properties"
  source "configResponse3.properties"
  mode 0755
  owner "root"
  group "root"
end

template "installvariables-single" do
  path "/installFiles/rsp/installvariables-single.properties"
  source "installvariables-single.properties"
  mode 0755
  owner "root"
  group "root"
end

# Ensure this file exists and contains a specific string that WAS install can use.
file "/etc/centos-release" do
  owner "root"
  group "root"
  mode "0644"
  action :create
  content "Extra special CentOS Linux final release 6.5 Final"
end

execute "Copy archive files to VM" do
  command "cp -rf /installs/WAS7_Linux32/* /installFiles/"
  ignore_failure false
  not_if do ::File.exists?('/installFiles/C1G34ML.tar.gz') end
end

bash "Unpack archive files on VM" do
	cwd "/installFiles/"
	user "root"
	group "root"
	code <<-EOH
		tar zxvf C1G2CML.tar.gz > /dev/null
		tar zxvf C1G32ML.tar.gz > /dev/null
		tar zxvf C1G33ML.tar.gz > /dev/null
		tar zxvf C1G34ML.tar.gz > /dev/null
		EOH
	not_if do ::File.exists?('/installFiles/WAS/install') end
end

template "wasDM" do
  path "/etc/init.d/wasDM"
  source "initdScript.txt"
  variables({
	:start => node[:wasDM][:start],
	:stop => node[:wasDM][:stop]
  })
  mode 0755
  owner "root"
  group "root"
end

template "wasNode" do
  path "/etc/init.d/wasNode"
  source "initdScript.txt"
  variables({
	:start => node[:wasNode][:start],
	:stop => node[:wasNode][:stop]
  })
  mode 0755
  owner "root"
  group "root"
end

template "wasServer" do
  path "/etc/init.d/wasServer"
  source "initdScript.txt"
  variables({
	:start => node[:wasServer][:start],
	:stop => node[:wasServer][:stop]
  })
  mode 0755
  owner "root"
  group "root"
end

template "wasRSPFile" do
  path "/installFiles/standalone.rsp"
  source "standalone.rsp"
  variables({
	:wasHost => node[:wasNode][:hostname]
  })
  mode 0755
  owner "root"
  group "root"
end

# Look for a better way, I want to enable and disable using a chef service resource
bash "Enable services autostart" do
	cwd "/etc/"
	user "root"
	group "root"
	code <<-EOH
		ln -s /etc/init.d/wasNode /etc/rc.d/rc3.d/S99WASNode
		ln -s /etc/init.d/wasNode /etc/rc.d/rc5.d/S99WASNode
		ln -s /etc/init.d/wasServer /etc/rc.d/rc3.d/S99WASServer
		ln -s /etc/init.d/wasServer /etc/rc.d/rc5.d/S99WASServer
		ln -s /etc/init.d/wasDM /etc/rc.d/rc3.d/S99WASDM
		ln -s /etc/init.d/wasDM /etc/rc.d/rc5.d/S99WASDM
		EOH
		not_if do ::File.exists?('etc/rc.d/rc5.d/S99WASDM') end
end

bash "install WAS" do
	cwd "/installFiles/"
	user "root"
	group "root"
	code <<-EOH
		WAS/install -options /installFiles/standalone.rsp -silent
		EOH
	ignore_failure false
	not_if do ::File.exists?('/opt/IBM/WebSphere/AppServer/bin/startServer.sh') end
end

bash "update SOAP client timeout" do
	cwd "/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/properties/"
	user "root"
	group "root"
	code <<-EOH
		cp soap.client.props soap.client.props.bak
		sed -e 's/requestTimeout=180/requestTimeout=0/' soap.client.props.bak > soap.client.props
	EOH
	environment 'PREFIX' => "/usr/local"
	not_if do ::File.exists?('/app/IBM/WebSphere/AppServer/profiles/AppSrv01/properties/soap.client.props.bak') end
end

execute "install WAS update installer" do
  command "/installFiles/UpdateInstaller/install -options /installFiles/rsp/updateInstaller.rsp -silent"
  ignore_failure false
  not_if do ::File.exists?('/opt/IBM/WebSphere/UpdateInstaller/update.sh') end
end

execute "install WAS fix pack update" do
  command "/opt/IBM/WebSphere/UpdateInstaller/update.sh -options /installFiles/rsp/was-fp31.rsp -silent"
  ignore_failure false
  not_if "grep 7.0.0.31 /opt/IBM/WebSphere/AppServer/properties/version/WAS.product"
end

service "wasServer" do
  action   :start
  retries	3
  retry_delay	3
  not_if "ps auxww | grep server1 | grep -v grep"
end

bash "install ISIM" do
	cwd "/installs/SIM6/SIM_6.0_FOR_LINUX,_ML/"
	user "root"
	group "root"
	code <<-EOH
		./instlinux.bin -i silent -f /installFiles/rsp/installvariables-single.properties -DITIM_CFG_RESP_FILE_DIR=/installFiles/rsp/
	EOH
	ignore_failure true
	not_if do ::File.exists?('/opt/IBM/isim/data/enRole.properties') end
end