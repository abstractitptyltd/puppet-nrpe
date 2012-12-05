class nrpe::params (
  $user = 'nrpe',
  $group = 'nrpe',
  $port = 5666,
  $nagios_ips, # comma separated list of ips that can talk to nrpe
  $nagios_extra_plugins = undef, # directory for non standard nagios scripts
  $command_timeout = 180,
)
{
  $nagios_plugins = $architecture ? { 'x86_64' => '/usr/lib64/nagios/plugins', default => '/usr/lib/nagios/plugins'}
  case $operatingsystem {
    default: {
      $nrpe_package = 'nrpe'
      $nrpe_check_package = 'nagios-plugins-nrpe'
      $nrpe_service = 'nrpe'
      $pid_file = '/var/run/nrpe/nrpe.pid'
    }
    /(Debian|Ubuntu)/: {
      $nrpe_package = 'nagios-nrpe-server'
      $nrpe_check_package = 'nagios-nrpe-plugin'
      $nrpe_service = 'nagios-nrpe-server'
      $pid_file = '/var/run/nagios/nrpe.pid'
    }
  }
}
