#!/bin/bash
#*\
##=========+====================+================================================+
##RD         Main0              | JScriptWare Power Tools
##RFILE    +====================+=======+=================+======+===============+
##FD   JPT10_Main0.sh           |   9479|  4/16/22  4:16|   136| v1.05.20417.011
##FD   JPT10_Main0.sh           |  13466|  5/04/22 16:36|   930| p1.06-20504-1636
##FD   JPT10_Main0.sh           |  16480|  5/04/22 19:38|   967| p1.06-20504-1938
##FD   JPT10_Main0.sh           |  16601|  5/15/22 12:59|   968| p1.06-20515-1259
##FD   JPT10_Main0.sh           |  16909|  9/22/22 13:53|   970| p1.06-20922-1353
##FD   JPT10_Main0.sh           |  19373| 11/03/22 16:12|  1006| p1.06-21103-1612
##FD   JPT10_Main0.sh           |  19070| 11/13/22 19:13|   998| p1.06-21113-1913
##FD   JPT10_Main0.sh           |  18051| 11/17/22 15:40|   294| p1.06-21117.1540
##DESC     .--------------------+-------+-----------------+------+---------------+
#            Use the commands in this script to manage Ubuntu and Windows
#            resources.
#
##LIC      .--------------------+----------------------------------------------+
#            Copyright (c) 2022 JScriptWare.us * Released under
#            MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+-------+-------------------+------+-----------+
#            sayMsg             | ["sp"] {aMsg} ({bDebug}: 1)echo  2)echo then quit, 3) echo with no indent) ["sp"]
#            Help               | List of JPT commands
#            RSS                | Robin's Shell Scripts                                                     # .(21103.03.1)
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
# .(21031.01 10/31/22 RAM  7:45a| Allow version _dm.nn
# .(21103.03 11/03/22 RAM  4:12p| Add RSS commands
# .(21113.05 11/13/22 RAM  5:45p| Display Version and Source in Begin
# .(21117.03 11/17/22 RAM 12:55p| New version of JPT13_reNum_p1.07.sh

##PRGM     +====================+===============================================+
##ID 69.600. Main0              |
##SRCE     +====================+===============================================+
#*/
#========================================================================================================== #  ===============================  #

     aVdt="Nov 17, 2022  3:40p"; aVtitle="JScripWare Power Tools";                                          # .(21113.05.2 RAM Add aVtitle for Version in Begin)
     aVer="$( echo $0 | awk '{  match( $0, /_[dpstuv][0-9]+\.[0-9]+/ ); print substr( $0, RSTART+1, RLENGTH-1) }' )"  # .(21031.01.1 RAM Add [d...).(20416.03.8 "_p2.02", or _d1.09)

     LIB="JPT"; LIB_LOG=${LIB}_LOG; LIB_USER=${LIB}_USER; Lib=${LIB}                                        # .(80923.01.1)

#    aFns="$( dirname "${BASH_SOURCE}"         )/JPT12_Main2Fns_p1.06_v21105.sh";  if [ ! -f "${aFns}" ]; then  ##.(21113.05.3 RAM Use FRT12_Main2Fns_p1.06_v21027.sh)
     aFns="$( dirname "${BASH_SOURCE}"         )/JPT12_Main2Fns_p1.07.sh";         if [ ! -f "${aFns}" ]; then  # .(21113.05.3 RAM Use JPT12_Main2Fns_p1.07.sh)
     echo -e "\n ** JPT10[ 57]  JPT Fns script, '.${aFns#*._2}', NOT FOUND\n"; exit; fi; #fi
     source "${aFns}";

# +------- +------------------ +----------------------------------------------------------- # ------------+ ------------------- # --------------+

     bDoit=0                                                                                                # .(20501.01.2 RAM !Important in Sub script).(20620.05.1 RAM Move to here)
     bQuiet=1                                                                                               # .(20501.01.3 RAM).(20601.02.2 bQuiet by default)
     bDebug=0                                                                                               # .(20501.01.4 RAM)
     bSpace=0;                                                                                              # .(20620.04.8 RAM A space hasn't been displayed, print one next; was 1)

     Begin "$@"                                                                                             # .(21113.05.12)

#    setOS; bSpace=1;                                                                                       #  A space hasn't been displayed, print one next
     setOS;                                                                                                 # .(20620.04.8 RAM A space hasn't been displayed, print one next; was 1)
     aLstSp="echo "; if [ "${aOSv/w}" != "${aOSv}" ]; then aLstSp=""; fi                                        # .(10706.09.1 RAM Windows returns an extra blank line).(21113.06.1 RAM Reverse)

