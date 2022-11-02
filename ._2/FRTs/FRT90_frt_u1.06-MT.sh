#!/bin/bash
#*\
##=========+====================+================================================+
##RD         frt                | FormR Tools MT Template
##RFILE    +====================+=======+=================+======+===============+
##FD   FRT90_frt-MT.sh          |  11427|  5/04/22 19:36|   197| u1.06-20504-1936
##FD   FRT90_frt-MT.sh          |   9755|  5/04/22 15:19|   188| u1.06-20504-1519
##FD   FRT90_frt-MT.sh          |   9479| 10/02/21 10:35|   136| v1.05-81008-01
##DESC     .--------------------+-------+-----------------+------+---------------+
#            Use the commands in this script to manage FormR Apps in a Windows
#            Workstation or a Ubuntu Server.
#
##LIC      .--------------------+----------------------------------------------+
#            Copyright (c) 2021 8020Data-FormR * Released under
#            MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+-------+-------------------+------+-----------+
#            sayMsg             | {aMsg} {bDebug}: 1)echo  2)echo then quit, 3)??
#            Help               | {aCmd} != "", echo {aCmd} error
#                               |
#                               |
##CHGS     .--------------------+-------+-------------------+------+-----------+
# .(11002.01 10/02/21 RAM 10:35p| Created


##PRGM     +====================+===============================================+
##ID 69.600. Main               |
##SRCE     +====================+===============================================+
#*/
#========================================================================================================== #  ===============================  #

    aVdt="May 1, 2022 4:16a"
    aVer="$( echo $0 | awk '{ sub( /.+_p/, "p" ); sub( /\.sh/, ""); print }' )"                             # "p2.02"

 if [ "${1:0:3}" == "ver" ] || [ "${1:0:2}" == "-v" ]; then                                                 # .(20420.07.1 RAM Added Version)
    echo ""
#   echo "  {JName} {JPT} Version ${aVer}  ($( date "+%b %-d %Y %H:%M" ))"                                  ##.(20429.04.1)
    echo "  {JName} {JPT} Version ${aVer}  (${aVdt})"                                                       # .(20429.04.1 RAM)
    echo ""
    exit
    fi
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

    aFldr=$( echo $0 | awk '{       gsub( /[//\\][^//\\]*$/,  "" ); print }' )                              # .(20416.03.1 RAM Get aVer and lost main2Fns)
    aVer=$(  echo $0 | awk '{ v = gensub( /.+[-_]([ptu][0-9.]+).sh/, "\\1", "g", $0 ); print v }' )         #  just: _p1                   # .(20416.03.2 RAM)
#   echo "aFldr: '${aFldr}', aVer: '${aVer}', aJFns: '${aFldr}/JPT12_Main2Fns_p1.05.sh'"; exit

    aJFns="${aFldr}/JPT12_Main2Fns_${aVer}.sh"; if [ ! -f "${aJFns}" ]; then                                #  require "JPT12-main2Fns.sh" # .(80920.02.1).(20416.03.3 RAM Check if file exists)
    aJFns="${aFldr}/JPT12_Main2Fns_p1.05.sh";   if [ ! -f "${aJFns}" ]; then                                # .(20416.03.4 RAM Check if p1.05 exists)
    echo ""; echo " ** JPT Fns script, '${aJFns}', NOT FOUND"; echo ""; exit; fi; fi

#   echo    "   {JPT}[ 51]  aJFns: '${aJFns}'"; exit
    export aJFns=${aJFns};  source "${aJFns}"                                                                # .(20429.04.1 RAM).(20501.01.1 RAM Exported ${aJFns})
#   sayMsg     "{JPT}[ 53]  aJFns: '${aJFns}' loaded" 2

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

    if [ "${THE_SERVER}"  == "" ]; then THE_SERVER=${SCN_SERVER}; fi
    if [ "${THE_SERVER}"  == "" ]; then THE_SERVER="rm212d-w10p"; fi

    aServer=${THE_SERVER}; if [ "${aServer}" == "" ]; then aServer="${SCN_SERVER}"; fi

    aOS="Linux"; if [ "${aServer:7:1}" == "w" ]; then aOS="Windows"; fi
                 if [ "${aServer:7:1}" == "m" ]; then aOS="macOS";   fi

    aSvr=${aServer:0:6}

