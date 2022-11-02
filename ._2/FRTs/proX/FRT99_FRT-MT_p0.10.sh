#!/bin/bash
#*\
##=========+====================+================================================+
##RD         FRTmt              | FormR Tools MT Template
##RFILE    +====================+=======+===============+======+=================+
##FD   FRT99_FRTmt.sh           |   7874|  5/09/22 07:17|   154| p0.10-20509-0717
##FD   FRT99_FRTmt.sh           |  15405|  5/08/22 16:12|   246| p1.06-20508-1612
##FD   FRT99_FRTmt.sh           |  66449|  5/08/22 16:10|  1169| p2.02-20508-1610
##DESC     .--------------------+-------+---------------+------+-----------------+
#            Use the commands in this script to run git commands with helpfull
#            output.
#
##LIC      .--------------------+----------------------------------------------+
#            Copyright (c) 2021 8020Data-FormR * Released under
#            MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+----------------------------------------------+
#            Help()             |
#
##CHGS     .--------------------+----------------------------------------------+
# .(20509.01  5/09/22 RAM  6:50a| Created
#
##PRGM     +====================+===============================================+
##ID 69.600. Main               |
##SRCE     +====================+===============================================+
#*/
#========================================================================================================== #  ===============================  #

        aVdt="May 8, 2022 4:16a"
        aVer="$( echo $0 | awk '{ sub( /.+_p/, "p" ); sub( /\.sh/, ""); print }' )"

     if [ "${1:0:3}" == "ver" ] || [ "${1:0:2}" == "-v" ]; then
        echo ""
#       echo "  FRT Tools MT Template ${aVer}  ($( date "+%b %-d %Y %H:%M" ))"
        echo "  FRT Tools MT Template ${aVer}  (${aVdt})"
        echo ""
        exit
        fi
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

     if [ "${aJFns}" != "" ]; then source ${aJFns};
       else echo " ** Unable to load Script Fns, 'JPT12_Main2Fns_p*.sh'"; exit; fi;     # .(20501.01.2 RAM)

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

        setOS; bSpace=1;                                                                                    #  A space hasn't been displayed, print one next
        aLstSp="echo "; if [ "${aOSv:0:1}" == "w" ]; then aLstSp=""; fi                                     # .(10706.09.1 RAM Windows returns an extra blank line)

#       bDoit=0                                                                                             ##.(20501.01.5 RAM !Important don't reset in Sub script)
#       bQuiet=0                                                                                            ##.(20501.01.6 RAM)
#       bDebug=0                                                                                            ##.(20501.01.7 RAM)

#       sayMsg    "FRTmt[ 92]  aServer: '${aServer}', aOS: '${aOS}', bDebug: '${bDebug}'" 2

# ------------------------------------------------------------------------------------
#
#       HELP
#
#====== =================================================================================================== #  ===========

function Help( ) {

        sayMsg    "FRTmt[102]  aCmd:  '${aCmd}', aCmd0: '$1'" 1

     if [ "${aCmd}" != "Help" ] && [ "help" != "$1" ]; then return; fi
     if [ "$1" != "help" ]; then sayMsg " ** Invalid Command: '$1'" 3 "sp"; aCmd="Help"; fi

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

        echo "  Useful FormR Tools  (${aVer})      (${aVdt})"
        echo "  ------------------------------------------- -----------------------------------"
        echo ""
        echo "  frt tool aaa"
        echo "  frt tool bbb"
        ${aLstSp}
        exit
     } # eof Help
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#========================================================================================================== #  ===============================  #

        setArgs "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9"

        getOpts "bdq"
        setCmds

        sayMsg sp "FRTmt[191]  \$1: '$1', \$2: '$2', \$3: '$3', \$4: '$4', \$5: '$5', \$6: '$6', \$7: '$8'"
        sayMsg    "FRTmt[192]  aCmd:  '${aCmd}', aCmd1: '${aCmd1}', aCmd2: '${aCmd2}', aCmd3: '${aCmd3}', aCmd0: '${aCmd0}', bDoit: '$bDoit', bDebug: '$bDebug', bQuiet: '$c' " 1
#       sayMsg    "FRTmt[193]  aCmd:  '$aCmd',  aCmd1: '$aCmd1', aCmd2: '$aCmd2', aCmd3: '$aCmd3', aCmd0: '$aCmd0' "

# ------------------------------------------------------------------------------------
#
#       Tool Functions
#
#====== =================================================================================================== #  ===========

 function setTool() {                                                                                        # .(20412.02.2 Beg RAM Added)
        echo ""
        echo "  set Tool
        echo ""
#
        }                                                                                                   # .(20412.02.2 End)
#    -- --- ---------------  =  ------------------------------------------------------  #

#====== =================================================================================================== #  ===========

 function runTool() {                                                                                        # .(20412.02.2 Beg RAM Added)
        echo ""
        echo "  set Tool
        echo ""
#
        }                                                                                                   # .(20412.02.2 End)
#    -- --- ---------------  =  ------------------------------------------------------  #

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       Tool Commands
#
#========================================================================================================== #  ===============================  #

        sayMsg "FRTmt[326]  App Commands" 2

        setTool

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       NEXT COMMAND Commands                                                                               # .(20102.01.2 Beg RAM Added Command)
#
#====== =================================================================================================== #

     sayMsg    "Proxy[406]  Next Command" sp;

  if [ "${aCmd}" == "Next Command" ]; then

     sayMsg    "Proxy[410]  Next Command" 1

     ${aLstSp}
     fi # eoc Next Command                                                                                  # .(20102.01.2 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       END
#
#========================================================================================================== #  ===============================  #
#*\
##SRCE     +====================+===============================================+
##RFILE    +====================+=======+===================+======+=============+
#*/
