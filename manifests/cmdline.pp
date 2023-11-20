#
# @summary Manages /boot/cmdline.txt parameters.
#
class pi::cmdline {
  augeas::lens { 'boot_cmdline':
    lens_content => file("${module_name}/boot_cmdline.aug"),
  }
}
