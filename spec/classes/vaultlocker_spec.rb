# frozen_string_literal: true

require 'spec_helper'

describe 'vaultlocker' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
      it { is_expected.to contain_class('vaultlocker::install') }
      it { is_expected.to contain_class('vaultlocker::config') }

      describe 'vaultlocker::install' do
        it { is_expected.to contain_python__pip('vaultlocker') }
        context 'with Python management disabled' do
          let(:params) {{ manage_python: false }}
          it { is_expected.not_to contain_class('python') }
        end
      end
      describe 'vaultlocker::config' do
        context 'with vaultlocker config set' do
          let(:params) do
            {
              config: {
                'url'     => 'https://vault.internal:8200',
                'backend' => 'secret',
              }
            }
          end
          it do
            is_expected.to contain_file('/etc/vaultlocker/vaultlocker.conf')
              .with_content(/url=https:\/\/vault.internal:8200/)
              .with_content(/backend=secret/)
          end
        end
      end
      context "with block devices to encrypt" do
        let(:params) {{ encrypted_block_devices: ['/dev/sdb','/dev/sdc'] }}
        it { is_expected.to contain_vaultlocker__encrypt('/dev/sdb') }
        it { is_expected.to contain_vaultlocker__encrypt('/dev/sdc') }
      end
    end
  end
end
