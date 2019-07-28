# The profile to set up the endpoints, auth, and database for Glance
class stein::profile::glance::auth {
  stein::resources::controller { 'glance': }
  stein::resources::database { 'glance': }

  class  { '::glance::keystone::auth':
    password         => hiera('stein::glance::password'),
    public_address   => hiera('stein::storage::address::api'),
    admin_address    => hiera('stein::storage::address::management'),
    internal_address => hiera('stein::storage::address::management'),
    region           => hiera('stein::region'),
  }
}
}
