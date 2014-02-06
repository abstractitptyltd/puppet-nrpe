
define nrpe::plugin (
  $check_command,
  $ensure = 'present',
  $plugin = 'main',
  $command_args = '',
  $sudo = false
) {

  include nrpe::params
  $nagios_plugins = $nrpe::params::nagios_plugins
  $nagios_extra_plugins = $nrpe::params::nagios_extra_plugins ? {
    default => $nrpe::params::nagios_extra_plugins,
    undef   => $nagios_plugins,
  }

  file { "nrpe_plugin_${name}":
    ensure  => $ensure,
    name    => "/etc/nrpe.d/${name}.cfg",
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('nrpe/nrpe_service.cfg.erb'),
    notify  => Class['nrpe::service'],
  }
  if $sudo == true {
    # setup sudo rules for this command
    if defined(Sudo::Rule["nrpe_${name}"]) {
      # don't set this up again
    } else {
    sudo::rule { "nrpe_${name}":
      ensure   => $ensure,
      who      => 'nrpe',
      commands => $plugin ? { "main" => "${nagios_plugins}/${check_command}", default => "${nagios_extra_plugins}/${check_command}" },
      nopass   => true,
    }
    }
  }
}
