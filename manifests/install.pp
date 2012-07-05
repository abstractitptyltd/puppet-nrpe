class nrpe::install {

	include nrpe::params

	package { 'nrpe':
		ensure	=> installed,
		name	=> $operatingsystem ? { /(Debian|Ubuntu)/ => 'nagios-nrpe-server', default => 'nrpe' },
	}

	if $operatingsystem =~ /(CentOS|Redhat|Fedora)/ {
		package { 'nsca-client': ensure => installed }
	}
	package { 'nrpe_check':
		ensure	=> installed,
		name	=> $operatingsystem ? { /(CentOS|Redhat|Fedora)/ => 'nagios-plugins-nrpe', /(Debian|Ubuntu)/ => 'nagios-nrpe-plugin' },
	}
}
