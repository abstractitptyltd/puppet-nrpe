class nrpe::firewall {

  include ::nrpe
  $nagios_ips = $::nrpe::nagios_ips
  $firewall = $::nrpe::firewall

  if $firewall {
    firewall { '100 nrpe rules':
      proto  => 'tcp',
      source => $nagios_ips,
      dport  => 5666,
      state  => 'NEW',
      action => 'accept',
    }
  }

}
