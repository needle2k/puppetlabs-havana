class stein::profile::ceilometer::agent {
  class { '::stein::common::ceilometer': } ->
  class { '::ceilometer::agent::compute': }
}
