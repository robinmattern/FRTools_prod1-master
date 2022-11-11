#!/bin/bash
#*\
##=========+====================+================================================+
##RD         RSS Launcher       | Robin's Shell Scripts Command Launcher
##RFILE    +====================+=======+===================+======+=============+
##FD   RSS1-Main1.sh            |   7187|  9/26/18 21:00|   121| v1.5.80925
##FD   RSS1-Main1.sh            |  10534| 11/03/22 16:16|   169| p1.06-21103-1616
##DESC     .--------------------+-------+-------------------+------+------------+
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

##PRGM     +====================+===============================================+
##ID 69.600. Main               |
##SRCE     +====================+===============================================+
#*/
     aVdt="Nov 5, 2022 9:00p"

     aVer="$( echo $0 | awk '{ match( $0, /_[dpstuv][0-9]+\.[0-9]+/ ); print substr( $0, RSTART+1, RLENGTH-1) }' )"  # .(21031.01.1 RAM Add [d...).(20416.03.8 "_p2.02", or _d1.09)

  if [ "${1:0:3}" == "ver" ] || [ "${1:0:2}" == "-v" ]; then                                                # .(20420.07.1 RAM Added Version)
     echo ""
#    echo "  Robin's Shell Scripts Version: ${aVer}   ($( date "+%b %-d %Y %H:%M" ))"                       ##.(20429.04.1)
     echo "  Robin's Shell Scripts Version: ${aVer}   (${aVdt})"                                            # .(20429.04.1 RAM)
     if [ "${1:0:3}" == "-vv" ]; then echo "  $0"; fi                                                       # .(20620.01.1 RAM)
     echo ""
     exit
     fi
#    -- --- ---------------  =  ------------------------------------------------------  #

     LIB="RSS"; LIB_LOG=${LIB}_LOG; LIB_USER=${LIB}_USER; Lib=${LIB}                                      # .(80923.01.1)

     aFldr=$( echo $0 | awk '{ gsub( /[//\\][^//\\]*$/, ""    ); print }' ); # aFldr=${aFldr}/../${Lib}s  # .(81002.07.1 Override path)
     aVnTS=$( echo $0 | awk '{ gsub( /.+[-_]v|\.[^.]+$/,   "" ); print }' );   aVnTS="p1.06"              # .(81002.07.2 Hardcode version, v1.3.80916.2301).(21031.04.01)
     aFns=${aFldr}/${Lib}1-Main2Fns_${aVnTS}.sh;  source "${aFns}"; # echo "# aFns: ${aFns}";             # .(80920.02.1 Require "${LIB}-main2Fns.sh")
     aVer="$( echo $0 | awk '{  match( $0, /_[dpstuv][0-9]+\.[0-9]+/ ); print substr( $0, RSTART+1, RLENGTH-1) }' )"  # "_p2.02", or _d1.09     # .(21031.04.2 RAM Add [d...)

# +------- +------------------ +----------------------------------------------------------- # ------------+ ------------------- # --------------+

     bQuiet=1; bTest=0; aCmd=

  if [ "$1"      == "test"   ]; then                         bTest=1;           shift;     fi
  if [ "$1"      == "noisy"  ]; then                         bTest=1; bQuiet=0; shift;     fi
  if [ "$1"      == "source" ]; then if [ "$2" != "" ]; then bTest=1;           shift; fi; fi
  if [ "$1"      != ""       ]; then aCmd=$1;        fi
  if [ "${aCmd}" == ""       ]; then aCmd=help;      fi

  if [ "${aCmd}" == "dir"    ]; then if [ "$2" == "list" ]; then aCmd="dirlist"; shift; shift; fi; fi
  if [ "${aCmd}" == "dl"     ]; then aCmd="dirlist"; shift; fi
  if [ "${aCmd}" == "du"     ]; then aCmd="dirlist"; shift; fi

#    aOSv=gfw1 | w10p | w08s
#    aOSv=rh62 | rh70 | uv14 | ub16

     setOS

     Begin "$@"

# ----------------------------------------------------------------------------------------------------

function Help() {
     echo ""
     echo "  Useful Shell Scripts  (${aVer})          (${aVdt})"
     echo "  -------------------------------------  ---------------------------------"
     echo "    RSS Dir     {Dir} {FileSearch}       List or Find files"
     echo "    RSS DirList {Dir} {-test}            List Directory Counts"
#    echo "    RSS Net                              Set Up Network"
     echo "    RSS Info                             Set and Show Info"
#    echo "    RSS makSH                            Make a  "
     echo "    RSS source {Cmd}                     Check command file locations"
     echo "    RSS version {Cmd}                    Show RSS version or source script"
     echo ""
     exit
     }
  if [ "${aCmd}"  == "help" ]; then Help;    fi

# ----------------------------------------------------------------

         JPTdir=$( dirname $0 )                                                 # .(21111.01.2) 

  if [ "${aCmd}" == "dir" ] || [ "${aCmd}" == "rdir" ]; then                    # .(21111.01.1 RAM Beg Replace Run with direct call)

          LIB_FileList=${JPTdir}/FileList/${LIB}21-FileList
        ${LIB_FileList}.sh; if [ "$?" == "0" ]; then exit; fi        
     fi
# ----------------------------------------------------------------

  if [ "${aCmd}" == "dirlist" ]; then

          LIB_DirList=${JPTdir}/DirList/${LIB}22-DirList
        ${LIB_DirList}.sh       
     fi
# ----------------------------------------------------------------

# if [ "${aCmd:0:2}" == "ed" ]; then
#
#         LIB_Edit=${JPTdir}/${LIB}23-EditFile
#       ${LIB_Edit}.sh       
#    fi
# ----------------------------------------------------------------
#
  if [ "${aCmd:0:2}" == "in" ]; then
 
          LIB_Info=${JPTdir}/Info/${LIB}22-Info
        ${LIB_Info}.sh       
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
