class { 'pi::config':
  reboot => false,  # reboots are problematic for acceptance testing
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
