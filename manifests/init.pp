class nrpe {
	include nrpe::params
	include nrpe::install
	include nrpe::config
	include nrpe::service
	include nrpe::firewall
}
