# The profile for installing the Swift Proxy
class stein::profile::swift::proxy {

  stein::resources::controller { 'swift': }
  stein::resources::firewall { 'Swift Proxy': port => '8080', }

  class { 'swift::keystone::auth':
    password         => hiera('stein::swift::password'),
    public_address   => hiera('stein::controller::address::api'),
    admin_address    => hiera('stein::controller::address::management'),
    internal_address => hiera('stein::controller::address::management'),
    region           => hiera('stein::region'),
  }

  class { '::swift':
    swift_hash_suffix => hiera('stein::swift::hash_suffix'),
  }

  # sets up the proxy service
  class { '::swift::proxy':
    proxy_local_net_ip => hiera('stein::controller::address::api'),
    pipeline           => ['catch_errors', 'healthcheck', 'cache',
                           'ratelimit',    'swift3',
                           'authtoken',    'keystone',    'proxy-server'],
    workers            => 1,
    require            => Class['::swift::ringbuilder'],
  }

  ### BEGIN Middleware Configuration (declared in pipeline for proxy)
  class { ['::swift::proxy::catch_errors',
           '::swift::proxy::healthcheck', ]: }

  class { '::swift::proxy::cache':
    memcache_servers => [ hiera('stein::controller::address::management'), ]
  }

  class { ['::swift::proxy::ratelimit',
           '::swift::proxy::swift3', ]: }

  class { '::swift::proxy::authtoken':
    admin_password => hiera('stein::swift::password'),
    auth_host      => hiera('stein::controller::address::management'),
  }

  class { '::swift::proxy::keystone': }

  ### END Middleware Configuration

  # collect all of the resources that are needed to balance the ring
  Ring_object_device <<| |>>
  Ring_container_device <<| |>>
  Ring_account_device <<| |>>

  class { 'swift::ringbuilder':
    part_power     => 18,
    replicas       => 3,
    min_part_hours => 1,
    require        => Class['::swift'],
  }

  class { 'swift::ringserver':
    local_net_ip => hiera('stein::controller::address::management'),
  }

}
