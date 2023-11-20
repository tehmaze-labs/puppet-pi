# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'pi::cmdline::parameter define' do
  context 'without any parameters' do
    before(:context) do
      shell('mkdir -p /boot')
      create_remote_file('default', '/boot/cmdline.txt', 'console=serial0,115200 console=tty1 root=PARTUUID=4a435670-02 rootfstype=ext4 fsck.repair=yes rootwait quiet splash plymouth.ignore-serial-consoles')
    end

    include_examples 'the example', 'cmdline.pp'

    describe file('/boot/cmdline.txt') do
      it { is_expected.to be_file }
    end
  end
end
