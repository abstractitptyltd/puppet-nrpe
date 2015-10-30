#!/usr/bin/env rspec
require 'spec_helper'
require 'pry'

describe 'nrpe' do
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
      # it { is_expected.to compile.with_all_deps }
      context 'when fed no parameters' do
        # it { should create_class('nrpe') }
        it 'should include the nrpe::install class' do
          should contain_class('nrpe::install').that_comes_before('Class[Nrpe::Config]')
        end
        it 'should include the nrpe::config class' do
          should contain_class('nrpe::config').that_notifies('Class[Nrpe::Service]')
        end
        it 'should include the nrpe::service class' do
          should contain_class('nrpe::service').that_comes_before('Class[Nrpe::Firewall]')
        end
        it 'should include the nrpe::firewall class' do
          should contain_class('nrpe::firewall')
        end
      end#no params
    end
  end
end
