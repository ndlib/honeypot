class lib_vips ( $vips_version = '7.40.11' ) {
  $pkglist = ['gcc-c++', 'glib2-devel', 'libtiff-devel', 'libpng-devel', 'libjpeg-turbo-devel']

  package { $pkglist:
    ensure => present,
  }

  $test_command = "test \$(vips --version 2>&1 | head -n 1 | awk -F '-' '{print \$2}') = '${vips_version}'"

  ::lib_vips::netinstall { 'vips':
    url                 => "http://www.vips.ecs.soton.ac.uk/supported/current/vips-${vips_version}.tar.gz",
    destination_dir     => '/var/tmp/vips', # Must Exist
    postextract_command => "sh ./configure; make; make install",
    postextract_refreshonly => false,
    postextract_unless => $test_command,
    require => Package[$pkglist],
  }
}
