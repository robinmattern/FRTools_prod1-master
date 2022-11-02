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
##FD   FRT10_Main0.sh           |  22809| 10/31/22 19:46|   361| d1.09-21031-1946

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

##PRGM     +====================+===============================================+
##ID 69.600. Main               |
##SRCE     +====================+===============================================+
#*/
#========================================================================================================== #  ===============================  #

     aVdt="Oct 27 2022 11:00"                                                                               # .(20601.01.1 RAM)

#    aVer="$( echo $0 | awk '{    sub( /.+_u/,           "u"    ); sub( /\.sh/, ""); print }' )"            # "p2.02"
#    aVer="$( echo $0 | awk '{    sub( /.+_([pstuv])/,   "v"    ); sub( /\.sh/, ""); print }' )"            # "p2.02"
#    aVer="$( echo $0 | awk '{ gensub( /.+_([pstuv]).+/, "&", 1 ); sub( /\.sh/, ""); print }' )"            # "p2.02"
     aVer="$( echo $0 | awk '{  match( $0, /_[dpstuv][0-9]+\.[0-9]+/ ); print substr( $0, RSTART+1, RLENGTH-1) }' )"  # "_p2.02", or _d1.09     # .(21031.01.1 RAM Add [d...)

  if [ "${1:0:3}" == "ver" ] || [ "${1:0:2}" == "-v" ]; then                                                # .(20420.07.1 RAM Added Version)
     echo ""
#    echo "  FRTools Version ${aVer}   ($( date "+%b %-d %Y %H:%M" ))"                                      ##.(20429.04.1)
     echo "  FRTools Version ${aVer}   (${aVdt})"                                                           # .(20429.04.1 RAM)
     if [ "${1:0:3}" == "-vv" ]; then echo "  $0"; fi                                                       # .(20620.01.1 RAM)
     echo ""
     exit
     fi
#    -- --- ---------------  =  ------------------------------------------------------  #

#    aVer=$(  echo $0 | awk '{ match( $0, /_[dptuv][0-9.]{1,3}/ ); print substr( $0, RSTART+1, RLENGTH) }' ) # .(20410.01.1 RAM Added)

     aFldr=$( echo $0 | awk '{       gsub( /[//\\][^//\\]*$/,  "" ); print }' )                             # .(20416.03.1 RAM Get aVer and lost main2Fns)
#    aJVer=$( echo $0 | awk '{       gsub( /.+[-_]v|\.[^.]+$/, "" ); print }' )                             # _v1.03.80916.2301
     aVer=$(  echo $0 | awk '{ v = gensub( /.+[-_]([dptu][0-9.]+).sh/, "\\1", "g", $0 ); print v }' )       #  just: _p1  or _d1.09             # .(20416.01.1 RAM).(21031.01.2)
#    echo "aFldr: '${aFldr}', aVer: '${aVer}', aJFns: '${aFldr}/JPT12_Main2Fns_p1.05.sh'"; exit

     aJFns="${aFldr}/JPT12_Main2Fns_${aVer}.sh"; if [ ! -f "${aJFns}" ]; then                               #  require "JPT12-main2Fns.sh" # .(80920.02.1).(20416.03.2 RAM Check if file exists)
#    aJFns="${aFldr}/JPT12_Main2Fns_p1.05.sh";   if [ ! -f "${aJFns}" ]; then                               # .(20416.03.3 RAM Check if p1.05 exists)
     aJFns="${aFldr}/JPT12_Main2Fns_u1.06.sh";   if [ ! -f "${aJFns}" ]; then                               # .(20601.01.2 RAM Check if u1.06 exists)

     echo "";
     echo  " ** FRT10[ 90]  JPT Fns script, '${aJFns}', NOT FOUND"; echo ""; exit; fi; fi

     bDoit=0                                                                                                # .(20501.01.2 RAM !Important in Sub script).(20620.05.1 RAM Move to here)
     bQuiet=0                                                                                               # .(20501.01.3 RAM).(20601.02.2 bQuiet by default)
     bDebug=0                                                                                               # .(20501.01.4 RAM)
     bSpace=0;                                                                                              # .(20620.04.8 RAM A space hasn't been displayed, print one next; was 1)

