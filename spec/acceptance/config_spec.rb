# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'pi::config class' do
  context 'without any parameters' do
    include_examples 'the example', 'config.pp'
  end

  context 'with parameters =>' do
    let(:config_txt) do
      <<~CONFIG
        dtparam=i2c_arm=on
        dtparam=spi=on
        enable_uart=1
        init_uart_baud=9600
        dtoverlay=pps-gpio,gpiopin=4
      CONFIG
    end

    include_context 'config.txt test setup'
    include_examples 'the example', 'fragments.pp'

    describe file('/boot/config.txt') do
      it { is_expected.to be_file }
      its(:content) { is_expected.to match config_txt }
    end
  end
end
