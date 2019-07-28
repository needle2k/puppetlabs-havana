# Common class for cinder installation
# Private, and should not be used on its own
class stein::common::cinder {
  class { '::cinder':
    sql_connection    => $::stein::resources::connectors::cinder,
    rabbit_host       => hiera('stein::controller::address::management'),
    rabbit_userid     => hiera('stein::rabbitmq::user'),
    rabbit_password   => hiera('stein::rabbitmq::password'),
    debug             => hiera('stein::debug'),
    verbose           => hiera('stein::verbose'),
  }
}
