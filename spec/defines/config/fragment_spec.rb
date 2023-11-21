# frozen_string_literal: true

require 'spec_helper'

describe 'pi::config::fragment' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:title) { 'foo' }
      let(:params) { { 'content' => 'foo=bar' } }

      it { is_expected.to compile.with_all_deps }

      it do
        is_expected.to contain_concat__fragment('foo').with(
          target: '/boot/config.txt',
          content: 'foo=bar',
          order: 50
        ).that_notifies('Reboot[/boot/config.txt]')
      end

      context 'with reboot => false' do
        let(:pre_condition) do
          <<-PP
          class { 'pi::config':
            reboot => false,
          }
          PP
        end

        it do
          is_expected.to contain_concat__fragment('foo').with(
            target: '/boot/config.txt',
            content: 'foo=bar',
            order: 50
          )
        end
      end
    end
  end
end
