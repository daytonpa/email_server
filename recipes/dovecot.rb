#
# Cookbook Name:: email_server
# Recipe:: postfix
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

template '/etc/dovecot/passwd.db' do
    user node['email_server']['user']
    group node['email_server']['group']
    mode '0644'
    source 'passwd.db.erb'
    action :create
end

template '/etc/dovecot/conf.d/01-mail-stack-delivery.conf' do
    user node['email_server']['user']
    group node['email_server']['group']
    mode '0644'
    source '01-mail-stack-delivery.conf.erb'
    action :create
end