#    echo  "  - FRT10[ 97]  aJFns: '${aJFns}'"; exit
     export aJFns=${aJFns}; source "${aJFns}"                                                               # .(20429.04.1 RAM).(20501.01.1 RAM Exported ${aJFns})

#    sayMsg    "FRT10[100]  aJFns: '${aJFns}' loaded" 1

#    -- --- ---------------  =  ------------------------------------------------------  #

     setOS;                                                                                                 # .(20620.04.8 RAM A space hasn't been displayed, print one next; was 1)
     aLstSp="echo "; if [ "${aOSv:0:1}" == "w" ]; then aLstSp=""; fi                                        # .(10706.09.1 RAM Windows returns an extra blank line)

#    sayMsg    "FRT10[107]  aServer: '${aServer}', aOS: '${aOS}', bDebug: '${bDebug}'" 1
#    sayMsg    "FRT10[108]  $\1: '$1', $\2: '$2', $\3: '$3', $\4: '$4', bQuiet: '${bQuiet}', bDebug: '${bDebug}'" 2

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       HELP Command
#
#====== =================================================================================================== #  ===========

function Help() {

     if [ "${aCmd}" != "Help" ] && [ "help" != "$1" ]; then return; fi
     if [ "$1" != "help" ]; then sayMsg " ** Invalid Command: '$1'" 3 "sp"; aCmd="Help"; fi

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

     echo ""
#    echo "  FormR Tools ${aVer}   ($( date "+%b %-d %Y %H:%M" ))"                      ##.(20429.04.2)
     echo "  formR Tools ${aVer}                     (${aVdt})"                         # .(20429.04.2 RAM).(21031.03.1 RAM)
     echo "  ------------------------------------  ---------------------------------"
     echo "    frt [help]"                                                              # .(20620.01.1 RAM)
     echo ""                                                                            #
     echo "    frt keys [ host ] [ help ]          Manage SSH Key files"
     echo "        keys list [ ssh hosts ]"                                             # .(20429.02.1 Beg RAM Added)
#    echo "        keys make ssh key  {KeyOwner}  {Host} {HostUser} {Resource}"
#    echo "        keys delete ssh key  {KNo} [au[thorized_keys]]"
#    echo "        keys copy ssh key  {KNo}"
#    echo "        keys list ssh hosts keys"
#    echo "        keys set  ssh host {KNo}       {Host} {HostUser} {Resource}"
#    echo "        keys test ssh host {HostAliasName}"                                  # .(20429.02.1 End)
     echo ""
     echo "    frt gitr [ help ]                   Manage Git Local and Remote Repos"  # .(20429.03.1 Beg RAM Added)
     echo "        gitr init"                                                           # .(20429.03.1 End)
     echo "        gitr clone"                                                          # .(21027.04.1 RAM Added)
     echo ""
     echo "    frt prox [ help ]                   Manage Proxy files on server"
     echo "        prox [ list | restart ]"
     echo "        prox log"
     echo "        prox config"
     echo ""
     echo "    frt appr [ help ]                   Manage FormR Apps"
#    echo "        appr set domain {domain}"                                            # .(20407.03.1 RAM Added)
#    echo "        appr set homepage {homepage}"                                        # .(20407.01.1 RAM Added).(20410.03.1 RAM)
#    echo "        appr set port {port}"                                                # .(20407.02.1 RAM Added)
#    echo "        appr set title {app title}"                                          # .(20409.03.1 RAM Added)
#    echo "        appr set ssh_host {ssh login alias}"                                 # .(20411.03.1 RAM Added)
     echo "        appr list [ files | styles ]"
#    echo "        appr list files"                                                     # .(20410.02.1 RAM Added)
#    echo "        appr list styles"                                                    # .(20601.01.3 RAM Added)
#    echo "        appr rename styles"                                                  # .(20601.01.4 RAM Added)
#    echo "        appr save files"                                                     # .(20415.01.1 RAM Added)
#    echo "        appr save backup"                                                    # .(204xx.xx.x RAM Added)
#    echo "        appr doc"                                                            # .(20415.02.1 RAM Added)
#    echo ""
     echo "        appr [ start | build | deploy ]"
#    echo "        appr build"
#    echo "        appr run prod"
#    echo "        appr deploy"                                                         # .(20411.08.1 RAM Added)
     echo ""
     echo "        ssh [ {ssh login alias} ]"                                           # .(20412.02.1 RAM Added)
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
     echo   "--- FRT10[187]  $\1: '$1', $\2: '$2', $\3: '$3', $\4: '$4',  bQuiet: '${bQuiet}', bDebug: '${bDebug}'"; echo ""

     echo   "--- FRT10[189]  Hello Robin          -- bSpace: '${bSpace}', bQuiet: '${bQuiet}', bDebug: '${bDebug}'"
     sayMsg     "FRT10[190]  Hello Robin"
     sayMsg     "FRT10[191]  Hello Robin" 1
#    sayMsg     "FRT10[192]  Hello Robin" 2

     echo   "--- FRT10[194]  sp Hello Robin       -- bSpace: '${bSpace}', bQuiet: '${bQuiet}', bDebug: '${bDebug}'"
     sayMsg  sp "FRT10[195]  sp Hello Robin"
     sayMsg  sp "FRT10[196]  sp Hello Robin" 1
#    sayMsg  sp "FRT10[197]  sp Hello Robin" 2

     echo   "--- FRT10[199]  Hello Robin sp       -- bSpace: '${bSpace}', bQuiet: '${bQuiet}', bDebug: '${bDebug}'"
     sayMsg     "FRT10[200]  Hello Robin sp" sp
     sayMsg     "FRT10[201]  Hello Robin sp" sp 1
#    sayMsg     "FRT10[202]  Hello Robin sp" sp 2

     echo   "--- FRT10[204]  sp Hello Robin sp    -- bSpace: '${bSpace}', bQuiet: '${bQuiet}', bDebug: '${bDebug}'"
     sayMsg  sp "FRT10[205]  sp Hello Robin sp" sp
     sayMsg  sp "FRT10[206]  sp Hello Robin sp" sp 1
     sayMsg  sp "FRT10[207]  sp Hello Robin sp" sp 2

     exit
     fi

     sayMsg sp "FRT10[212]  \$1: '$1', \$2: '$2', \$3: '$3', \$4: '$4', \$5: '$5', \$6: '$6', \$7: '$8'";
     sayMsg    "FRT10[213]  aCmd:  '${aCmd}', aCmd1: '${aCmd1}', aCmd2: '${aCmd2}', aCmd3: '${aCmd3}', aCmd0: '${aCmd0}', bDoit: '$bDoit', bDebug: '$bDebug', bQuiet: '$bQuiet' " -1  # .(20601.02.3 RAM Was bQuiet: '$c' ??)
#    sayMsg    "FRT10[214]  aCmd:  '${aCmd}', aCmd1: '${aCmd1}', aCmd2: '${aCmd2}', aCmd3: '${aCmd3}', aCmd0: '${aCmd0}'" -1

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#    Help

#    getCmd    "he"            "Help"
     getCmd1   "proxy" ""      "proX"                                                                       # .(20620.03.1 RAM).(20620.10.1 RAM was Proxy)(20622.2.5 RAM Beg Use getCmd1)
     getCmd1   "gitr"  ""      "gitR"  # 1                                                                  # .(20620.10.2 RAM was GitR)
     getCmd1   "keys"  ""      "keyS"  1                                                                    # .(20620.10.3 RAM was Keys)
     getCmd1   "appr"  "run"   "appR"                                                                       # .(20508.01.1 RAM)(20620.10.4 RAM was App)(20622.2.5 RAM End)
#    getCmd    "run"   "ap"    "appR"                                                                       # .(20508.01.2 RAM)(20620.10.5 RAM was App)

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

     sayMsg    "FRT10[229]  aArg1: '$aArg1', aArg2: '$aArg2', aArg3: '$aArg3', aArg4: '$aArg4', aArg5: '$aArg5', aArg6: '$aArg6', aArg7: '$aArg7', aArg8: '$aArg8', aArg9: '$aArg9'"
     sayMsg sp "FRT10[230]  aCmd:  '${aCmd}', aCmd1: '${aCmd1}', aCmd2: '${aCmd2}', aCmd3: '${aCmd3}', aCmd0: '${aCmd0}', bDoit: '${bDoit}', bDebug: '${bDebug}', bQuiet: '${bQuiet}" -1

     Help ${aCmd0}

     sayMsg    "FRT10[234]  aCmd:  '${aCmd}', aArg1: '${aArg1}', aArg2: '${aArg2}', aArg3: '${aArg3}', bGlobal: '${bGlobal}'" sp -1

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       GITR Commands
#
#====== =================================================================================================== #

#       sayMsg "FRT10[244]  gitR Commands (${aArg1:0:3}) aCmd: '${aCmd}'" 1                                 # .(20429.03.2 Beg RAM Added)

     if [ "${aCmd}"    ==  "gitR" ]; then

        sayMsg "FRT10[248]  gitR:  '${aArg1}' '${aArg2}' '${aArg3}' '${aArg4}', bDoit: '${bDoit}', bDebug: '${bDebug}', bQuiet: '${bQuiet}'" -1

        shift
# echo "$( dirname $0 )/gitR/FRT22_gitR1_p2.02.sh"  "${aArg1}" "${aArg2}" "${aArg3}" "${aArg4}"
#      "$( dirname $0 )/gitR/FRT22_gitR1_p2.02.sh"  "${aArg1}" "${aArg2}" "${aArg3}" "${aArg4}"
#      "$( dirname $0 )/gitR/FRT22_gitR1_p2.02.sh"  "$@"
# echo "$( dirname $0 )/gitR/FRT22_gitR1_d2.04.sh"  "$@"
       "$( dirname $0 )/gitR/FRT22_gitR1_d2.04.sh"  "$@"                                                   # .(21027.04.2)

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

#       sayMsg "FRT10[270]  keyS Commands (${aArg1:0:3})"                                                   # .(20429.02.2 Beg RAM Added)

     if [ "${aCmd}"     == "keyS" ]; then

        sayMsg "FRT10[274]  keyS: '${aArg1}' '${aArg2}' '${aArg3}' '${aArg4}', bDoit: '${bDoit}', bDebug: '${bDebug}', bQuiet: '${bQuiet}'"

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

#       sayMsg "FRT10[292]  appR Commands (${aArg1:0:3})"                                                    # .(20429.02.2 Beg RAM Added)

     if [ "${aCmd}"     == "appR" ]; then

        sayMsg "FRT10[296]  appR:   '${aArg1}' '${aArg2}' '${aArg3}' '${aArg4}', bDoit: '${bDoit}', bDebug: '${bDebug}', bQuiet: '${bQuiet}'" 1

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

        sayMsg "FRT10[319]  proX: '${aArg1}' '${aArg2}' '${aArg3}' '${aArg4}', bDoit: '${bDoit}', bDebug: '${bDebug}', bQuiet: '${bQuiet}'"

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

        sayMsg    "FRT10[339]  Next Command" sp;

  if [ "${aCmd}" == "Next Command" ]; then

        sayMsg    "FRT10[343]  Next Command" 1

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
