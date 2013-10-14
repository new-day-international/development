development
===========

Files, tools and utilities for New Day developers.

This uses Vagrant to setup a Ubuntu Linux 12.04 VM in VirtualBox using Chef that
will run the reddit code and all of its dependencies.  You will then be able
to edit the code on your VM host and see the changes reflected in the VM.

This assumes you are running on Mac OS X 10.8.

To get started:

1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads). Version 4.2.18 works.
1. Install [Vagrant](http://downloads.vagrantup.com/).  Version 1.3.4 works.
1. If you already had Vagrant installed, be sure you don't already have a
Vagrant base box called "precise64".

        vagrant box remove precise64 virtualbox

1. Install required vagrant plugins:
	
        vagrant plugin install vagrant-berkshelf
        vagrant plugin install vagrant-omnibus

1. Check this out of github  

        git clone git@github.com:new-day-international/development 

1. If you are a lightnet developer and have access to our AWS account you'll want to checkout some
settings files that will make it easier to get up and running
        
        git clone git@github.com:new-day-international/lightnet-operations

1. In a shell go to the directory you just checked out

        cd ~/development

1. If you checked out lightnet-operations in the step above do the following commands.
If not you will need to copy `settings.yml.sample` to `settings.yml`.

        ln -s ../lightnet-operations/development-settings.yml settings.yml
     
1. Check out a copy of the reddit code with your github credentials.  This
will allow you to commit your code after you make changes.

    	git clone git@github.com:new-day-international/reddit.git

If you are rerunning `vagrant provision` laster, you need to make sure your
checkout is up to date or it will fail with this error:
        
        STDERR: Host key verification failed.
        fatal: The remote end hung up unexpectedly

1. Create VM and install reddit code.  This step will take a few minutes

        vagrant up

This will create (if needed) a VirtualBox VM, then start it, then run `vagrant
provision`.  

1. Edit your host file to point to the VM.  You want a line like this:

    	172.16.42.42	localdev.lightnetb.org
        
1. Access the reddit code running on your VM, by going to
`http://localdev.lightnet.is/`

1. You can edit the code in `development/reddit` and after a brief automatic
restart the changes will be reflected at the above URL.

* To stop the VM, you can use `vagrant halt`.  
* To start it again you can use `vagrant up`.  
* To rebuild it from scratch use `vagrant destroy` and then `vagrant up`.
* To run tests

        vagrant ssh
        cd /vagrant/reddit/r2
        ./run_tests.sh

* To access the development database

        vagrant ssh
        sudo -u postgres psql reddit

* To get a python shell with the development enviroment

        vagrant ssh
        cd /vagrant/reddit/r2
        paster shell run.ini

* To list all pending messages in rabbitmq

        sudo rabbitmqctl list_queues -p /reddit

If you need to change something that you want to presist after rebuilding
from scatch you might want to look at the [Chef cookbook that builds the
vm](https://github.com/new-day-international/chef-lightnet)

## Troubleshooting

* When running the `vagrant up` or `vagrant provision` we've seen the error
"error: could not create 'r2.egg-info': File exists".  We think this is a
problem with VirtualBox's shared folder system.  To fix this we did `vagrant
reload` which stops virtualbox then starts it again, then ran `vagrant
provision`.

