#!/usr/bin/env rspec
require 'spec_helper'
require 'pry'

describe 'nrpe::service' do
  let(:pre_condition){ 'class{"nrpe::params":}'}
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
          "operatingsystem" => "Debian",
          "operatingsystemrelease" => [
            "7"
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
        it { should create_class('nrpe::service') }

        case facts[:operatingsystem]
        when 'Debian'
          it 'should contain the npre service' do
            should contain_service('nrpe').with({
              :ensure     => 'running',
              :name       => 'nagios-nrpe-server',
              :enable     => true,
              :hasstatus  => false,
              :hasrestart => true
            }).that_requires('class[nrpe::install]')
          end
        when 'Ubuntu'
          it 'should contain the npre service' do
            should contain_service('nrpe').with({
              :ensure     => 'running',
              :name       => 'nagios-nrpe-server',
              :enable     => true,
              :hasstatus  => true,
              :hasrestart => true
            }).that_requires('class[nrpe::install]')
          end
        when 'RedHat'
          it 'should contain the npre service' do
            should contain_service('nrpe').with({
              :ensure     => 'running',
              :name       => 'nrpe',
              :enable     => true,
              :hasstatus  => true,
              :hasrestart => true
            }).that_requires('class[nrpe::install]')
          end
        end#case osfamily

      end#no params
    end
  end
end
