class stein::role::swiftstorage (
  $zone = undef,
) inherits ::stein::role  {
  class { '::stein::profile::firewall': }
  class { '::stein::profile::swift::storage': zone => $zone }
}
