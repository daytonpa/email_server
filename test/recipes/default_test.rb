# # encoding: utf-8

# Inspec test for recipe email_server::default

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

# Default admin and group
describe user('jade_helm') do
    it { should exist }
end

describe group('jade_helm') do
    it { should exist }
    its('members') { should cmp 'jade_helm' }
end

# Default packages
%w( postfix postfix-mysql dovecot-core dovecot-imapd
    dovecot-lmtpd dovecot-mysql ).each do |pkg|
    describe package(pkg) do
        it { should be_installed }
        # its('owner') { should cmp 'jade_helm' }
    end
end

describe file('/etc/ssh/sshd_config') do
    it { should exist }
    it { should be_file }
    its('owner') { should cmp 'jade_helm' }
    its('group') { should cmp 'jade_helm' }
    its('mode') { should cmp '0644'}
end

describe file('/etc/postfix/main.cf') do
    it { should exist }
    it { should be_file }
    its('owner') { should cmp 'jade_helm' }
    its('group') { should cmp 'jade_helm' }
    its('mode') { should cmp '0644' }
end

describe file('/etc/mailname') do
    it { should exist }
    it { should be_file }
end
# describe port(8080) do
#     it { should be_listening }
# end
