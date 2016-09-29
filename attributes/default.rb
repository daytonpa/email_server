default['email_server'].tap do |email|

    email['user'] = 'jade_helm'
    email['group'] = 'jade_helm'
    email['home'] = '/bin/bash'

    # ssh configuration attributes
    email['listening_address'] = '0.0.0.0'
    email['listening_port'] = '22'
    email['pubkey_auth'] = 'yes'

    # The following attributes will configure Postfix for your
    # email server. Change the attribute values for your domain

    # Your server's domain name
    email['my_domain'] = 'yourdomain'
    email['ext'] = 'com'
    email['full_domain'] = "#{node['email_server']['my_domain']}.#{node['email_server']['ext']}"
    # Your server's IP Address
    email['network_address'] = '192.168.0.0'
    # Remote servers must identify themselves
    email['smtpd_helo'] = 'yes'
    # Ask remote servers to identify themselves with a certificate
    email['smtpds_tls_ask_ccert'] = 'yes'
    # Location of certificate authority
    email['smtpds_tls_CAfile'] = '/etc/ssl/certs/ca-certificates.cr'
    # Postfix forced encryption ciphers.  Set to 'high' to avoid using weak ciphers
    email['smtpd_tls_ciphers'] = 'high'
end
