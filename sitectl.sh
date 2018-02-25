#!/bin/bash

#
# Author: Jack Bilemjian jck000@gmail.com
#
# Description:
#    This is an interactive script used to enable/disable apache sites.  It will simply
#    move configuration files to .disabled to disable a site and will remove the 
#    .disabled extension to enable it.
#
# Usage: 
#    sitectl.sh 
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

while true; do

  entirelist=""
  idx=1
  echo -e "\n\n"
  for i in `ls *.{conf,disabled} `; do 
    status=`echo $i| grep 'disabled'`
    newi=`printf "%3u  %s\n" $idx $i`
    if [ -n "$status" ] ; then
      echo -e "${disabled}${newi}${endcolor}"
    else 
      echo -e "${enabled}${newi}${endcolor}"
    fi
    entirelist="$entirelist\n$newi"
    idx=`expr $idx + 1`
  done
  echo -e "$resetcolor\n"
  
  echo -e "  X  Quit
   disableall  Disable All Sites 
   enablealli  Enable All Sites

    Select a number(s) to toggle site status 
"
  read selection
  
  if [ "$selection" = "X" -o "$nums" == "x" ] ; then

    exit

  elif [ "$selection" = "disableall" ] ; then
  
    echo "disableall\n"
  
  elif [ "$selection" = "enableall" ] ; then
  
    echo "enableall\n"
  
  else
    toggleitem=`echo $entirelist| grep " $selection  "`
  
    echo -e "$toggleitem\n"
  
  fi

done
