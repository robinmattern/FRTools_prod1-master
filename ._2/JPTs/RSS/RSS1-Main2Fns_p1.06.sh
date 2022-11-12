#!/bin/bash
#*\
##=========+====================+================================================+
##RD         RSS Launcher Fns   | RSS Common Functions
##RFILE    +====================+=======+===================+======+=============+
##FD   RSS1-Main2Fns.sh         |  10833|  3/15/18 21:00|   198| v1.05.90315.2100
##FD   RSS1-Main2Fns.sh         |  15109| 11/12/22 15:56|   246| p1.06-21112-1556
##FD   RSS1-Main2Fns.sh         |  16988| 11/12/22 18:20|   265| p1.06-21112-1820
##DESC     .--------------------+-------+-------------------+------+------------+
#
#
##LIC      .--------------------+----------------------------------------------+
#            Copyright (c) 2018 SicommNet-JSW * Released under
#            MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+-------+-------------------+------+-----------+
#
##CHGS     .--------------------+-------+-------------------+------+-----------+
# .(80916.02  9/16/18 RAM  8:50a| Break out $nLv and $aAct
# .(80917.01  9/17/18 RAM  4:10p| Fix bug when $aAct = x
# .(80920.01  9/20/18 RAM  1:20p| Put JPTnn..sh scripts into JPTs not JSHs
# .(80920.02  9/20/18 RAM  2:45p| Add logIt()
# .(80923.02  9/23/18 RAM  9:45a| Change JPT to LIB
# .(80925.01  9/25/18 RAM  2:45a| Use ${!LIB_LOG} to get ${LIB}
# .(80925.02  9/25/18 RAM  2:45a| Add ${aAct} == D
# .(80926.01  9/25/18 RAM 12:45a| Add RSS_Vars
# .(90315.01  3/15/19 RAM 10:45a| Add 1n -> N: as location for NFS on WIndows
# .(90321.01  3/21/19 RAM 12:15p| Change aVol to aNFS
# .(90321.02  3/21/19 RAM  1:15p| Set NFS & VOLs from SCN_DRIVES
# .(90326.01  3/26/19 RAM 13:45p| Add aVars = {Lib}-Parms.sh and source it
# .(90326.02  3/26/19 RAM  1:45p| Set NFS & VOLs in {Lib}1-Parms.sh
# .(21112.02 11/12/22 RAM 11:50a| Export useful variables
# .(21112.04 11/12/22 RAM  4:30p| Change SCN_SERVER to THE_SERVER
# .(21112.05 11/12/22 RAM  6:20p| Set THE_SERVER if not set

##PRGM     +====================+===============================================+
##ID 69.600. Main               |
##SRCE     +====================+===============================================+
#*/
           if [ "${LIB}" == "" ]; then LIB=RSS; Lib=RSS; fi                                 # .(80926.01.1)
#         LIB=RSS; LIB_LOG=${LIB}_LOG; LIB_USER=${LIB}_USER; Lib=rss                        ##.(80923.02.1).(80925.01.1)
                   LIB_LOG=${LIB}_LOG; LIB_USER=${LIB}_USER                                 # .(80925.01.2
                   LIB_LOG=${!LIB_LOG} LIB_USER=${!LIB_USER}                                # .(80925.01.1 uses Indirect Expansion)

#         bQuiet=0; bTestFns=1   # setOS and Run are called by calling script if bTestFns=0 # .(90326.01.3)

function  logIt() {                                                                         # .(80920.02.1)
          aFncLine="$1[$2]             "; aFncLine="${aFncLine:0:17} $3";
#         aFncLine="${aFncLine/ \//\/}";  aFncLine="${aFncLine/ C:/C:}";  aFncLine="${aFncLine/ D:/D:}";  aFncLine="${aFncLine/ M:/M:}";
 if [ -f "$LIB_LOG" ]; then echo "$( date '+%Y%m%d-%H%M%S%z')  ${THE_SERVER:0:11} ${LIB_USER:0:8}  ${aFncLine}" >>"$LIB_LOG"; fi   # .(21112.04.1)
          }
          aLFdr=$( echo $0 | awk '{ gsub( /[//\\][^//\\]*$/, ""    ); print }' ); aNFS="_"  # .(90326.01.4 RAM)
          aVars=${aLFdr}/${LIB}1-Parms.sh; if [ -f "${aVars}" ]; then source "${aVars}"; fi # .(90326.01.5 RAM)
          aCmd=

