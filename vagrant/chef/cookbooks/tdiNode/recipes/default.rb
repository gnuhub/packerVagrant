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
  command "cp /installs/TDI-V711/* /installFiles/"
  ignore_failure false
  not_if do ::File.exists?('/installFiles/TDI_IDENTITY_E_7.1.1_LIN-X86.tar') end
end

bash "Unpack archive files on VM" do
	cwd "/installFiles/"
	user "root"
	group "root"
	code <<-EOH
		tar xvf TDI_IDENTITY_E_7.1.1_LIN-X86.tar &> /dev/null
		EOH
	not_if do :: File.directory?('/installFiles/linux_x86/') end
end

template "tdiRSP" do
  path "/installFiles/tdi.rsp"
  source "tdi.rsp"
  mode 0755
  owner "root"
  group "root"
  not_if do ::File.exists?('/installFiles/tdi.rsp') end
end

bash "install TDI" do
	cwd "/installFiles/linux_x86/"
	user "root"
	group "root"
	code <<-EOH
		/installFiles/linux_x86/install_tdiv711_linux_x86.bin -i silent -f /installFiles/tdi.rsp &> /dev/null
		EOH
	ignore_failure false
	# Bodge due to installer producing warnings due to failure to determine Linux DE version
	returns 1
	not_if do :: File.directory?('/opt/IBM/TDI/V7.1.1/') end
end