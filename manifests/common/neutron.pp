# Common class for neutron installation
# Private, and should not be used on its own
# Sets up configuration common to all neutron nodes.
# Flags install individual services as needed
# This follows the suggest deployment from the neutron Administrator Guide.
class stein::common::neutron {
  $controller_management_address = hiera('stein::controller::address::management')

  $data_network = hiera('stein::network::data')
  $data_address = ip_for_network($data_network)

  class { '::neutron':
    rabbit_host     => $controller_management_address,
    core_plugin     => 'neutron.plugins.openvswitch.ovs_neutron_plugin.OVSNeutronPluginV2',
    rabbit_user     => hiera('stein::rabbitmq::user'),
    rabbit_password => hiera('stein::rabbitmq::password'),
    debug           => hiera('stein::debug'),
    verbose         => hiera('stein::verbose'),
  }

  # everone gets an ovs agent (TODO true?)
  class { '::neutron::agents::ovs':
    enable_tunneling => 'True',
    local_ip         => $data_address,
    enabled          => true,
    tunnel_types     => ['gre',],
  }

  # everyone gets an ovs plugin (TODO true?)
  class  { '::neutron::plugins::ovs':
    sql_connection      => $::stein::resources::connectors::neutron,
    tenant_network_type => 'gre',
  }

  if $::osfamily == 'redhat' {
    package { 'iproute':
        ensure => latest,
        before => Class['::neutron']
    }
  }
}
