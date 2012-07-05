class nrpe::params {

	case $operatingsystem {
		default: {
			$nrpe_package		= 'nrpe'
			$nrpe_check_package	= 'nagios-plugins-nrpe'
			$nrpe_service		= 'nrpe'
			$pid_file			= '/var/run/nrpe.pid'
		}
		/(Debian|Ubuntu)/: {
			$nrpe_package		= 'nagios-nrpe-server'
			$nrpe_check_package	= 'nagios-nrpe-plugin'
			$nrpe_service		= 'nagios-nrpe-server'
			$pid_file			= '/var/run/nagios/nrpe.pid'
		}
	}
}
