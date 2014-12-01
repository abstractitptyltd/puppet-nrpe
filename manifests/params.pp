class nrpe::params (
  $nagios_ips           = undef, # comma separated list of ips that can talk to nrpe
  $user                 = 'nrpe',
  $group                = 'nrpe',
  $port                 = 5666,
  $command_timeout      = 180,
  $firewall             = false, # # disabling this for now
  $nagios_extra_plugins = undef,) {
  $nagios_plugins = $::architecture ? {
    'x86_64' => '/usr/lib64/nagios/plugins',
    default  => '/usr/lib/nagios/plugins'
  }

  case $::lsbdistdescription {
    # # some tricky logic to use systemd on fedora 17+
    /Fedora release (.+)/ : {
      if versioncmp($1, '17') >= 0 {
        $nrpe_service  = 'nrpe.service'
        $nrpe_provider = 'systemd'
      }
    }
    /^(Debian|Ubuntu)/    : {
      $nrpe_service  = 'nagios-nrpe-server'
      $nrpe_provider = undef
    }
    default               : {
      $nrpe_service  = 'nrpe'
      $nrpe_provider = undef
    }
  }

  case $::operatingsystem {
    default           : {
      $nrpe_package       = 'nrpe'
      $nrpe_check_package = 'nagios-plugins-nrpe'
      $pid_file           = '/var/run/nrpe/nrpe.pid'
    }
    /(Debian|Ubuntu)/ : {
      $nrpe_package       = 'nagios-nrpe-server'
      $nrpe_check_package = 'nagios-nrpe-plugin'
      $pid_file           = '/var/run/nagios/nrpe.pid'
    }
  }

  case $::osfamily {
    RedHat : {
      $plugin_package_list = [
        'perl-Nagios-Plugin',
        'nagios-plugins-all',
        ]
    }
    Debian : {
      $plugin_package_list = [
        'libnagios-plugin-perl',
        'nagios-plugins-extra',
        'nagios-plugins-basic',
        'nagios-plugins-standard',
        'nagios-plugins']
    }
  }
}
