# Cookbook Name:: WAS
# Recipe:: default
#
# Windows practice.
#

#directory "c:/chefMade" do
#  owner "root"
#  group "root"
#  mode 00644
#  action :create
#end

# Can I create a user ?
# Can I create a group ?
# if yes to both, use them when creating a file.
# copy/download app and install
# set path to help with using commands/apps
# need 7zip & learn useful basic DOS ones well.
# Do nuff apps to create nice desktop windows automagically.

# Different to Unix, need rights (Learn more)
directory "C:/chefmade" do
  rights :read, "Everyone"
end

# Update templates - create user and group then try to use them & see effect
template "update hosts file" do
  path "C:/Windows/System32/Drivers/etc/hosts2"
  source "hosts.txt"
  mode 0644
#  owner "root"
#  group "root"
end

# Runs DOS cmds as well as bash ones.
execute "Copy archive files to VM" do
  command "ipconfig > c:/chefmade/netcfg2"
  ignore_failure false
  not_if do ::File.exists?('/installFiles/C1G34ML.tar.gz') end
end

# Look for a better way, I want to enable and disable using a chef service resource
#bash "Enable services autostart" do
#	cwd "/etc/"
#	user "root"
#	group "root"
#	code <<-EOH
#		ln -s /etc/init.d/WASNode.sh /etc/rc.d/rc3.d/S99WASNode
#		EOH
#		ignore_failure true
#end

#service "wasDM" do
#  action	:start
#  not_if "ps auxww | grep dmgr | grep -v grep"
#end

#service "wasNode" do
#  action   :start
#  not_if "ps auxww | grep nodeagent | grep -v grep"
#end

#service "wasServer" do
#  action   :start
#  retries	3
#  retry_delay	3
#  not_if "ps auxww | grep server1 | grep -v grep"
#end