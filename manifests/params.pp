class pi::params {
  # https://www.raspberrypi.com/documentation/computers/config_txt.html
  # Prior to Raspberry Pi OS Bookworm, Raspberry Pi OS stored the boot partition at /boot/.
  if $::facts['os']['name'] == 'Raspbian' and versioncmp($::facts['os']['release']['major'], '12') >= 0 {
    $path = '/boot/firmware'
  } else {
    $path = '/boot'
  }
}
