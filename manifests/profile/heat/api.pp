# The profile for installing the heat API
class stein::profile::heat::api {
  stein::resources::controller { 'heat': }
  stein::resources::database { 'heat': }
  stein::resources::firewall { 'Heat API': port     => '8004', }
  stein::resources::firewall { 'Heat CFN API': port => '8000', }

  $controller_management_address = hiera('stein::controller::address::management')

  class { '::heat::keystone::auth':
    password         => hiera('stein::heat::password'),
    public_address   => hiera('stein::controller::address::api'),
    admin_address    => hiera('stein::controller::address::management'),
    internal_address => hiera('stein::controller::address::management'),
    region           => hiera('stein::region'),
  }

  class { '::heat::keystone::auth_cfn': 
    password         => hiera('stein::heat::password'),
    public_address   => hiera('stein::controller::address::api'),
    admin_address    => hiera('stein::controller::address::management'),
    internal_address => hiera('stein::controller::address::management'),
    region           => hiera('stein::region'),
  }

  class { '::heat':
    sql_connection    => $::stein::resources::connectors::heat,
    rabbit_host       => hiera('stein::controller::address::management'),
    rabbit_userid     => hiera('stein::rabbitmq::user'),
    rabbit_password   => hiera('stein::rabbitmq::password'),
    debug             => hiera('stein::debug'),
    verbose           => hiera('stein::verbose'),
    keystone_host     => hiera('stein::controller::address::management'),
    keystone_password => hiera('stein::heat::password'),
  }

  class { '::heat::api':
    bind_host => hiera('stein::controller::address::api'),
  }

  class { '::heat::api_cfn':
    bind_host => hiera('stein::controller::address::api'),
  }

  class { '::heat::engine':
    auth_encryption_key => hiera('stein::heat::encryption_key'),
  }
}
