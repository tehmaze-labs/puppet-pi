# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'pi::cmdline class' do
  context 'without any parameters' do
    include_examples 'the example', 'cmdline.pp'

    describe file('/opt/puppetlabs/puppet/share/augeas/lenses/boot_cmdline.aug') do
      it { is_expected.to be_file }
    end
  end

  context 'with parameters =>' do
    include_context 'cmdline.txt test setup'
    include_examples 'the example', 'parameters.pp'

    describe file('/opt/puppetlabs/puppet/share/augeas/lenses/boot_cmdline.aug') do
      it { is_expected.to be_file }
    end

    describe file('/boot/cmdline.txt') do
      it { is_expected.to be_file }

      %w[
        coherent_pool=1M
        bcm2708_fb.fbwidth=0
        bcm2708_fb.fbswap=1
      ].each do |param|
        its(:content) { is_expected.to match param }
      end
    end
  end
end
