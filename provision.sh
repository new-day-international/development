#!/bin/sh

if [ ! -f /vagrant/provisioning-complete ]; then
  echo "Provisioning already done"
  exit 0
fi
        
echo "LC_ALL=en_US.UTF-8" >  /etc/default/locale
locale-gen en_US.UTF-8
dpkg-reconfigure locales
export DEBIAN_FRONTEND=noninteractive
export LC_ALL=en_US.UTF-8

aptitude update
aptitude install joe

/vagrant/install-reddit.sh

touch /vagrant/provisioning-complete