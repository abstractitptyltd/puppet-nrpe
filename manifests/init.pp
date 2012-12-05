class nrpe {
	include nrpe::params
  include nrpe::users
	include nrpe::install
	include nrpe::config
	include nrpe::service
  #	include nrpe::firewall ## can't use this for now because it's another module i wrote which needs to be added to my project
  Class[nrpe::params] -> Class[nrpe::users] -> Class[nrpe::install] -> Class[nrpe::config] -> Class[nrpe::service]
}
