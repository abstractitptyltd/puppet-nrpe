#!/usr/bin/env rspec
require 'spec_helper'
require 'pry'

describe 'nrpe::config' do
  on_supported_os({
      :hardwaremodels => ['x86_64'],
      :supported_os   => [
        {
          "operatingsystem" => "Ubuntu",
          "operatingsystemrelease" => [
            "14.04"
          ]
        },
        {
          "operatingsystem" => "CentOS",
          "operatingsystemrelease" => [
            "7"
          ]
        }
      ],
    }).each do |os, facts|
    context "When on an #{os} system" do
      let(:facts) do
        facts.merge({
          :concat_basedir => '/tmp',
        })
      end
      it { is_expected.to compile.with_all_deps }
      context 'when fed no parameters' do
        it { should create_class('nrpe::config') }

        it 'should contain nrpe config file' do
          should contain_file('/etc/nagios/nrpe.cfg').with({
            :ensure => 'file',
            :owner  => 'nagios',
            :group  => 'nagios',
            :mode   => '0644',
            }).that_notifies('class[nrpe::service]')
        end

        it 'should contain nrpe.d directory' do
          should contain_file('/etc/nrpe.d').with({
            :ensure => 'directory',
            :owner  => 'nagios',
            :group  => 'nagios',
            :mode   => '0755',
            })
        end
      end#no params
    end
  end
end
