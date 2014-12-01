abstractit-nrpe
====

####Table of Contents

0. [New stuff and bug fixes](#new)
1. [Overview - What is the nrpe module?](#overview)
2. [Module Description - What does the module do?](#module-description)
3. [Setup - The basics of getting started with nrpe](#setup)
4. [Usage - The parameters available for configuration](#usage)
5. [Implementation - An under-the-hood peek at what the module is doing](#implementation)
6. [Limitations - OS compatibility, etc.](#limitations)
7. [Development - Guide for contributing to the module](#development)
8. [Release Notes - Notes on the most recent updates to the module](#release-notes)

New stuff and bug fixes
-----------------------

Initial move towards using base class as primary API for the module.
Added metadata.json to work with newer versions of puppet

I recently started a consulting company called Abstract IT Pty Ltd. I have transfered ownership of all my puppet modules to a new organisation on Puppet Forge called abstractit.
I am making one final release of my modules under rendhalver and abstractit to give you a chance to switch over to the new organisation.
I have also added a licence. All my modules will be licenced under Apache v2.

Overview
--------

Puppet module for managing nrpe and service checks.

Module Description
------------------

Manages nrpe and the extra service for nrpe.
It also uses my sudo module to setup sudo rules for the commands that need it.

Setup
-----

**what nrpe affects:**

* the nrpe sericve
* installs standard nagios plugin packages
* /etc/nagios/nrpe.cfg
* /etc/nrpe.d/ and services in that directory

### Beginning with nrpe

This will manage a basic setup for nrpe.

    include nrpe

If you are using abstractit-monitoring include this class as well.

    include nrpe::monitoring

Defaults for vars to set if you need them.
These are class params so use hiera or and ENC to set them up easily.
Using nrpe class

    $nrpe::nagios_ips
    # comma separated list of ip addresses that can talk to this nrpe server
    $nrpe::user = 'nrpe'
    # user nrpe runs as
    $nrpe::group = 'nrpe'
    # group nrpe will run as
    $nrpe::command_timeout = 180
    # timeout for nrpe checks
    $nrpe::firewall = false
    # whether to use puppetlabs/firewall to setup the iptables rule

Using nrpe::params class

    $nrpe::params::user = 'nrpe'
    # user nrpe runs as
    $nrpe::params::group = 'nrpe'
    # group nrpe will run as
    $nrpe::params::nagios_ips
    # comma separated list of ip addresses that can talk to this nrpe server
    $nrpe::params::command_timeout = 180
    # timeout for nrpe checks
    $nrpe::params:: firewall = false
    # whether to use puppetlabs/firewall to setup the iptables rule

Usage
-----

    nrpe::plugin { "blah":
      ensure => present, 
      plugin => 'main', 
      check_command => '',
      command_args => '',
      sudo => false,
    }

### nrpe::plugin

This type manages plugins for nrpe.
The name/title of the plugin is the name of the check for `check_nrpe`

**Parameters within nrpe::plugin**

#### `ensure`

Whether the plugin should exist or not (present is the default)

#### `plugin`

where to find the plugin. main is the standard nagios plugin directory
anything else will use the location defined in the variable `nrpe::params::nagios_extra_plugins` which defaults to `nrpe::params::nagios_plugins`

#### `check_command`

the command to run (args for the command go in `command_args`)
This is so I can setup sudo rules for the commands that need it

#### `command_args`

Arguments for the command.

#### `sudo`

Whether to run the command as root with sudo


Implementation
--------------

Uses files based on templates to manage the nrpe commands

Limitations
------------

There may be some. Don't hesitate to let me know if you find any.

Development
-----------

All development, testing and releasing is done by me at this stage.
If you wish to join in let me know.

Release Notes
-------------

**1.2.1**

BUGFIXES: set nrpe::params::nagios_ips to undef so using nrpe class works

**1.2.0**

BUGFIXES: template variables (@rfray)
Added metadata.json so it works with newer versions of puppet
Initial move towards using base class as primary API.

**1.1.3**

Final release for rendhalver-nrpe.
First release as abstractit-nrpe.
Removed dependency on abstractit-monitoring to avoid cyclic dependencies

**1.1.2**

fixing packages for Fedora 19

**1.1.1**

fixing class chaining

**1.1.0**

Updated to use sudo module for managing sudo rules

**1.0.2**

switched back to old way of doing class chaining

**1.0.1**

switching to puppetlabs/firewall
new class chaining scheme
added monitoring for nrpe using my monitoring module
adding fixes to service plays nice on Fedora using systemd


**1.0.0**

Initial release
