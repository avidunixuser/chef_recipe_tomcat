#
# Cookbook:: tomcat
# Recipe:: server
#
# Copyright:: 2017, The Authors, All Rights Reserved.

package 'java-1.8.0-openjdk-devel'

# 'sudo groupadd tomcat'
group 'tomcat'
group 'chef'

# sudo useradd -M -s /bin/nologin -g tomcat -d /opt/tomcat tomcat
user 'tomcat' do
  manage_home false
  shell '/bin/nologin'
  group 'tomcat'
  home '/opt/tomcat'
end

# sudo useradd -M -s /bin/bash -d /home/chef -g chef chef -p chef
user 'chef' do
  comment 'A Chef user'
  home '/home/chef'
  shell '/bin/bash'
  group 'chef'
  password 'chef'
end

directory '/opt/tomcat' do
  #action :create group
  group 'tomcat'
end

# wget http://apache.mirrors.ionfish.org/tomcat/tomcat-8/v8.5.20/bin/apache-tomcat-8.5.20.tar.gz

remote_file 'apache-tomcat-8.5.23.tar.gz' do
  source 'http://apache.mirrors.ionfish.org/tomcat/tomcat-8/v8.5.23/bin/apache-tomcat-8.5.23.tar.gz'
end


# TODO: extract tomcat compressed tar file - NOT DESIRED_STATE
execute 'sudo tar xvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1'

# TODO: execute group permissions - NOT DESIRED_STATE
execute 'sudo chown -R tomcat /opt'
execute 'sudo chgrp -R tomcat /opt'

# directory '/opt/tomcat/conf' do
#   mode '0070'
# end

# TODO: NOT DESIRED_STATE
execute 'chmod g+rwx /opt/tomcat/conf'
execute 'chmod g+r /opt/tomcat/conf/*'

# TODO: NOT DESIRED_STATE
execute 'sudo chown -R tomcat /opt/tomcat /opt/tomcat/webapps/ /opt/tomcat/work/ /opt/tomcat/temp/ /opt/tomcat/logs/'

# TODO: NOT DESIRED_STATE
#execute 'sudo vi /etc/systemd/system/tomcat.service' do
template '/etc/systemd/system/tomcat.service' do
      source 'tomcat.service.erb'
end



# TODO: NOT DESIRED_STATE
execute 'sudo systemctl daemon-reload'
# execute 'sleep 60'

service 'tomcat' do
  action [:start, :enable]
end
