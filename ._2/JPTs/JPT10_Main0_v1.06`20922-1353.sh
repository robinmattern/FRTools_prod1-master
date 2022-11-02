#!/bin/bash
#*\
##=========+====================+================================================+
##RD         Main0              | JScriptWare Power Tools
##RFILE    +====================+=======+=================+======+===============+
##FD   JPT10_Main0.sh           |   9479|  4/16/22  4:16|   136| v1.05.20417.011
##FD   JPT10_Main0.sh           |  13466|  5/04/22 16:36|   930| p1.06-20504-1636
##FD   JPT10_Main0.sh           |  16480|  5/04/22 19:38|   967| p1.06-20504-1938
##FD   JPT10_Main0.sh           |  16601|  5/15/22 12:59|   968| p1.06-20515-1259
##DESC     .--------------------+-------+-----------------+------+---------------+
#            Use the commands in this script to manage Ubuntu and Windows
#            resources.
#
##LIC      .--------------------+----------------------------------------------+
#            Copyright (c) 2022 JScriptWare.us * Released under
#            MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+-------+-------------------+------+-----------+
#            sayMsg             | ["sp"] {aMsg} ({bDebug}: 1)echo  2)echo then quit, 3) echo with no indent) ["sp"]
#            Help               | {aCmd} != "", echo {aCmd} error
#                               |
#                               |
#                               |
##CHGS     .--------------------+-------+-------------------+------+-----------+
# .(01001.01 10/01/20 RAM 10:00p| Created
# .(10706.09 10/01/20 RAM 10:00p| Windows returns an extra blank line)
# .(20416.03  4/16/22 RAM  3:30p| Get aVer and lost main2Fns
# .(20417.02  4/17/22 RAM  4:00p| Add Make Proj Dirs
# .(20420.07  4/20/22 RAM  6:08p| Add Version command
# .(20429.07  4/29/22 RAM  3:08p| Removed ${CMD_NAME} aka Keys Help
# .(20429.09  4/29/22 RAM  7:30p| Convert aArgsNs to lowercase in getOpt
# .(20429.04  4/29/22 RAM  3:45p| Make Version Date permenant ${aVdt}
# .(20501.01  5/01/22 RAM 11:30a| Enable JPT12_Main2Fns_p1.05.sh in sub-scripts
# .(20429.09  5/01/22 RAM  2:45p| Run Args_toLower once
# .(20504.01  5/04/22 RAM  4:45p| Add Format Script
# .(20922.04  9/22/22 RAM  1:50p| Bump Version of JPT13_reNum_p1.06-1.sh

##PRGM     +====================+===============================================+
##ID 69.600. Main0              |
##SRCE     +====================+===============================================+
#*/
#========================================================================================================== #  ===============================  #

     aVdt="May 1, 2022 4:16a"
     aVer="$( echo $0 | awk '{ sub( /.+_p/, "p" ); sub( /\.sh/, ""); print }' )"                            # "p2.02"

  if [ "${1:0:3}" == "ver" ] || [ "${1:0:2}" == "-v" ]; then                                                # .(20420.07.1 RAM Added Version)
     echo ""
#    echo "  JPTools Version ${aVer}  ($( date "+%b %-d %Y %H:%M" ))"                                       ##.(20429.04.1)
     echo "  JPTools Version ${aVer}  (${aVdt})"                                                            # .(20429.04.1 RAM)
     echo ""
     exit
     fi
#    -- --- ---------------  =  ------------------------------------------------------  #

#    aVer=$(  echo $0 | awk '{ match( $0, /_[ptuv][0-9.]{1,3}/ ); print substr( $0, RSTART+1, RLENGTH) }' ) # .(20410.01.1 RAM Added)

     aFldr=$( echo $0 | awk '{       gsub( /[//\\][^//\\]*$/,  "" ); print }' )                             # .(20416.03.1 RAM Get aVer and lost main2Fns)
#    aJVer=$( echo $0 | awk '{       gsub( /.+[-_]v|\.[^.]+$/, "" ); print }' )                             # _v1.03.80916.2301
     aVer=$(  echo $0 | awk '{ v = gensub( /.+[-_]([ptu][0-9.]+).sh/, "\\1", "g", $0 ); print v }' )        #  just: _p1                   # .(20416.01.1 RAM)

     aJFns="${aFldr}/JPT12_Main2Fns_${aVer}.sh"; if [ ! -f "${aJFns}" ]; then                               #  require "JPT12-main2Fns.sh" # .(80920.02.1).(20416.03.2 RAM Check if file exists)
     aJFns="${aFldr}/JPT12_Main2Fns_p1.06.sh";   if [ ! -f "${aJFns}" ]; then                               # .(20416.03.3 RAM Check if p1.05 exists)
     echo ""; echo " ** JPT10[ 62]  JPT Fns script, '${aJFns}', NOT FOUND"; echo ""; exit; fi; fi

#    echo  "  - JPT10[ 64]  aJFns: '${aJFns}'"; exit
     export aJFns=${aJFns};  source "${aJFns}"                                                              # .(20429.04.1 RAM).(20501.01.1 RAM Exported ${aJFns})
#    sayMsg    "JPT10[ 66]  aJFns: '${aJFns}' loaded" 2

#    -- --- ---------------  =  ------------------------------------------------------  #

     if [ "${THE_SERVER}"  == "" ]; then THE_SERVER=${SCN_SERVER}; fi
     if [ "${THE_SERVER}"  == "" ]; then THE_SERVER="rm212d-w10p"; fi

     aServer=${THE_SERVER}; if [ "${aServer}" == "" ]; then aServer="${SCN_SERVER}"; fi

     aOS="Linux"; if [ "${aServer:7:1}" == "w" ]; then aOS="Windows"; fi
                 if [ "${aServer:7:1}" == "m" ]; then aOS="macOS";     fi

     aSvr=${aServer:0:6}

#    sayMsg    "JPT10[ 80]  aServer: '${aServer}', aOS: '${aOS}', bDebug: '${bDebug}'" 2

#    -- --- ---------------  =  ------------------------------------------------------  #

     setOS; bSpace=1;                                                                                       #  A space hasn't been displayed, print one next
     aLstSp="echo "; if [ "${aOSv:0:1}" == "w" ]; then aLstSp=""; fi                                        # .(10706.09.1 RAM Windows returns an extra blank line)

     bDoit=0                                                                                                # .(20501.01.2 RAM !Important in Sub script)
     bQuiet=0                                                                                               # .(20501.01.3 RAM)
     bDebug=0                                                                                               # .(20501.01.4 RAM)

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       HELP Command
#
#====== =================================================================================================== #  ===========

function Help( ) {

     if [ "${aCmd}" != "Help" ] && [ "help" != "$1" ]; then return; fi
     if [ "$1" != "help" ]; then sayMsg " ** Invalid Command: '$1'" 3 "sp"; aCmd="Help"; fi

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

     echo ""
#    echo "  Useful JScriptWare Power Tools  (${aVer})      $( date '+%m/%d/%Y %H:%M' )"                    ##.(20429.04.2)
     echo "  Useful JScriptWare Power Tools  (${aVer})      (${aVdt})"                                      # .(20429.04.2 RAM)
     echo "  ------------------------------------------- -----------------------------------"
     echo ""
     echo "    JPT Make Project Dirs                     Create project structure "
     echo "    JPT Format Script                         Update sayMsg LineNos and ## FD header "           # .(20504.01.1 RAM Added)
     echo "    {JPT} {Command1}                          {Command1}"                                        # .(20416.01.1 RAM Added)
     echo "    {JPT} {Command1}                          {Command2}"                                        # .(20416.02.1 RAM Added)
     echo ""
     echo "  Notes: Only 2 lowercase letters are needed for each command, seperated by spaces"
     echo "         One or more command options follow. Help for the command is dispayed if no options are given"
     echo "         The options, debug, doit and quietly, can follow anywhere after the command"
     ${aLstSp}                                                                                              # .(10706.09.3)
     exit

     } # eof Help
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#========================================================================================================== #  ===============================  #

     setArgs "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9"

     getOpts "bdqgl"
     setCmds

     sayMsg sp "JPT10[132]  \$1: '$1', \$2: '$2', \$3: '$3', \$4: '$4', \$5: '$5', \$6: '$6', \$7: '$8'"
     sayMsg    "JPT10[133]  aCmd:  '${aCmd}', aCmd1: '${aCmd1}', aCmd2: '${aCmd2}', aCmd3: '${aCmd3}', aCmd0: '${aCmd0}', bDoit: '$bDoit', bDebug: '$bDebug', bQuiet: '$c' " 1
#    sayMsg    "JPT10[134]  aCmd:  '$aCmd',  aCmd1: '$aCmd1', aCmd2: '$aCmd2', aCmd3: '$aCmd3', aCmd0: '$aCmd0' "

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#    Help

#    getCmd  "he"              "Help"
#    getCmd  "cmd1"            "{Command1}"                                                                 # .(20416.01.2)
#    getCmd  "cmd2"            "{Command2}"                                                                 # .(20416.02.2)
     getCmd  "ma" "pr" "di"    "Make Project Dirs"
     getCmd  "fo" "sc"         "Format Script"                                                              # .(20504.01.2

#    sayMsg    "JPT10[146]  aCmd:  '${aCmd}', nLv: -, aARG1:'${mARGs[0]}', aARG2:'${mARGs[1]}', aARG3:'${mARGs[2]}', aARG4:'${mARGs[3]}', aARG5:'${mARGs[4]}', aARG6:'${mARGs[5]}', aARG7:'${mARGs[6]}' " 1

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

     sayMsg    "JPT10[150]  aArg1: '$aArg1', aArg2: '$aArg2', aArg3: '$aArg3', aArg4: '$aArg4', aArg5: '$aArg5', aArg6: '$aArg6', aArg7: '$aArg7', aArg8: '$aArg8', aArg9: '$aArg9'"
     sayMsg    "JPT10[151]  aCmd:  '${aCmd}', aCmd1: '${aCmd1}', aCmd2: '${aCmd2}', aCmd3: '${aCmd3}', aCmd0: '${aCmd0}', bDoit: '${bDoit}', bDebug: '${bDebug}', bQuiet: '${bQuiet}" 1

     Help ${aCmd0}

     sayMsg    "JPT10[155]  aCmd:  '${aCmd}', aArg1: '${aArg1}', aArg2: '${aArg2}', aArg3: '${aArg3}', bGlobal: '${bGlobal}'" 1 # 2
     sayMsg    "JPT10[156]  aCmd:  '${aCmd}', aArg1: '${mARGs[0]}', aArg2: '${mARGs[1]}', aArg3: '${mARGs[2]}', aArg4: '${mARGs[3]}',aArg5: '${mARGs[4]}', bGlobal: '${bGlobal}'" 1 # 2

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       MAKE PROJECT DIRS Command                                                                           # .(20417.02.1 Beg RAM Added Command)
#
#====== =================================================================================================== #

        sayMsg    "JPT10[166]  Make Project Dirs"

     if [ "${aCmd}" == "Make Project Dirs" ]; then

        sayMsg sp "JPT10[170]  ${aCmd} '${aArg1}' '${aArg2}' '${aArg3}' '${aArg4}'" 1
        sayMsg    "JPT10[171]  aArg1: '${aArg1}' '${aArg2}' '${aArg3}' '${aArg4}', bDoit: '${bDoit}', bDebug: '${bDebug}', bQuiet: '${bQuiet}'"

        shift
       "$( dirname $0)/JPT21_Dirs1_p1.01.sh"  "$@"
#      "$( dirname $0)/JPT21_Dirs1_p1.01.sh"  "${aArg1}" "${aArg2}" "${aArg3}" "${aArg4}"

        ${aLstSp}
        exit
     fi # eoc Make Project Dirs                                                                             # .(20417.02.1 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       FORMAT SCRIPT Command                                                                               # .(20504.01.2 Beg RAM Added Command)
#
#====== =================================================================================================== #

        sayMsg    "JPT10[190]  Format Script"

     if [ "${aCmd}" == "Format Script" ]; then

        sayMsg sp "JPT10[194]  ${aCmd} '${mARGs[0]}' '${mARGs[1]}' 'bDoit: '${bDoit}', bDebug: '${bDebug}', bQuiet: '${bQuiet}'" 1
#       sayMsg    "JPT10[195]  aArg1: '${aArg1}' '${aArg2}' '${aArg3}' '${aArg4}', bDoit: '${bDoit}', bDebug: '${bDebug}', bQuiet: '${bQuiet}'"

     if [ "${aArg1}" == "" ]; then
        sayMsg sp "Please enter a script filename to format." 2
        fi

#       shift
#      "$( dirname $0 )/JPT13_reNum_p1.06-1.sh"  "$@"                                                       # .(20922.04.1 RAM New Version)
       "$( dirname $0 )/JPT13_reNum_p1.06-1.sh"  "${mARGs[0]}" "${mARGs[1]}"                                # .(20922.04.2 RAM New Version)

        ${aLstSp}
        exit
     fi # eoc Format Script                                                                                 # .(20504.01.1 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       {COMMAND1} Functions                                                                                # .(20416.01.3 Beg RAM Added Command)
#
#====== ===================================================================================================

function subFunction() {                                                                                    # .(20416.01.4 Beg RAM Added)

        sayMsg "{JPT}[139]  subFunction[1]  Begin" 1


     } # eof subFunction
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

# ------------------------------------------------------------------------------------
#
#       {COMMAND1} Commands
#
#====== =================================================================================================== #

        sayMsg "{JPT}[149]  {Command1}"

  if [ "${aCmd}" == "{Command1}" ]; then
        sayMsg "{JPT}[152] {Command1}" 1

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #


        ${aLstSp}
     fi # eoc {Command1}                                                                                    # .(20416.01.3 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       {COMMAND2} Commands                                                                                 # .(20416.02.3 Beg RAM Added Command)
#
#====== =================================================================================================== #

        sayMsg "{JPT}[169]  {Command2}" # sp

  if [ "${aCmd}" == "{Command2}" ]; then
        sayMsg "{JPT}[172]  {Command2}" 1

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #


        ${aLstSp}                                                                                           # .(10706.09.14)
     fi # eoc {Command2}                                                                                    # .(20416.02.3 End)
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























































































































































































































































































































































































































































































































































































































































































































