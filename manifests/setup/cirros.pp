class stein::setup::cirros {
  glance_image { 'cirros':
    ensure           => present,
    name             => 'Cirros',
    is_public        => 'yes',
    container_format => 'bare',
    disk_format      => 'qcow2',
    source           => 'http://download.cirros-cloud.net/0.4.0/cirros-0.4.0-x86_64-disk.img',
  }
}
