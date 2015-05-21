#
# Cookbook Name:: lamp
# Recipe:: default
#
# Copyright 2015, Manato Kuroda
#
# All rights reserved - Do Not Redistribute
#

# PHP, Apache
%w{php php-devel php-mbstring php-mysql httpd}.each do |p|
    package p do
        action :install
        options "--enablerepo=remi --enablerepo=remi-php55"
    end
end

# MySQL
remote_file "/tmp/#{node['mysql']['file_name']}" do
    source "#{node['mysql']['remote_uri']}"
end
bash "install_mysql" do
    user "root"
    cwd "/tmp"
    code <<-EOH
        tar xf "#{node['mysql']['file_name']}"
    EOH
end
node['mysql']['rpm'].each do |rpm|
  package rpm[:package_name] do
    action :install
    provider Chef::Provider::Package::Rpm
    source "/tmp/#{rpm[:rpm_file]}"
  end
end
service "mysqld" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end


service "iptables" do
  action [:disable, :stop]
end

# chkconfig httpd on
# httpd -k start
service "httpd" do
    action [:enable, :start]
end

# template "httpd.conf" do
#     path "/etc/httpd/conf/httpd.conf"
#     source "httpd.conf.erb"
#     mode 0644
#     notifes :restart, "service[httpd]"
# end

template "index.html" do
    path "/var/www/html/index.html"
    source "index.html.erb"
    mode 0644
end
