# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'pi::cmdline::parameter define' do
  context 'without any parameters' do
    include_context 'cmdline.txt test setup'
    include_examples 'the example', 'cmdline_parameter.pp'

    describe file('/boot/cmdline.txt') do
      it { is_expected.to be_file }

      %w[
        8250.nr_uarts=0
        coherent_pool=1M
        snd_bcm2835.enable_headphones=0
      ].each do |param|
        its(:content) { is_expected.to match param }
      end
    end
  end
end
