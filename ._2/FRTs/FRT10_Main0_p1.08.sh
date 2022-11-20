#!/bin/bash
#*\
##=========+====================+================================================+
##RD         Main0              | FormR Tools
##RFILE    +====================+=======+===============+======+=================+
##FD   FRT10_Main0.sh           |   9479|  4/29/22 14:48|   136| v1.05.20429.1448
##FD   FRT10_Main0.sh           |  28713|  5/03/22 13:12|   536| p1.06-20503-1312
##FD   FRT10_Main0.sh           |  29813|  5/03/22 14:53|   558| p1.06-20503-1453
##FD   FRT10_Main0.sh           |  32740|  5/04/22 19:24|   967| p1.06-20504-1924
##FD   FRT10_Main0.sh           |  22585|  5/08/22 16:17|   810| p1.06-20508-1617
##FD   FRT10_Main0.sh           |  22845|  5/09/22 07:04|   813| p1.06-20509-0704
##FD   FRT10_Main0.sh           |  23513|  5/15/22 13:04|   825| p1.06-20515-1304
##FD   FRT10_Main0.sh           |  24121|  6/01/22 08:30|   830| u1.07-20601-0830
##FD   FRT10_Main0.sh           |  24278|  6/01/22 11:15|   830| u1.07-20601-1115
##FD   FRT10_Main0.sh           |  24934|  6/01/22 18:29|   838| u1.07-20601-1829
##FD   FRT10_Main0.sh           |  19714|  6/20/22 10:50|   316| u1.08-20620-1050
##FD   FRT10_Main0.sh           |  21741|  6/20/22 21:54|   351| u1.08-20620-2154
##FD   FRT10_Main0.sh           |  22602| 10/27/22 10:59|   358| u1.08-21027-1059
##FD   FRT10_Main0.sh           |  22912| 11/03/22 15:15|   361| p1.08-21103-1515
##FD   FRT10_Main0.sh           |  23981| 11/19/22 19:22|   385| p1.08-21119.1922
##FD   FRT10_Main0.sh           |  24904| 11/20/22 13:55|   392| p1.08-21120.1355
##DESC     .--------------------+-------+---------------+------+-----------------+
#            Use the commands in this script to manage FormR app resources.
#
#
##LIC      .--------------------+----------------------------------------------+
#            Copyright (c) 2022 8020Data-FormR * Released under
#            MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+----------------------------------------------+
#            sayMsg             | ["sp"] {aMsg} ({bDebug}: 1)echo  2)echo then quit, 3) echo with no indent) ["sp"]
#            Help               | {aCmd} != "", echo {aCmd} error
#            appR               |
#            gitR               |
#            keyS               |
#            proX               |
#                               |
##CHGS     .--------------------+----------------------------------------------+
# .(01001.01 10/01/20 RAM 10:00p| Created
# .(10706.09 10/01/20 RAM 10:00p| Windows returns an extra blank line)
# .(20416.03  4/16/22 RAM  3:30p| Get aVer and lost main2Fns
# .(20420.05  4/20/22 RAM  5:15p| Update FRT10_Main0_p1.06.sh changes
# .(20420.07  4/20/22 RAM  6:08p| Add Version command
# .(20429.02  4/29/22 RAM  2:48p| Add Keys command
# .(20429.03  4/29/22 RAM  2:48p| Add Git command
# .(20429.04  4/29/22 RAM  3:45p| Make Version Date permenant ${aVdt}
# .(20429.09  4/29/22 RAM  7:30p| aArgsNs have been converted to lowercase in getOpts
# .(20501.01  5/01/22 RAM 11:30a| Enable JPT12_Main2Fns_p1.05.sh in sub-scripts
# .(20502.06  5/02/22 RAM 12:00p| Major overhaul of JPT12_Main2Fns_p1.06.sh
# .(20508.01  5/08/22 RAM  2:50p| Put App Commands into separate script
# .(20601.01  6/01/22 RAM  8:30a| Add App List Styles and Rename Styles
# .(20601.02  6/01/22 RAM 10:15p| Never sayMsg() if bQuiet = 1
# .(20620.02  6/20/22 RAM 10:45a| Run Proxy in FRT24_Proxy1_u1.06.sh
# .(20620.05  6/20/22 RAM  6:15a| Move setting bDoit=0, bQuiet=0, bDebug=0
# .(20620.04  6/20/22 RAM  5:45p| Reworked sayMsg sp functionality
# .(21027.04 10/27/22 RAM 10:59a| Update gitr with sparse and clone
# .(21031.01 10/31/22 RAM  7:45a| Allow version _d1.09
# .(21107.02 11/07/22 RAM 12:45a| Add RSS Commands
# .(21113.05 11/13/22 RAM  5:30p| Display Version and Source in Begin
# .(21119.01 11/19/22 RAM  7:22p| Capitalize Help Menu
# .(21120.01 11/20/22 RAM  1:55p| Fix aOSv and aLstSp

