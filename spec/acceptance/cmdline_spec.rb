# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'pi::cmdline class' do
  context 'without any parameters' do
    include_examples 'the example', 'cmdline.pp'

    describe file('/opt/puppetlabs/puppet/share/augeas/lenses/boot_cmdline.aug') do
      it { is_expected.to be_file }
    end
  end
end
