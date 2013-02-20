class nrpe::users {

  /*
  group { 'nagcmd':
    ensure => present,
    gid => 401,
    allowdupe => false,
  }

  group { 'nrpe':
    ensure => present,
    gid => 399,
    allowdupe => false,
  }
  user { 'nrpe':
    ensure => present,
    uid => 399,
    gid => nrpe,
    comment => 'NRPE user for the NRPE service',
    home => '/',
    groups => [ 'nagios' ],
    shell => $nologin_shell,
    provider => 'useradd',
    require => Group[nrpe],
  }

  group { 'nagios':
    ensure => present,
    gid => 400,
    allowdupe => false,
    tag => ['nagios']
  }
  user { 'nagios':
    ensure => present,
    uid => 400,
    gid => nagios,
    comment => 'Nagios User',
    home => '/var/spool/nagios',
    shell => '/bin/bash',
    groups => [ 'nagcmd' ],
    managehome => true,
    provider => 'useradd',
    require => Group[nagios],
    tag => ['nagios']
  }
  */
}

