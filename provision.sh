#!/bin/sh

FLAG_FILE=/var/local/provisioning-complete
if [ -f $FLAG_FILE ]; then
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

echo "sleeping for 30 seconds to let the startup scripts to settle down..."
sleep 30

cd /vagrant/reddit_home/reddit/r2
paster run run.ini r2/models/populatedb.py -c 'populate()'
start reddit-job-update_reddits

touch $FLAG_FILE
