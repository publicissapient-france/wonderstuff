#
# Cookbook Name:: wonderstuff
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

package 'lighttpd'

service 'lighttpd' do
  action [:enable, :start]
end

cookbook_file '/var/www/index.html' do
  source 'wonderstuff.html'
end
