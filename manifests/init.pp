class nrpe {
  require sudo
  include nrpe::params
  class{'nrpe::install':} ->
  class{'nrpe::config':} ~>
  class{'nrpe::service':} ->
  class{'nrpe::firewall':} ->
  Class['nrpe']

}
