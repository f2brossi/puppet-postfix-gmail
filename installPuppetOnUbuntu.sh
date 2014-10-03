#!/bin/bash

#
# Install puppet or update to the lattest stable version
#

logfile=/tmp/install-puppet.log

echo "Download puppetlabs repo config"
wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb 2>$logfile 1>$logfile

echo "Install puppetlabs repo config"
dpkg -i puppetlabs-release-precise.deb 2>$logfile 1>$logfile
echo "Update repositories"
apt-get update 2>$logfile 1>$logfile

echo "Install puppet"
apt-get install -y puppet facter libshadow-ruby1.8 augeas-tools python-pip 2>$logfile 1>$logfile
echo "Puppet version $(puppet --version) installed"

exit 0

