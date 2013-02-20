class nrpe::service {
  include nrpe::params

  service { 'nrpe':
    name => $nrpe::params::nrpe_service,
    provider => $nrpe::params::nrpe_provider,
    ensure => running,
    enable => true,
    hasstatus => $operatingsystem ? { default => true, Debian => false },
    hasrestart => true,
    require => Class['nrpe::install'],
  }
}
