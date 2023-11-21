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
