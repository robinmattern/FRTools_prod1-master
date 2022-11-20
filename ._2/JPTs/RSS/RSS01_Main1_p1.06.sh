#!/bin/bash
#*\
##=========+====================+================================================+
##RD         RSS Launcher       | Robin's Shell Scripts Command Launcher
##RFILE    +====================+=======+===================+======+=============+
##FD   RSS1-Main1.sh            |   7187|  9/26/18 21:00|   121| v1.5.80925
##FD   RSS1-Main1.sh            |  10534| 11/03/22 16:16|   169| p1.06-21103-1616
##FD   RSS01_Main1.sh           |   7751| 11/03/22 16:16|   134| p1.06-21114-1945
##FD   RSS01_Main1.sh           |   9572| 11/20/22 13:48|   154| p1.06-21120.1348
##FD   RSS01_Main1.sh           |   9734| 11/20/22 14:00|   156| p1.06-21120.1400
##DESC     .--------------------+-------+-------------------+------+------------+
#            Use the commands in this script to manage file resources.
#
#
##LIC      .--------------------+----------------------------------------------+
#            Copyright (c) 2018 SicommNet-JSW * Released under
#            MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+-------+-------------------+------+-----------+
#
##CHGS     .--------------------+-------+-------------------+------+-----------+
# .(80920.02  9/16/18 RAM  3:26p| Change filename structure
# .(80923.01  9/23/18 RAM  8:50p| Change JPT to RSS
# .(80923.03  9/23/18 RAM  9:50a| Change FileList version to v1.5.80923
# .(81007.01 10/07/18 RAM  2:00a| Add DirList
# .(81007.02 10/07/18 RAM  2:00a| Hardcode Main2Fns_v{YMMDD}.sh
# .(90101.02  7/07/21 RAM  9:00p| Add Filelist/RSS21_v1.6.10707.sh
# .(10826.01  8/26/21 RAM 12:00p| Use this one ${LIB_FileList}_v1.7.10826.sh
# .(11010.02 10/10/21 RAM  8:20p| Use this one ${LIB_FileList}.sh
# .(21031.04 10/31/22 RAM  9:14p| Allow for Main2Fns_p1.06.90327
# .(21113.03 11/13/22 RAM  2:00p| Use ../ Main2Fns_p1.07
# .(21113.05 11/13/22 RAM  5:30p| Display Version and Source in Begin
# .(21114.06 11/13/22 RAM  7:45p| Fix Path to sub commands
# .(21120.02 11/20/22 RAM  2:00p| Fix aOSv and aLstSp

##PRGM     +====================+===============================================+
##ID 69.600. Main               |
##SRCE     +====================+===============================================+
#*/
#========================================================================================================== #  ===============================  #

     aVdt="Nov 20, 2022  2:00p"; aVtitle="Robin's Shell Scripts"                                            # .(21113.05.4 RAM Add aVtitle for Version in Begin)
     aVer="$( echo $0 | awk '{  match( $0, /_[dpstuv][0-9]+\.[0-9]+/ ); print substr( $0, RSTART+1, RLENGTH-1) }' )"  # .(21031.01.1 RAM Add [d...).(20416.03.8 "_p2.02", or _d1.09)

     LIB="RSS"; LIB_LOG=${LIB}_LOG; LIB_USER=${LIB}_USER; Lib=${LIB}                                        # .(80923.01.1)

#    aFns="$( dirname "${BASH_SOURCE}"         )/RSS01_Main2Fns_p1.06_v21112.sh";  if [ ! -f "${aFns}" ]; then  ##.(21113.05.5 RAM Use RSS01_Main2Fns_p1.06_v21112.sh)
     aFns="$( dirname "${BASH_SOURCE}"      )/../JPT12_Main2Fns_p1.07.sh";         if [ ! -f "${aFns}" ]; then  # .(21113.05.5 RAM Use JPT12_Main2Fns_p1.07.sh)
     echo -e "\n ** RSS01[ 48]  JPT Fns script, '.${aFns#*._2}', NOT FOUND\n"; exit; fi; #fi
     source "${aFns}";

# +------- +------------------ +----------------------------------------------------------- # ------------+ ------------------- # --------------+

     bDoit=0                                                                                                # .(20501.01.2 RAM !Important in Sub script).(20620.05.1 RAM Move to here)
     bQuiet=1                                                                                               # .(20501.01.3 RAM).(20601.02.2 bQuiet by default)
     bDebug=0                                                                                               # .(20501.01.4 RAM)
     bSpace=0;                                                                                              # .(20620.04.8 RAM A space hasn't been displayed, print one next; was 1)

     Begin "$@"                                                                                             # .(21113.05.14)

     setOS

#    aLstSp="echo "; if [ "${aOSv:0:1}" != "w" ]; then aLstSp=""; fi                                        ##.(10706.09.1 RAM Windows returns an extra blank line).(21113.06.1 RAM Reverse).(21120.02.9)
     aLstSp="echo "; if [ "${aOSv/w}" != "${aOSv}" ]; then aLstSp=""; fi                                    # .(10706.09.1 RAM Windows returns an extra blank line).(21113.06.1 RAM Reverse).(21120.02.9)
#    echo "  - RSS01[ 64]  aOSv: ${aOSv}, ${aOS}, aLstSp: '${aLstSp}'"; ${aLstSp}; # exit

