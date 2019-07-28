class stein::role::compute inherits ::stein::role {
  class { '::stein::profile::firewall': }
  class { '::stein::profile::neutron::agent': }
  class { '::stein::profile::nova::compute': }
  class { '::stein::profile::ceilometer::agent': }
}
