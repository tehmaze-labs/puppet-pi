# @summary
#  Create a /boot/config.txt fragment
#
# @param content
#   /boot/config.txt configuration fragment
#
# @param order
#   Order of the fragment within /boot/config.txt
#
define pi::config::fragment (
  Optional[String[1]] $content = undef,
  Integer[1] $order = 50,
) {
  include pi::config

  $_real_content = $content ? {
    undef => "${name}\n",
    default => $content,
  }

  concat::fragment { $name:
    target  => $pi::config::path,
    content => $_real_content,
    order   => $order,
  }

  if Class['pi::config']['reboot'] {
    Concat::Fragment[$name] ~> Reboot[$pi::config::path]
  }
}
