# frozen_string_literal: true

require 'spec_helper'

describe 'vaultlocker::encrypt' do
  let(:title) { '/dev/sdb' }
  let(:params) do
    {}
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
    end
  end
end
