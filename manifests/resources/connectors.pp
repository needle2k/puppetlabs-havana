class stein::resources::connectors {

  $management_address = hiera('stein::controller::address::management')
  $password = hiera('stein::mysql::service_password')

  $keystone = "mysql://keystone:${password}@${management_address}/keystone"
  $cinder   = "mysql://cinder:${password}@${management_address}/cinder"
  $glance   = "mysql://glance:${password}@${management_address}/glance"
  $nova     = "mysql://nova:${password}@${management_address}/nova"
  $neutron  = "mysql://neutron:${password}@${management_address}/neutron"
  $heat     = "mysql://heat:${password}@${management_address}/heat"
}