##PRGM     +====================+===============================================+
##ID 69.600. Main0              |
##SRCE     +====================+===============================================+
#*/
#========================================================================================================== #  ===============================  #

     aVdt="Nov 20, 2022  1:55p"; aVtitle="formR Tools"                                                      # .(21113.05.8 RAM Add aVtitle for Version in Begin)
     aVer="$( echo $0 | awk '{  match( $0, /_[dpstuv][0-9]+\.[0-9]+/ ); print substr( $0, RSTART+1, RLENGTH-1) }' )"  # .(21031.01.1 RAM Add [d...).(20416.03.8 "_p2.02", or _d1.09)

     LIB="FRT"; LIB_LOG=${LIB}_LOG; LIB_USER=${LIB}_USER; Lib=${LIB}                                        # .(80923.01.1)

#    aFns="$( dirname "${BASH_SOURCE}"         )/FRT12_Main2Fns_p1.06_v21027.sh";  if [ ! -f "${aFns}" ]; then  ##.(21113.05.9 RAM Use FRT12_Main2Fns_p1.06_v21027.sh)
     aFns="$( dirname "${BASH_SOURCE}" )/../JPTs/JPT12_Main2Fns_p1.07.sh";         if [ ! -f "${aFns}" ]; then  # .(21113.05.9 RAM Use JPT12_Main2Fns_p1.07.sh)
     echo -e "\n ** FRT10[ 76]  JPT Fns script, '.${aFns#*._2}', NOT FOUND\n"; exit; fi; #fi
     source "${aFns}";

# +------- +------------------ +----------------------------------------------------------- # ------------+ ------------------- # --------------+

     bDoit=0                                                                                                # .(20501.01.2 RAM !Important in Sub script).(20620.05.1 RAM Move to here)
     bQuiet=1                                                                                               # .(20501.01.3 RAM).(20601.02.2 bQuiet by default)
     bDebug=0                                                                                               # .(20501.01.4 RAM)
     bSpace=0;                                                                                              # .(20620.04.8 RAM A space hasn't been displayed, print one next; was 1)

     Begin "$@"                                                                                             # .(21113.05.18)

     setOS;                                                                                                 # .(20620.04.8 RAM A space hasn't been displayed, print one next; was 1)
     aLstSp="echo "; if [ "${aOSv/w}" != "${aOSv}" ]; then aLstSp=""; fi                                    # .(10706.09.1 RAM Windows returns an extra blank line).(21113.06.1 RAM Reverse).(21120.02.1)
#    echo "  - FRT10[ 90]  aOSv: ${aOSv}, ${aOS}, aLstSp: '${aLstSp}'"; ${aLstSp}; # exit

#    -- --- ---------------  =  ------------------------------------------------------  #

#    aOSv=gfw1 | w10p | w08s
#    aOSv=rh62 | rh70 | uv14 | ub16

