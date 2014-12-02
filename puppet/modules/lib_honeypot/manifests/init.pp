class lib_honeypot( $deploy_to, $remote_image_mount ) {
  class { 'lib_iipimage':
    deploy_to => $deploy_to,
    remote_image_mount => $remote_image_mount,
  }
  class { 'lib_vips': }
}
