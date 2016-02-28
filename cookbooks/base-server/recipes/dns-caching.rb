#
# Cookbook Name:: curse-dns-caching
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'resolvconf'

package 'dnsmasq'

template '/etc/dnsmasq.d/listen.conf' do
  source 'listen.conf.erb'
  notifies_immediately :restart, 'service[dnsmasq]'
end

template '/etc/dnsmasq.d/dns.conf' do
  source 'dns.conf.erb'
  notifies_immediately :restart, 'service[dnsmasq]'
  only_if {lazy{node['sds-dns-caching']['dnsmasq']['servers']}}
end

service 'dnsmasq' do
  action [:enable, :start]
end
