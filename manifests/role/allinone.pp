class stein::role::allinone inherits ::stein::role {
  class { '::stein::profile::firewall': }
  class { '::stein::profile::rabbitmq': }
  class { '::stein::profile::memcache': }
  class { '::stein::profile::mysql': }
  class { '::stein::profile::mongodb': }
  class { '::stein::profile::keystone': } 
  class { '::stein::profile::ceilometer::agent': }
  class { '::stein::profile::ceilometer::api': }
  class { '::stein::profile::glance::api': }
  class { '::stein::profile::glance::auth': }
  class { '::stein::profile::cinder::volume': }
  class { '::stein::profile::cinder::api': }
  class { '::stein::profile::nova::compute': }
  class { '::stein::profile::nova::api': }
  class { '::stein::profile::neutron::router': }
  class { '::stein::profile::neutron::server': }
  class { '::stein::profile::heat::api': }
  class { '::stein::profile::horizon': }
  class { '::stein::profile::auth_file': }

  # class { '::stein::setup::sharednetwork': }
  class { '::stein::setup::cirros': }
}
