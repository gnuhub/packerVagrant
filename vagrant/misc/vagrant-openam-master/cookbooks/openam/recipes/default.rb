#
# Cookbook Name:: openam
# Recipe:: default
#
# Copyright 2012, Patrick de Lanauze
#
# All rights reserved - Do Not Redistribute
#

include_recipe "tomcat"

unless File.exists? '/var/lib/tomcat6/webapps/openam.war'

  bash "install openam" do
    user "tomcat6"
    cwd '/tmp'
    command 'wget http://download.forgerock.org/downloads/openam/openam10/10.0.0/openam_10.0.0.war' unless File.exists? '/tmp/openam_10.0.0.war'
    command 'mv ./openam_10.0.0.war /var/lib/tomcat6/webapps/openam.war'
  end

  bash 'chown openam' do
    user 'root'
    command 'sudo chown tomcat6:tomcat6 /var/lib/tomcat6/webapps/openam.war'
    command 'sudo chown -R tomcat6 /usr/share/tomcat6'
  end

end