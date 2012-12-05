class nrpe::firewall {

  # this won't work right now because it uses another of my modules that i need to release
/*
  include firewall

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
*/
}