#    -- --- ---------------  =  ------------------------------------------------------  #

#    aOSv=gfw1 | w10p | w08s
#    aOSv=rh62 | rh70 | uv14 | ub16

#    sayMsg    "JPT10[ 78]  aServer: '${aServer}', aOSv: ${aOSv}, aOS: '${aOS}', bDebug: '${bDebug}', aLstSp: '${aLstSp}'" 2
#    sayMsg    "JPT10[ 79]  $\1: '$1', $\2: '$2', $\3: '$3', $\4: '$4', bQuiet: '${bQuiet}', bDebug: '${bDebug}'" 2

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
#    echo "  Useful JScriptWare Power Tools  (${aVer})     $( date '+%m/%d/%Y %H:%M' )"                     ##.(20429.04.2)
     echo "  Useful JScriptWare Power Tools  (${aVer})     (${aVdt})"                                       # .(20429.04.2 RAM)
     echo "  ------------------------------------------- -----------------------------------"
     echo ""
#    echo "    JPT Make Project Dirs                     Create project structure "
     echo "    JPT Format Script                         Update sayMsg LineNos and ## FD header "           # .(20504.01.1 RAM Added)
     echo "    JPT RSS {Command}                         Robin's Shell Script {Command}"                    # .(21103.03.2 RAM Added)
#    echo "    JPT10 {Command1}                          {Command1}"                                        # .(20416.01.1 RAM Added)
#    echo "    JPT10 {Command2}                          {Command2}"                                        # .(20416.02.2 RAM Added)
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

     sayMsg sp "JPT10[123]  \$1: '$1', \$2: '$2', \$3: '$3', \$4: '$4', \$5: '$5', \$6: '$6', \$7: '$8'" -1
#    sayMsg    "JPT10[124]  aCmd:  '${aCmd}', aCmd1: '${aCmd1}', aCmd2: '${aCmd2}', aCmd3: '${aCmd3}', aCmd0: '${aCmd0}', bDoit: '$bDoit', bDebug: '$bDebug', bQuiet: '$c' " 1
     sayMsg    "JPT10[125]  aCmd:  '$aCmd',  aCmd1: '$aCmd1', aCmd2: '$aCmd2', aCmd3: '$aCmd3', aCmd0: '$aCmd0' " -1

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#    Help

#    getCmd  "he"              "Help"
#    getCmd  "cmd1"            "{Command1}"                                                                 # .(20416.01.2)
#    getCmd  "cmd2"            "{Command2}"                                                                 # .(20416.02.2)
     getCmd  "ma" "pr" "di"    "Make Project Dirs"
     getCmd  "fo" "sc"         "Format Script"                                                              # .(20504.01.2
#    getCmd  "rss"             "RSS"   1                                                                    # .(21103.03.3
     getCmd  "rss"     "*"     "RSS"                                                                        # .(21103.03.3

     sayMsg    "JPT10[139]  aCmd:  '${aCmd}', nLv: -, aARG1:'${mARGs[0]}', aARG2:'${mARGs[1]}', aARG3:'${mARGs[2]}', aARG4:'${mARGs[3]}', aARG5:'${mARGs[4]}', aARG6:'${mARGs[5]}', aARG7:'${mARGs[6]}' " -1

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#    sayMsg    "JPT10[143]  aArg1: '$aArg1', aArg2: '$aArg2', aArg3: '$aArg3', aArg4: '$aArg4', aArg5: '$aArg5', aArg6: '$aArg6', aArg7: '$aArg7', aArg8: '$aArg8', aArg9: '$aArg9'"
#    sayMsg    "JPT10[144]  aCmd:  '${aCmd}', aCmd1: '${aCmd1}', aCmd2: '${aCmd2}', aCmd3: '${aCmd3}', aCmd0: '${aCmd0}', bDoit: '${bDoit}', bDebug: '${bDebug}', bQuiet: '${bQuiet}" 1

     Help ${aCmd0}

