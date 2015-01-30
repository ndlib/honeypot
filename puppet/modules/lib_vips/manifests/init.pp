class lib_vips ( $vips_version = '7.40.11' ) {
  $pkglist = ['gcc-c++', 'glib2-devel', 'libtiff-devel', 'libpng-devel', 'libjpeg-turbo-devel']

  package { $pkglist:
    ensure => present,
  }

  $test_command = "test \$(vips --version 2>&1 | head -n 1 | awk -F '-' '{print \$2}') = '${vips_version}'"
  $vips_dir = $vips_version.match(/^[0-9]+\.[0-9]+/)[0]

  ::lib_vips::netinstall { 'vips':
    url                 => "http://www.vips.ecs.soton.ac.uk/supported/${vips_dir}/vips-${vips_version}.tar.gz",
    destination_dir     => '/var/tmp/vips', # Must Exist
    postextract_command => "sh ./configure; make; make install",
    postextract_refreshonly => false,
    postextract_unless => $test_command,
    require => Package[$pkglist],
  }

  file { '.bashrc':
    name => '/home/app/.bashrc',
    replace => true,
    mode => "0644",
    owner => "app",
    group => "app",
    content => template('lib_vips/.bashrc'),
  }

  file { '.bash_profile':
    name => '/home/app/.bash_profile',
    replace => true,
    mode => "0644",
    owner => "app",
    group => "app",
    content => template('lib_vips/.bash_profile'),
  }

  file { 'vips.conf':
    name => '/etc/ld.so.conf.d/vips.conf',
    replace => true,
    mode => "0644",
    content => template('lib_vips/vips.conf'),
  }

  exec { "reload-ldconfig":
    subscribe => File['vips.conf'],
    command => "/sbin/ldconfig",
    refreshonly => true,
  }

}
