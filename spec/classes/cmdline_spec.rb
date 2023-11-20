# frozen_string_literal: true

require 'spec_helper'

describe 'pi::cmdline' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      # camptocamp/augeas 1.9.0 is using legacy facts
      let(:facts) { override_facts(os_facts, osfamily: os_facts[:os]['family']) }

      it { is_expected.to compile.with_all_deps }
    end
  end
end
