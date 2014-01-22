# lightnet Development

Files, tools and utilities for New Day developers.

This uses Vagrant and Chef to setup a Ubuntu Linux 12.04 in a VirtualBox guest that will run the lightnet code and all of its dependencies.  You will then be able to edit the code on your host and see the changes reflected in the guest.

This assumes you are running on Mac OS X 10.9, and have 8GB of RAM.

To get started:

1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads). Version 4.3.6 works.
1. Install [Vagrant](http://downloads.vagrantup.com/).  Version 1.4.1 works.
1. If you already had Vagrant installed, be sure you don't already have a
Vagrant base box called "precise64".  You only need to do this the first time you follow these directions.

        vagrant box remove precise64 virtualbox

1. Install required vagrant plugins:
	
        vagrant plugin install vagrant-omnibus

1. Install vagrant-berkself from source (when version 1.4.0 is release this step can go back to installing with `vagrant plugin install`)

        git clone https://github.com/berkshelf/vagrant-berkshelf.git
	bundle
	bundle exec thor gem:build
	vagrant plugin install --plugin-prerelease --plugin-source https://rubygems.org pkg/vagrant-berkshelf-1.4.0.*.gem

1. If you are a lightnet developer and have access to our AWS account you'll want to checkout some
settings files that will make it easier to get up and running
        
        git clone git@github.com:new-day-international/lightnet-operations

1. In a shell clone this repo

        git clone git@github.com:new-day-international/development
        cd ~/development

1. If you checked out lightnet-operations in the step above do the following commands.
If not you will need to copy `settings.yml.sample` to `settings.yml`.

        ln -s ../lightnet-operations/development-settings.yml settings.yml
     
1. Create VM and install reddit code.  This step will take a few minutes

        vagrant up

    This will create (if needed) a VirtualBox VM, then start it, then run `vagrant provision`.  

1. Edit your host file to point to the VM.  You want a line like this:

    	172.16.42.42	localdev.lightnetb.org
        
1. Access the reddit code running on your VM, by going to
[http://localdev.lightnetb.org/](http://localdev.lightnetb.org/)

1. You can edit the code in `development/reddit` and after a brief automatic
restart the changes will be reflected at the above URL.

## Frequently Used Commands 

#### Stop the VM
    
    vagrant halt
    
#### Start it
    
    vagrant up
    
#### Rebuild it from scratch 
    
    vagrant destroy
    vagrant up

#### Rerun chef scripts 

Might be useful to do if `vagrant up` was interupted and failed.

    vagrant provision

#### Run tests

    vagrant ssh
    cd /vagrant/reddit/r2
    ./run_tests.sh

#### Access the development database

    vagrant ssh
    sudo -u postgres psql reddit

#### Run a python shell with the development enviroment

    vagrant ssh
    cd /vagrant/reddit/r2
    paster shell run.ini

#### List all pending messages in rabbitmq

    vagrant ssh
    sudo rabbitmqctl list_queues -p /reddit

## Persisting changes between vm rebuilds

If you need to change something that you want to presist after rebuilding
from scatch you might want to look at the [Chef cookbook that builds the
vm](https://github.com/new-day-international/chef-lightnet)

## Troubleshooting

* When running the `vagrant up` or `vagrant provision` we've seen the error
"error: could not create 'r2.egg-info': File exists".  We think this is a
problem with VirtualBox's shared folder system.  To fix this we did `vagrant
reload` which stops virtualbox then starts it again, then ran `vagrant
provision`.

## Booting a Development VM on AWS

If you edit your settings.yml file and add your keys for AWS you can spin up a 
EC2 instance.

First you'll need to add a dummy base box, since AWS AMI's take the place of 
VirtualBox's base boxes.

    vagrant box add precise64 https://github.com/mitchellh/vagrant-aws/blob/master/dummy.box?raw=true --provider aws

Now we can start up a VM.
   
    vagrant up --provider aws

