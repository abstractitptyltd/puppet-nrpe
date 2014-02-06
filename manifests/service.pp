class nrpe::service {
  include nrpe::params

  service { 'nrpe':
    ensure     => running,
    name       => $nrpe::params::nrpe_service,
    provider   => $nrpe::params::nrpe_provider,
    enable     => true,
    hasstatus  => $::operatingsystem ? { default  => true, Debian => false },
    hasrestart => true,
    require    => Class['nrpe::install'],
  }
}
