class stein::role::storage inherits ::stein::role {
  class { '::stein::profile::firewall': }
  class { '::stein::profile::glance::api': }
  class { '::stein::profile::cinder::volume': }
}
