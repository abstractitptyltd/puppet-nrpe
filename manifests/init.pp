class nrpe {
  include nrpe::params
  include nrpe::users
  include nrpe::install
  include nrpe::config
  include nrpe::service
  include nrpe::firewall
  include nrpe::monitoring
  Class[nrpe::params] ->
  Class[nrpe::users] ->
  Class[nrpe::install] ->
  Class[nrpe::config] ~>
  Class[nrpe::service] ->
  Class[nrpe::firewall] ->
  Class[nrpe::monitoring] ->
  Class[nrpe]

##  This method of class chaining doesn't seem to be working properly
/*
  class{'nrpe::params':} ->
  class{'nrpe::install':} ->
  class{'nrpe::config':} ~>
  class{'nrpe::service':} ->
  class{'nrpe::firewall':} ->
  class{'nrpe::monitoring':} ->
  Class['nrpe']
*/
}
