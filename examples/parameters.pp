class { 'pi::cmdline':
  reboot     => false,  # reboots are problematic for acceptance testing
  parameters => {
    'coherent_pool=1M'     => {},
    'bcm2708_fb.fbwidth=0' => {},
    'bcm2708_fb.fbswap=1'  => {},
  },
}
