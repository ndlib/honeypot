class lib_iipimage( $app_root = '/home/app') {

  $pkglist = [ "iipsrv", "iipsrv-httpd-fcgi" ]
  $image_root = "${app_root}/images"
  $log_dir = "${app_root}/logs"

  package { $pkglist:
    ensure => present,
  }

  file { [ $image_root, $log_dir ]:
    ensure => directory,
    mode => 0775,
    owner => "app",
    group => "app",
    require => Package[$pkglist],
  }

  # the mod_fcgid directory needs to be group writable since the fcgi processes run as the app user
  file { '/var/run/mod_fcgid':
    ensure => directory,
    mode => 0775,
    owner => "apache",
    group => "apache",
    require => File[$image_root, $log_dir],
  }

  file { 'iipsrv.conf':
    name => '/etc/httpd/conf.d/iipsrv.conf',
    replace => true,
    content => template('lib_iipimage/iipsrv.conf.erb'),
    require => File['/var/run/mod_fcgid'],
  }

  exec { "restart-apache":
    subscribe => File['iipsrv.conf'],
    command => "/sbin/service httpd restart",
    refreshonly => true,
  }
    
}
