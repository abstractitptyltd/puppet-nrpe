
class nrpe::config {

  include ::nrpe

  $nagios_ips = $::nrpe::nagios_ips
  $user = $::nrpe::user
  $group = $::nrpe::group
  $port = $::nrpe::port
  $command_timeout = $::nrpe::command_timeout
  $nagios_extra_plugins = $::nrpe::nagios_extra_plugins

  $pid_file = $nrpe::params::pid_file
  $nagios_plugins = $::nrpe::params::nagios_plugins

  file { '/etc/nagios/nrpe.cfg':
    ensure  => file,
    owner   => 'nagios',
    group   => 'nagios',
    mode    => '0644',
    content => template('nrpe/nrpe.cfg.erb'),
    notify  => Class['nrpe::service'],
  }

  file { '/etc/nrpe.d':
    ensure => directory,
    owner  => 'nagios',
    group  => 'nagios',
    mode   => '0755',
  }

}

