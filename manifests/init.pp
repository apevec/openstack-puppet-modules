class collectd(
  $fqdnlookup   = true,
  $interval     = 10,
  $threads      = 5,
  $timeout      = 2,
  $purge        = undef,
  $recurse      = undef,
  $purge_config = false,
  $version      = installed,
) {
  include collectd::params

  $plugin_conf_dir = $collectd::params::plugin_conf_dir

  package { 'collectd':
    ensure   => $version,
    name     => $collectd::params::package,
    provider => $collectd::params::provider,
    before   => File['collectd.conf', 'collectd.d'],
  }

  file { 'collectd.d':
    ensure  => directory,
    name    => $collectd::params::plugin_conf_dir,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    purge   => $purge,
    recurse => $recurse,
  }

  $conf_content = $purge_config ? {
    true    => template('collectd/collectd.conf.erb'),
    default => undef,
  }

  file { 'collectd.conf':
    path    => $collectd::params::config_file,
    content => $conf_content,
    notify  => Service['collectd'],
  }

  if $purge_config != true {
    # former include of conf_d directory
    file_line { 'include_conf_d':
      ensure  => absent,
      line    => "Include \"${collectd::params::plugin_conf_dir}/\"",
      path    => $collectd::params::config_file,
      notify  => Service['collectd'],
    }
    # include (conf_d directory)/*.conf
    file_line { 'include_conf_d_dot_conf':
      ensure  => present,
      line    => "Include \"${collectd::params::plugin_conf_dir}/*.conf\"",
      path    => $collectd::params::config_file,
      notify  => Service['collectd'],
    }
  }

  service { 'collectd':
    ensure    => running,
    name      => $collectd::params::service_name,
    enable    => true,
    require   => Package['collectd'],
  }
}
