#!/usr/bin/env rspec
require 'spec_helper'
require 'pry'

describe 'nrpe::plugin', :type => :define do
  on_supported_os({
      :hardwaremodels => ['x86_64','i386'],
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
          :domain => 'domain.com',
        })
      end
      case facts[:hardwaremodel]
      when 'x86_64'
        nagios_plugins       = '/usr/lib64/nagios/plugins'
      when 'i386'
        nagios_plugins       = '/usr/lib/nagios/plugins'
      end

      context "when called with base options" do
        let (:title) { 'my_plugin'}
        let (:params) {{ 'check_command' => 'foo'}}
        it 'should create our nrpe::plugin config file as expected' do
          should contain_file("/etc/nrpe.d/my_plugin.cfg").with({
            :ensure  => "present",
            :owner   => 'root',
            :group   => 'root',
            :mode    => '0644',
            :content => "command[check_my_plugin]=#{nagios_plugins}/foo \n",
          }).that_notifies('class[nrpe::service]')
        end
      end#base options

      context "when called with ensure absent" do
        let (:title) { 'my_plugin'}
        let (:params) {{ 'check_command' => 'foo', 'ensure' => 'absent'}}
        it 'should ensure our nrpe::plugin config file is absent' do
          should contain_file("/etc/nrpe.d/my_plugin.cfg").with({
            :ensure  => "absent",
            :owner   => 'root',
            :group   => 'root',
            :mode    => '0644',
          }).that_notifies('class[nrpe::service]')
        end
      end#ensure absent

      context "when called with command_args set" do
        let (:title) { 'my_plugin'}
        let (:params) {{ 'check_command' => 'foo', 'command_args' => '--bar --baz'}}
        it 'should create our nrpe::plugin config file as expected' do
          should contain_file("/etc/nrpe.d/my_plugin.cfg").with({
            :ensure  => "present",
            :owner   => 'root',
            :group   => 'root',
            :mode    => '0644',
            :content => "command[check_my_plugin]=#{nagios_plugins}/foo --bar --baz\n",
          }).that_notifies('class[nrpe::service]')
        end
      end#base options

      context "when called with plugin set to extra" do
        let(:pre_condition){ "class{'nrpe': nagios_extra_plugins => '/opt/foo'}"}
        let (:title) { 'my_plugin'}
        let (:params) {{ 'check_command' => 'foo', 'plugin' => 'extra'}}
        it 'should create our nrpe::plugin config file as expected' do
          should contain_file("/etc/nrpe.d/my_plugin.cfg").with({
            :ensure  => "present",
            :owner   => 'root',
            :group   => 'root',
            :mode    => '0644',
            :content => "command[check_my_plugin]=/opt/foo/foo \n",
          }).that_notifies('class[nrpe::service]')
        end
      end#base options

      context "when called with sudo set to true" do
        let (:title) { 'my_plugin'}
        let (:params) {{ 'check_command' => 'foo', 'sudo' => true}}
        it 'should create our nrpe::plugin config file as expected' do
          should contain_file("/etc/nrpe.d/my_plugin.cfg").with({
            :ensure  => "present",
            :owner   => 'root',
            :group   => 'root',
            :mode    => '0644',
            :content => "command[check_my_plugin]=/usr/bin/sudo #{nagios_plugins}/foo \n",
          }).that_notifies('class[nrpe::service]')
        end
        it 'should create an sudo::rule as expected' do
          should contain_sudo__rule("nrpe_my_plugin").with({
            :ensure   => 'present',
            :who      => 'nrpe',
            :commands => "#{nagios_plugins}/foo",
            :nopass   => true
          })
        end
      end#base options

      context "when called with sudo set to true and plugin set to extra" do
        let(:pre_condition){ "class{'nrpe': nagios_extra_plugins => '/opt/foo'}"}
        let (:title) { 'my_plugin'}
        let (:params) {{ 'check_command' => 'foo', 'plugin' => 'extra', 'sudo' => true}}
        it 'should create our nrpe::plugin config file as expected' do
          should contain_file("/etc/nrpe.d/my_plugin.cfg").with({
            :ensure  => "present",
            :owner   => 'root',
            :group   => 'root',
            :mode    => '0644',
            :content => "command[check_my_plugin]=/usr/bin/sudo /opt/foo/foo \n",
          }).that_notifies('class[nrpe::service]')
        end
        it 'should create an sudo::rule as expected' do
          should contain_sudo__rule("nrpe_my_plugin").with({
            :ensure   => 'present',
            :who      => 'nrpe',
            :commands => "/opt/foo/foo",
            :nopass   => true
          })
        end
      end#base options

    end
  end
end
