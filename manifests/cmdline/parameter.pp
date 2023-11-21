# @summary
#  Manage a single /boot/cmdline.txt kernel parameter
#
# @param parameter
#   The kernel parameter to manage. E.g. 8250.nr_uarts=1
#
#   Note that the management of parameters is not very intelligent.
#   8250.nr_uarts=1 and 8250.nr_uarts=2 would be treated as two different
#   parameters.
#
define pi::cmdline::parameter (
  Optional[String[1]] $parameter = undef,
) {
  include pi::cmdline

  $_real_parameter = $parameter ? {
    undef => $name,
    default => $parameter,
  }

  augeas { $name:
    context => '/files/boot/cmdline.txt/1',
    lens    => 'Boot_Cmdline.lns',
    incl    => '/boot/cmdline.txt',
    changes => [
      "set parameter[. = '${_real_parameter}'] '${_real_parameter}'",
    ],
    require => Augeas::Lens['boot_cmdline'],
  }

  if Class['pi::cmdline']['reboot'] {
    Augeas[$name] ~> Reboot['/boot/cmdline.txt']
  }
}
