# frozen_string_literal: true

shared_context 'config.txt test setup' do
  before(:context) do
    shell('mkdir -p /boot')
  end

  after(:context) do
    shell('rm -rf /boot/config.txt')
  end
end
