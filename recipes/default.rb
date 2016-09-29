#
# Cookbook Name:: email_server
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# This recipe is a run-list for building your own email server.  It will
# allow you to create a custom domain and user accounts.

include_recipe 'apt'

# Create default user and group
user node['email_server']['user'] do
    home node['email_server']['home']
    system true
end
group node['email_server']['group'] do
    members node['email_server']['user']
    system true
end

# Install basic email packages
%w( postfix postfix-mysql dovecot-core
    dovecot-imapd dovecot-lmtpd dovecot-mysql).each do |pkg|
    apt_package(pkg) do
        action :install
    end
end

# Install custom ssh configuration file to allow default user
# permissions to the command line
template '/etc/ssh/sshd_config' do
    user node['email_server']['user']
    group node['email_server']['group']
    mode '0644'
    source 'sshd_config.erb'
    action :create
    notifies :restart, 'service[ssh]', :immediately
end

# This recipe will configure the postfix service for your server
include_recipe 'email_server::postfix'

service 'ssh' do
    supports status: true, reload: true, restart: true
    action [:start, :enable]
end

service 'postfix' do
    supports status: true, reload: true, restart: true
    action [:start, :enable]
end

service 'dovecot' do
    supports status: true, reload: true, restart: true
    action [:start, :enable]
end
