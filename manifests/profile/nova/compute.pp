# The puppet module to set up a Nova Compute node
class stein::profile::nova::compute {
  $management_network = hiera('stein::network::management')
  $management_address = ip_for_network($management_network)

  class { 'stein::common::nova':
    is_compute => true,
  }

  class { '::nova::compute::libvirt':
    libvirt_type     => hiera('stein::nova::libvirt_type'),
    vncserver_listen => $management_address,
  }

  file { '/etc/libvirt/qemu.conf':
    ensure => present,
    source => 'puppet:///modules/stein/qemu.conf',
    mode   => '0644',
    notify => Service['libvirt'],
  }

  Package['libvirt'] -> File['/etc/libvirt/qemu.conf']
}
