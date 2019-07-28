class stein::role::network inherits ::stein::role {
  class { '::stein::profile::firewall': }
  class { '::stein::profile::neutron::router': }
}
