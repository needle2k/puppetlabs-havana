# The profile to set up the Nova controller (several services)
class stein::profile::nova::api {
  stein::resources::controller { 'nova': }
  stein::resources::database { 'nova': }
  stein::resources::firewall { 'Nova API': port => '8774', }
  stein::resources::firewall { 'Nova Metadata': port => '8775', }
  stein::resources::firewall { 'Nova NoVncProxy': port => '6080', }

  class { '::nova::keystone::auth':
    password         => hiera('stein::nova::password'),
    public_address   => hiera('stein::controller::address::api'),
    admin_address    => hiera('stein::controller::address::management'),
    internal_address => hiera('stein::controller::address::management'),
    region           => hiera('stein::region'),
    cinder           => true,
  }

  include ::stein::common::nova
}
