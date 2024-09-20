# @summary
#   Manages `/boot/config.txt`
#
# @param fragments
#  A hash of pi::config::fragments to be concatenated into
#  `/boot/config.txt`.
#
# @param reboot
#   Whether or not to force a reboot when `/boot/config.txt` changes.
#
class pi::config (
  Hash[String[1], Hash] $fragments = {},
  Boolean $reboot = true,
) {
  include pi::params

  $path = "${pi::params::path}/config.txt"

  concat { $path:
    ensure => present,
    mode   => '0755',  # this is the default, +x seems odd
  }

  $fragments.each | String $name, Hash $conf | {
    pi::config::fragment { $name:
      * => $conf,
    }
  }

  if ($reboot) {
    reboot { $path:
      apply   => finished,
      message => "Rebooting to apply ${path} changes",
      when    => refreshed,
    }
  }
}
