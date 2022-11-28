#!/bin/bash
#*\
##=========+====================+================================================+
##RD         frt command        | FormR Tools MT Template
##RFILE    +====================+=======+=================+======+===============+
##FD   FRT30_Doc0.sh            |  11350| 11/28/22 08:01|   188| p1.01-21128.0801
##FD   FRT99_Template0.sh       |  10134| 11/28/22 13:47|   169| p1.01-21128.1347
##DESC     .--------------------+-------+-----------------+------+---------------+
#            Use the commands in this script to document sample commands
#
##LIC      .--------------------+----------------------------------------------+
#            Copyright (c) 2022 8020Data-FormR * Released under
#            MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+-------+-------------------+------+-----------+
#            sayMsg             | {aMsg} {bDebug}: 1)echo  2)echo then quit, 3)??
#            Help               | {aCmd} != "", echo {aCmd} error
#            Start              |
#                               |
##CHGS     .--------------------+-------+-------------------+------+-----------+
# .(11002.01 10/02/21 RAM 10:35p| Created


##PRGM     +====================+===============================================+
##ID 69.600. Main               |
##SRCE     +====================+===============================================+
#*/
#========================================================================================================== #  ===============================  #

        aVdt="Nov 28, 2022  1:47p"; aVtitle="OS Info Tools"
        aVer="$( echo $0 | awk '{ match( $0, /_[dpstuv][0-9]+\.[0-9]+/ ); print substr( $0, RSTART+1, RLENGTH-1) }' )"  # .(21111.04.1)

        LIB=DOC; LIB_LOG=${DOC}_LOG; LIB_USER=${LIB}_USER

        aFns="$( dirname "${BASH_SOURCE}" )/../JPTs/JPT12_Main2Fns_p1.07.sh";  if [ ! -f "${aFns}" ]; then  # .(21113.05.9 RAM Use JPT12_Main2Fns_p1.07.sh)
        echo -e "\n ** {JPT}[ 35]  JPT Fns script, '.${aFns#*._2}', NOT FOUND\n"; exit; fi; #fi
        source "${aFns}";

#   +===== +================== +=========================================================== # ==========+

        bDoit=0                                                                                             ##.(20501.01.5 RAM !Important don't reset in Sub script)
        bQuiet=1                                                                                            ##.(20501.01.6 RAM).(20601.02.2 bQuiet by default)
        bDebug=0                                                                                            ##.(20501.01.7 RAM)
        bSpace=0;                                                                                           # .(20620.04.8 RAM A space hasn't been displayed, print one next; was 1)

        Begin "$@"                                                                                          # .(21113.05.16)

        setOS; bSpace=1;                                                                                    #  A space hasn't been displayed, print one next
        aLstSp="echo "; if [ "${aOSv/w}" != "${aOSv}" ]; then aLstSp=""; fi                                 # .(10706.09.1 RAM Windows returns an extra blank line).(21113.06.1 RAM Reverse).(21120.02.2)
#       echo "  - {JPT}[ 49]  aOSv: ${aOSv}, ${aOS}, aLstSp: '${aLstSp}'"; ${aLstSp}; # exit

#    -- --- ---------------  =  ------------------------------------------------------  #

#       sayMsg   "{JPT}[ 53]  aServer: '${aServer}', aOS: '${aOS}', bDebug: '${bDebug}'" 2

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       HELP Command
#
#====== =================================================================================================== #

