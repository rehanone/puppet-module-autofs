# @summary
#   This class handles the autofs service.
#
# @api private
#
class autofs::service inherits autofs {
  if $autofs::service_manage == true {
    service { 'autofs':
      ensure     => $autofs::service_ensure,
      enable     => $autofs::service_enable,
      name       => $autofs::service_name,
      hasstatus  => $autofs::service_hasstatus,
      hasrestart => $autofs::service_hasrestart,
      restart    => $autofs::service_restart;
    }
  }
}
