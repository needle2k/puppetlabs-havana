# The profile to install an OpenStack specific MongoDB server
class stein::profile::mongodb {
  $management_network = hiera('stein::network::management')
  $inferred_address = ip_for_network($management_network)
  $explicit_address = hiera('stein::controller::address::management')

  if $inferred_address != $explicit_address {
    fail("MongoDB setup failed. The inferred location of the database based on the
    stein::network::management hiera value is ${inferred_address}. The
    explicit address from stein::controller::address::management
    is ${explicit_address}. Please correct this difference.")
  }

  class { '::mongodb::server':
    bind_ip => ['127.0.0.1', hiera('stein::controller::address::management')],
  }

  class { '::mongodb::client': }
}
