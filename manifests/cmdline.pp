#
# @summary Manages /boot/cmdline.txt parameters.
#
# @param parameters
#  A hash of pi::cmdline::parameter resources to create.
#
# @param reboot
#   Whether or not to force a reboot when `/boot/cmdline.txt` parameters change.
#
class pi::cmdline (
  Hash[String[1], Hash] $parameters = {},
  Boolean $reboot = true,
) {
  include pi::params

  $path = "${pi::params::path}/cmdline.txt"

  augeas::lens { 'boot_cmdline':
    lens_content => file("${module_name}/boot_cmdline.aug"),
  }

  $parameters.each | String $name, Hash $conf | {
    pi::cmdline::parameter { $name:
      * => $conf,
    }
  }

  if ($reboot) {
    reboot { $path`:
      apply   => finished,
      message => "Rebooting to apply ${path} changes",
      when    => refreshed,
    }
  }
}
