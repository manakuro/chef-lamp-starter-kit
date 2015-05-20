#
# Cookbook Name:: lamp
# Recipe:: default
#
# Copyright 2015, Manato Kuroda
#
# All rights reserved - Do Not Redistribute
#

# PHP, MySQL, Apache
%w{php php-devel php-mbstring php-mysql mysql-server httpd}.each do |p|
    package p do
        action :install
        options "--enablerepo=remi --enablerepo=remi-php55"
    end
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
