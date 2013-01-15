
define nrpe::plugin ( $ensure = 'present', $plugin = "main", $check_command, $sudo = false ) {

  include nrpe::params
  $nagios_plugins = $nrpe::params::nagios_plugins
  $nagios_extra_plugins = $nrpe::params::nagios_extra_plugins

  file { "nrpe_plugin_${name}":
    ensure => $ensure,
    name => "/etc/nrpe.d/${name}.cfg",
    owner => root,
    group => root,
    mode => 644,
    content => template("nrpe/nrpe_service.cfg.erb"),
    notify => Class['nrpe::service'],
  }
}
