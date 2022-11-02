#!/bin/bash
#*\
##=========+====================+================================================+
##RD         JPT Launcher Fns   | JPT Common Functions
##RFILE    +====================+=======+===============+======+=================+
##FD   JPT12_Main2Fns.sh        |  24586|  5/03/22  9:09|   407| p1.06-20503-0909
##FD   JPT12_Main2Fns.sh        |  27869|  5/05/22  9:54|   461| p1.06-20505-0954
##FD   JPT12_Main2Fns.sh        |  30170|  5/08/22 18:36|   491| p1.06-20508-1836
##FD   JPT12_Main2Fns.sh        |  30197|  6/01/22 10:15|   491| u1.06-20601-1015
##FD   JPT12_Main2Fns.sh        |  35619|  6/20/22 21:55|   538| u1.06-20620-2155
##FD   JPT12_Main2Fns.sh        |  37566|  6/23/22 09:34|   565| u1.06-20623-0934
##FD   JPT12_Main2Fns.sh        |  39508|  6/25/22 11:38|   586| u1.06-20625-1138
##FD   JPT12_Main2Fns.sh        |  41252| 10/27/22 12:00|   605| u1.06-21027-1200

##DESC     .--------------------+-------+---------------+------+-----------------+
#            Common function for JScriptWare Tools
#
##LIC      .--------------------+----------------------------------------------+
#            Copyright (c) 2018 JScriptware Power Tools * Released under
#            MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+----------------------------------------------+
#            sayMsg( )          |
#            setOS( )           |
#            logIt( )           |
#            askYN( )           |                                                       #.(20503.03.3 RAM Added)
#            sayMsg( )          |
#            setArgs()          |
#            getOpts()          |
#            getOpt()           |
#            setCmds()          |
#            getCmd()           |
#            setLv()            |
#            isDir()            |                                                       # .(20623.02.1 RAM Added)
#            Begin()            |
#            Run()              |
#            End()              |
#
##CHGS     .--------------------+----------------------------------------------+
# .(80916.02  9/16/18 RAM  8:50a| Break out $nLv and $aAct
# .(80917.01  9/17/18 RAM  4:10p| Fix bug when $aAct = x
# .(80920.01  9/20/18 RAM  2:45p| Add logIt()
# .(20418.01  4/18/22 RAM  9:30a| Add sayMsg()
# .(20418.02  4/18/22 RAM  9:30a| Add getOpt()
# .(20418.03  4/18/22 RAM  9:45a| Add getCmd()
# .(20429.09  4/29/22 RAM  7:30p| Convert aArgsNs to lowercase
# .(20429.09  5/01/22 RAM  2:45p| Run Args_toLower once
# .(20502.06  5/02/22 RAM 12:00p| Major overhaul of JPT12_Main2Fns_p1.06.sh
# .(20503.03  5/03/22 RAM 12:30p| Added askYn()
# .(20503.04  5/03/22 RAM  3:11p| Removed 2nd version of sayMsg
# .(20508.03  5/08/22 RAM  4:00p| Added THE_SERVER checks
# .(20601.02  6/01/22 RAM 10:15p| Never sayMsg if bQuiet = 1
# .(20601.04  6/01/22 RAM  7:00p| Played with dBug and nLen
# .(20620.04  6/20/22 RAM  5:45p| Reworked sayMsg sp functionality
# .(20620.09  6/20/22 RAM  7:45p| Do    print if bDebug=1 and sayMsg ... -1
# .(20622.01  6/22/22 RAM  4:45p| Write getCmd1 for 1st level cmd
# .(20623.02  6/23/22 RAM  9:30a| Added isDir()
# .(20623.03  6/23/22 RAM  1:30p| Add aOS back
# .(20620.09  6/23/22 RAM  2:45p| Don't print if bDebug=1 and sayMsg ... 1
# .(21027.03 10/27/22 RAM 12:00p| Add "*" as optional getCmd 2nd Arg

##PRGM     +====================+===============================================+
##ID 69.600. Main               |
##SRCE     +====================+===============================================+
#*/
#    ------ ------------------  =  ---------------------------------------------------  #  ----------------

