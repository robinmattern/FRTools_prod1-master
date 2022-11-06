#!/bin/bash
#*\
##=========+====================+================================================+
##RD         JPT Launcher Fns   | JPT Common Functions
##RFILE    +====================+=======+===============+======+=================+
##FD   JPT12_Main2Fns.sh        |  27951|  5/04/22 19:38|   462| p1.06-20504-1938
##FD   JPT12_Main2Fns.sh        |  27747|  5/03/22 19:37|   459| p1.06-20503-1937
##FD   JPT12_Main2Fns.sh        |  25287|  5/03/22 15:43|   427| p1.06-20503-1543
##FD   JPT12_Main2Fns.sh        |  25850|  5/03/22 13:33|   434| p1.06-20503-1333
##FD   JPT12_Main2Fns.sh        |  24586|  5/03/22  9:09|   407| p1.06-20503-0909
##DESC     .--------------------+-------+---------------+------+-----------------+
#
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
#            setLv()            |
#            getCmd()           |
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

##PRGM     +====================+===============================================+
##ID 69.600. Main               |
##SRCE     +====================+===============================================+
#*/
#    ------ ------------------  =  ---------------------------------------------------  #  ----------------

function  setOS() {

  if [ "${SCN_SERVER}" == "" ]; then echo ""; echo "* \$SCN_SERVER NOT DEFINED; OS will probably be incorrect"; exit; fi

     aSCN_SERVER=$( echo $SCN_SERVER | tr '[:upper:]' '[:lower:]' )
     aIP=${aSCN_SERVER##* (}; aIP=${aIP//)/}

     aSvr=${aSCN_SERVER%%_*}
     aOSv=${aSvr##*-}
     aSvr=${aSvr%%-*}
#    echo "  - JPFns[ 62]  bTest: ${bTest}, bQuiet: ${bQuiet}, aSvr: ${aSvr}, aOSv: ${aOSv}, aIP: ${aIP}"; # exit

  if [ "${ConEmuTask}" != "" ]; then
     aOSv=gfw1
     fi
                                         aDrv=""
  if [ "${aOSv:0:1}" == "g"    ]; then aDrv="/c"  ; fi
  if [ "${aOSv:0:1}" == "w"    ]; then aDrv="C:"  ; fi
  if [ "${aOSv}"     == "w08s" ]; then aDrv="D:"  ; fi

                                       aVOL=""            ; aVol="/nfs/u06"
  if [ "${aOSv:0:1}" == "g"    ]; then aVOL="c/vols/u06"                    ; fi
  if [ "${aOSv:0:1}" == "w"    ]; then aVOL="C:/VOLs/U06"                   ; fi
  if [ "${aOSv}"     == "w10p" ]; then                      aVol="M:/U06"   ; fi
  if [ "${aOSv}"     == "w08s" ]; then aVOL="D:/VOLs/U06" ; aVol="M:/U06"   ; fi

  if [ "${bDebug}"   == "1"    ]; then                                                                      # .(20503.05.1 RAM was if bQuiet = 0)
     echo "  - JPFns[ 79]  SCN_SERVER: ${aSCN_SERVER}; aSvr: ${aSvr}, aOSv: ${aOSv}, aIP: ${aIP}"
     echo "  - JPFns[ 80]  aCmd: ${aCmd}; aDrv: ${aDrv}, aVOL: ${aVOL}, aVol: ${aVol}";
     fi
#    echo "  - JPFns[ 82]  bTest: ${bTest}, bQuiet: ${bQuiet}, aSvr: ${aSvr}, aOSv: ${aOSv}, aIP: ${aIP}"; exit

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

function sayMsg( ) {  aMsg="$1"; aSp=""; aSP=$3 # aSp=" -- space --";

  bDebug1=${bDebug};  if [ "$2" != "" ]; then bDebug1=$2; fi
    if [ "${bDebug1}" == "0" ]; then return; fi;
    if [ "${aMsg}" == "sp" ] && [ "${bDebug}" == "1"  ];  then aSP=1; bSpace=0; fi      # .(20502.02.1)

#    echo ""; echo "-1- bDebug: '${bDebug}', \$2: '$2'; bSpace: '${bSpace}',  bDebug1: '${bDebug1}' != '3', aMsg: '${aMsg}'"

#   if [ "${aMsg}"    == ""  ] || [ "${aMsg}" == "sp" ];  then bSpace=$(( 1 - bSpace )); aMsg="$2"; bDebug1=$3;   aSP=$4; fi    # toggle bSpace
    if [ "${aMsg}"    == ""  ] || [ "${aMsg}" == "sp" ];  then bSpace=$(( 1 - bSpace )); aMsg="$2"; bDebug1=$aSP; aSP=$4; fi    # toggle bSpace  # .(20502.02.1 Keep bDebug if set)
    if [ "${bDebug1}" == ""  ]; then return; fi                                                                                 # bDebug1 can't be ''

#             echo "-2- bDebug1: '${bDebug1}', \$2: '$2'; bSpace: '${bSpace}',  bDebug: '${bDebug}' != '3', aMsg: '${aMsg}'"

    if [ "${bSpace}"  == "1" ] && [ "${bDebug1}" != "3" ]; then echo "${aSp}"; bSpace=0; fi                                     # A leading space has been displayed, print one next
    if [ "${bDebug1}" == "1" ]; then echo "  - ${aMsg}"; fi
    if [ "${bDebug1}" == "2" ]; then echo " ** ${aMsg}"; ${aLstSp}; exit; fi            # .(10706.09.2)
    if [ "${bDebug1}" == "3" ]; then echo     "${aMsg}"; fi
    if [ "${aSP}"    == "sp" ]; then echo "";  bSpace=0; fi                             #                                       A trailing space has been displayed, don't print one next

#             echo "-3- bDebug1: '${bDebug1}', aSP: '$aSP'"
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

#   sayMsg    "JPFns[162]  aArg1: '$aArg1', aArg2: '$aArg2', aArg3: '$aArg3', aArg4: '$aArg4', aArg5: '$aArg5', aArg6: '$aArg6', aArg7: '$aArg7', aArg8: '$aArg8', aArg9: '$aArg9' " 2

    } # eof setArgs
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

#======= ================================================================================================== #  ===========

function getOpts() {

    if [ "${1/b/}" != "$1" ]; then if [ "${bDebug}"  != "1" ]; then getOpt "-b" "-de";  export bDebug=${nOpt};  fi; sayMsg "JPFns[171]  bDebug:  '${bDebug}'"  ; fi   # .(20501.01.3)
    if [ "${1/d/}" != "$1" ]; then if [ "${bDoit}"   != "1" ]; then getOpt "-d" "doit"; export bDoit=${nOpt};   fi; sayMsg "JPFns[172]  bDoit:   '${bDoit}'"   ; fi   # .(20501.01.5)
    if [ "${1/q/}" != "$1" ]; then if [ "${bQuiet}"  != "1" ]; then getOpt "-q" "qu";   export bQuiet=${nOpt};  fi; sayMsg "JPFns[173]  bQuiet:  '${bQuiet}'"  ; fi   # .(20501.01.4)
    if [ "${1/g/}" != "$1" ]; then if [ "${bGlobal}" != "1" ]; then getOpt "-g" "glo";  export bGlobal=${nOpt}; fi; sayMsg "JPFns[174]  bGlobal: '${bGlobal}'" ; fi
#   if [ "${1/l/}" != "$1" ]; then if [ "${bLocal}"  != "1" ]; then getOpt "-l" "loc";  export bLocal=${nOpt};  fi; sayMsg "JPFns[175]  bLocal:  '${bLocal}'"  ; fi

    } # eof getOpts
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

#======= ================================================================================================== #  ===========

function getOpt( ) {
#   sayMsg sp "JPFns[183]  aARG1:'${mARGs[0]}', aARG2:'${mARGs[1]}', aARG3:'${mARGs[2]}', aARG4:'${mARGs[3]}', aARG5:'${mARGs[4]}', aARG6:'${mARGs[5]}', aARG7:'${mARGs[6]}', aARG8:'${mARGs[7]}' " 1
#   sayMsg    "JPFns[184]  aArg1:'$aArg1', aArg2:'$aArg2', aArg3:'$aArg3', aArg4:'$aArg4', aArg5:'$aArg5', aArg6:'$aArg6', aArg7:'$aArg7', aArg8:'$aArg8', aArg9:'$aArg9' " 1 # Called 3 or 4 files

                                                   w=${#2};            nOpt=0; mKeep=( 0 1 2 3 4 5 6 7 8 )
    if [ "${aArg1:0:2}" == "$1" ] || [ "${aArg1:0:$w}" == "$2" ]; then nOpt=1; mKeep=(   1 2 3 4 5 6 7 8 ); aArg1="$aArg2"; aArg2="$aArg3"; aArg3="$aArg4"; aArg4="$aArg5"; aArg5="$aArg6"; aArg6="$aArg7"; aArg7="$aArg8"; fi
    if [ "${aArg2:0:2}" == "$1" ] || [ "${aArg2:0:$w}" == "$2" ]; then nOpt=1; mKeep=( 0   2 3 4 5 6 7 8 );                 aArg2="$aArg3"; aArg3="$aArg4"; aArg4="$aArg5"; aArg5="$aArg6"; aArg6="$aArg7"; aArg7="$aArg8"; fi
    if [ "${aArg3:0:2}" == "$1" ] || [ "${aArg3:0:$w}" == "$2" ]; then nOpt=1; mKeep=( 0 1   3 4 5 6 7 8 );                                 aArg3="$aArg4"; aArg4="$aArg5"; aArg5="$aArg6"; aArg6="$aArg7"; aArg7="$aArg8"; fi
    if [ "${aArg4:0:2}" == "$1" ] || [ "${aArg4:0:$w}" == "$2" ]; then nOpt=1; mKeep=( 0 1 2   4 5 6 7 8 );                                                 aArg4="$aArg5"; aArg5="$aArg6"; aArg6="$aArg7"; aArg7="$aArg8"; fi
    if [ "${aArg5:0:2}" == "$1" ] || [ "${aArg5:0:$w}" == "$2" ]; then nOpt=1; mKeep=( 0 1 2 3   5 6 7 8 );                                                                 aArg5="$aArg6"; aArg6="$aArg7"; aArg7="$aArg8"; fi
    if [ "${aArg6:0:2}" == "$1" ] || [ "${aArg6:0:$w}" == "$2" ]; then nOpt=1; mKeep=( 0 1 2 3 4   6 7 8 );                                                                                 aArg6="$aArg7"; aArg7="$aArg8"; fi
    if [ "${aArg7:0:2}" == "$1" ] || [ "${aArg7:0:$w}" == "$2" ]; then nOpt=1; mKeep=( 0 1 2 3 4 5   7 8 );                                                                                                 aArg7="$aArg8"; fi
    if [ "${aArg8:0:2}" == "$1" ] || [ "${aArg8:0:$w}" == "$2" ]; then nOpt=1; mKeep=( 0 1 2 3 4 5 6   8 );                                                                                                                 fi

#   sayMsg    "JPFns[196]  getOpt( '$1' '$2' ) -> mKeep: '${mKeep[*]}'" 1

    mARgs=(); for i in ${mKeep[@]}; do mARgs+=( ${mARGs[$i]} ); done; mARGs=( ${mARgs[@]} )

    sayMsg    "JPFns[200]  mARGs[$i]:'${mARGs[$i]}', mARgs: '${mARgs[*]}'"
#   done; mARGs=( ${mARgs[@]} )

#   sayMsg sp "JPFns[203]  \$1: '$1', \$2: '$2' -- nOpt:  ${nOpt}" 1 # sp
#   sayMsg    "JPFns[204]  aArg1:'$aArg1', aArg2:'$aArg2', aArg3:'$aArg3', aArg4:'$aArg4', aArg5:'$aArg5', aArg6:'$aArg6', aArg7:'$aArg7', aArg8:'$aArg8', aArg9:'$aArg9' " 1 # Called 3 or 4 files
#   sayMsg    "JPFns[205]  aARG1:'${mARGs[0]}', aARG2:'${mARGs[1]}', aARG3:'${mARGs[2]}', aARG4:'${mARGs[3]}', aARG5:'${mARGs[4]}', aARG6:'${mARGs[5]}', aARG7:'${mARGs[6]}', aARG8:'${mARGs[7]}' " 1

    } # eof getOpt
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

#======= ================================================================================================== #  ===========

function setCmds( ) {
    aCmd=""

#   aCmd0="${aArg1} ${aArg2} ${aArg3}";

    aCmd1=${aArg1:0:2};                               aCmd1=${aCmd1/ls/li}; # .(20429.09.8)
    aSub1=${aArg2:0:2};    aCmd2=${aCmd1}-${aSub1};   aSub1=${aSub1/ls/li}; # .(20429.09.9)
    aSub2=${aArg3:0:2};    aCmd3=${aCmd2}-${aSub2};   aSub2=${aSub2/ls/li}; # .(20429.09.10)

    if [ "${aCmd1}" == "he" ] || [ "${aCmd1}" == "" ]; then aCmd0="help"; fi

    sayMsg    "JPFns[223]  aCmd:   '${aCmd}', aCmd1: '${aCmd1}', aCmd2: '${aCmd2}', aCmd3: '${aCmd3}', aCmd0: '${aCmd0}' "

    } # eof setCmds
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

#======= ================================================================================================== #  ===========

function setLv() {
#   sayMsg    "JPFns[231]  nLv: $1, aArg1:'$aArg1', aArg2:'$aArg2', aArg3:'$aArg3', aArg4:'$aArg4', aArg5:'$aArg5', aArg6:'$aArg6', aArg7:'$aArg7' " 1

    if [ "$1" == "1" ]; then aArg1="${aArg2}"; aArg2="${aArg3}"; aArg3="${aArg4}"; aArg4="${aArg5}"; aArg5="${aArg6}"; aArg6="${aArg7}"; aArg7="${aArg8}";
                             mARgs=(); mKeep=( 1 2 3 4 5 6 ); for i in ${mKeep[@]}; do mARgs+=( ${mARGs[$i]} ); done; mARGs=( ${mARgs[@]} )
                             fi

    if [ "$1" == "2" ]; then aArg1="${aArg3}"; aArg2="${aArg4}"; aArg3="${aArg5}"; aArg4="${aArg6}"; aArg5="${aArg7}"; aArg6="${aArg8}";
                             mARgs=(); mKeep=(   2 3 4 5 6 ); for i in ${mKeep[@]}; do mARgs+=( ${mARGs[$i]} ); done; mARGs=( ${mARgs[@]} )
                             fi

    if [ "$1" == "3" ]; then aArg1="${aArg4}"; aArg2="${aArg5}"; aArg3="${aArg6}"; aArg4="${aArg7}"; aArg5="${aArg8}";
                             mARgs=(); mKeep=(     3 4 5 6 ); for i in ${mKeep[@]}; do mARgs+=( ${mARGs[$i]} ); done; mARGs=( ${mARgs[@]} )
                             fi

    sayMsg    "JPFns[245]  aCmd:  '${aCmd}', nLv: $1, aArg1:'$aArg1', aArg2:'$aArg2', aArg3:'$aArg3', aArg4:'$aArg4', aArg5:'$aArg5', aArg6:'$aArg6', aArg7:'$aArg7' "
#   sayMsg    "JPFns[246]  aCmd:  '${aCmd}', nLv: $1, aARG1:'${mARGs[0]}', aARG2:'${mARGs[1]}', aARG3:'${mARGs[2]}', aARG4:'${mARGs[3]}', aARG5:'${mARGs[4]}', aARG6:'${mARGs[5]}', aARG7:'${mARGs[6]}' " 1

    return
    } # eof setLv
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

#======= ================================================================================================== #  ===========

function getCmd( ) {

    sayMsg sp "JPFns[256]  aArg1: '${aArg1}', \$1: '$1', \$2: '$2', \$3: '$3', \$4: '$4', aCmd1: '${aCmd1}', aCmd2: '${aCmd2}', aCmd3: '${aCmd3}'"

    if [ "${aCmd}" != "" ]; then return; fi

 if [ "$3" == "" ]; then
    sayMsg    "JPFns[261]  Checking aArg1: '${aArg1}'       == '$1'"
    if [ "${aArg1}" == "$1"       ]; then aCmd="$2"; setLv 1; return; fi   # .(20502.03.1 RAM Special case)
    if [ "${aCmd1}" == "$1"       ]; then aCmd="$2"; setLv 1; return; fi
    fi
#   -----------------------------------------------------

 if [ "$4" == "" ]; then
    sayMsg    "JPFns[268]  Checking aCmd2: '${aCmd2}'    == '$1-$2'    or '$2-$1'"

    if [ "${aCmd2}" == "$1-$2"    ]; then aCmd="$3"; setLv 2; return; fi   # aCmd2 <= ${aArg1:0:2}-${aArg2:0:2}, i.e. entered command
#   if [ "${aCmd3}" == "$1-$2-"   ]; then aCmd="$3"; setLv 2; return; fi

    if [ "${aCmd2}" == "$2-$1"    ]; then aCmd="$3"; setLv 2; return; fi
#   if [ "${aCmd3}" == "$2-$1-"   ]; then aCmd="$3"; setLv 2; return; fi

#   if [ "${aCmd1}" == "$1"       ]; then aCmd="$3"; setLv 1; return; fi
#   if [ "${aCmd3}" == "$1--"     ]; then aCmd="$3"; setLv 1; return; fi
    fi
#   -----------------------------------------------------

    sayMsg    "JPFns[281]  Checking aCmd2: '${aCmd2}'    == '$1-$3'    or '$2-$3'    or '$3-$1'    or '$3-$2'"
    sayMsg    "JPFns[282]  Checking aCmd3: '${aCmd3}' == '$1-$2-$3' or '$1-$3-$2' or '$2-$3-$1' or '$2-$1-$3'  or '$3-$1-$2' or '$3-$2-$1'"

    if [ "${aCmd2}" == "$1-$3"    ]; then aCmd="$4"; setLv 2; return; fi
    if [ "${aCmd2}" == "$2-$3"    ]; then aCmd="$4"; setLv 2; return; fi
    if [ "${aCmd2}" == "$3-$1"    ]; then aCmd="$4"; setLv 2; return; fi
    if [ "${aCmd2}" == "$3-$2"    ]; then aCmd="$4"; setLv 2; return; fi

    if [ "${aCmd3}" == "$1-$2-$3" ]; then aCmd="$4"; setLv 3; return; fi
    if [ "${aCmd3}" == "$1-$3-$2" ]; then aCmd="$4"; setLv 3; return; fi
    if [ "${aCmd3}" == "$2-$3-$1" ]; then aCmd="$4"; setLv 3; return; fi
    if [ "${aCmd3}" == "$2-$1-$3" ]; then aCmd="$4"; setLv 3; return; fi
    if [ "${aCmd3}" == "$3-$1-$2" ]; then aCmd="$4"; setLv 3; return; fi
    if [ "${aCmd3}" == "$3-$2-$1" ]; then aCmd="$4"; setLv 3; return; fi

#   if [ "${aCmd3}" == "$1-$3-"   ]; then aCmd="$4"; setLv 2; return; fi
#   if [ "${aCmd3}" == "$3-$1-"   ]; then aCmd="$4"; setLv 2; return; fi
#   if [ "${aCmd3}" == "$2-$3-"   ]; then aCmd="$4"; setLv 2; return; fi
#   if [ "${aCmd3}" == "$3-$2-"   ]; then aCmd="$4"; setLv 2; return; fi

#   sayMsg sp "JPFns[301]  aCmd1: '${aCmd1}', aCmd2: '${aCmd2}', aCmd3: '${aCmd3}', nLv: '${nLv}'"  2
#   sayMsg sp "JPFns[302]  aArg1:'$aArg1', aArg2:'$aArg2', aArg3:'$aArg3', aArg4:'$aArg4', aArg5:'$aArg5', aArg6:'$aArg6', aArg7:'$aArg7'' " 1

#   if [ "${mLv}" == "1" ]; then aArg1="${aArg2}"; aArg2="${aArg3}"; aArg3="${aArg4}"; aArg4="${aArg5}"; aArg5="${aArg6}"; aArg6="${aArg7}"; aArg7="${aArg8}"; fi
#   if [ "${nLv}" == "2" ]; then aArg1="${aArg3}"; aArg2="${aArg4}"; aArg3="${aArg5}"; aArg4="${aArg6}"; aArg5="${aArg7}"; aArg6="${aArg8}"; fi
#   if [ "${nLv}" == "3" ]; then aArg1="${aArg4}"; aArg2="${aArg5}"; aArg3="${aArg6}"; aArg4="${aArg7}"; aArg5="${aArg8}"; fi

       } # eof getCmd
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

#======= ================================================================================================== #  ===========

#                          aArg1="$1";     aArg2="$2";     aArg3="$3";     aArg4="$4";     aArg5="$5";     aArg6="$6";     aArg7="$7";     aArg8="$8";     aArg9="$9";
#   sayMsg "" "JPT12[131]  aArg1:'$aArg1', aArg2:'$aArg2', aArg3:'$aArg3', aArg4:'$aArg4', aArg5:'$aArg5', aArg6:'$aArg6', aArg7:'$aArg7', aArg8:'$aArg8', aArg9:'$aArg9' " 1
#   sayMsg    "JPT12[132]    \$1:'$1',       \$2:'$2',       \$3:'$3',       \$4:'$4',       \$5:'$5',       \$6:'$6',       \$7:'$7',       \$8:'$8',       \$9:'$9' " 1

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
