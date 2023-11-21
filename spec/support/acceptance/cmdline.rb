# frozen_string_literal: true

shared_context 'cmdline.txt test setup' do
  before(:context) do
    shell('mkdir -p /boot')

    create_remote_file('default', '/boot/cmdline.txt', 'console=serial0,115200 console=tty1 root=PARTUUID=4a435670-02 rootfstype=ext4 fsck.repair=yes rootwait quiet splash plymouth.ignore-serial-consoles')
  end

  after(:context) do
    shell('rm -rf /boot/cmdline.txt')
  end
end
