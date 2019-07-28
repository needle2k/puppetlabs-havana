# Common class for ceilometer installation
# Private, and should not be used on its own
class stein::common::ceilometer {
  $is_controller = $::stein::profile::base::is_controller

  $controller_management_address = hiera('stein::controller::address::management')

  $mongo_password = hiera('stein::ceilometer::mongo::password')
  $mongo_connection = 
    "mongodb://${controller_management_address}:27017/ceilometer"

  class { '::ceilometer':
    metering_secret => hiera('stein::ceilometer::meteringsecret'),
    debug           => hiera('stein::debug'),
    verbose         => hiera('stein::verbose'),
    rabbit_hosts    => [$controller_management_address],
    rabbit_userid   => hiera('stein::rabbitmq::user'),
    rabbit_password => hiera('stein::rabbitmq::password'),
  }

  class { '::ceilometer::api':
    enabled           => $is_controller,
    keystone_host     => $controller_management_address,
    keystone_password => hiera('stein::ceilometer::password'),
  }

  class { '::ceilometer::db':
    database_connection => $mongo_connection,
  }

  class { '::ceilometer::agent::auth':
    auth_url      => "http://${controller_management_address}:5000/v2.0",
    auth_password => hiera('stein::ceilometer::password'),
    auth_region   => hiera('stein::region'),
  }
}

