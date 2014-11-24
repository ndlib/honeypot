class lib_iipimage( $deploy_to, $remote_image_mount ) {

  $pkglist = [ "iipsrv", "iipsrv-httpd-fcgi" ]
  $remote_image_directory = "${remote_image_mount}/images"
  $local_image_directory = "${deploy_to}/shared/public/images"
  $log_dir = "${deploy_to}/shared/log"

  package { $pkglist:
    ensure => present,
  }

  file { [ $remote_image_directory, $log_dir ]:
    ensure => directory,
    mode => "0775",
    owner => "app",
    group => "app",
    require => Package[$pkglist],
  }

  file { $local_image_directory:
    ensure => link,
    mode => "0775",
    owner => "app",
    group => "app",
    target => $remote_image_directory,
    require => File[$remote_image_directory],
  }

  # the mod_fcgid directory needs to be group writable since the fcgi processes run as the app user
  file { '/var/run/mod_fcgid':
    ensure => directory,
    mode => "0775",
    owner => "apache",
    group => "apache",
    require => File[$local_image_directory, $log_dir],
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
