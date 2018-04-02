#!/bin/sh

#
# Author: Jack Bilemjian 
# https://github.com/jck000/sitectl.git
#

clear 

# Copy script to the correct location, create alias and set permissions
if [ ! -e /usr/local/bin/sitectl.sh ] ; then
  cp ./sitectl.sh /usr/local/bin
  ln -s /usr/local/bin/sitectl.sh /usr/local/bin/sitectl
  chmod 755 /usr/local/bin/sitectl.sh
else
  echo -e "Script is already installed\n"
  exists=1
fi

# Copy configuration file to the correct location and set permissions
if [ ! -e /etc/sitectl.cfg ] ; then 
  cp ./sitectl.cfg /etc
  chmod 755 /etc/sitectl.cfg
else
  echo -e "Configuration file exists\n\n"
  exists=1
fi

if [ -n "$exists" ] ; then
  echo -e "Script or configuration file already exists.  Please remove them to reinstall\n\n"
fi

ls -l /usr/local/bin/sitectl* /etc/sitectl.cfg

echo -e "Completed\n\n"
