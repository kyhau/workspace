#!/bin/sh

case `uname -s` in
  "SunOS" )   # Define the paths for commands used on Solaris
    AWK=/usr/local/bin/gawk
    DF=/usr/bin/df
    DU=/usr/bin/du
    ECHO=/usr/bin/echo
    FIND=/usr/bin/find
    GETOPT=/bin/getopt
    GREP=/usr/bin/grep
    LN=/usr/bin/ln
    MAIL=/usr/bin/mailx
    RM="/bin/rm -fr"
    SED=/usr/bin/sed;;
  "Linux" )   # Define the paths for commands used on Linux
    AWK=/usr/bin/gawk
    DF=/bin/df
    DU=/usr/bin/du
    ECHO="/bin/echo -e"
    FIND=/usr/bin/find
    GETOPT=/usr/bin/getopt
    GREP=/bin/grep
    LN=/bin/ln
    MAIL=/bin/mail
    RM="/bin/rm -fr"
    SED=/bin/sed;;
  * )
    # Can't define command paths, try using "echo" to export the error message to log file
    echo "`date '+%Y.%m.%d %H:%M'` Unspecified operating system -- ABORT"; exit
esac


# Set global variables
HOME_=$HOME
USER_=$USER
PWD_=$PWD
ARGC_=$#
#TMP=/tmp/tmp_userlist.$$  # Unique filename in /tmp


# Functions start here

# Show usage screen
show_options()
{
  $ECHO "\n======================================================="
  $ECHO "USAGE\n    -[a|h]"
  $ECHO "\nOPTIONS"
  $ECHO "   -a     Clean all, excluding data/"
  $ECHO "   -d     Clean all output data and reports"
  $ECHO "   -h     Show usage screen\n"
}


# Prepare to exit, remove temporarily files before exit.
ready_exit() {
# if [ -f $TMP ]; then $RM $TMP; fi
  exit;
}


# Script entry point is here

# Get and Check options
if [ $# -eq 1 ] && [ "$1" = "-h" ] ; then
  show_options
  ready_exit
fi

i=0
set -- `$GETOPT "adh" "$@"` || { exit 10; }
while [ $i -lt $ARGC_ ] ; do
  case $1 in
    -a)   #$RM $PWD_/data
          $RM $PWD_/users
          $RM $PWD_/reports
          $RM $PWD_/Log
          shift;;
    -d)   $RM $PWD_/reports
          $RM $PWD_/Log
          shift;;
    -h)   # Do nothing when -h is entered with other options
          shift;;
    --)   
          break;;
  esac
  i=`expr $i + 1`
done

$RM $PWD_/tmp.tmp.tmp1
ready_exit