#    sayMsg    "FRT10[ 97]  aServer: '${aServer}', aOSv: ${aOSv}, aOS: '${aOS}', bDebug: '${bDebug}'" 1
#    sayMsg    "FRT10[ 98]  $\1: '$1', $\2: '$2', $\3: '$3', $\4: '$4', bQuiet: '${bQuiet}', bDebug: '${bDebug}'" 2

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
#    echo "  FormR Tools ${aVer}   ($( date "+%b %-d %Y %H:%M" ))"                      ##.(20429.04.2)
     echo "  Useful FRTools  (${aVer})               (${aVdt})"                         # .(20429.04.2 RAM).(21031.03.1 RAM)
     echo "  ------------------------------------  ---------------------------------"
     echo "     FRT [Help]"                                                             # .(20620.01.1 RAM)
     echo ""                                                                            #
   # echo "     FRT keyS [ Host ] [ Help ]          Manage SSH Key files"
   # echo "         keyS List [ SSH Hosts ]"                                            # .(20429.02.1 Beg RAM Added)
#  # echo "         keyS Make SSH Key  {KeyOwner}  {Host} {HostUser} {Resource}"
#  # echo "         keyS Delete SSH Key {KNo} [Authorized_Keys]"
#  # echo "         keyS Copy SSH Key  {KNo}"
#  # echo "         keyS List SSH Hosts Keys"
#  # echo "         keyS set  SSH Host {KNo}       {Host} {HostUser} {Resource}"
#  # echo "         keyS Test SSH Host {HostAliasName}"                                 # .(20429.02.1 End)
   # echo ""
     echo "     FRT gitR [ help ]                   Manage Git Local and Remote Repos"  # .(20429.03.1 Beg RAM Added)
     echo "         gitR Init"                                                          # .(20429.03.1 End)
     echo "         gitR Clone"                                                         # .(21027.04.1 RAM Added)
     echo "         gitR Pull"                                                          # .(21119.01.1 RAM Added)
     echo ""
   # echo "     FRT proX [ help ]                   Manage Proxy files on server"
   # echo "         proX [ list | restart ]"
   # echo "         proX log"
   # echo "         proX config"
   # echo ""
   # echo "     FRT appR [ help ]                   Manage FormR Apps"
#  # echo "         appR set domain {domain}"                                           # .(20407.03.1 RAM Added)
#  # echo "         appR set homepage {homepage}"                                       # .(20407.01.1 RAM Added).(20410.03.1 RAM)
#  # echo "         appR set port {port}"                                               # .(20407.02.1 RAM Added)
#  # echo "         appR set title {AppTitle}"                                          # .(20409.03.1 RAM Added)
#  # echo "         appR set ssh_host {ssh login alias}"                                # .(20411.03.1 RAM Added)
   # echo "         appR list [ files | styles ]"
#  # echo "         appR list files"                                                    # .(20410.02.1 RAM Added)
#  # echo "         appR list styles"                                                   # .(20601.01.3 RAM Added)
#  # echo "         appR rename styles"                                                 # .(20601.01.4 RAM Added)
#  # echo "         appR save files"                                                    # .(20415.01.1 RAM Added)
#  # echo "         appR save backup"                                                   # .(204xx.xx.x RAM Added)
#  # echo "         appR doc"                                                           # .(20415.02.1 RAM Added)
#  # echo ""
   # echo "         appR [ start | build | deploy ]"
#  # echo "         appR build"
#  # echo "         appR run prod"
#  # echo "         appR deploy"                                                        # .(20411.08.1 RAM Added)
   # echo ""
   # echo "         SSH [ {ssh login alias} ]"                                          # .(20412.02.1 RAM Added)
   # echo ""
     echo "         JPT {Cmd}"                                                          # .(21107.02.1)
     echo "         JPT RSS {Cmd}"                                                      # .(21107.02.2)
     echo "             RSS Rir (RDir)"                                                 # .(21107.02.3)
     echo "             RSS DirList (DirList)"                                          # .(21107.02.4)
     echo ""
     echo "  Notes: Only 3 lowercase letters are needed for each command, separated by spaces"
     echo "         One or more command options follow. Help for the command is dispayed if no options are given"
     echo "         The options, debug, doit and quietly, can follow anywhere after the command"
     ${aLstSp}                                                                                              # .(10706.09.3)
     exit

     } # eof Help
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#========================================================================================================== #  ===============================  #

     setArgs "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9"

     getOpts "bdqgl" 0
     setCmds         0  # dBug: JPFns[262] and in JPFns.getCmd[270, 285]

  if [ "1" == "0" ]; then
     echo   "--- FRT10[183]  $\1: '$1', $\2: '$2', $\3: '$3', $\4: '$4',  bQuiet: '${bQuiet}', bDebug: '${bDebug}'"; echo ""

     echo   "--- FRT10[185]  Hello Robin          -- bSpace: '${bSpace}', bQuiet: '${bQuiet}', bDebug: '${bDebug}'"
     sayMsg     "FRT10[186]  Hello Robin"
     sayMsg     "FRT10[187]  Hello Robin" 1
