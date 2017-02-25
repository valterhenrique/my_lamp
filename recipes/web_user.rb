#
# Cookbook:: my_lamp
# Recipe:: web_user
#
# Copyright:: 2017, The Authors, All Rights Reserved.

group node['my_lamp']['group']

user node['my_lamp']['user'] do
  group node['my_lamp']['group']
  system true
  shell '/bin/bash'
end
