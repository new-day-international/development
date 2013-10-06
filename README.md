development
===========

Files, tools and utilities for New Day developers.

This uses Vagrant to setup a Ubuntu Linux 12.04 VM in VirtualBox using Chef that
will run the reddit code and all of its dependencies.  You will then be able
to edit the code on your VM host and see the changes reflected in the VM.

This assumes you are running on Mac OS X 10.8.

To get started:

1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads). Version 4.2.18 works.
2. Install [Vagrant](http://downloads.vagrantup.com/).  Version 1.3.4 works.
3. Install required vagrant plugins:
	
    vagrant plugin install vagrant-berkshelf
    vagrant plugin install vagrant-omnibus

4. Check this out of github  

    git clone https://github.com/new-day-international/development 

5. In a shell go to the directory you just checked out

    cd ~/development

6. Check out a copy of the reddit code with your github credentials.  This
will allow you to commit your code after you make changes.

    git clone git@github.com:new-day-international/reddit.git

7. Create VM and install reddit code.  This step will take a few minutes

    vagrant up; vagrant provision

8. Edit your host file to point to the VM.  You want a line like this:

    172.16.42.42	localdev.lightnet.is
        
9. Access the reddit code running on your VM, by going to
`http://localdev.lightnet.is/`

10. You can edit the code in `development/reddit` and after a brief automatic
restart the changes will be reflected at the above URL.


To stop the VM, you can use `vagrant halt`.  
To start it again you can use `vagrant up`.  
To rebuild it from scratch use `vagrant destroy` and then `vagrant up`.

If you need to change something that you want to presist after rebuilding
from scatch you might want to look at the [Chef cookbook that builds the
vm](https://github.com/new-day-international/chef-lightnet)