#    sayMsg     "FRT10[188]  Hello Robin" 2

     echo   "--- FRT10[190]  sp Hello Robin       -- bSpace: '${bSpace}', bQuiet: '${bQuiet}', bDebug: '${bDebug}'"
     sayMsg  sp "FRT10[191]  sp Hello Robin"
     sayMsg  sp "FRT10[192]  sp Hello Robin" 1
#    sayMsg  sp "FRT10[193]  sp Hello Robin" 2

     echo   "--- FRT10[195]  Hello Robin sp       -- bSpace: '${bSpace}', bQuiet: '${bQuiet}', bDebug: '${bDebug}'"
     sayMsg     "FRT10[196]  Hello Robin sp" sp
     sayMsg     "FRT10[197]  Hello Robin sp" sp 1
#    sayMsg     "FRT10[198]  Hello Robin sp" sp 2

     echo   "--- FRT10[200]  sp Hello Robin sp    -- bSpace: '${bSpace}', bQuiet: '${bQuiet}', bDebug: '${bDebug}'"
     sayMsg  sp "FRT10[201]  sp Hello Robin sp" sp
     sayMsg  sp "FRT10[202]  sp Hello Robin sp" sp 1
     sayMsg  sp "FRT10[203]  sp Hello Robin sp" sp 2

     exit
     fi

     sayMsg sp "FRT10[208]  \$1: '$1', \$2: '$2', \$3: '$3', \$4: '$4', \$5: '$5', \$6: '$6', \$7: '$8'";
     sayMsg    "FRT10[209]  aCmd:  '${aCmd}', aCmd1: '${aCmd1}', aCmd2: '${aCmd2}', aCmd3: '${aCmd3}', aCmd0: '${aCmd0}', bDoit: '$bDoit', bDebug: '$bDebug', bQuiet: '$bQuiet' " -1  # .(20601.02.3 RAM Was bQuiet: '$c' ??)
#    sayMsg    "FRT10[210]  aCmd:  '${aCmd}', aCmd1: '${aCmd1}', aCmd2: '${aCmd2}', aCmd3: '${aCmd3}', aCmd0: '${aCmd0}'" -1

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#    Help

#    getCmd    "he"            "Help"
     getCmd1   "proxy"   ""    "proX"                                                                       # .(20620.03.1 RAM).(20620.10.1 RAM was Proxy)(20622.2.5 RAM Beg Use getCmd1)
     getCmd1   "gitr"    ""    "gitR"  # 1                                                                  # .(20620.10.2 RAM was GitR)
     getCmd1   "keys"    ""    "keyS"  1                                                                    # .(20620.10.3 RAM was Keys)
     getCmd1   "appr"    "run" "appR"                                                                       # .(20508.01.1 RAM)(20620.10.4 RAM was App)(20622.2.5 RAM End)
