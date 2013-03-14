class nrpe::install {

  include nrpe::params

  package { $nrpe::params::nrpe_package:
    ensure  => installed,
  }
  package { $nrpe::params::nrpe_check_package:
    ensure  => installed,
  }

  case $osfamily {
    RedHat: {
      package { ["perl-Nagios-Plugin"]: ensure => installed }
      package { ["nagios-plugins-http","nagios-plugins-tcp", "nagios-plugins-sensors", "nagios-plugins-time", "nagios-plugins-dig", "nagios-plugins-rpc", "nagios-plugins-dns","nagios-plugins-ups", "nagios-plugins-ldap", "nagios-plugins-nagios", "nagios-plugins-smtp"]: ensure => installed }
      package { ["nagios-plugins-dhcp","nagios-plugins-disk","nagios-plugins-dummy","nagios-plugins-file_age","nagios-plugins-icmp","nagios-plugins-ide_smart","nagios-plugins-load","nagios-plugins-log","nagios-plugins-mailq","nagios-plugins-ntp","nagios-plugins-perl","nagios-plugins-ping","nagios-plugins-procs","nagios-plugins-ssh","nagios-plugins-swap","nagios-plugins-users", "nagios-plugins-check_sip","nagios-plugins-cluster"]: ensure => installed }
      package { ["nagios-plugins-check-updates","nagios-plugins-fping","nagios-plugins-mysql","nagios-plugins-snmp","nagios-plugins-rhev","nagios-plugins-ifstatus","nagios-plugins-linux_raid"]: ensure => installed }
    }
    Debian: {
      package { ["libnagios-plugin-perl"]: ensure => installed }
      package { ["nagios-plugins-extra","nagios-plugins-basic","nagios-plugins-standard", "nagios-plugins"]: ensure => installed }
    }
  }

}
