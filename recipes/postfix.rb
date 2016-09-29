#
# Cookbook Name:: email_server
# Recipe:: postfix
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

template '/etc/postfix/main.cf' do
    user node['email_server']['user']
    group node['email_server']['group']
    mode '0644'
    source 'main.cf.erb'
    action :create
    
    notifies :restart, 'service[postfix]', :immediately
end

template '/etc/postfix/virtual-mailbox-domains.db' do
    user node['email_server']['user']
    group node['email_server']['group']
    mode '0644'
    source 'virtual-mailbox-domains.db.erb'
    action :create

    notifies :restart, 'service[postfix]', :immediately
end

template '/etc/postfix/virtual-mailbox-users' do
    user node['email_server']['user']
    group node['email_server']['group']
    mode '0644'
    source 'virtual-mailbox-users.erb'
    action :create

    notifies :restart, 'service[postfix]', :immediately
end

template '/etc/postfix/virtual' do
    user node['email_server']['user']
    group node['email_server']['group']
    mode '0644'
    source 'virtual.erb'
    action :create

    notifies :restart, 'service[postfix]', :immediately
end
