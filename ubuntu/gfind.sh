#!/bin/bash
#
# @author       kyhau
# @description  Simple API for grepping given file type.
# @usage        Create following symbolic links to this file:
#               a) gfind
#               b) gfindn
#               c) jfind
#               d) jfind
#
fileExt="*.[CcHh]"
option=
case `basename $0` in
  "csfind" )
    fileExt="*.cs" ;;

  "csfindi" )
    option="-i"
    fileExt="*.cs" ;;

  "gfind" )
    fileExt="*.[CcHh]" ;;

  "gfindi" )
    option="-i"
    fileExt="*.[CcHh]" ;;

  "jfind" )
    fileExt="*.java" ;;

  "jfindi" )
    option="-i"
    fileExt="*.java" ;;

  "pfind" )
    fileExt="*.py" ;;

  "jfindi" )
    option="-i"
    fileExt="*.py" ;;

  * )
    exit 1;
esac


[ -z "$1" ] || {
  find . -name "${fileExt}" | xargs egrep ${option} "${1}"
}

exit 0
