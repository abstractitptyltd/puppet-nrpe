
class nrpe::monitoring {

  monitoring::service { 'nrpe':
    service_description => 'NRPE',
    servicegroups => 'system',
    check_command => 'check_nrpe_status',
    contact_groups => 'admins,linux_admins',
    sms_contact_groups => 'linux_admin_sms',
  }

}
