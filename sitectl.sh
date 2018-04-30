#!/bin/bash

#
# Author: Jack Bilemjian jck000@gmail.com
#
# Description:
#    This is an interactive script used to enable/disable Apache web sites.  It will 
#    simply move site configuration files (site.conf) to site.conf.disabled to disable 
#    a site and will remove the .disabled extension to enable it.
#
# Usage: 
#    sitectl
#

#
# Set up default environment variables
#

. /etc/sitectl.cfg

#
# Help and usage information.
#
usage() {
  echo "

Usage:

  sitectl.sh [OPTIONS]

    --color     - force color (default)
    --nocolor   - force no color

    --h|--help  - Detailed help.

    --usage     - This screen

  "|less
  exit
}

help() {
  echo " 

Help:
    
  sitectl.sh 

    There are 2 parts to this script.  The executable should be placed into /usr/local/bin and the configuration should go into /etc

    sitectl.sh  - This script.
    sitectl.cfg - configuration

  "|less
  exit

}

toggle_state() {

  isdisabled="`echo $1 | grep 'disabled' `"

  if [ -n "$isdisabled" ] ; then
    conf="`echo $1| sed 's/\.disabled//g'`"
    mv $1 $conf
    sitename="`echo $conf| sed 's/\.conf//g'`"
    echo -e "Enabled $sitename\n";
  else
    mv $1 $1.disabled
    sitename="`echo $1| sed 's/\.conf//g'`"
    echo -e "Disabled $sitename\n";
  fi


}

export COLOR='yes'

#
# Process arguments
#

while [ $# -ne 0 ] ; do  ### Loop until no more values on the command line
  case "$1" in           ### Process each argument
    --color)
      COLOR='yes'
    ;;
    --nocolor)
      COLOR='no'
    ;;
    --h|-h|--help)
      usage
    ;;
    --usage)
      usage
    ;;
    *)
      "ERROR $1 is not a valid argument 

"
      error 2 $1
      exit
    ;;
  esac
  shift
done

#
# Load config
#
if [ -z "/etc/sitectl.cfg" ] ; then
  "Config file does not exist.  Create configuration file /etc/sitectl.cfg

"
  help
fi

#
# Run it!
#

# Color settings
if [ "$COLOR" != "yes"  ] ; then
  disabled=""
  enabled=""
  endcolor=""
  resetcolor=""
fi

> $TMPFILE
cd $SITECONF
while true; do
  tput clear
  idx=1
  echo -e "\n\n"
  for i in `ls | egrep '\.(conf|disabled)' `; do 
    status=`echo $i| grep 'disabled'`
    newi=`printf "%3u  %s\n" $idx $i`
    if [ -n "$status" ] ; then
      echo -e "${disabled}${newi}${endcolor}"
    else 
      echo -e "${enabled}${newi}${endcolor}"
    fi
    echo "$newi" >> $TMPFILE

    idx=`expr $idx + 1`
  done
  echo -e "$resetcolor
 enableall   Enable  All Sites
 disableall  Disable All Sites 

  X  Exit

    Select the number of a site to toggle its status 
"
  read selection
  
  if [ "$selection" = "X" -o "$selection" = "x" ] ; then
    rm $TMPFILE
    exit

  elif [ "$selection" = "disableall" ] ; then

    for i in *.conf; do
      toggle_state $i 
    done
  
  elif [ "$selection" = "enableall" ] ; then
  
    for i in *.disabled; do
      toggle_state $i 
    done
  
  else

    toggleitem="` grep \" $selection  \" $TMPFILE | cut -c6- `"
  
     toggle_state $toggleitem 

  fi

done


