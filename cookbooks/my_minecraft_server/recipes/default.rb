#
# Cookbook Name:: minecraft_server
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Use the following to create your own linux admin user, replace angle backets with your actual username and public key
# node.override['admin']['name'] = '<your user name>'
# node.override['admin']['pub_key'] = '<your ssh public key>'

# Adding your mojang account here will make you an admin on the minecraft server, replace angle brackets with your
# actual username
# node.override['minecraft']['ops'] = %w(<your mojang account>)


node.override['sds-dns-caching']['dnsmasq']['servers'] = %w(8.8.8.8 8.8.4.4)

include_recipe 'base-server::apt'
include_recipe 'base-server::users' if node['admin']
include_recipe 'base-server::dns-caching'
include_recipe 'base-server::misc'


## Uncomment the following line to create a vannilla, bukkit, spigot or ftb server
# node.override['minecraft']['install_type'] = 'vanilla'
# node.override['minecraft']['install_type'] = 'bukkit'
# node.override['minecraft']['install_type'] = 'spigot'
node.override['minecraft']['install_type'] = 'ftb'

# The type of minecraft server can be set in the default attributes file of this cookbook
include_recipe 'minecraft::default'

