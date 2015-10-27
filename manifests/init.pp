class nrpe (
  $nagios_ips = $::nrpe::params::nagios_ips,
  $user = $::nrpe::params::user,
  $group = $::nrpe::params::group,
  $port = $::nrpe::params::port,
  $command_timeout = $::nrpe::params::command_timeout,
  $firewall = $::nrpe::params::firewall,
  $nagios_extra_plugins = $::nrpe::params::nagios_extra_plugins,
) inherits ::nrpe::params {

  require sudo
  class{'::nrpe::install':} ->
  class{'::nrpe::config':} ~>
  class{'::nrpe::service':} ->
  class{'::nrpe::firewall':} ->
  Class['nrpe']

}
