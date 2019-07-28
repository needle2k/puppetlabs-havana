class stein::setup::sharednetwork {

  $external_network = hiera('stein::network::external')
  $start_ip = hiera('stein::network::external::ippool::start')
  $end_ip   = hiera('stein::network::external::ippool::end')
  $ip_range = "start=${start_ip},end=${end_ip}"
  $gateway  = hiera('stein::network::external::gateway')
  $dns      = hiera('stein::network::external::dns')

  $private_network = hiera('stein::network::neutron::private')

  neutron_network { 'public':
    tenant_name              => 'services',
    provider_network_type    => 'gre',
    router_external          => true,
    provider_segmentation_id => 3604,
    shared                   => true,
  } ->

  neutron_subnet { $external_network:
    cidr             => $external_network,
    ip_version       => '4',
    gateway_ip       => $gateway,
    enable_dhcp      => false,
    network_name     => 'public',
    tenant_name      => 'services',
    allocation_pools => [$ip_range],
    dns_nameservers  => [$dns],
  }

  neutron_network { 'private':
    tenant_name              => 'services',
    provider_network_type    => 'gre',
    router_external          => false,
    provider_segmentation_id => 4063,
    shared                   => true,
  } ->

  neutron_subnet { $private_network:
    cidr             => $private_network,
    ip_version       => '4',
    enable_dhcp      => true,
    network_name     => 'private',
    tenant_name      => 'services',
    dns_nameservers  => [$dns],
  } 

  stein::setup::router { 'services': }
  stein::setup::router { 'test': }
}
