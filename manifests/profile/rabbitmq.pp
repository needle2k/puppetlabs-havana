# The profile to install rabbitmq and set the firewall
class stein::profile::rabbitmq {
  class { '::nova::rabbitmq':
    userid             => hiera('stein::rabbitmq::user'),
    password           => hiera('stein::rabbitmq::password'),
    cluster_disk_nodes => hiera('stein::controller::address::management'),
  }
}
