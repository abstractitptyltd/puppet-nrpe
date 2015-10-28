class nrpe (
  $nagios_ips = $::nrpe::params::nagios_ips,
  $user = $::nrpe::params::user,
  $group = $::nrpe::params::group,
  $port = $::nrpe::params::port,
  $command_timeout = $::nrpe::params::command_timeout,
  $firewall = $::nrpe::params::firewall,
  $nagios_extra_plugins = $::nrpe::params::nagios_extra_plugins,
) inherits ::nrpe::params {

  require ::sudo
  include ::nrpe::install
  include ::nrpe::config
  include ::nrpe::service
  include ::nrpe::firewall

  Class['::nrpe::install'] ->
  Class['::nrpe::config'] ~>
  Class['::nrpe::service'] ->
  Class['::nrpe::firewall']

}
