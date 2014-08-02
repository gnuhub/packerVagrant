# Open LDAP on Ubuntu 12.04 using Vagrant

This project enables you to install Open LDAP in a virtual machine running
Ubuntu 12.04, using [Vagrant] and [Puppet].

## Acknowledgements

This project was created using the [jfryman/puppet-openldap] openldap module.

It uses the version "2" Vagrant file format.

## Requirements

* You need to have [Vagrant] 1.1.2 or greater installed.
* The host machine probably needs at least 4GB of RAM (I have only tested 8 GB
  of RAM).
* I have tested this project on a host machine running Ubuntu 12.04, but other
  operating systems should also work, as long as they can run Vagrant.

## Installation

* Check out this project:

        git clone https://github.com/cforcey/vagrant_ubuntu_openldap.git

* Run `vagrant box add precise64` to download and make available Ubuntu 12.04 for your vagrant boxes.
* Run `vagrant up` from the base directory of this project. This should take a
  few minutes.

You should now be able to connect to the ldap server on port 3890 on localhost thanks to Vagrant port mapping: `ldap://localhost:3890/dc=puppetlabs,dc=test`

A test admin user has been added:

'puppetlabs.test':
  basedn   => 'dc=puppetlabs,dc=test',
  rootdn   => 'cn=admin',
  rootpw   => 'test'

There is also a test user:  test/pass

## To Do

* Finish testing the auth_who parameter for blocking anonymous binding.  This sets the ACL in modules/ldap/templates/server/openldap/domain_template.rb to have a users or admin auth line.  Ideally this could be passed into the script for tokenization at the high level.

## Alternate Approaches

* Seemingly simpler puppet but no vagrant: http://fluxcoil.net/doku.php/software/puppet/recipe_setup_openldap
* Vagrant but no Puppet: http://codebrane.com/blog/?p=2798 

[Vagrant]: http://www.vagrantup.com/

[Puppet]: http://puppetlabs.com/

[jfryman/puppet-openldap]: https://github.com/jfryman/puppet-openldap