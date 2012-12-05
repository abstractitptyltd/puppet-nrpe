
class nrpe::config {

  include nrpe::params

  $pid_file = $nrpe::params::pid_file
  $port = $nrpe::params::port
  $user = $nrpe::params::user
  $group = $nrpe::params::group
  $nagios_plugins = $nrpe::params::nagios_plugins
  $nagios_extra_plugins = $nrpe::params::nagios_extra_plugins
  $nagios_ips = $nrpe::params::nagios_ips
  $command_timeout = $nrpe::params::command_timeout

  file { 'nrpecfg':
    name => '/etc/nagios/nrpe.cfg',
    owner => nagios,
    group => nagios,
    mode => 644,
    content => template('nrpe/nrpe.cfg.erb'),
    notify => Class['nrpe::service'],
  }

  file { '/etc/nrpe.d':
    ensure => directory,
    owner => nagios,
    group => nagios,
    mode => 644,
  }

}

