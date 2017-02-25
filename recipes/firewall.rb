#
# Cookbook:: my_lamp
# Recipe:: firewall
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'firewall::default'

node['my_lamp']['open_ports'].each do |oport|
  firewall_rule "open port #{oport}" do
    port oport
  end
end
