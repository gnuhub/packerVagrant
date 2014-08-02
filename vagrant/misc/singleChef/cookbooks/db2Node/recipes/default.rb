# Cookbook Name:: db2Node
# Recipe:: default
#
# Copyright 2014, Dennis English <devop@nomoreheroes.org.uk>
#

directory "/installFiles" do
  owner "root"
  group "root"
  mode 00755
  action :create
end

execute "Copy archive files to VM" do
  command "cp /installs/DB210Linux64/* /installFiles/"
  ignore_failure false
  not_if do ::File.exists?('/installFiles/DB2_ESE_10_Linux_x86-64.tar.gz') end
end

bash "Unpack archive files on VM" do
	cwd "/installFiles/"
	user "root"
	group "root"
	code <<-EOH
		tar zxvf DB2_ESE_10_Linux_x86-64.tar.gz &> /dev/null
		EOH
	not_if do :: File.directory?('/installFiles/ese/') end
end

template "tdiRSP" do
  path "/installFiles/db2.rsp"
  source "db2.rsp"
  mode 00755
  owner "vagrant"
  group "vagrant"
  not_if do ::File.exists?('/installFiles/db2.rsp') end
end

bash "install DB2" do
	cwd "/installFiles/"
	user "vagrant"
	group "vagrant"
	code <<-EOH
		ese/db2setup -r /installFiles/db2.rsp
		EOH
	ignore_failure false
end