# == Class opendaylight::params
#
# This class manages the default params for the ODL class.
#
class opendaylight::params {
  # NB: If you update the default values here, you'll also need to update:
  #   spec/spec_helper_acceptance.rb's install_odl helper fn
  #   spec/classes/opendaylight_spec.rb tests that use default Karaf features
  # Else, both the Beaker and RSpec tests will fail
  # TODO: Remove this possible source of bugs^^
  $default_features = ['config', 'standard', 'region', 'package', 'kar', 'ssh', 'management']
  $extra_features = []
  $odl_rest_port = '8080'
  $install_method = 'rpm'
  $tarball_url = 'https://nexus.opendaylight.org/content/repositories/autorelease-1079/org/opendaylight/integration/distribution-karaf/0.4.0-Beryllium/distribution-karaf-0.4.0-Beryllium.tar.gz'
  $unitfile_url = 'https://github.com/dfarrell07/opendaylight-systemd/archive/master/opendaylight-unitfile.tar.gz'
  $enable_l3 = 'no'
  $log_levels = {}
}
