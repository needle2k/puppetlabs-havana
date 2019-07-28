class stein:role::controller inherits ::stein::role {
  class { '::stein::profile::firewall': }
  class { '::stein::profile::rabbitmq': } ->
  class { '::stein::profile::memcache': } ->
  class { '::stein::profile::mysql': } ->
  class { '::stein::profile::mongodb': } ->
  class { '::stein::profile::keystone': } ->
  class { '::stein::profile::ceilometer::api': } ->
  class { '::stein::profile::glance::auth': } ->
  class { '::stein::profile::cinder::api': } ->
  class { '::stein::profile::swift::proxy': } ->
  class { '::stein::profile::nova::api': } ->
  class { '::stein::profile::neutron::server': } ->
  class { '::stein::profile::heat::api': } ->
  class { '::stein::profile::horizon': }
  class { '::stein::profile::auth_file': }
}