# +------- +------------------ +----------------------------------------------------------- # ------------+ ------------------- # --------------+

function  setOS() {

     if [ "${OS:0:7}"     == "Windows" ]; then aOSv="w10p"; aName="Windows"; fi                                                 # .(21112.05.1 RAM Is it Windows)
     if [ "${OSTYPE:0:5}" == "linux"   ]; then aOSv="linx"; aName="Linux";   fi                                                 # .(21112.05.2 RAM Is it Linux)
     if [ -f "/etc/issue" ]; then aOSv=$( cat "/etc/issue" | awk '/Ubuntu/ { print "ub" substr($0,8,2) }' ); fi                 # .(21112.05.3 RAM Is it Ubuntu)
     if [ "${aOSv:0:2}"   == "ub"      ]; then              aName="Ubuntu";  fi                                                 # .(21112.05.4)

# if [ "${THE_DRIVES}" == "" ]; then echo ""; echo "* \$THE_DRIVES is NOT DEFINED; NFS Vol won't be correct";  exit; fi         # .(90321.02.1)
  if [ "${THE_SERVER}" == "" ]; then echo ""; echo "* \$THE_SERVER is NOT Defined; OS will probably be incorrect"
        THE_SERVER="${HOSTNAME:0:6}-${aOSv}_${aName}-Prod1 (127.0.0.1)";  echo "  Setting it to \"${THE_SERVER}\""              # .(21112.05.5)
#                               echo "Info/RSS22-Info.sh vars set THE_SERVER   ${THE_SERVER}"
        export aOSv                                                                                                             # .(21112.05.6 RAM Needed for set vars)
        $( dirname "${BASH_SOURCE}" )/Info/RSS22-Info.sh vars set THE_SERVER  "${THE_SERVER}"
        exit
        fi
        # exit; fi  # .(21112.04.2)

     aTHE_SERVER=$( echo $THE_SERVER | tr '[:upper:]' '[:lower:]' )                                                             # .(21112.04.3 RAM BEG)
     aIP=${aTHE_SERVER##* (}; aIP=${aIP//)/}

     aSvr=${aTHE_SERVER%%_*}
     aOSv=${aSvr##*-}   # Delete everything before -
     aSvr=${aSvr%%-*}   # Delete everything after -
     aTHE_SERVER=${aTHE_SERVER// (*}                                                  # .(90326.04.1 Delete everything after " (").(21112.04.3 RAM End)
#    echo "setOS[1]  bTest: ${bTest}, bQuiet: ${bQuiet}, aSvr: ${aSvr}, aOSv: ${aOSv}, aIP: ${aIP}"; exit

     bGFW1=$( echo $PATH | awk '/\/(git|Git)\/usr\// { print 1 }' )                                                             # .(21112.05.7 RAM Check if /git/usr/bin in path)
  if [ "${bGFW1}" == "1" ]; then                                                                                                # .(21112.05.8 RAM Was if [ "${ConEmuTask}" != "" ])
     aOSv="gfw1"
     fi
                                         aDrv=""
  if [ "${aOSv:0:1}" == "g"      ]; then aDrv="/c"  ; fi
  if [ "${aOSv:0:1}" == "w"      ]; then aDrv="C:"  ; fi
  if [ "${aOSv}"     == "w08s"   ]; then aDrv="D:"  ; fi

  if [ "${aNFS}"     == "_"      ]; then aVOL=""            ; aNFS="/nfs/u06"               # .(90326.02.1)
  if [ "${aOSv:0:1}" == "g"      ]; then aVOL="c/vols/u06"                    ; fi
  if [ "${aOSv:0:1}" == "w"      ]; then aVOL="C:/VOLs/U06"                   ; fi

# if [ "${aOSv}"     == "w10p"   ]; then                      aNFS="M:/U06"   ; fi          ##.(90315.01.3 M: is now N:)
  if [ "${aOSv}"     == "w10p"   ]; then                      aNFS="N:/U06"   ; fi          # .(90315.01.3 M: is now N:)
# if [ "${aOSv}"     == "w08s"   ]; then aVOL="D:/VOLs/U06" ; aNFS="M:/U06"   ; fi          ##.(90315.01.4 M: is now N:)
  if [ "${aOSv}"     == "w08s"   ]; then aVOL="D:/VOLs/U06" ; aNFS="N:/U06"   ; fi          # .(90315.01.4 M: is now N:)
     fi                                                                                     # .(90326.02.2)

     export aOSv                                                                                                                # .(21112.02.1 RAM Export aOSv)

  if [ "${bQuiet}"   == "0"      ] || [ "1" == "0" ]; then
     aCmd0="${aCmd}                       "; aCmd0="${aCmd0:0:23}";
     echo "  THE_SERVER: ${aTHE_SERVER}; aSvr: ${aSvr}, aOSv: ${aOSv}, aIP: ${aIP}"                                             # .(21112.04.4)
     echo "        aCmd: ${aCmd0};  aDrv=${aDrv} aVOL=${aVOL}; aNFS=${aNFS};  Main2Fns Lib=${Lib}";
     fi
#    exit
     }
# ----------------------------------------------------------------

function  Begin() {

          aArgs="";  aWhat=""; bRan=0;
      for aArg in "$@"; do
          if [ "${aArg/[ *]/}" != "${aArg}" ]; then aArg="\"${aArg}\""; fi;        # Quote arg with "*" or " "
          if [ "${aArg}"       != "${aCmd}" ]; then aArgs="${aArgs} ${aArg}"; fi   # delete "${aCmd} "
          done

  if [ "${aCmd}"     == "help" ]; then bTest=0; fi
  if [ "${bTest}" == "1"       ]; then echo "";
     fi
          aCmd=$( echo ${aCmd} | tr '[:upper:]' '[:lower:]' )

#         logIt "${LIB}1-main1" 0 "${aFns/2Fns/1}  ${aCmd}${aArgs}"                         # .(80920.02.2).(80923.02.2 Was "JPT1-..)

# ----------------------------------------------------------------------------------------------------------------------------------

  if [ "${aCmd}" == "version"  ]; then echo ""; echo $0 | awk '{ gsub( /.+-v|.sh/, "" ); print "  '$LIB' Version: "          $0      }'; echo ""; exit; fi  # .(80923.02.4 Was "JPT-..)
  if [ "${aCmd}" == "source"   ]; then echo ""; echo $0 | awk '{                         print "  '$LIB' Script File(s): \"" $0 "\"" }';                fi  # .(80923.02.3 Was "JPT-..)
  if [ "${aCmd}" == "source"   ]; then echo $aFncs      | awk '{                         print "                      \""    $0 "\"" }'; echo ""; exit; fi
     }
# ----------------------------------------------------------------------------------------------------------------------------------

function  Run() {

     aTyp="$1 "; aTyp=${aTyp:0:2}     # .(80916.02.1 RAM was: nLv=$1)
     nLv="${aTyp:0:1}"                # .(80916.02.2)
     aAct=${aTyp:1:1}                 # .(80916.02.3)
     aPath=$2
     aScript=$3

     aExt1=$( echo ${aScript} | awk '{ gsub( /[-_]v.+[0-9]/, "" ); print }' ); aExt=${aExt1##*.}
#    bJPT=$(  echo ${aScript} | awk      '/JPT[0-9]*-/    { print 1 }' ); if [ "${bJPT}" == "" ]; then bJPT=0; fi        ##.(80920.01.1).(80923.02.5)

#    bLIB=$(  echo ${aScript} | awk '/'${LIB}'[0-9]*-/    { print 1 }' ); if [ "${bLIB}" == "" ]; then bLIB=0; fi        ##.(80923.02.5).(90327.01.1)
     bLIB=$(  echo ${aScript} | awk '/'${LIB}'[0-9]*[_-]/ { print 1 }' ); if [ "${bLIB}" == "" ]; then bLIB=0; fi        # .(90327.01.1 SB -, but maybe not)
     aWhat=" Script for"
                                         aDrv1="${aDrv}"; aSRC=""
                                         aVOL1="${aVOL}"; aVOL2="${aNFS}"
                                         aVOL3=""

  if [ "${aAct}"     == "r"      ]; then aDrv1=""    ; fi
  if [ "${aAct}"     == "c"      ]; then aDrv1="C:"  ; fi
  if [ "${aAct}"     == "d"      ]; then aDrv1="D:"  ; fi                                  # .(80925.02.1 Added D)
# if [ "${aAct}"     == "m"      ]; then aDrv1="M:"  ; fi                                  ##.(80925.02.1 Added M).(90321.01.1 Don't ever use "m")
# if [ "${aAct}"     == "n"      ]; then aDrv1="N:"  ; fi                                  ##.(90315.01.1 Added N).(90321.01.1 "n" always means NFS)
  if [ "${aAct}"     == "n"      ]; then aDrv1="${aNFS/\\*}"; aDrv1="${aDrv1/\/*/}"; fi    # .(90321.01.1 either Windows Drive "N:" or "")

  if [ "${aAct}"     == "j"      ]; then aDrv1="${aNFS/\\*}";  aDrv1="${aDrv1/\/*/}"; fi    # .(90321.01.1 either Windows Drive "N:" or "")
  if [ "${aAct}"     == "j"      ]; then aDrv1="${aDrv1/\\*}"; aDrv1="${aDrv1/\/*/}"; fi    # .(90321.01.1 either Windows Drive "N:" or "")

  if [ "${nLv}"      == "0"      ]; then aDrv1="C:"  ; fi
  if [ "${nLv}"      == "7"      ]; then aVOL1="${aDrv1}/VOLs/U06"  ; fi
  if [ "${aAct}"     == "v"      ]; then aVOL1="${aDrv1}/VOLs/U06"  ; fi                   # .(80925.02.1 Added v)
  if [ "${aAct}"     == "r"      ]; then aVOL1="";aVOL2="/nfs/u06"  ; fi                   # .(90321.01.2 Isn't it always {aNFS}: /nfs/u06

  if [ "${bTestFns}" == "1"      ]; then aDrv3="${aDrv1}  ";
     echo  "      Run[1]: aAct=${bLIB};  bLIB=${bLIB};  nLv=${nLv};  "
     echo  "      Run[2]: aScr=${aSvr};  aOSv=$aOSv;  aDrv=${aDrv} aVOL=${aVOL};  aDrv1=${aDrv3:0:3} aNFS=${aNFS};  Main1    LIB=${LIB}"; exit; fi

  if [ "${aExt}" == "${aExt1}"   ]; then aSRC="bin/" ; fi
  if [ "${aExt}" == "cmd"        ]; then aSRC="cmds/"; fi
  if [ "${aExt}" == "sh"         ]; then aSRC="JSHs/"; fi
  if [ "${aExt}" == "njs"        ]; then aSRC="NJSs/"; fi
  if [ "${aExt}" == "bat"        ]; then aSRC="BATs/"; fi
# if [ "${aExt}" == "js"         ]; then aSRC="JPTs/"; fi
# if [ "${aScript:0:3}" == "JPT" ]; then aSRC="JPTs/"; fi                                   ##.(80920.01.2)
# if [ "${bJPT}" == "1"          ]; then aSRC="JPTs/"; fi                                   ##.(80920.01.2).(80923.02.6)

  if [ "${bLIB}" == "1"          ]; then aSRC="${LIB}s/"; fi                                # .(80923.02.6)

  if [ "${bQuiet}" == "0"        ]; then
     echo "           ${nLv}${aAct} bLIB: ${bLIB},  aSRC: ${aSRC},    ${aScript},  aExt: ${aExt},  aDrv1: ${aDrv1},  aVOL1: ${aVOL1}"; fi  # .(80923.02.7 Was "JPT1-..)

  if [ "${nLv}"  == "0"          ]; then aPrg="${aDrv1}/Home/_0/${aSRC}${aScript}";     fi
  if [ "${nLv}"  == "1"          ]; then aPrg="${aDrv1}/${aPath}/_1/${aSRC}${aScript}"; fi
  if [ "${nLv}"  == "2"          ]; then aPrg="${aDrv1}/${aPath}/_2/${aSRC}${aScript}"; fi
  if [ "${nLv}"  == "3"          ]; then aPrg="${aDrv1}/${aPath}/_3/${aSRC}${aScript}"; fi
  if [ "${nLv}"  == "7"          ]; then aPrg="${aVOL1}/${aPath}/_1/${aSRC}${aScript}"; fi
  if [ "${nLv}"  == "8"          ]; then aPrg="${aVOL2}/${aPath}/_1/${aSRC}${aScript}"; fi
  if [ "${nLv}"  == "9"          ]; then aPrg="${aVOL2}/_0/${aSRC}${aScript}";          fi

  if [ -f "${aPrg}"              ]; then aOK="Found"; else aOK="Missing "; fi

# --------------------------------------------------------------------------------------------------

  if [ "${bTest}" == "1" ]; then

#    aEnbl=acdgwru                                                                          ##.(80916.02.8)
#    echo "is ax in aAct: \"${aAct##*ax*}\"" # -z "${string##*$reqsubstr*}"
#    echo "  for \"${aTyp}\", is x in aAct: \"${aAct}\"? \"${aAct##*x*}\""

# if [ "${aAct##*x*}"     ==  "" ]; then                                                    ##.(80916.02.4).(80916.02.9)
# if [ "${aEnbl##*$aAct*" !=  "" ]; then                                                    ##.(80916.02.6)  # }
  if [ "${aAct}"          == "x" ]; then                                                    # .(80916.02.9)
  if [ "${aOK}"  ==      "Found" ]; then aOK="Disabled"; fi; else                           # .(80916.02.5)
  if [ "${aOK}"  ==      "Found" ]; then aOK="Enabled "; fi; fi;                            # .(80916.02.7)

     aLibCmd="$Lib ${aCmd}           "; aLibCmd=$( echo "${aLibCmd:0:11}" | tr '[:upper:]' '[:lower:]' )  # .(90327.04.2)
#    echo "***"
#    echo  "  jpt ${aCmd} ${nLv} ${aPath} ${aScript}"
#    echo "   $Lib ${aCmd1} ${aTyp} ${aOK} \"${aPrg}\"${aArgs}"                             # .(80916.02.6 was: {nLv}).(80923.02.8 Was jpt ${aCmd})
     echo "  ${aLibCmd} ${aTyp} ${aOK} \"${aPrg}\"${aArgs}"                                 # .(90327.04.2)
#    echo ""

# -----------------------------------------------------------------------------------------
   else

     if [ "${aOK}" != "Found" ]; then
     if [ "${bQuiet}" == "1"     ]; then return; fi

        echo ""
        echo "* $LIB Tool Script, ${aCmd}, NOT FOUND"                                       # .(80923.02.9 Was JPT Tool)
        echo "   (\"${aPrg}\")"
        return;

      else

     if [ "${aAct}" != "x" ]; then                                                          # .(80917.01.1)
     if [ "${bQuiet}" != "1"  ]; then
        echo ""; echo "  run \"${aPrg}\" ${aArgs} (${aTyp})";
        echo "  --------------------------------------------------------------------------"
        fi

# echo  logIt "${LIB}1-main1" 1 "${aPrg} ${aArgs}"
        logIt "${LIB}1-main1" 1 "${aPrg} ${aArgs}"                                          # .(80920.02.3).(80923.02.10 Was JPT1-..)

        ${aPrg} ${aArgs}; bRan=1                                                            #  RUN IT HERE !
        exit
        fi; fi                                                                              # .(80917.01.2)
     fi
# -----------------------------------------------------------------------------------------
     }
# ----------------------------------------------------------------------------------------------------------------------------------

function End() {

    if [ "${aWhat}" == ""  ]; then
    if [ "${bTest}" != "1" ]; then echo ""; fi; bTest=0; fi
    if [ "${bTest}" == "1" ]; then echo ""; return; fi
    if [ "${bRan}"  == "0" ]; then
    if [ "${aWhat}" != ""  ]; then echo ""; aWhat="Script for Tool"; else aWhat="Tool"; fi

       echo "* $LIB ${aWhat}, ${aCmd}, NOT FOUND"                                           # .(80923.02.11 Was JPT ${aWhat})
    if [ "${aWhat}" == ""  ]; then Help; else echo ""; fi
       fi
    }
# ----------------------------------------------------------------------------------------------------------------------------------

    if [ "${bTestFns}" == "1" ]; then setOS; Run "1n"; exit; fi                             # .(90326.02.3)
#*\
##SRCE     +====================+===============================================+
##RFILE    +====================+=======+===================+======+=============+
#*/
