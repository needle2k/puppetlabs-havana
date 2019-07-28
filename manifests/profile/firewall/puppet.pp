class stein::profile::firewall::puppet {
  stein::resources::firewall { 'Puppet': port => '8140' }
  stein::resources::firewall { 'Puppet Orchestration': port => '61613' }
  stein::resources::firewall { 'Puppet Console': port => '443' }
}
