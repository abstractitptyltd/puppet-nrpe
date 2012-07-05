class nrpe::firewall {

	firewall::rule { 'nrpe':
		proto	=> 'tcp',
		source	=> $nagios_ip,
		dport	=> 5666,
		state	=> 'NEW',
		jump	=> 'ACCEPT',
	}
	if $nagios_ip2 != '' {
		firewall::rule { 'nrpe2':
			proto	=> 'tcp',
			source	=> $nagios_ip2,
			dport	=> 5666,
			state	=> 'NEW',
			jump	=> 'ACCEPT',
		}
	}

}
