case node['platform']
  when "ubuntu"

  case
  when node['platform_version'].to_f <= 9.04
    default['postgresql']['version'] = "8.3"
  when node['platform_version'].to_f <= 11.04
    default['postgresql']['version'] = "8.4"
  else
    default['postgresql']['enable_pgdg_apt'] = true
    default['postgresql']['version'] = "9.3"
  end

  default['postgresql']['dir'] = "/etc/postgresql/#{node['postgresql']['version']}/main"
  case
  when (node['platform_version'].to_f <= 10.04) && (! node['postgresql']['enable_pgdg_apt'])
    default['postgresql']['server']['service_name'] = "postgresql-#{node['postgresql']['version']}"
  else
    default['postgresql']['server']['service_name'] = "postgresql"
  end

  default['postgresql']['client']['packages'] = ["postgresql-client-#{node['postgresql']['version']}","libpq-dev"]
  default['postgresql']['server']['packages'] = ["postgresql-#{node['postgresql']['version']}"]
  default['postgresql']['contrib']['packages'] = ["postgresql-contrib-#{node['postgresql']['version']}"]
  
  default['postgresql']['config']['ssl_key_file']  = '/etc/ssl/private/ssl-cert-snakeoil.key'
  default['postgresql']['config']['ssl_cert_file'] = '/etc/ssl/certs/ssl-cert-snakeoil.pem'
  
  
  default['postgresql']['config']['data_directory'] = "/var/lib/postgresql/#{node['postgresql']['version']}/main"
  default['postgresql']['config']['hba_file'] = "/etc/postgresql/#{node['postgresql']['version']}/main/pg_hba.conf"
  default['postgresql']['config']['ident_file'] = "/etc/postgresql/#{node['postgresql']['version']}/main/pg_ident.conf"
  default['postgresql']['config']['external_pid_file'] = "/var/run/postgresql/#{node['postgresql']['version']}-main.pid"
  default['postgresql']['config']['unix_socket_directories'] = '/var/run/postgresql' if node['postgresql']['version'].to_f >= 9.3
end