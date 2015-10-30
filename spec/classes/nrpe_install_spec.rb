#!/usr/bin/env rspec
require 'spec_helper'
require 'pry'

describe 'nrpe::install' do
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
        it { should create_class('nrpe::install') }

        case facts[:osfamily]
        when 'Debian'
          it 'should install required packages $plugin_package_list packages' do
            should contain_package('nagios-nrpe-server')
            should contain_package('nagios-nrpe-plugin')
            should contain_package('libnagios-plugin-perl')
            should contain_package('nagios-plugins-extra')
            should contain_package('nagios-plugins-basic')
            should contain_package('nagios-plugins-standard')
            should contain_package('nagios-plugins')
          end
        when 'RedHat'
          it 'should install required packages' do
            should contain_package('nrpe')
            should contain_package('nagios-plugins-nrpe')
            should contain_package('perl-Nagios-Plugin')
            should contain_package('nagios-plugins-all')
          end
        end #case osfamily
      end#no params
    end
  end
end
