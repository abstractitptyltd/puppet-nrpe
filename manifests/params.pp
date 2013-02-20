class nrpe::params (
  $user = 'nrpe',
  $group = 'nrpe',
  $port = 5666,
  $nagios_ips, # comma separated list of ips that can talk to nrpe
  $command_timeout = 180,
  $firewall = false, ## disabling this for now
)
{
  $nagios_plugins = $architecture ? { 'x86_64' => '/usr/lib64/nagios/plugins', default => '/usr/lib/nagios/plugins'}
  $nagios_extra_plugins = hiera('monitoring::nagios_extra_plugins', undef)
  case $lsbdistdescription {
    ## some tricky logic to use systemd on fedora 17+
    /Fedora release (.+)/: {
      if versioncmp($1,"17") >= 0 {
        $nrpe_service = 'nrpe.service'
        $nrpe_provider = 'systemd'
      }
    }
    /^(Debian|Ubuntu)/: {
      $nrpe_service = 'nagios-nrpe-server'
      $nrpe_provider = undef
    }
    default: {
      $nrpe_service = 'nrpe'
      $nrpe_provider = undef
    }
  }
  case $operatingsystem {
    default: {
      $nrpe_package = 'nrpe'
      $nrpe_check_package = 'nagios-plugins-nrpe'
      $pid_file = '/var/run/nrpe/nrpe.pid'
      #$nrpe_service = 'nrpe'
    }
    /(Debian|Ubuntu)/: {
      $nrpe_package = 'nagios-nrpe-server'
      $nrpe_check_package = 'nagios-nrpe-plugin'
      #$nrpe_service = 'nagios-nrpe-server'
      $pid_file = '/var/run/nagios/nrpe.pid'
    }
  }
}
