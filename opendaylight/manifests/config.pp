# == Class opendaylight::config
#
# This class handles ODL config changes.
# It's called from the opendaylight class.
#
class opendaylight::config {
  # Configuration of Karaf features to install
  file { 'org.apache.karaf.features.cfg':
    ensure  => file,
    path    => '/opt/opendaylight/etc/org.apache.karaf.features.cfg',
    # Set user:group owners
    owner   => 'odl',
    group   => 'odl',
    # Use a template to populate the content
    content => template('opendaylight/org.apache.karaf.features.cfg.erb'),
  }

  # Configuration of ODL NB REST port to listen on
  file { 'jetty.xml':
    ensure  => file,
    path    => '/opt/opendaylight/etc/jetty.xml',
    # Set user:group owners
    owner   => 'odl',
    group   => 'odl',
    # Use a template to populate the content
    content => template('opendaylight/jetty.xml.erb'),
  }

  # Enable or disable ODL OVSDB ML2 L3 forwarding
  file { 'custom.properties':
    ensure  => file,
    path    => '/opt/opendaylight/etc/custom.properties',
    # Set user:group owners
    owner   => 'odl',
    group   => 'odl',
    # Use a template to populate the content
    content => template('opendaylight/custom.properties.erb'),
  }
}
