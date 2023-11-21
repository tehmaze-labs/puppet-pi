# Fruit Pi Management Module

## Overview

Manages features specific to [raspberrypi](https://www.raspberrypi.org/) and
related fruit flavored hardware.

## /boot/cmdline.txt

### puppet

```puppet
class { 'pi::cmdline':
  reboot     => false,  # reboots are problematic for acceptance testing
  parameters => {
    'coherent_pool=1M'     => {},
    'bcm2708_fb.fbwidth=0' => {},
    'bcm2708_fb.fbswap=1'  => {},
  },
}

pi::cmdline::parameter { '8250.nr_uarts=0': }
pi::cmdline::parameter { 'coherent_pool=1M': }
pi::cmdline::parameter { 'snd_bcm2835.enable_headphones=0': }
```

### hiera

```yaml
pi::cmdline::reboot: false
pi::cmdline::parameters:
  coherent_pool=1M: {}
  bcm2708_fb.fbwidth=0: {}
  bcm2708_fb.fbswap=1: {}
  8250.nr_uarts=0: {}
  coherent_pool=1M: {}
  snd_bcm2835.enable_headphones=0: {}
```

## /boot/config.txt

### puppet

```puppet
class { 'pi::config':
  reboot    => false,  # reboots are problematic for acceptance testing
  fragments => {
    'dtoverlay=pps-gpio,gpiopin=4' => {
      'order' => 99,
    },
    'dtparam=i2c_arm=on'           => {
      'order' => 1,
    },
    'dtparam=spi=on'               => {},
    'serial port'                  => {
      # lint:ignore:strict_indent
      'content' => @("CONTENT"),
        enable_uart=1
        init_uart_baud=9600
        | CONTENT
      # lint:endignore
    },
  },
}

pi::config::fragment { 'disable_overscan=1': }
pi::config::fragment { 'dtparam=audio=on':
  order => 1,
}
pi::config::fragment { 'hdmi_mode=1':
  order => 99,
}
pi::config::fragment { 'foo':
  content => "hdmi_safe=1\n",
}
```

### hiera

```yaml
pi::config::reboot: false
pi::config::fragments:
  dtoverlay=pps-gpio,gpiopin=4':
    order: 99
  dtparam=i2c_arm=on:
    order: 1
  dtparam=spi=on: {}
  'serial port':
    content: |
      enable_uart=1
      init_uart_baud=9600
  disable_overscan=1:  {}
  dtparam=audio=on:
    order: 1
  hdmi_mode=1:
    order: 99
  foo:
    content: "hdmi_safe=1\n"
```
