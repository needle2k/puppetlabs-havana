# The profile to install an OpenStack specific mysql server
class stein::profile::auth_file {
  class { '::openstack::auth_file':
    admin_tenant    => 'admin',
    admin_password  => hiera('stein::keystone::admin_password'),
    region_name     => hiera('stein::region'),
    controller_node => hiera('stein::controller::address::api'),
  }
}
