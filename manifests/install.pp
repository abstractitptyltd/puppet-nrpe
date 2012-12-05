class nrpe::install {

	include nrpe::params

	package { $nrpe::params::nrpe_package:
		ensure	=> installed,
	}
	if $operatingsystem =~ /(CentOS|Redhat|Fedora)/ {
		package { 'nsca-client': ensure => installed }
	}
	package { $nrpe::params::nrpe_check_package:
		ensure	=> installed,
	}
}
