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
#
# Maybe later
# * Set IP address to the one that WAS expects - chef or vagrant ???
#
#

directory "/installFiles" do
  owner "root"
  group "root"
  mode 00644
  action :create
end

# Ensure this file exists and contains a specific string that WAS install can use.
file "/etc/centos-release" do
  owner "root"
  group "root"
  mode "0644"
  action :create
  content "Extra special CentOS Linux final release 6.5 Final"
end

bash "update hosts file" do
	cwd "/etc"
	user "root"
	group "root"
	code <<-EOH
		echo "10.0.15.3 REUXGBLS291" >> hosts
		echo "10.0.15.4 REUXGBLS292" >> hosts
		EOH
	environment 'PREFIX' => "/usr/local"
end

execute "Copy archive files to VM" do
  command "cp /installs/WAS7_Linux32/* /installFiles/"
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
  path "/installFiles/simpleCell.rsp"
  source "simpleCell.rsp"
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
		ln -s /etc/init.d/WASNode.sh /etc/rc.d/rc3.d/S99WASNode
		ln -s /etc/init.d/WASNode.sh /etc/rc.d/rc5.d/S99WASNode
		ln -s /etc/init.d/WASServer.sh /etc/rc.d/rc3.d/S99WASServer
		ln -s /etc/init.d/WASServer.sh /etc/rc.d/rc5.d/S99WASServer
		ln -s /etc/init.d/WASDM.sh /etc/rc.d/rc3.d/S99WASDM
		ln -s /etc/init.d/WASDM.sh /etc/rc.d/rc5.d/S99WASDM
		EOH
		ignore_failure true
end

bash "install WAS" do
	cwd "/installFiles/"
	user "root"
	group "root"
	code <<-EOH
		WAS/install -options /installFiles/simpleCell.rsp -silent
		EOH
	ignore_failure false
end

service "wasDM" do
  action	:start
  not_if "ps auxww | grep dmgr | grep -v grep"
end

service "wasNode" do
  action   :start
  not_if "ps auxww | grep nodeagent | grep -v grep"
end

service "wasServer" do
  action   :start
  retries	3
  retry_delay	3
  not_if "ps auxww | grep server1 | grep -v grep"
end

template "wasVNodeRSP" do
  path "/installFiles/vNode2.rsp"
  source "vNode.rsp"
  variables({
	:wasDM => node[:wasNode][:hostname],
	:wasProfile => node[:wasNode2][:profile]
  })
  mode 0755
  owner "root"
  group "root"
end

bash "create vNode2" do
	cwd "/opt/IBM/WebSphere/AppServer/"
	user "root"
	group "root"
	code <<-EOH
		bin/manageprofiles.sh -create -response /installFiles/vNode2.rsp
		EOH
	ignore_failure false
end

bash "Federate vNode2" do
	cwd "/opt/IBM/WebSphere/AppServer/profiles/AppSrv02"
	user "root"
	group "root"
	code <<-EOH
		bin/addNode.sh REUXGBLS291 8879 -username wasadmin -password Passw0rd
		EOH
	ignore_failure false
end