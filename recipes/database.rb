#
# Cookbook:: my_lamp
# Recipe:: database
#
# Copyright:: 2017, The Authors, All Rights Reserved.

#configure the MySQL client
mysql_client 'default' do
  action :create
end
# configure MySQL service
mysql_service 'default' do
  initial_root_password node['my_lamp']['database']['root_pw']
  action [:create, :start]
end
