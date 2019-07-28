# The profile to install the Glance API and Registry services
# Note that for this configuration API controls the storage,
# so it is on the storage node instead of the control node
class stein::profile::glance::api {
  $api_network = hiera('stein::network::api')
  $api_address = ip_for_network($api_network)

  $management_network = hiera('stein::network::management')
  $management_address = ip_for_network($management_network)

  $explicit_management_address = hiera('stein::storage::address::management')
  $explicit_api_address = hiera('stein::storage::address::api')

  $controller_address = hiera('stein::controller::address::management')

  if $management_address != $explicit_management_address {
    fail("Glance Auth setup failed. The inferred location of Glance from
    the stein::network::management hiera value is
    ${management_address}. The explicit address from
    stein::storage::address::management is ${explicit_management_address}.
    Please correct this difference.")
  }

  if $api_address != $explicit_api_address {
    fail("Glance Auth setup failed. The inferred location of Glance from
    the stein::network::management hiera value is
    ${api_address}. The explicit address from
    stein::storage::address::api is ${explicit_api_address}.
    Please correct this difference.")
  }

  stein::resources::firewall { 'Glance API': port      => '9292', }
  stein::resources::firewall { 'Glance Registry': port => '9191', }

  class { '::glance::api':
    keystone_password => hiera('stein::glance::password'),
    auth_host         => hiera('stein::controller::address::management'),
    keystone_tenant   => 'services',
    keystone_user     => 'glance',
    sql_connection    => $::stein::resources::connectors::glance,
    registry_host     => hiera('stein::storage::address::management'),
    verbose           => hiera('stein::verbose'),
    debug             => hiera('stein::debug'),
  }

  class { '::glance::backend::file': }

  class { '::glance::registry':
    keystone_password => hiera('stein::glance::password'),
    sql_connection    => $::stein::resources::connectors::glance,
    auth_host         => hiera('stein::controller::address::management'),
    keystone_tenant   => 'services',
    keystone_user     => 'glance',
    verbose           => hiera('stein::verbose'),
    debug             => hiera('stein::debug'),
  }

  class { '::glance::notify::rabbitmq': 
    rabbit_password => hiera('stein::rabbitmq::password'),
    rabbit_userid   => hiera('stein::rabbitmq::user'),
    rabbit_host     => hiera('stein::controller::address::management'),
  }
}