#    sayMsg    "JPT10[148]  aCmd:  '${aCmd}', aArg1: '${aArg1}', aArg2: '${aArg2}', aArg3: '${aArg3}', bGlobal: '${bGlobal}'" 1 # 2
#    sayMsg    "JPT10[149]  aCmd:  '${aCmd}', aArg1: '${mARGs[0]}', aArg2: '${mARGs[1]}', aArg3: '${mARGs[2]}', aArg4: '${mARGs[3]}',aArg5: '${mARGs[4]}', bGlobal: '${bGlobal}'" 1 # 2

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       MAKE PROJECT DIRS Command                                                                           # .(20417.02.1 Beg RAM Added Command)
#
#====== =================================================================================================== #

        sayMsg    "JPT10[159]  Make Project Dirs"

     if [ "${aCmd}" == "Make Project Dirs" ]; then

        sayMsg sp "JPT10[163]  ${aCmd} '${aArg1}' '${aArg2}' '${aArg3}' '${aArg4}'" 1
        sayMsg    "JPT10[164]  aArg1: '${aArg1}' '${aArg2}' '${aArg3}' '${aArg4}', bDoit: '${bDoit}', bDebug: '${bDebug}', bQuiet: '${bQuiet}'"

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

        sayMsg    "JPT10[183]  Format Script"

     if [ "${aCmd}" == "Format Script" ]; then

        sayMsg sp "JPT10[187]  ${aCmd} '${mARGs[0]}' '${mARGs[1]}' 'bDoit: '${bDoit}', bDebug: '${bDebug}', bQuiet: '${bQuiet}'" 1
#       sayMsg    "JPT10[188]  aArg1: '${aArg1}' '${aArg2}' '${aArg3}' '${aArg4}', bDoit: '${bDoit}', bDebug: '${bDebug}', bQuiet: '${bQuiet}'"

     if [ "${aArg1}" == "" ]; then
        sayMsg sp "Please enter a script filename to format." 2
        fi

#       shift
#      "$( dirname $0 )/JPT13_reNum_p1.06-1.sh"  "$@"                                                       # .(20922.04.1 RAM New Version)
#      "$( dirname $0 )/JPT13_reNum_p1.06-1.sh"  "${mARGs[0]}" "${mARGs[1]}"                                # .(20922.04.2 RAM New Version)
       "$( dirname $0 )/JPT13_reNum_p1.07.sh"    "${mARGs[0]}" "${mARGs[1]}"                                # .(21117.03.1 RAM New Version)

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

        sayMsg "JPT10[214]  subFunction[1]  Begin" 1

     } # eof subFunction
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

# ------------------------------------------------------------------------------------
#
#       RSS Commands                                                                                        # .(21103.03.4 Beg RAM Added RSS)
#
#====== =================================================================================================== #

        sayMsg "JPT10[225]  RSS ${aCmd}"

  if [ "${aCmd}" == "RSS" ]; then
#       sayMsg "JPT10[228]  RSS Not implemented yet" 1

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

        shift
        sayMsg "JPT10[233] \"$( dirname $0 )/RSS/RSS1-Main1.sh\" \"$@\"" 1
        $( dirname $0 )/RSS/RSS01_Main1.sh "$@"

        ${aLstSp}
     fi # eoc RSS                                                                                           # .(21103.03.4 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

# ------------------------------------------------------------------------------------
#
#       {COMMAND1} Commands                                                                                 # .(20416.01.4 Beg RAM Added Command)
#
#====== =================================================================================================== #

        sayMsg "JPT10[246]  {Command1}"

  if [ "${aCmd}" == "{Command1}" ]; then
        sayMsg "JPT10[249] {Command1} Not implemented yet" 2

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

        shift
        sayMsg "JPT10[254] \"$( dirname $0 )/{Command1_Script}\" \"$@\"" 1
#       $( dirname $0 )/{Command1_Script} "$@"

        ${aLstSp}
     fi # eoc {Command1}                                                                                    # .(20416.01.4 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       {COMMAND2} Commands                                                                                 # .(20416.02.5 Beg RAM Added Command)
#
#====== =================================================================================================== #

        sayMsg "JPT10[269]  {Command2}" # sp

  if [ "${aCmd}" == "{Command2}" ]; then
        sayMsg "JPT10[272]  {Command2} Not implemented yet" 2

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

        shift
#       sayMsg "JPT10[277] \"$( dirname $0 )/{Command1_Script}\" \"$@\"" 1
        $( dirname $0 )/{Command2_Script} "$@"

        ${aLstSp}                                                                                           # .(10706.09.14)
     fi # eoc {Command2}                                                                                    # .(20416.02.5 End)
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


