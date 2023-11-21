# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'pi::config::fragment define' do
  let(:config_txt) do
    <<~CONFIG
      dtparam=audio=on
      disable_overscan=1
      hdmi_safe=1
      hdmi_mode=1
    CONFIG
  end

  include_context 'config.txt test setup'
  include_examples 'the example', 'config_fragment.pp'

  describe file('/boot/config.txt') do
    it { is_expected.to be_file }
    its(:content) { is_expected.to match config_txt }
  end
end
