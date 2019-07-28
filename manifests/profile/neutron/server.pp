# The profile to set up the neutron server
class stein::profile::neutron::server {
  stein::resources::controller { 'neutron': }
  stein::resources::database { 'neutron': }
  stein::resources::firewall { 'Neutron API': port => '9696', }

  class { '::neutron::keystone::auth':
    password         => hiera('stein::neutron::password'),
    public_address   => hiera('stein::controller::address::api'),
    admin_address    => hiera('stein::controller::address::management'),
    internal_address => hiera('stein::controller::address::management'),
    region           => hiera('stein::region'),
  }

  class { '::neutron::server':
    auth_host     => hiera('stein::controller::address::management'),
    auth_password => hiera('stein::neutron::password'),
    enabled       => true,
  }

  include ::stein::common::neutron
}
