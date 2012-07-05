
define nrpe::plugin ( $ensure = 'present', $plugin = "main", $check_command, $sudo = false ) {

	include nrpe::params

	file { "nrpe_plugin_${name}":
		ensure	=> $ensure,
		name	=> "/etc/nrpe.d/$name.cfg",
		owner   => root,
		group   => root,
		mode	=> 644,
		content => template("monitoring/nrpe_service.cfg.erb"),
		notify	=> Class['nrpe::service'],
	}
}
