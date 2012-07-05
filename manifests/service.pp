class nrpe::service {
	include nrpe::params

	service { "nrpe":
		name		=> $nrpe::params::nrpe_service,
		ensure		=> running,
		enable		=> true,
		hasstatus	=> $operatingsystem ? { default => true, Debian => false },
		hasrestart	=> true,
#		subscribe	=> Class['nrpe::config'],
		require		=> Class['nrpe::install'],
	}
}