#    -- --- ---------------  =  ------------------------------------------------------  #

#    aOSv=gfw1 | w10p | w08s
#    aOSv=rh62 | rh70 | uv14 | ub16

#    sayMsg    "RSS01[ 71]  aServer: '${aServer}', aOSv: ${aOSv}, aOS: '${aOS}', bDebug: '${bDebug}'" 1
#    sayMsg    "RSS01[ 72]  $\1: '$1', $\2: '$2', $\3: '$3', $\4: '$4', bQuiet: '${bQuiet}', bDebug: '${bDebug}'" 2

                                                             bTest=0;
  if [ "$1"      == "test"   ]; then                         bTest=1;           shift;     fi
  if [ "$1"      == "noisy"  ]; then                         bTest=1; bQuiet=0; shift;     fi
  if [ "$1"      == "source" ]; then if [ "$2" != "" ]; then bTest=1;           shift; fi; fi
  if [ "$1"      != ""       ]; then aCmd=$1;        fi
  if [ "${aCmd}" == ""       ]; then aCmd=help;      fi

  if [ "${aCmd}" == "dir"    ]; then if [ "$2" == "list" ]; then aCmd="dirlist"; shift; shift; fi; fi
  if [ "${aCmd}" == "dl"     ]; then aCmd="dirlist"; shift; fi
  if [ "${aCmd}" == "du"     ]; then aCmd="dirlist"; shift; fi

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       HELP Command
#
#====== =================================================================================================== #  ===========

function Help() {
     echo ""
     echo "  Useful Shell Scripts  (${aVer})               (${aVdt})"
     echo "  ------------------------------------------  ---------------------------------"
     echo "    RSS [R]Dir  {Dir} {FileSearch}            List or Find files"
     echo "    RSS DirList {Dir} {-test}                 List Directory Counts"
#    echo "    RSS Net                                   Set Up Network"
     echo "    RSS Info [Help]                           Show or Set OS Info"
     echo "    RSS Info Path [Show|Add]                  Show or Update [System] Path"
     echo "    RSS Info Vars [Show|Set {Var} {Val}]      Show or Set [System] Path"
#    echo "    RSS makSH                                 Make a  "
     echo "    RSS source  {Cmd}                         Check command file locations"
     echo "    RSS version {Cmd}                         Show RSS version or source script"
     ${aLstSp}
     exit
     }
  if [ "${aCmd}"  == "help" ]; then Help;    fi

# ----------------------------------------------------------------

         JPTdir="$( dirname "${BASH_SOURCE}" )"                                 # .(21114.06.1 RAM Do Workie)
#        JPTdir=$( dirname $0 )                                                 ##.(21111.01.2 RAM No Workie).(21114.06.1)
#        JPTdir="."                                                             ##.(21114.06.1 RAM No Workie)

  if [ "${aCmd}" == "dir" ] || [ "${aCmd}" == "rdir" ]; then                    # .(21111.01.1 RAM Beg Replace Run with direct call).(21111.03.1)
          shift
          export -f sayMsg sayMBugEnd; export bDebug                            # .(21117.03.1 RAM Wierd)
          LIB_FileList="${JPTdir}/FileList/${LIB}21_FileList"                   # .(21114.06.2 RAM Was ${LIB}21-FileList)
        ${LIB_FileList}.sh "$@"; if [ "$?" == "0" ]; then exit; fi              # .(21111.03.2 RAM Exit if successful)
     fi
# ----------------------------------------------------------------

  if [ "${aCmd}" == "dirlist" ]; then
          shift
          LIB_DirList="${JPTdir}/DirList/${LIB}22_DirList"                      # .(21114.06.3 RAM Was ${LIB}21-DirList)
        ${LIB_DirList}.sh "$@";  if [ "$?" == "0" ]; then exit; fi              # .(21111.03.3)
     fi
# ----------------------------------------------------------------

# if [ "${aCmd:0:2}" == "ed" ]; then
#         shift
#         LIB_Edit=${JPTdir}/${LIB}23-EditFile
#       ${LIB_Edit}.sh "$@";     if [ "$?" == "0" ]; then exit; fi              # .(21111.03.4)
#    fi
# ----------------------------------------------------------------
#
  if [ "${aCmd:0:2}" == "in" ]; then
          shift
          LIB_Info="${JPTdir}/Info/${LIB}22_Info"
#         echo -e "\n LIB_Iinfo: '${LIB_Info}.sh'" "$@"
        ${LIB_Info}.sh "$@";     if [ "$?" == "0" ]; then exit; fi              # .(21111.03.5)
     fi                                                                         # .(21101.01.1 RAM End)
# ----------------------------------------------------------------

# if [ "${aCmd:0:2}" == "ne" ]; then  Run  1  "home/robin"  "Config/rh70/bin/rnet-v80914.sh"; fi
# if [ "${aCmd:0:2}" == "sh" ]; then  Run  1  "home/robin"  "Config/rh70/bin/rsho.sh"; fi
# if [ "${aCmd:0:2}" == "ma" ]; then  Run  1  "home/robin"  "bin/makSH.sh"; fi

# ----------------------------------------------------------------------------------------------------

     End

#*\
##SRCE     +====================+===============================================+
##RFILE    +====================+=======+===================+======+=============+
#*/
