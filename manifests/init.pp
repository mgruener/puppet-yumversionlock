class yumversionlock (
  $enabled          = 1,
  $follow_obsoletes = 0,
  $locklist         = $yumversionlock::params::locklist,
  $packagename      = $yumversionlock::params::packagename,
  $configfile       = $yumversionlock::params::configfile,
  $locks            = [],
) inherits yumversionlock::params {
  package { $packagename:
    ensure => present,
  }

  file { $configfile:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('yumversionlock/versionlock.conf.erb'),
  }

  file { $locklist:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => inline_template('<%= Array(@locks).join("\n") %>'),
  }
}
