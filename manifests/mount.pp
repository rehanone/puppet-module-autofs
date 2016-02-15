#
define autofs::mount(
  $mapfile,
  $map,
  $mount   = $name,
  $ensure  = 'present',
  $options = undef,
) {
  validate_string($mapfile)
  validate_string($map)
  validate_string($mount)
  validate_string($ensure)
  validate_string($options)

  include ::autofs

  if $mapfile == $autofs::master_config {
    fail("You can't add mounts directly to ${autofs::mapfile_config_dir}/${autofs::master_config}!")
  }

  # Allow mount@mapfile as name, if we have the same mountpoints under different share.
  $_mount = regsubst($mount, '^([^@]+)@?.*$', '\1')

  if $ensure == 'present' {
    ensure_resource('autofs::mapfile', $mapfile)

    concat::fragment { "${_mount}@${mapfile}":
      target  => $mapfile,
      content => "${_mount} ${options} ${map}",
      require => Autofs::Mapfile[$mapfile];
    }
  }
}