#    getCmd    "run"     "ap"  "appR"                                                                       # .(20508.01.2 RAM)(20620.10.5 RAM was App)
     getCmd1   "jpt"     ""    "JPT"   1                                                                    # .(21107.02.5)
     getCmd1   "rss"     ""    "JPT_RSS"      1                                                             # .(21107.02.6)
     getCmd1   "rdir"    ""    "JPT_RDIR"     1                                                             # .(21107.02.7)
     getCmd1   "dirlist" ""    "JPT_DIRLIST"  1                                                             # .(21107.02.8)
     getCmd1   "dir"     ""    "JPT_RDIR"     1                                                             # .(21119.05.7)

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

     sayMsg    "FRT10[230]  aArg1: '$aArg1', aArg2: '$aArg2', aArg3: '$aArg3', aArg4: '$aArg4', aArg5: '$aArg5', aArg6: '$aArg6', aArg7: '$aArg7', aArg8: '$aArg8', aArg9: '$aArg9'"
     sayMsg sp "FRT10[231]  aCmd:  '${aCmd}', aCmd1: '${aCmd1}', aCmd2: '${aCmd2}', aCmd3: '${aCmd3}', aCmd0: '${aCmd0}', bDoit: '${bDoit}', bDebug: '${bDebug}', bQuiet: '${bQuiet}" -1

     Help ${aCmd0}

     sayMsg    "FRT10[235]  aCmd:  '${aCmd}', aArg1: '${aArg1}', aArg2: '${aArg2}', aArg3: '${aArg3}', bGlobal: '${bGlobal}'" sp -1

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------                      # .(21107.02.9 Beg RAM Added)
#
#       JPT Commands
#
#====== =================================================================================================== #

#      sayMsg "FRT10[245]  JPT Commands (${aArg1:0:3}) aCmd: '${aCmd}', \$@: '$@'" 1

     if [ "${aCmd:0:3}" == "JPT" ]; then

#       sayMsg "FRT10[249]  jpt: '${aArg1}' '${aArg2}' '${aArg3}' '${aArg4}', bDoit: '${bDoit}', bDebug: '${bDebug}', bQuiet: '${bQuiet}'" -1

#       aArgs="$( echo "$@" | tr '[:upper:]' '[:lower:]' )"                                                 #

        if [ "${aCmd}" ==  "JPT" ];         then aSubCmd=""; fi
        if [ "${aCmd}" ==  "JPT_RSS1" ];    then aSubCmd="rss"; fi                                          ##.(21119.05.1 RAM)
        if [ "${aCmd}" ==  "JPT_RSS"  ];    then aSubCmd=""; fi                                             # .(21119.05.1 RAM)
        if [ "${aCmd}" ==  "JPT_RDIR" ];    then aSubCmd="rss rdir"; fi
        if [ "${aCmd}" ==  "JPT_DIRLIST" ]; then aSubCmd="rss dirlist"; fi
        if [ "${aCmd}" ==  "JPT_RSS"  ] && [ "$#" == "1" ]; then aSubCmd="rss"; fi                          # .(21119.05.2)
#       if [ "$@" == "rss"            ];    then aSubCmd="rss"; fi                                          # .(21119.05.2)

        shift;
#       sayMsg     "FRT10[262]  JPT: JPT00_Main0.sh \"$@\"" 2
#       echo   "  - FRT10[263]  JPT: JPT00_Main0.sh   ${aSubCmd} \"$@\""; exit

        "$( dirname $0 )/../JPTs/JPT00_Main0.sh"  ${aSubCmd}  "$@"

        ${aLstSp}
        exit
     fi # eoc JPT Commands
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- # .(21107.02.9 End)

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       GITR Commands
#
#====== =================================================================================================== #

#       sayMsg "FRT10[280]  gitR Commands (${aArg1:0:3}) aCmd: '${aCmd}'" 1                                 # .(20429.03.2 Beg RAM Added)

     if [ "${aCmd}"    ==  "gitR" ]; then

        sayMsg "FRT10[284]  gitR:  '${aArg1}' '${aArg2}' '${aArg3}' '${aArg4}', bDoit: '${bDoit}', bDebug: '${bDebug}', bQuiet: '${bQuiet}'" -1

        shift
