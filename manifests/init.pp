class nrpe {
  class{'nrpe::params':} ->
  class{'nrpe::install':} ->
  class{'nrpe::config':} ~>
  class{'nrpe::service':} ->
  class{'nrpe::firewall':} ->
  class{'nrpe::monitoring':} ->
  Class['nrpe']
}
