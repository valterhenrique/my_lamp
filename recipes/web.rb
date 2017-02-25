#
# Cookbook:: my_lamp
# Recipe:: web
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# install apache and start the service
httpd_service 'lamp' do
  # PHP must be run in a single-threaded Multi-Processing Module, or MPM.
  # Therefore, we set the mpm attribute to use the prefork module.
  mpm 'prefork'
  action [:create, :start]
end

# add the site configuration
httpd_config 'lamp' do
  instance 'lamp'
  source 'lamp.conf.erb'
  notifies :restart, 'httpd_service[lamp]'
end

# create the document root directory
directory node['my_lamp']['document_root'] do
  recursive true
end

#write the home page
file "#{node['my_lamp']['document_root']}/index.html" do
  content '<html>This is a placeholder</html>'
  mode '0644'
  owner node['my_lamp']['user']
  group node['my_lamp']['group']
end
