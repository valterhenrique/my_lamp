#
# Cookbook:: my_lamp
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'apt::default'
include_recipe 'my_lamp::firewall'
include_recipe 'my_lamp::web_user'
