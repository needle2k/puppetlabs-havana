class stein::profile::firewall {
  class { '::stein::profile::firewall::pre': }
  class { '::stein::profile::firewall::puppet': }
  class { '::stein::profile::firewall::post': }
}