# echo "$( dirname $0 )/gitR/FRT22_gitR1_p2.02.sh"  "${aArg1}" "${aArg2}" "${aArg3}" "${aArg4}"
#      "$( dirname $0 )/gitR/FRT22_gitR1_p2.02.sh"  "${aArg1}" "${aArg2}" "${aArg3}" "${aArg4}"
#      "$( dirname $0 )/gitR/FRT22_gitR1_p2.02.sh"  "$@"
# echo "$( dirname $0 )/gitR/FRT22_gitR1_d2.04.sh"  "$@"
       "$( dirname $0 )/gitR/FRT22_gitR1_p2.04.sh"  "$@"                                                   # .(21027.04.2)

        ${aLstSp}
        exit
     fi # eoc gitR Commands
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       KEYS Commands
#
#====== =================================================================================================== #

#       sayMsg "FRT10[306]  keyS Commands (${aArg1:0:3})"                                                   # .(20429.02.2 Beg RAM Added)

     if [ "${aCmd}"     == "keyS" ]; then

        sayMsg "FRT10[310]  keyS: '${aArg1}' '${aArg2}' '${aArg3}' '${aArg4}', bDoit: '${bDoit}', bDebug: '${bDebug}', bQuiet: '${bQuiet}'"

        shift
       "$( dirname $0 )/keyS/FRT21_Keys1_p2.01.sh"  "$@"

        ${aLstSp}
        exit
     fi # eoc keyS Commands                                                                                 # .(20429.02.2 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#========================================================================================================== #  ===============================  #

# ------------------------------------------------------------------------------------
#
#       APP Commands                                                                                        # .(20508.01.2 Beg RAM Put into seperate App script)
#
#====== =================================================================================================== #

#       sayMsg "FRT10[328]  appR Commands (${aArg1:0:3})"                                                    # .(20429.02.2 Beg RAM Added)

     if [ "${aCmd}"     == "appR" ]; then

        sayMsg "FRT10[332]  appR:   '${aArg1}' '${aArg2}' '${aArg3}' '${aArg4}', bDoit: '${bDoit}', bDebug: '${bDebug}', bQuiet: '${bQuiet}'" 1

        shift
# echo "$( dirname $0 )/appR/FRT23_FRApp1_p1.06.sh"  "$@"                                                     ##.(20601.01.5)
#      "$( dirname $0 )/appR/FRT23_FRApp1_p1.06.sh"  "$@"                                                     ##.(20601.01.5)
       "$( dirname $0 )/appR/FRT23_FRApp1_u1.07.sh"  "$@"                                                     # .(20601.01.5 RAM Use u1.xx rather than p1.xx)

        ${aLstSp}
        exit
     fi # eoc appR Commands                                                                                  # .(20429.02.2 End).(20508.01.2 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#========================================================================================================== #  ===============================  #

# ------------------------------------------------------------------------------------
#
#       PROXY Commands
#
#====== =================================================================================================== #

#    if [ "${1:0:3}" == "pro" ]; then                                                                       ##.(20429.02.2)
     if [ "${aCmd}"     == "proX" ]; then                                                                  # .(20429.02.2 RAM Beg Added)

        sayMsg "FRT10[355]  proX: '${aArg1}' '${aArg2}' '${aArg3}' '${aArg4}', bDoit: '${bDoit}', bDebug: '${bDebug}', bQuiet: '${bQuiet}'"

        shift
#      "$( dirname $0 )/proX/FRT24_Proxy_v1.06\`20620-1041.sh"  "$@"
#      "$( dirname $0 )/proX/FRT24_Proxy1_v1.07\`20620-1052.sh"  "$@"
       "$( dirname $0 )/proX/FRT24_Proxy1_u1.07.sh"  "$@"

        ${aLstSp}
        exit
     fi # eoc proX Commands                                                                                # .(20620.02.2 RAM End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       NEXT COMMAND Commands                                                                               # .(20102.01.2 Beg RAM Added Command)
#
#====== =================================================================================================== #

        sayMsg    "FRT10[375]  Next Command" sp;

  if [ "${aCmd}" == "Next Command" ]; then

        sayMsg    "FRT10[379]  Next Command" 1

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
