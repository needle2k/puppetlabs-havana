# The profile to install the volume service
class stein::profile::cinder::volume {

  stein::resources::firewall { 'ISCSI API': port => '3260', }

  include ::stein::common::cinder

  class { '::cinder::setup_test_volume': 
    volume_name => 'cinder-volumes',
    size        => hiera('stein::cinder::volume_size')
  } ->

  class { '::cinder::volume':
    package_ensure => true,
    enabled        => true,
  }

  class { '::cinder::volume::iscsi':
    iscsi_ip_address  => hiera('stein::storage::address::management'),
    volume_group      => 'cinder-volumes',
  }
}