function Help() {

        sayMsg    "{JPT}[ 65]  aCmd:  '${aCmd}', aCmd0: '$1', aCmd1: '${aCmd1}'" -1

     if [ "${aCmd}" == "" ]; then bQuiet=0; sayMsg " ** Invalid gitR Command: '$1'" 3; aCmd="Help";  fi     # .(21117.01.2 RAM Works best)
     if [ "${aCmd}" == "Help" ]; then                                                                       # .(21117.01.3)

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

        echo ""
        echo "  Useful DocR Commands   (${aVer})                                 (${aVdt})"
        echo "  -------------------------------------------------------------- -----------------------------------"
        echo "    {LIB} Command 1                                              Command 1"                   # .(21128.01.1 RAM Beg Add)
        echo "    {LIB} Command 2                                              Command 2"                   # .(21128.01.1 RAM End)
        ${aLstSp}; exit                                                                                     # .(10706.09.3)
        fi
        } # eof Help
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#========================================================================================================== #  ===============================  #

        setArgs "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9"

        getOpts "bdqgl"
        setCmds

        sayMsg sp "{JPT}[ 89]  \$1: '$1', \$2: '$2', \$3: '$3', \$4: '$4', \$5: '$5', \$6: '$6', \$7: '$8'"
        sayMsg    "{JPT}[ 90]  aCmd:  '${aCmd}', aCmd1: '${aCmd1}', aCmd2: '${aCmd2}', aCmd3: '${aCmd3}', aCmd0: '${aCmd0}', bDoit: '$bDoit', bDebug: '$bDebug', bQuiet: '$c' " 1
#       sayMsg    "{JPT}[ 91]  aCmd:  '$aCmd',  aCmd1: '$aCmd1', aCmd2: '$aCmd2', aCmd3: '$aCmd3', aCmd0: '$aCmd0' "

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

        getCmd  "he"           "Help"
        getCmd  "Command1"     "Command1"                                                                  # .(21128.01.2 RAM Beg)
        getCmd  "Command2"     "Command2"                                                                  # .(21128.01.2 RAM End)

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

        sayMsg "{JPT}[101]  \$1: '$1', \$2: '$2', \$3: '$3', \$4: '$4', \$5: '$5', \$6: '$6', \$7: '$8'"
        sayMsg "{JPT}[102]  aArg1: '$aArg1', aArg2: '$aArg2', aArg3: '$aArg3', aArg4: '$aArg4', aArg5: '$aArg5', aArg6: '$aArg6', aArg7: '$aArg7', aArg8: '$aArg8', aArg9: '$aArg9'"
        sayMsg "{JPT}[103]  aCmd:  '${aCmd}', aCmd1: '${aCmd1}', aCmd2: '${aCmd2}', aCmd3: '${aCmd3}', aCmd0: '${aCmd0}', bDoit: '${bDoit}', bDebug: '${bDebug}', bQuiet: '${bQuiet}" 1

        Help ${aCmd0}

        sayMsg "{JPT}[107]  aCmd:  '${aCmd}', aArg1: '${aArg1}', aArg2: '${aArg2}', aArg3: '${aArg3}', bGlobal: '${bGlobal}'" 1 # 2

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       Doc Functions                                                                                       #
#
#====== =================================================================================================== #

function subFunction() {                                                                                    # .(21128.01.3 RAM Beg Add subFunction)

        sayMsg "{JPT}[119]  subFunction[1]  Begin" 1


     } # eof subFunction                                                                                    # .(21128.01.3 RAM End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== # .(21128.01.4 RAM Beg Add Command)
#
#       DOC START Command
#
#====== =================================================================================================== #

        sayMsg "{JPT}[131]  Command1"

  if [ "${aCmd}" == "Command1" ]; then
        sayMsg "{JPT}[134]  Command1" 1

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #


        ${aLstSp}
     fi # eoc Doc Start                                                                                     # .(21128.01.4 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       {COMMAND2} Commands                                                                                 # .(20416.02.3 Beg RAM Added Command)
#
#====== =================================================================================================== #

        sayMsg "{JPT}[151]  Command2" # sp

  if [ "${aCmd}" == "{Command2}" ]; then
        sayMsg "{JPT}[154]  Command2" 1

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #


        ${aLstSp}                                                                                           # .(10706.09.14)
     fi # eoc {Command2}                                                                                    # .(20416.02.3 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

# ------------------------------------------------------------------------------------
#
#       END
#
#========================================================================================================== #  ===============================  #
#*\
##SRCE     +====================+===============================================+
##RFILE    +====================+=======+===================+======+=============+
#*/
