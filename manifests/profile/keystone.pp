# The profile to install the Keystone service
class stein::profile::keystone {

  stein::resources::controller { 'keystone': }
  stein::resources::database { 'keystone': }
  stein::resources::firewall { 'Keystone API': port => '5000', }

  class { '::keystone':
    admin_token    => hiera('stein::keystone::admin_token'),
    sql_connection => $::stein::resources::connectors::keystone,
    verbose        => hiera('stein::verbose'),
    debug          => hiera('stein::debug'),
  }

  class { '::keystone::roles::admin':
    email        => hiera('stein::keystone::admin_email'),
    password     => hiera('stein::keystone::admin_password'),
    admin_tenant => 'admin',
  }

  class { 'keystone::endpoint':
    public_address   => hiera('stein::controller::address::api'),
    admin_address    => hiera('stein::controller::address::management'),
    internal_address => hiera('stein::controller::address::management'),
    region           => hiera('stein::region'),
  }

  $tenants = hiera('stein::tenants')
  $users = hiera('stein::users')
  create_resources('stein::resources::tenant', $tenants)
  create_resources('stein::resources::user', $users)
}
