# sitectl

This is a simple script to manage Apache web sites.  It allows you to quickly enable 
  or disable a web site by simply moving the .conf file to .conf.disable

## Installation

### clone this repository

  git clone https://github.com/jck000/sitectl.git

### install the scripts

  cd sitectl
  sudo ./install.sh

### install location 

* /usr/local/bin/sitectl.sh actual script.  Make sure that /usr/local/bin is in your path or create an alias for sitectl
* /etc/sitectl.cfg configuration file
* /tmp/sitectl.xxxx a tmp file will be created while executing the script.  It will be deleted when the script terminates


### edit configuration file

To set screen color options or change paths for tmp file and location of configuration apache scripts

  vi /etc/sitectl.cfg


*NOTE*:  This script simply moves the file(s), you MUST restart Apache in order for your changes to take effect.

