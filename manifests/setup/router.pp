define stein::setup::router {
  $subnet = hiera('stein::network::neutron::private')

  neutron_router { $title:
    tenant_name          => $title,
    gateway_network_name => 'public',
    require              => [Neutron_network['public'], Neutron_subnet["${subnet}"]]
  } ->

  neutron_router_interface  { "${title}:${subnet}": 
    ensure => present
  }
}