#   sayMsg     "{JPT}[ 67]  aServer: '${aServer}', aOS: '${aOS}', bDebug: '${bDebug}'" 2

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

    setOS; bSpace=1;                                                                                        #  A space hasn't been displayed, print one next
    aLstSp="echo "; if [ "${aOSv:0:1}" == "w" ]; then aLstSp=""; fi                                         # .(10706.09.1 RAM Windows returns an extra blank line)

    bDoit=0                                                                                                 # .(20501.01.2 RAM !Important in Sub script)
    bQuiet=0                                                                                                # .(20501.01.3 RAM)
    bDebug=0                                                                                                # .(20501.01.4 RAM)

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       HELP Command
#
#====== =================================================================================================== #

function Help() {

    if [ "${aCmd}" != "Help" ] && [ "help" != "$1" ]; then return; fi
    if [ "$1" != "help" ]; then sayMsg " ** Invalid Command: '$1'" 3 "sp"; aCmd="Help"; fi

#   ------ ---------------  =  -------------------------------------------------------------- ------       #

     echo ""
     echo "  Useful {JPT} Tools  (${aVer})"
     echo "  ------------------------------------------- -----------------------------------"
     echo ""
     echo "    {JPT} {CmdName}                           {Command1}"                                        # .(20416.01.1 RAM Added)
     echo "    {JPT} {CmdName}                           {Command2}"                                        # .(20416.02.1 RAM Added)
     echo ""
     echo "  Notes: Only two lowercase letter are needed for each command, seperated by spaces"
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

        sayMsg sp "GitR1[191]  \$1: '$1', \$2: '$2', \$3: '$3', \$4: '$4', \$5: '$5', \$6: '$6', \$7: '$8'"
        sayMsg    "GitR1[192]  aCmd:  '${aCmd}', aCmd1: '${aCmd1}', aCmd2: '${aCmd2}', aCmd3: '${aCmd3}', aCmd0: '${aCmd0}', bDoit: '$bDoit', bDebug: '$bDebug', bQuiet: '$c' " 1
#       sayMsg    "GitR1[193]  aCmd:  '$aCmd',  aCmd1: '$aCmd1', aCmd2: '$aCmd2', aCmd3: '$aCmd3', aCmd0: '$aCmd0' "

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#       getCmd  "he"           "Help"
#       getCmd  "cmd1"         "{Command1}"                                                                 # .(20416.01.2)
#       getCmd  "cmd2"         "{Command2}"                                                                 # .(20416.02.2)

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

        sayMsg "{JPT}[128]  \$1: '$1', \$2: '$2', \$3: '$3', \$4: '$4', \$5: '$5', \$6: '$6', \$7: '$8'"
        sayMsg "{JPT}[129]  aArg1: '$aArg1', aArg2: '$aArg2', aArg3: '$aArg3', aArg4: '$aArg4', aArg5: '$aArg5', aArg6: '$aArg6', aArg7: '$aArg7', aArg8: '$aArg8', aArg9: '$aArg9'"
        sayMsg "{JPT}[130]  aCmd:  '${aCmd}', aCmd1: '${aCmd1}', aCmd2: '${aCmd2}', aCmd3: '${aCmd3}', aCmd0: '${aCmd0}', bDoit: '${bDoit}', bDebug: '${bDebug}', bQuiet: '${bQuiet}" 1

        Help ${aCmd0}

        sayMsg "{JPT}[134]  aCmd:  '${aCmd}', aArg1: '${aArg1}', aArg2: '${aArg2}', aArg3: '${aArg3}', bGlobal: '${bGlobal}'" 1 # 2

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       {COMMAND1} Functions                                                                                # .(20416.01.3 Beg RAM Added Command)
#
#====== =================================================================================================== #

function subFunction() {                                                                                    # .(20416.01.4 Beg RAM Added)

        sayMsg "{JPT}[146]  subFunction[1]  Begin" 1


     } # eof subFunction
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #
#
#       ${COMMAND1} Commands
#
#====== =================================================================================================== #

        sayMsg "{JPT}[158]  {Command1}"

  if [ "${aCmd}" == "{Command1}" ]; then
        sayMsg "{JPT}[161] "{Command1}" 1

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

        sayMsg "{JPT}[178]  {Command2}" # sp

  if [ "${aCmd}" == "{Command2}" ]; then
        sayMsg "{JPT}[181]  {Command2}" 1

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