function  setOS() {

     if [ "${THE_SERVER}"  == "" ]; then THE_SERVER=${SCN_SERVER}; fi
#    if [ "${THE_SERVER}"  == "" ]; then THE_SERVER="rm212d-w10p"; fi                   ##.(20508.03.1 RAM

     if [ "${THE_SERVER}" == "" ]; then echo ""; echo "* \$THE_SERVER NOT DEFINED; OS will probably be incorrect"; exit; fi

     aServer=${THE_SERVER}; if [ "${aServer}" == "" ]; then aServer="${SCN_SERVER}"; fi

#    aOS="linux"; if [ "${aServer:7:1}" == "w" ]; then aOS="windows"; fi                ##.(20508.03.2)
#                 if [ "${aServer:7:1}" == "m" ]; then aOS="macOS";   fi                ##.(20508.03.3)

#    aSvr=${aServer:0:6}                                                                ##.(20508.03.4)

     aSCN_SERVER=$( echo ${THE_SERVER} | tr '[:upper:]' '[:lower:]' )                   # .(20508.03.5 RAM Set var from THE_SERVER)
     aIP=${aSCN_SERVER##* (}; aIP=${aIP//)/}

     aSvr=${aSCN_SERVER%%_*}
     aOSv=${aSvr##*-}                                                                   # [wmu?] 1st char after -
     aSvr=${aSvr%%-*}
#    echo "  - JPFns[ 87]  bTest: ${bTest}, bQuiet: ${bQuiet}, aSvr: ${aSvr}, aOSv: ${aOSv}, aIP: ${aIP}"; # exit

  if [ "${ConEmuTask}" != "" ]; then
     aOSv=gfw1
     fi
                                       aDrv=""
  if [ "${aOSv:0:1}" == "g"    ]; then aDrv="/c"  ; fi    # Windows Git Bash
  if [ "${aOSv:0:1}" == "m"    ]; then aDrv=""    ; fi    # MacOS                       # .(20623.03.1)
  if [ "${aOSv:0:1}" == "u"    ]; then aDrv=""    ; fi    # Ubuntu                      # .(20623.03.2)
  if [ "${aOSv:0:2}" == "rh"   ]; then aDrv=""    ; fi    # Red Hat                     # .(20623.03.3)
  if [ "${aOSv:0:1}" == "w"    ]; then aDrv="C:"  ; fi    # Windows
  if [ "${aOSv}"     == "w08s" ]; then aDrv="D:"  ; fi

                                       aVOL=""            ; aVol="/nfs/u06"
  if [ "${aOSv:0:1}" == "g"    ]; then aVOL="c/vols/u06"                    ; fi
  if [ "${aOSv:0:1}" == "w"    ]; then aVOL="C:/VOLs/U06"                   ; fi
  if [ "${aOSv}"     == "w10p" ]; then                      aVol="M:/U06"   ; fi
  if [ "${aOSv}"     == "w08s" ]; then aVOL="D:/VOLs/U06" ; aVol="M:/U06"   ; fi

# if [ "${bDebug}"   == "1"    ]; then                                                                      # .(20503.05.1 RAM was if bQuiet = 0)
#    echo "  - JPFns[107]  SCN_SERVER: ${aSCN_SERVER}; aSvr: ${aSvr}, aOSv: ${aOSv}, aIP: ${aIP}"
#    echo "  - JPFns[108]  aCmd: ${aCmd}; aDrv: ${aDrv}, aVOL: ${aVOL}, aVol: ${aVol}"
#    echo "  - JPFns[109]  bTest: ${bTest}, bQuiet: ${bQuiet}, aSvr: ${aSvr}, aOSv: ${aOSv}, aIP: ${aIP}";
#    fi

     aOS="linux"; if [ "${aOSv:0:1}" == "w" ]; then aOS="windows"; fi                   # .(20623.03.4)
                  if [ "${aOSv:0:1}" == "m" ]; then aOS="macOS";   fi                   # .(20623.03.5)
                  if [ "${aOSv:0:1}" == "g" ]; then aOS="GitBash"; fi                   # .(20623.03.6)

     } # eof setOS
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

#======= ================================================================================================== #  ===========

function logIt() {                                                                                          # .(80920.02.1)
         aFncLine="$1[$2]             "; aFncLine="${aFncLine:0:17} $3"; # aFncLine="${aFncLine/ \//\/}";
  if [ "${JPT_LOG}" != "" ]; then echo "$( date '+%Y%m%d-%H%M%S%z')  ${SCN_SERVER:0:11} ${JPT_USER:0:8}  ${aFncLine}" >>"${JPT_LOG}"; fi

     } # eof logIt
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

#======= ================================================================================================== #  ===========

function askYN() {
        echo "    $1"
        echo ""; read -p "    Enter Yes or No: [y/n]: " aAnswer
        aAnswer=$( echo ${aAnswer} | awk '/^[ynYN]+$/' )
if [ "${aAnswer}" == "" ]; then echo ""; echo "  * Please Yes or No."; exit; fi
        aAnswer=$( echo ${aAnswer} | awk '/^[yY]+$/ { print "y" }' )
# if [ "${aAnswer}" != "y" ]; then exit; fi

     } # eof askYN                                                                      # .(20409.05.3)
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

#======= ================================================================================================== #  ===========

function sayMBugEnd() {                                                                                     # .(20620.06.1 RAM Beg)
      if [ "$1" == "1" ]; then
            echo ""; echo "----------------------------------------------------------------------------------------------------------"; echo ""
            fi
         }                                                                                                  # .(20620.06.1 RAM End)
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

function sayMsg( ) {  aMsg="$1"; aSp=""; aSP=$3;  aSp=" -- space --"; bSP=0; if [ "${bMBug}" == "" ]; then bMBug=0; fi

            dBug2="$2"; if [ "$1" == "sp" ]; then dBug2="$3"; aSP=$4; bSP=1; aMsg="$2"; fi                  # .(20620.04.1 RAM Beg Redo sp functionality)
                        if [ "$2" == "sp" ]; then dBug2="$3"; aSP=$2; fi                                    # .(20623.09.1 RAM Don't assign bSP=1, aSP=$2)
                        if [ "$3" == "sp" ]; then dBug2="$4"; aSP=$3; fi                                    # .(20623.09.2)
                        if [ "$4" == "sp" ]; then             aSP=$4; fi                                    # .(20620.04.1 RAM End).(20623.09.3)


#           bNoQuit=0;  if [ "$2"       == "2" ] || [ "$3" == "2"        ] || [ "$4" == "2"       ]; then bNoQuit=1; fi        # .(20601.02.3)
            bNoQuit=0;  if [ "${dBug2}" == "1" ] || [ "${dBug2}" == "-1" ] || [ "${dBug2}" == "2" ]; then bNoQuit=1; fi
#           bDebug1=${bDebug};  if [ "$2" != ""          ]; then bDebug1=$2;       fi
            bDebug1=${bDebug};  if [ "${dBug2}" != ""    ]; then bDebug1=${dBug2};
            fi

#   if [ "${bMBug}"  ==  "1" ]; then echo "-0- bDebug1: '${bDebug1}', bDebug: '${bDebug}', dBug2: '${dBug2}', bNoQuit: '${bNoQuit}', bSP: '${bSP}', aSP: '${aSP}', aMsg: '${aMsg}'"; fi

    if [ "${dBug2}"  == "-1" ] ||  [ "${dBug2}" == ""    ]; then bDebug1=0; fi                              # .(20620.09.1)
    if [ "${bDebug}" ==  "1" ] &&  [ "${dBug2}" == "-1"  ]; then bDebug1=1; fi                              # .(20620.09.2)
    if [ "${bDebug}" ==  "1" ] &&  [ "${dBug2}" ==  "1"  ]; then bDebug1=0; fi                              # .(20620.09.3)
    if                             [ "${dBug2}" ==  "1"  ]; then bDebug1=1; fi                              # .(20620.09.4)
    if                             [ "${dBug2}" ==  "2"  ]; then bDebug1=2; fi                              # .(20620.09.5)


#   if [ "${bDebug}" ==  "1" ] && [ "${bDebug1}" == "-1" ]; then bDebug1=1; fi                              ##.(20620.09.3 RAM Only force print if bDebug = 1 and bDebug1 = -1 )

    if [ "${bMBug}"  ==  "1" ]; then echo "-1- bDebug1: '${bDebug1}', bQuiet: '${bQuiet}', dBug2: '${dBug2}', bNoQuit: '${bNoQuit}', bSP: '${bSP}', aSP: '${aSP}', aMsg: '${aMsg}'"; fi

    if [ "${bQuiet}" ==  "1" ]  && [ "${bNoQuit}" == "0" ]; then sayMBugEnd ${bMBug}; return; fi            # .(20601.02.3).(20620.04.2 RAM Use bNoQuit).(20620.06.2)

    if [ "${bDebug1}" == "0" ];                             then sayMBugEnd ${bMBug}; return; fi;           # .(20620.06.3)

#   if [ "${aMsg}"   == "sp" ]  && [ "${bDebug}" == "1"  ]; then aSP=1; bSpace=0; fi                        # .(20502.02.1)
#   if [ "${bSP}"     == "1" ]  && [ "${bDebug}" == "1"  ]; then bSP=1; bSpace=0; fi                        # .(20502.02.3)
    if [ "${bSP}"     == "1" ]  && [ "${bSpace}" == "0"  ]; then        bSpace=1; fi                        # .(20620.07.1 RAM Why is bDebug special)

    if [ "${bMBug}"   == "1" ]; then echo "-2- bDebug1: '${bDebug1}', bDebug: '${bDebug}', bSpace:  '${bSpace}', bSP: '${bSP}', aSP: '${aSP}', aMsg: '${aMsg}'"; fi

#   if [ "${aMsg}"    == ""  ] || [ "${aMsg}" == "sp" ];    then bSpace=$(( 1 - bSpace )); aMsg="$2"; bDebug1=$3;     aSP=$4; fi  # toggle bSpace
#   if [ "${aMsg}"    == ""  ] || [ "${bSP}"  == "1"  ];    then bSpace=$(( 1 - bSpace ));            bDebug1=${bSP}; aSP=$4; fi  # toggle bSpace  # .(20502.02.1 Keep bDebug if set)
    if [ "${aMsg}"    == ""  ] || [ "${bSP}"  == "1"  ];    then bSpace=$(( 1 - bSpace ));                                    fi  # .(20620.09.6 RAM Don't re-assign bDebug1, or aSP)
    if [ "${bDebug1}" == ""  ];                             then sayMBugEnd ${bMBug}; return; fi            # .(20620.06.4).(bDebug1 can't be ''

    if [ "${bMBug}"   == "1" ]; then echo "-3- bDebug1: '${bDebug1}', bDebug: '${bDebug}', bSpace:  '${bSpace}', bSP: '${bSP}', aSP: '${aSP}', aMsg: '${aMsg}'"; fi

#   if [ "${bSpace}"  == "1" ]  && [ "${bDebug1}" != "3" ]; then echo "${aSp}"; bSpace=0; fi                                    # A leading space has just been displayed, print one next
    if [ "${bSpace}"  == "0" ]  && [ "${bDebug1}" != "3" ]; then echo "${aSp}"; bSpace=1; fi                                    # A leading space has been not displayed,  print this one

    if [ "${bDebug1}" == "1" ]; then echo "  - ${aMsg}"; fi

    if [ "${bDebug1}" == "2" ]; then echo " ** ${aMsg}";                                                    # .(20620.09.7 RAM  # Ok, pring space before exit)
    if [ "${aSP}"    == "sp" ]; then echo     "${aSp}" ; fi; ${aLstSp}; exit; fi                            # .(10706.09.2)
#   if [ "${bDebug1}" == "2" ]; then                         ${aLstSp}; exit; fi                            ##.(10706.09.3 RAM  # No trailing space on exit)

    if [ "${bDebug1}" == "3" ]; then echo     "${aMsg}"; fi
    if [ "${aSP}"    == "sp" ]; then echo     "${aSp}" ; export bSpace=1; fi                                # .(20625.04 RAM Set bSpace=1, not 0 and add export)

    if [ "${bMBug}" == "1"   ]; then echo "-4- bDebug1: '${bDebug1}', bDebug: '${bDebug}', bSpace:  '${bSpace}', aSP: '$aSP', bQuiet: '${bQuiet}', "; sayMBugEnd ${bMBug}; fi # .(20620.06.4)
    }
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

#======= ================================================================================================== #  ===========

function setArgs( ) {                                                                   # .(20429.09.8 Beg RAM Added)

    mARGs=( "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9" )

    aArg1="$( echo "$1" | tr '[:upper:]' '[:lower:]' )"
    aArg2="$( echo "$2" | tr '[:upper:]' '[:lower:]' )"
    aArg3="$( echo "$3" | tr '[:upper:]' '[:lower:]' )"
    aArg4="$( echo "$4" | tr '[:upper:]' '[:lower:]' )"
    aArg5="$( echo "$5" | tr '[:upper:]' '[:lower:]' )"
    aArg6="$( echo "$6" | tr '[:upper:]' '[:lower:]' )"
    aArg7="$( echo "$7" | tr '[:upper:]' '[:lower:]' )"
    aArg8="$( echo "$8" | tr '[:upper:]' '[:lower:]' )"
    aArg9="$( echo "$9" | tr '[:upper:]' '[:lower:]' )"

#   aArg1="$( echo "${aArg1}" | awk '{ print tolower( $0 ) }' )"                        # .(20429.09.01 Beg RAM)
#   aArg2="$( echo "${aArg2}" | awk '{ print tolower( $0 ) }' )"
#   aArg3="$( echo "${aArg3}" | awk '{ print tolower( $0 ) }' )"
#   aArg4="$( echo "${aArg4}" | awk '{ print tolower( $0 ) }' )"
#   aArg5="$( echo "${aArg5}" | awk '{ print tolower( $0 ) }' )"
#   aArg6="$( echo "${aArg6}" | awk '{ print tolower( $0 ) }' )"
#   aArg7="$( echo "${aArg7}" | awk '{ print tolower( $0 ) }' )"
#   aArg8="$( echo "${aArg8}" | awk '{ print tolower( $0 ) }' )"                        # .(20429.09.01 End)

    aCmd0="$1 $2 $3"; aCmd0="$( echo "${aCmd0}" | awk '{ sub( / +$/, "" ); print }' )"
    sayMsg sp "JPFns[236]  aArg1:'$aArg1', aArg2:'$aArg2', aArg3:'$aArg3', aArg4:'$aArg4', aArg5:'$aArg5', aArg6:'$aArg6', aArg7:'$aArg7', aArg8:'$aArg8', aArg9:'$aArg9' " 0

    } # eof setArgs
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

#======= ================================================================================================== #  ===========

function getOpts() {  dBug=$2
    sayMsg    "JPFns[244]  aArg1:'$aArg1', aArg2:'${aArg2}', aArg3:'$aArg3', aArg4:'$aArg4', aArg5:'$aArg5', aArg6:'$aArg6', aArg7:'$aArg7', aArg8:'$aArg8', aArg9:'$aArg9' " ${dBug} # Called 3 or 4 files

    if [ "${1/b/}" != "$1" ]; then if [ "${bDebug}"  != "1" ]; then getOpt "-b" "-de";  export bDebug=${nOpt};  fi; sayMsg "JPFns[246]  bDebug:  '${bDebug}'"  ; fi   # .(20501.01.3)
    if [ "${1/d/}" != "$1" ]; then if [ "${bDoit}"   != "1" ]; then getOpt "-d" "doit"; export bDoit=${nOpt};   fi; sayMsg "JPFns[247]  bDoit:   '${bDoit}'"   ; fi   # .(20501.01.5)
    if [ "${1/q/}" != "$1" ]; then if [ "${bQuiet}"  != "1" ]; then getOpt "-q" "qu";   export bQuiet=${nOpt};  fi; sayMsg "JPFns[248]  bQuiet:  '${bQuiet}'"  ; fi   # .(20501.01.4)
    if [ "${1/g/}" != "$1" ]; then if [ "${bGlobal}" != "1" ]; then getOpt "-g" "glo";  export bGlobal=${nOpt}; fi; sayMsg "JPFns[249]  bGlobal: '${bGlobal}'" ; fi
#   if [ "${1/l/}" != "$1" ]; then if [ "${bLocal}"  != "1" ]; then getOpt "-l" "loc";  export bLocal=${nOpt};  fi; sayMsg "JPFns[250]  bLocal:  '${bLocal}'"  ; fi

    } # eof getOpts
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

#======= ================================================================================================== #  ===========

function getOpt( ) { # echo "getObj('$1');"
#   sayMsg sp "JPFns[258]  aARG1:'${mARGs[0]}', aARG2:'${mARGs[1]}', aARG3:'${mARGs[2]}', aARG4:'${mARGs[3]}', aARG5:'${mARGs[4]}', aARG6:'${mARGs[5]}', aARG7:'${mARGs[6]}', aARG8:'${mARGs[7]}' " 1
    sayMsg    "JPFns[259]  aArg1:'$aArg1', aArg2:'$aArg2', aArg3:'$aArg3', aArg4:'$aArg4', aArg5:'$aArg5', aArg6:'$aArg6', aArg7:'$aArg7', aArg8:'$aArg8', aArg9:'$aArg9' " ${dBug} # Called 3 or 4 files

                                                   w=${#2};            nOpt=0; mKeep=( 0 1 2 3 4 5 6 7 8 )
    if [ "${aArg1:0:2}" == "$1" ] || [ "${aArg1:0:$w}" == "$2" ]; then nOpt=1; mKeep=(   1 2 3 4 5 6 7 8 ); aArg1="$aArg2"; aArg2="$aArg3"; aArg3="$aArg4"; aArg4="$aArg5"; aArg5="$aArg6"; aArg6="$aArg7"; aArg7="$aArg8"; fi
    if [ "${aArg2:0:2}" == "$1" ] || [ "${aArg2:0:$w}" == "$2" ]; then nOpt=1; mKeep=( 0   2 3 4 5 6 7 8 );                 aArg2="$aArg3"; aArg3="$aArg4"; aArg4="$aArg5"; aArg5="$aArg6"; aArg6="$aArg7"; aArg7="$aArg8"; fi
    if [ "${aArg3:0:2}" == "$1" ] || [ "${aArg3:0:$w}" == "$2" ]; then nOpt=1; mKeep=( 0 1   3 4 5 6 7 8 );                                 aArg3="$aArg4"; aArg4="$aArg5"; aArg5="$aArg6"; aArg6="$aArg7"; aArg7="$aArg8"; fi
    if [ "${aArg4:0:2}" == "$1" ] || [ "${aArg4:0:$w}" == "$2" ]; then nOpt=1; mKeep=( 0 1 2   4 5 6 7 8 );                                                 aArg4="$aArg5"; aArg5="$aArg6"; aArg6="$aArg7"; aArg7="$aArg8"; fi
    if [ "${aArg5:0:2}" == "$1" ] || [ "${aArg5:0:$w}" == "$2" ]; then nOpt=1; mKeep=( 0 1 2 3   5 6 7 8 );                                                                 aArg5="$aArg6"; aArg6="$aArg7"; aArg7="$aArg8"; fi
    if [ "${aArg6:0:2}" == "$1" ] || [ "${aArg6:0:$w}" == "$2" ]; then nOpt=1; mKeep=( 0 1 2 3 4   6 7 8 );                                                                                 aArg6="$aArg7"; aArg7="$aArg8"; fi
    if [ "${aArg7:0:2}" == "$1" ] || [ "${aArg7:0:$w}" == "$2" ]; then nOpt=1; mKeep=( 0 1 2 3 4 5   7 8 );                                                                                                 aArg7="$aArg8"; fi
    if [ "${aArg8:0:2}" == "$1" ] || [ "${aArg8:0:$w}" == "$2" ]; then nOpt=1; mKeep=( 0 1 2 3 4 5 6   8 );                                                                                                                 fi

    sayMsg    "JPFns[271]  getOpt( '$1' '$2' ) -> mKeep: '${mKeep[*]}'; mARGs: '${mARGs[*]}'" # 1;

    mARgs=(); for i in ${mKeep[@]}; do mARgs+=( ${mARGs[$i]} );
    done; mARGs=( ${mARgs[@]} )

    sayMsg    "JPFns[276]  mARgs: '${mARgs[*]}', mARgs: '${mARgs[*]}'" # 1
#   done; mARGs=( ${mARgs[@]} )

#   sayMsg    "JPFns[279]  \$1: '$1', \$2: '$2' -- nOpt:  ${nOpt}" ${bBug} # sp
#   sayMsg    "JPFns[280]  aArg1:'$aArg1', aArg2:'$aArg2', aArg3:'$aArg3', aArg4:'$aArg4', aArg5:'$aArg5', aArg6:'$aArg6', aArg7:'$aArg7', aArg8:'$aArg8', aArg9:'$aArg9' " 1 # Called 3 or 4 files
#   sayMsg    "JPFns[281]  aARG1:'${mARGs[0]}', aARG2:'${mARGs[1]}', aARG3:'${mARGs[2]}', aARG4:'${mARGs[3]}', aARG5:'${mARGs[4]}', aARG6:'${mARGs[5]}', aARG7:'${mARGs[6]}', aARG8:'${mARGs[7]}' " 1

    } # eof getOpt
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

#======= ================================================================================================== #  ===========

function setCmds( ) {
    aCmd=""; dBug=$1                                                                                        # .(20601.04.1 RAM Added dBug="$1})

#   aCmd0="${aArg1} ${aArg2} ${aArg3}";

    aCmd1=${aArg1:0:2};                               aCmd1=${aCmd1/ls/li};                                 # .(20429.09.8)
    aSub1=${aArg2:0:2};    aCmd2=${aCmd1}-${aSub1};   aSub1=${aSub1/ls/li}; aCmd2_=${aCmd2}                 # .(21027.02.2).(20429.09.9)
    aSub2=${aArg3:0:2};    aCmd3=${aCmd2}-${aSub2};   aSub2=${aSub2/ls/li}; aCmd3_=${aCmd3}                 # .(21027.02.3).(20429.09.10)

    if [ "${aCmd1}" == "he" ] || [ "${aCmd1}" == "" ]; then aCmd0="help"; aCmd="Help"; fi                   # .(20622.03.1 RAM Added aCmd="Help")

#   bSpace=1; bMBug=1    # Don't print space unless sp passed; print sayMsg debug statements
    sayMsg sp "JPFns[300]  aCmd:  '${aCmd}', aCmd1: '${aCmd1}', aCmd2: '${aCmd2}', aCmd3: '${aCmd3}', aCmd0: '${aCmd0}', bQuiet: ${bQuiet}, dBug: ${dBug}" ${dBug} # 1   # .(20601.04.2)

    } # eof setCmds
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

#======= ================================================================================================== #  ===========

function getCmd1( ) {    # dBug=""; # "1"                                               # .(20622.02.1 RAM Beg Added)

#   sayMsg    "JPFns[309]  aArg1: '${aArg1}', \$1: '$1', \$2: '$2', \$3: '$3' " 1

#   if [ "${aArg1:0:5}" == "${1:0:5}" ] || [ "${aArg1:0:5}" == "${2:0:5}" ]; then aCmd=$3; fi
#   if [ "${aArg1:0:4}" == "${1:0:4}" ] || [ "${aArg1:0:4}" == "${2:0:4}" ]; then aCmd=$3; fi
    if [ "${aArg1:0:3}" == "${1:0:3}" ] || [ "${aArg1:0:3}" == "${2:0:3}" ]; then aCmd=$3; fi
#   if [ "${aArg1:0:2}" == "${1:0:2}" ] || [ "${aArg1:0:2}" == "${2:0:2}" ]; then aCmd=$3; fi

    } # eof getCmd1                                                                     # .(20622.02.1 RAM End)
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

#======= ================================================================================================== #  ===========

function setLv() {
    sayMsg    "JPFns[322]  nLv: $1, aArg1:'$aArg1', aArg2:'$aArg2', aArg3:'$aArg3', aArg4:'$aArg4', aArg5:'$aArg5', aArg6:'$aArg6', aArg7:'$aArg7' " ${dBug}

    if [ "$1" == "1" ]; then aArg1="${aArg2}"; aArg2="${aArg3}"; aArg3="${aArg4}"; aArg4="${aArg5}"; aArg5="${aArg6}"; aArg6="${aArg7}"; aArg7="${aArg8}";
                             mARgs=(); mKeep=( 1 2 3 4 5 6 ); for i in ${mKeep[@]}; do mARgs+=( ${mARGs[$i]} ); done;  mARGs=( ${mARgs[@]} )
                             fi

    if [ "$1" == "2" ]; then aArg1="${aArg3}"; aArg2="${aArg4}"; aArg3="${aArg5}"; aArg4="${aArg6}"; aArg5="${aArg7}"; aArg6="${aArg8}";
                             mARgs=(); mKeep=(   2 3 4 5 6 ); for i in ${mKeep[@]}; do mARgs+=( ${mARGs[$i]} ); done;  mARGs=( ${mARgs[@]} )
                             fi

    if [ "$1" == "3" ]; then aArg1="${aArg4}"; aArg2="${aArg5}"; aArg3="${aArg6}"; aArg4="${aArg7}"; aArg5="${aArg8}";
                             mARgs=(); mKeep=(     3 4 5 6 ); for i in ${mKeep[@]}; do mARgs+=( ${mARGs[$i]} ); done; mARGs=( ${mARgs[@]} )
                             fi

    sayMsg    "JPFns[336]  aCmd:  '${aCmd}', nLv: $1, aArg1:'$aArg1', aArg2:'$aArg2', aArg3:'$aArg3', aArg4:'$aArg4', aArg5:'$aArg5', aArg6:'$aArg6', aArg7:'$aArg7' "
    sayMsg    "JPFns[337]  aCmd:  '${aCmd}', nLv: $1, aARG1:'${mARGs[0]}', aARG2:'${mARGs[1]}', aARG3:'${mARGs[2]}',  aARG4:'${mARGs[3]}', aARG5:'${mARGs[4]}', aARG6:'${mARGs[5]}', aARG7:'${mARGs[6]}' " sp ${dBug}

    return
    } # eof setLv
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

#======= ================================================================================================== #  ===========

function getCmd( ) {    # dBug="1"; # "1"                                               # .(20601.04.3 RAM Added dBug="$3})

    if [ "${aCmd}" != "" ]; then return; fi                                             # .(20502.03.2 RAM Don't continue if already set)

    sayMsg sp "JPFns[349]  aArg1: '${aArg1}', aCmd: '${aCmd}', aCmd1: '${aCmd1}', aCmd2_: '${aCmd2_}', aCmd3_: '${aCmd3_}', \$1: '$1', \$2: '$2', \$3: '$3', \$4: '$4', \$5: '$5', dBug: ${dBug} " ${dBug} # -1

                                                                cmd=$4; dBug1=$5; c1=$1; c2=$2; c3=$3;       # .(20601.04.4).(20625.06.1 RAM Good grief)
 if [ "$4" == ""  ] || [ "$4" == "0" ] || [ "$4" == "1" ]; then cmd=$3; dBug1=$4; c1=$1; c2=$2; c3=""; fi    # .(20508.04.1 RAM).(20601.04.5).(20625.06.2)
 if [ "$3" == ""  ] || [ "$3" == "0" ] || [ "$3" == "1" ]; then cmd=$2; dBug1=$3; c1=$1; c2=""; c3=""; fi    # .(20508.04.2 RAM).(20601.04.6).(20625.06.3)

  if [ "$2" == "*" ]; then aCmd2="${aCmd2:0:2}-"; aCmd3="${aCmd3:0:2}--"; c2=""; c3="";                       # .(21027.02.4 RAM Allow 2nd Cmd to be "*")
                      else aCmd2="${aCmd2_}";     aCmd3="${aCmd3_}"; fi                                       # .(21027.02.5 RAM Gotta use original)

 if [ "${dBug1}" == "1" ]; then dBug=1; fi                                              # .(20601.04.7)
 if [ "${dBug}"  == ""  ]; then dBug=0; fi                                              # .(20601.04.7)

    sayMsg    "JPFns[361]  aArg1: '${aArg1}', aCmd1: '${aCmd1}', aCmd2: '${aCmd2}', aCmd3: '${aCmd3}', \$1: '$c1', \$2: '$c2', \$3: '$c3', dBug: ${dBug}" ${dBug}

#if [ "$3"           == ""  ]; then                                                     ##.(20508.04.3)
#if [ "${aCmd2:2:1}" == "-" ]; then                                                     ##.(20508.04.3 RAM if "${aCmd2:2:1}" == "-").(20625.06.4)
 if [ "$c2"          == ""  ]; then                                                     # .(20508.04.3 RAM if "$2" is MT, not if "${aCmd2:2:1}" == "-").(20625.06.4)

#              bOk1=0; if [ "${aArg1:0:2}-" == "${aCmd2}" ] || [ "${aArg1}" == "$c1" ]; then bOk1=1; fi                             ##.(20625.06.5)
               bOk1=0; if [ "${aArg1:0:2}-" == "${aCmd2}" ] || [   "${c2}"  == "$c1" ]; then bOk1=1; fi                             # .(20625.06.5)
       if [ "${bOk1}" == "1" ]; then

    nLen=${#1}                                                                                                                      # .(20601.04.5 RAM Added nLen)
#   sayMsg    "JPFns[372]      Checking aCmd1:  '${aCmd1}'    == '$1',   or aArg1: '${aArg1:0:${nLen}}' == '$1', ${nLen}" ${dBug}   # .(20601.04.6 RAM Added nLen)
    sayMsg    "JPFns[373]      Checking aCmd1:  '${aCmd1}'    == '$c1'   or aArg1: '${aArg1}' == '$c1'" ${dBug}                     # .(20601.04.6 RAM Added nLen)

# if [ "${aCmd1}"           == "$1"  ]; then aCmd="$cmd"; setLv 1; return; fi
# if [ "${aArg1:0:${nLen}}" == "$1"  ]; then aCmd="$cmd"; setLv 1; return; fi           ##.(20502.03.1 RAM Special case).(20601.04.4).(20625.06.6)
  if [ "${aArg1}"           == "$c1" ]; then aCmd="$cmd"; setLv 1; return; fi           # .(20502.03.1 RAM Special case).(20601.04.4).(20625.06.6)
# if [ "${aArg1}"     == "${c1:0:2}" ]; then aCmd="$cmd"; setLv 1; return; fi           # .(20502.03.2 RAM Special case with just 2 chars)
     else
    sayMsg    "JPFns[380]      No Check aCmd1: '${aCmd1}'    == '$c1'   or '${aArg1:0:2}-' != '${aCmd2}'" ${dBug}                  # .(20601.04.6 RAM Added nLen).(20625.06.7)
       fi
##                                                                  return              # .(20508.04.4 RAM Don't continue)
    fi  # eif [ "${aCmd2:2:1}" == "-" ]
#   -----------------------------------------------------

#if [ "$4" == "" ]; then                                                                ##.(20508.04.5)
#if [ "${aCmd3:5:1}" == "-" ]; then                                                     ##.(20508.04.5).(20625.06.5)
 if [ "$c3"          == ""  ]; then                                                     # .(20508.04.5).(20625.06.5)

#   sayMsg    "JPFns[390]      Checking aCmd2a: '${aCmd2}'    == '$1-$2' or '$2-$1'" ${dBug}
    sayMsg    "JPFns[391]      Checking aCmd2a: '${aCmd2}'    == '$c1-$c2' or '$c2-$c1'" ${dBug}

    if [ "${aCmd2}" == "$c1-$c2"  ]; then aCmd="$cmd"; setLv 2; return; fi   # aCmd2 <= ${aArg1:0:2}-${aArg2:0:2}, i.e. entered command   # .(20625.06.7)
#   if [ "${aCmd3}" == "$c1-$c2-" ]; then aCmd="$cmd"; setLv 2; return; fi

    if [ "${aCmd2}" == "$c2-$c1"  ]; then aCmd="$cmd"; setLv 2; return; fi              # .(20625.06.8)
#   if [ "${aCmd3}" == "$c2-$c1-" ]; then aCmd="$cmd"; setLv 2; return; fi

#   if [ "${aCmd1}" == "$c1"      ]; then aCmd="$cmd"; setLv 1; return; fi
#   if [ "${aCmd3}" == "$c1--"    ]; then aCmd="$cmd"; setLv 1; return; fi

                                                                return                  # .(20626.01.1 RAM No need to check the following if $c3 == "")

#   sayMsg    "JPFns[404]      Checking aCmd2b: '${aCmd2}'    == '$1-$3'    or '$2-$3'    or '$3-$1'    or '$3-$2'" ${dBug}
    sayMsg    "JPFns[405]      Checking aCmd2b: '${aCmd2}'    == '$c1-$c3'    or '$c2-$c3'    or '$c3-$c1'    or '$c3-$c2'" ${dBug}

    if [ "${aCmd2}" == "$c1-$c3"  ]; then aCmd="$cmd"; setLv 2; return; fi
    if [ "${aCmd2}" == "$c2-$c3"  ]; then aCmd="$cmd"; setLv 2; return; fi
    if [ "${aCmd2}" == "$c3-$c1"  ]; then aCmd="$cmd"; setLv 2; return; fi
    if [ "${aCmd2}" == "$c3-$c2"  ]; then aCmd="$cmd"; setLv 2; return; fi

                                                                return                  # .(20508.04.6 RAM Don't continue)
    fi
#   -----------------------------------------------------


    sayMsg    "JPFns[417]      Checking aCmd3:  '${aCmd3}' == '$1-$2-$3' or '$1-$3-$2' or '$2-$3-$1' or '$2-$1-$3'  or '$3-$1-$2' or '$3-$2-$1'" ${dBug}
    if [ "${aCmd3}" == "$1-$2-$3" ]; then aCmd="$cmd"; setLv 3; return; fi
    if [ "${aCmd3}" == "$1-$3-$2" ]; then aCmd="$cmd"; setLv 3; return; fi
    if [ "${aCmd3}" == "$2-$3-$1" ]; then aCmd="$cmd"; setLv 3; return; fi
    if [ "${aCmd3}" == "$2-$1-$3" ]; then aCmd="$cmd"; setLv 3; return; fi
    if [ "${aCmd3}" == "$3-$1-$2" ]; then aCmd="$cmd"; setLv 3; return; fi
    if [ "${aCmd3}" == "$3-$2-$1" ]; then aCmd="$cmd"; setLv 3; return; fi

#   if [ "${aCmd3}" == "$1-$3-"   ]; then aCmd="$4";   setLv 2; return; fi
#   if [ "${aCmd3}" == "$3-$1-"   ]; then aCmd="$4";   setLv 2; return; fi
#   if [ "${aCmd3}" == "$2-$3-"   ]; then aCmd="$4";   setLv 2; return; fi
#   if [ "${aCmd3}" == "$3-$2-"   ]; then aCmd="$4";   setLv 2; return; fi

    sayMsg    "JPFns[430]  aCmd: 'NOT FOUND': '${aCmd1}', aCmd2: '${aCmd2}', aCmd3: '${aCmd3}', nLv: '${nLv}'"  ${dBug}
#   sayMsg    "JPFns[431]  aArg1:'$aArg1', aArg2:'$aArg2', aArg3:'$aArg3', aArg4:'$aArg4', aArg5:'$aArg5', aArg6:'$aArg6', aArg7:'$aArg7'' "  ${dBug}

#   if [ "${mLv}" == "1" ]; then aArg1="${aArg2}"; aArg2="${aArg3}"; aArg3="${aArg4}"; aArg4="${aArg5}"; aArg5="${aArg6}"; aArg6="${aArg7}"; aArg7="${aArg8}"; fi
#   if [ "${nLv}" == "2" ]; then aArg1="${aArg3}"; aArg2="${aArg4}"; aArg3="${aArg5}"; aArg4="${aArg6}"; aArg5="${aArg7}"; aArg6="${aArg8}"; fi
#   if [ "${nLv}" == "3" ]; then aArg1="${aArg4}"; aArg2="${aArg5}"; aArg3="${aArg6}"; aArg4="${aArg7}"; aArg5="${aArg8}"; fi

       dBug=0

       } # eof getCmd
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

#======= ================================================================================================== #  ===========

#                          aArg1="$1";     aArg2="$2";     aArg3="$3";     aArg4="$4";     aArg5="$5";     aArg6="$6";     aArg7="$7";     aArg8="$8";     aArg9="$9";
#   sayMsg "" "JPFns[445]  aArg1:'$aArg1', aArg2:'$aArg2', aArg3:'$aArg3', aArg4:'$aArg4', aArg5:'$aArg5', aArg6:'$aArg6', aArg7:'$aArg7', aArg8:'$aArg8', aArg9:'$aArg9' " 1
#   sayMsg    "JPFns[446]    \$1:'$1',       \$2:'$2',       \$3:'$3',       \$4:'$4',       \$5:'$5',       \$6:'$6',       \$7:'$7',       \$8:'$8',       \$9:'$9' " 1

#   if [ "${bQuiet}" != "1" ]; then getOpt "qu" "-q";  bQuiet=${nOpt}; fi; sayMsg "JPT12[114]  bQuiet: '${bQuiet}'"
#   if [ "${bDebug}" != "1" ]; then getOpt "-d" "-de"; bDebug=${nOpt}; fi; sayMsg "JPT12[115]  bDebug: '${bDebug}'"
#   if [ "${bDoit}"  != "1" ]; then getOpt "do" "-do"; bDoit=${nOpt};  fi; sayMsg "JPT12[116]  bDoit:  '${bDoit}'"

#   aCmd0="${aArg1} ${aArg2} ${aArg3}";   aCmd=""

#   if [ "${aCmd1}" == "aa"       ]; then aCmd="{CmdName}";  nLv=1; fi
#   if [ "${aCmd2}" == "aa-cc"    ]; then aCmd="{CmdName}";  nLv=2; fi
#   if [ "${aCmd2}" == "cc-aa"    ]; then aCmd="{CmdName}";  nLv=2; fi
#   if [ "${aCmd3}" == "cc-bb-aa" ]; then aCmd="{CmdName}";  nLv=3; fi
#   if [ "${aCmd3}" == "aa-bb-cc" ]; then aCmd="{CmdName}";  nLv=3; fi
#   if [ "${aCmd3}" == "bb-aa-cc" ]; then aCmd="{CmdName}";  nLv=3; fi

#   getCmd "aa" "bb" "cc" "CmdName"

#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

#======= ================================================================================================== #  ===========

function  Begin() {

          aArgs="";  aWhat=""; bRan=0;
      for aArg in "$@"; do
          if [ "${aArg/[ *]/}" != "${aArg}" ]; then aArg="\"${aArg}\""; fi;        # Quote arg with "*" or " "
          if [ "${aArg}"       != "${aCmd}" ]; then aArgs="${aArgs} ${aArg}"; fi   # delete "${aCmd} "
          done

 if [ "${aCmd}"     == "help" ]; then bTest=0; fi
 if [ "${bTest}" == "1"       ]; then echo "";
#   echo "  aArgs:${aArgs}"; fi
    fi
          aCmd=$( echo ${aCmd} | tr '[:upper:]' '[:lower:]' )

#         logIt "JPT1-main1" 0 "${aFns/2Fns/1}  ${aCmd}${aArgs}"                                                 # .(80920.02.2)

 if [ "${aCmd}" == "version"  ]; then echo ""; echo $0 | awk '{ gsub( /.+-v|.sh/, "" ); print "  JPT Version: " $0 }'; echo ""; exit; fi
 if [ "${aCmd}" == "source"   ]; then echo ""; echo $0 | awk '{                         print "  JPT Script File(s): \""  $0 "\"" }';                fi
 if [ "${aCmd}" == "source"   ]; then echo $aFns       | awk '{                         print "                      \""  $0 "\"" }'; echo ""; exit; fi

    } # eof Begin
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

#======= ================================================================================================== #  ===========

function  Run() {

    aTyp="$1 "; aTyp=${aTyp:0:2}     # .(80916.02.1 RAM was: nLv=$1)
    nLv="${aTyp:0:1}"                # .(80916.02.2)
    aAct=${aTyp:1:1}                 # .(80916.02.3)
    aPath=$2
    aScript=$3
    aExt1=$( echo ${aScript} | awk '{ gsub( /[-_]v.+[0-9]/, "" ); print }' ); aExt=${aExt1##*.}
    bJPT=$(  echo ${aScript} | awk '/JPT[0-9]*-/ { print 1 }' ); if [ "${bJPT}" == "" ]; then bJPT=0; fi       # .(80920.01.1)
    aWhat=" Script for"
                                         aDrv1="${aDrv}"; aSRC=""
                                         aVOL1="${aVOL}"; aVOL2="${aVol}"

 if [ "${aAct}"     == "r"      ]; then aDrv1=""    ; fi
 if [ "${aAct}"     == "c"      ]; then aDrv1="C:"  ; fi
 if [ "${nLv}"      == "0"      ]; then aDrv1="C:"  ; fi
 if [ "${nLv}"      == "7"      ]; then aVOL1="${aDrv1}/VOLs/U06"  ; fi
 if [ "${aAct}"     == "r"      ]; then aVOL1=""; aVOL2="/nfs/u06" ; fi

 if [ "${aExt}" == "${aExt1}"   ]; then aSRC="bin/" ; fi
 if [ "${aExt}" == "cmd"        ]; then aSRC="cmds/"; fi
 if [ "${aExt}" == "sh"         ]; then aSRC="JSHs/"; fi
#if [ "${aExt}" == "js"         ]; then aSRC="JPTs/"; fi
 if [ "${aExt}" == "njs"        ]; then aSRC="NJSs/"; fi
 if [ "${aExt}" == "bat"        ]; then aSRC="BATs/"; fi
#if [ "${aScript:0:3}" == "JPT" ]; then aSRC="JPTs/"; fi                                ##.(80920.01.2)
 if [ "${bJPT}" == "1"          ]; then aSRC="JPTs/"; fi                                # .(80920.01.2)

 if [ "${bQuiet}" == "0"        ]; then
     echo "          ${nLv}${aAct} bJPT: ${bJPT},  aSRC: ${aSRC}, ${aScript}, aExt: ${aExt}, aDrv1: ${aDrv1}, aVOL1: ${aVOL1}"; fi

 if [ "${nLv}"  == "0"          ]; then aPrg="${aDrv1}/Home/_0/${aSRC}${aScript}";     fi
 if [ "${nLv}"  == "1"          ]; then aPrg="${aDrv1}/${aPath}/_1/${aSRC}${aScript}"; fi
 if [ "${nLv}"  == "2"          ]; then aPrg="${aDrv1}/${aPath}/_2/${aSRC}${aScript}"; fi
 if [ "${nLv}"  == "3"          ]; then aPrg="${aDrv1}/${aPath}/_3/${aSRC}${aScript}"; fi
 if [ "${nLv}"  == "7"          ]; then aPrg="${aVOL1}/${aPath}/_1/${aSRC}${aScript}"; fi
 if [ "${nLv}"  == "8"          ]; then aPrg="${aVOL2}/${aPath}/_1/${aSRC}${aScript}"; fi
 if [ "${nLv}"  == "9"          ]; then aPrg="${aVOL2}/_0/${aSRC}${aScript}";          fi

 if [ -f "${aPrg}"              ]; then aOK="Found"; else aOK="Missing "; fi

 if [ "${bTest}" == "1" ]; then

#   aEnbl=acdgwru                                                                       ##.(80916.02.8)
#   echo "is ax in aAct: \"${aAct##*ax*}\"" # -z "${string##*$reqsubstr*}"
#   echo "  for \"${aTyp}\", is x in aAct: \"${aAct}\"? \"${aAct##*x*}\""

#if [ "${aAct##*x*}"     ==  "" ]; then                                                 ##.(80916.02.4).(80916.02.9)
#if [ "${aEnbl##*$aAct*" !=  "" ]; then                                                 ##.(80916.02.6)
 if [ "${aAct}"          == "x" ]; then                                                 # .(80916.02.9)
 if [ "${aOK}"  ==      "Found" ]; then aOK="Disabled"; fi; else                        # .(80916.02.5)
 if [ "${aOK}"  ==      "Found" ]; then aOK="Enabled "; fi; fi;                         # .(80916.02.7)

#   echo "***"
#   echo "  jpt ${aCmd} ${nLv} ${aPath} ${aScript}"
    echo "  jpt ${aCmd} ${aTyp} ${aOK} \"${aPrg}\"${aArgs}"                             # .(80916.02.6 was: {nLv}
#   echo ""

  else

    if [ "${aOK}" != "Found" ]; then
    if [ "${bQuiet}" == "1"     ]; then return; fi

        echo ""
        echo "* JPT Tool Script, ${aCmd}, NOT FOUND"
        echo "   (\"${aPrg}\")"
        return;

      else
    if [ "${aAct}" != "x" ]; then                                                      # .(80917.01.1)
    if [ "${bQuiet}" != "1"  ]; then
        echo ""; echo "  run \"${aPrg}\" ${aArgs} (${aTyp})";
        echo "  ------------------------------------------------------------"
        fi

        logIt "JPT1-main1" 1 "${aPrg}  ${aArgs}"                                        # .(80920.02.3)

        ${aPrg} ${aArgs}; bRan=1
        exit
        fi; fi                                                                          # .(80917.01.2)
    fi
    }
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

#======= ================================================================================================== #  ===========

function isDir( ) {                                                                     # .(20623.02.2 RAM Beg Added)
         aFind="$1";        bChildOk=$3;  bRootOnly=$2
         aChild=""; if [ "${bChildOk}"  == "1" ]; then aChild="/.+"; fi
         aRoot="?"; if [ "${bRootOnly}" == "1" ]; then aRoot="$";    fi
         aDir="$( pwd | awk '{ nPos = match( tolower($0), "'"/${aFind}(${aChild})${aRoot}"'", a ); print a[0] }' )"
 echo "${aDir:1}"
    }                                                                                   # .(20623.02.2 RAM End)
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

#======= ================================================================================================== #  ===========

function End() {

    if [ "${aWhat}" == ""  ]; then
    if [ "${bTest}" != "1" ]; then echo ""; fi; bTest=0; fi
    if [ "${bTest}" == "1" ]; then echo ""; return; fi
    if [ "${bRan}"  == "0" ]; then
    if [ "${aWhat}" != ""  ]; then echo ""; aWhat="Script for Tool"; else aWhat="Tool"; fi

       echo "* JPT ${aWhat}, ${aCmd}, NOT FOUND"
    if [ "${aWhat}" == ""  ]; then Help; else echo ""; fi
       fi
    }
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------
#*\
##SRCE     +====================+===============================================+
##RFILE    +====================+=======+===================+======+=============+
#*/
