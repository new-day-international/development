development
===========

Files, tools and utilities for New Day developers.

This uses Vagrant 1.1 to setup a Ubuntu Linux 12.04 VM using VirtualBox that
will run the reddit code and all of its dependencies.  You will then be able
to edit the code on your VM host and see the changes reflected in the VM.

To get started:

1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads). Version 4.2.16 works.
2. Install [Vagrant](http://downloads.vagrantup.com/).  I used Vagrant 1.2.22.
3. Check this out of github  

        git clone https://github.com/new-day-international/development 

4. In a shell go to the directory you just checked out

        cd ~/development

4. Create VM and install reddit code.  This step will take a few minutes

        vagrant up 

5. Edit your host file to point to the VM.  You want a line like this:

        127.0.0.1	localhost reddit.local
        
6. Access the reddit code running on your VM, by going to `http://reddit.local:8080/`
7. You can edit the code in `development/reddit_home` and after a brief automatic restart the changes will be reflected at the above URL.


To stop the VM, you can use `vagrant halt`.  
To start it again you can use `vagrant up`.  
To rebuild it from scratch use `vagrant destroy` and then `vagrant up`.
