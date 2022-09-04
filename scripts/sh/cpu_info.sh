#!/bin/sh
OSNAME=`uname`

case $OSNAME in
  "Linux" )
    cat /proc/cpuinfo
    ;;
  "SunOS" )
    /usr/platform/`uname -i`/sbin/prtdiag
    ;;
  "Interix" )
    ;;
  * )
    echo "Hello World~ Unknown OS ${OSNAME}!"
esac
