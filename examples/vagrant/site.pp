node 'puppet' {
  include ::ntp
}

node 'control01.localdomain' {
  include ::stein::role::controller
}

node 'control02.localdomain' {
  include ::stein::role::controller
}

node 'control03.localdomain' {
  include ::stein::role::controller
}

node 'storage.localdomain' {
  include ::stein::role::storage
}

node 'network.localdomain' {
  include ::stein::role::network
}

node 'compute01.localdomain' {
  include ::stein::role::compute
}

node 'compute02.localdomain' {
  include ::stein::role::compute
}

node 'swiftstore1.localdomain' {
  class { '::stein::role::swiftstorage':
    zone => '1'
  }
}

node 'swiftstore2.localdomain' {
  class { '::stein::role::swiftstorage':
    zone => '2'
  }
}

node 'swiftstore3.localdomain' {
  class { '::stein::role::swiftstorage':
    zone => '3'
  }
}
