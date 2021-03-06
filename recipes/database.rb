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
  initial_root_password node['my_lamp']['database']['root_password']
  action [:create, :start]
end

# The database cookbook (chef supermarket, not this one) uses the mysql2 Ruby library (a Ruby library is often packaged as a gem) to connect to MySQL.
# To install this gem, we'll use the mysql2_chef_gem cookbook.

# install mysql2 Ruby gem
mysql2_chef_gem 'default' do
  action :install
end

# create the database instance
mysql_database node['my_lamp']['database']['dbname'] do
  connection(
    :host => node['my_lamp']['database']['host'],
    :username => node['my_lamp']['database']['root_username'],
    :password => node['my_lamp']['database']['root_password']
  )
  action :create
end

# add a database user
mysql_database_user node['my_lamp']['database']['admin_username'] do
  connection(
    :host => node['my_lamp']['database']['host'],
    :username => node['my_lamp']['database']['root_username'],
    :password => node['my_lamp']['database']['root_password']
  )
  password node['my_lamp']['database']['admin_password']
  database_name node['my_lamp']['database']['dbname']
  host node['my_lamp']['database']['host']
  action [:create, :grant]
end

create_tables_script_path = File.join(Chef::Config[:file_cache_path], 'create-tables.sql')
cookbook_file create_tables_script_path do
  source 'create-tables.sql'
  owner 'root'
  group 'root'
  mode '0600'
end

execute "initialize #{node['my_lamp']['database']['dbname']} database" do
  command "mysql" \
    " -h #{node['my_lamp']['database']['host']}" \
    " -u #{node['my_lamp']['database']['admin_username']}" \
    " -p#{node['my_lamp']['database']['admin_password']}" \
    " -D #{node['my_lamp']['database']['dbname']} < #{create_tables_script_path}"

  not_if "mysql" \
    " -h #{node['my_lamp']['database']['host']}" \
    " -u #{node['my_lamp']['database']['admin_username']}" \
    " -p#{node['my_lamp']['database']['admin_password']}" \
    " -D #{node['my_lamp']['database']['dbname']} -e 'describe customers;'"


end
