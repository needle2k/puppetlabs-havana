# The profile to install an OpenStack specific mysql server
class stein::profile::mysql {

  $management_network = hiera('stein::network::management')
  $inferred_address = ip_for_network($management_network)
  $explicit_address = hiera('stein::controller::address::management')

  if $inferred_address != $explicit_address {
    fail("MySQL setup failed. The inferred location of the database based on the
    stein::network::management hiera value is ${inferred_address}. The
    explicit address from stein::controller::address::management
    is ${explicit_address}. Please correct this difference.")
  }

  class { 'mysql::server':
    config_hash       => {
      'root_password' => hiera('stein::mysql::root_password'),
      'bind_address'  => hiera('stein::controller::address::management'),
    },
  }

  class { 'mysql::server::account_security': }
}
