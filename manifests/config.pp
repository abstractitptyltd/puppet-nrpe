
class nrpe::config {

	include users::virtual
	include nrpe::params

	$pid_file = $nrpe::params::pid_file
#	$nagios_extra_plugins = $nrpe::params::nagios_extra_plugins
#	$nagios_plugins = $nrpe::params::nagios_plugins

	file { 'nrpecfg':
		name	=> '/etc/nagios/nrpe.cfg',
		owner	=> nagios,
		group	=> nagios,
		mode	=> 644,
		content => template('nrpe/nrpe.cfg.erb'),
		notify	=> Class['nrpe::service'],
	}

	file { '/etc/nrpe.d':
		ensure	=> directory,
		owner	=> nagios,
		group	=> nagios,
		mode	=> 644,
	}

	file { '/etc/nagios/send_nsca.cfg':
		owner	=> nagios,
		group	=> nagios,
		mode	=> 644,
		content	=> template('monitoring/send_nsca.cfg.erb'),
	}
	File {
		require	=> Class['nrpe::install'],
	}

}

