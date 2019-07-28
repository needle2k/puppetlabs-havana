# The profile for installing the Cinder API
class stein::profile::cinder::api {

  stein::resources::controller { 'cinder': }
  stein::resources::database { 'cinder': }
  stein::resources::firewall { 'Cinder API': port => '8776', }

  class { '::cinder::keystone::auth':
    password         => hiera('stein::cinder::password'),
    public_address   => hiera('stein::controller::address::api'),
    admin_address    => hiera('stein::controller::address::management'),
    internal_address => hiera('stein::controller::address::management'),
    region           => hiera('stein::region'),
  }

  include ::stein::common::cinder

  class { '::cinder::api':
    keystone_password  => hiera('stein::cinder::password'),
    keystone_auth_host => hiera('stein::controller::address::management'),
    enabled            => true,
  }

  class { '::cinder::scheduler':
    scheduler_driver => 'cinder.scheduler.simple.SimpleScheduler',
    enabled          => true,
  }
}
