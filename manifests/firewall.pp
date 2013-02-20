class nrpe::firewall {

  include nrpe::params
  $nagios_ips = split($nrpe::params::nagios_ip, ',')

  if $nrpe::params::firewall {
    firewall { '100 nrpe rules':
      proto => 'tcp',
      source => $nagios_ips,
      dport => 5666,
      state => 'NEW',
      action => 'accept',
    }
  }

}
