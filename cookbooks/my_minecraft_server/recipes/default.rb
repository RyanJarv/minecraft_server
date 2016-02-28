#
# Cookbook Name:: minecraft_server
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

node.override['sds-dns-caching']['dnsmasq']['servers'] = %w(8.8.8.8 8.8.4.4)

node.override['minecraft']['install_type'] = 'bukkit'
node.override['minecraft']['ops'] = %w(rgerstenkorn)

include_recipe 'base-server::apt'
include_recipe 'base-server::users'
include_recipe 'base-server::dns-caching'


node.override['java']['install_flavor'] = 'openjdk'

include_recipe 'minecraft::default'

