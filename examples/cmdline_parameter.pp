class { 'pi::cmdline':
  reboot => false,  # reboots are problematic for acceptance testing
}

pi::cmdline::parameter { '8250.nr_uarts=0': }
pi::cmdline::parameter { 'coherent_pool=1M': }
pi::cmdline::parameter { 'snd_bcm2835.enable_headphones=0': }
