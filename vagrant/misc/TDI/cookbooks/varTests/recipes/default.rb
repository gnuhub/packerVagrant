# Cookbook Name:: tests
# Recipe:: default
#
# Copyright 2014, Dennis English <devop@nomoreheroes.org.uk>
#


template "samples.txt" do
  path "/samples.txt"
  source "samples.txt"
  variables({
	:myIP => node[:ipaddress],
	:myPlatform => node[:platform]
  })
  mode 0755
  owner "root"
  group "root"
end