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

  if [ "${aCmd}" == "dir" ]; then
                               LIB_FileList=FileList/${LIB}21-FileList
     Run  0x ""                         rdir-v1.3.80119          #  {Drv1}/Home/_0/bin/rdir-v1.3.80119

#    Run  1c "home/SCN2"     ${LIB_FileList}_v1.5.80923.sh       #  {Drv1}/home/robin/_1/RSSs/fileList/RSS21-fileList_v1.4.80916.sh
#    Run  1c "home/SCN2"     ${LIB_FileList}_v1.6.10707.sh       #  {Drv1}/home/robin/_1/RSSs/fileList/RSS21-fileList_v1.6.10707.sh
#    Run  1c "home/SCN2"     ${LIB_FileList}_v1.7.10826.sh       #  {Drv1}/home/robin/_1/RSSs/fileList/RSS21-fileList_v1.7.10826.sh  # .(10826.01.1 RAM Use this one)
     Run  1c "home/SCN2"     ${LIB_FileList}.sh                  #  {Drv1}/home/robin/_1/RSSs/fileList/RSS21-fileList.sh             # .(11010.02.1 RAM Use script with no version number)

     Run  1r "home/Robin"    ${LIB_FileList}_v1.4r.80916.sh      #  {Drv1}/home/robin/_1/RSSs/fileList/RSS21-fileList_v1.4r.80916.sh
     Run  1d "home/SCN2"     ${LIB_FileList}_v1.5.80923.sh       #  {Drv1}/home/SCN2/ _1/RSSs/fileList/RSS21-fileList_v1.5.80923.sh  # .(80923.03.1)
     Run  1d "home/Robin"    ${LIB_FileList}_v1.5.80923.sh       #  {Drv1}/home/robin/_1/RSSs/fileList/RSS21-fileList_v1.5.80923.sh  # .(80923.03.1)
     Run  1m "U06/SCN2"      ${LIB_FileList}_v1.5.80923.sh       #  {Drv2}/U06/SCN2/  _1/RSSs/fileList/RSS21-fileList_v1.5.80923.sh  # .(80923.03.1)
     Run  7  "robin"         ${LIB_FileList}_v1.4.80916.sh       #       {VOL1}/robin/_1/RSSs/fileList/RSS21-fileList_v1.4.80916.sh
#    Run  8  "robin"         ${LIB_FileList}_v1.4.80916.sh       #       {VOL2}/robin/_1/RSSs/fileList/RSS21-fileList_v1.4.80916.sh  ##.(80923.03.3)
     Run  8  "SCN2"          ${LIB_FileList}.sh                  #       {VOL2}/SCN2/ _1/RSSs/fileList/JPT21-fileList_v1.5.80923.sh  # .(80923.03.3)
     Run  9x "home"          ${LIB_FileList}_v1.4.80916.sh       #       {VOL2}/home/ _0/RSSs/fileList/RSS21-fileList_v1.4.80916.sh

#    Run  0  ""                bin/rdir                          #  {Drv1}/Home/_0/bin/rdir
#    Run  0  ""                bin/rdir-v1.3.80119               #  {Drv1}/Home/_0/bin/rdir-v1.3.80119
#    Run  1  "home/robin"       RSS_Dir.sh                       #  {Drv1}/home/robin/_1/RSSs/RSS_Dir.sh
#    Run  1  "home/robin"      bin/rdir-v1.4.80730.sh            #  {Drv1}/home/robin/_1/JSHs/bin/rdir-v1.4.80730.sh
#    Run  1r "home/robin"      RSS21_fileList-v1.4r.80916.sh     #  {Drv1}/home/robin/_1/RSSs/RSS21_fileList-v1.4r.80916.sh
#    Run  1d "home/JSW"        RSS_FileList-v1.4.80916.sh        #  {Drv1}/home/JSW/  _1/RSSs/RSS_FileList-v1.4.80916.sh
#    Run  7  "robin"           RSS_FileList-v1.4.80916.sh        #  {VOL1}/robin/     _1/RSSs/RSS_FileList-v1.4.80916.sh
#    Run  7  "home/robin"      bin/rdir-v1.4.80730.sh            #  {VOL1}/home/robin/_1/JSHs/bin/rdir-v1.4.80730.sh
     fi
# ----------------------------------------------------------------

  if [ "${aCmd}" == "dirlist" ]; then
                                        LIB_DirList=DirList/${LIB}22-DirList
     Run  0  ""                       ${LIB_DirList}
#    Run  1c "home/SCN2"              ${LIB_DirList}_v1.2.81007.sh
#    Run  1d "home/SCN2"              ${LIB_DirList}_v1.2.81007.sh
     Run  1r "home/Robin"             ${LIB_DirList}_v1.2.81007.sh
     Run  1m "U06/SCN2"               ${LIB_DirList}_v1.2.81007.sh
     Run  7  "robin"                  ${LIB_DirList}_v1.2.81007.sh
     Run  8  "SCN2"                   ${LIB_DirList}_v1.2.81007.sh
     Run  9  "home"                   ${LIB_DirList}_v1.2.81007.sh

     Run  1c "home/SCN2"              ${LIB_DirList}.sh
#    Run  1d "home/SCN2"              ${LIB_DirList}.sh
     fi
# ----------------------------------------------------------------

  if [ "${aCmd:0:2}" == "ed" ]; then
                                        LIB_Edit=${LIB}23-EditFile
     Run  0  ""                       ${LIB_Edit}
     Run  1  "home/robin"             ${LIB_Edit}.njs
     Run  1  "WEBs/SCN2"              ${LIB_Edit}_v80912.njs
     Run  2  "WEBs/SCN2/BASEC3"       ${LIB_Edit}_v80808.njs
     Run  3  "WEBs/SCN2/BASEC3/Buyer" ${LIB_Edit}_v80808.njs
     Run  7  "robin"                  ${LIB_Edit}_v80912.njs
     Run  8  "SCN2"                   ${LIB_Edit}_v80912.njs
     Run  9  "home"                   ${LIB_Edit}
     fi
# ----------------------------------------------------------------

  if [ "${aCmd:0:2}" == "in" ]; then
                                        LIB_Info=Info/${LIB}22-Info
     Run  1c "home/SCN2"              ${LIB_Info}_v0.7.80923.sh
     Run  1d "home/SCN2"              ${LIB_Info}_v0.7.80923.sh
     Run  1m "U06/SCN2"               ${LIB_Info}_v0.7.80923.sh
     Run  8  "SCN2"                   ${LIB_Info}_v0.7.80923.sh
     fi
# ----------------------------------------------------------------

  if [ "${aCmd:0:2}" == "ne" ]; then  Run  1  "home/robin"  "Config/rh70/bin/rnet-v80914.sh"; fi
  if [ "${aCmd:0:2}" == "sh" ]; then  Run  1  "home/robin"  "Config/rh70/bin/rsho.sh"; fi
  if [ "${aCmd:0:2}" == "ma" ]; then  Run  1  "home/robin"  "bin/makSH.sh"; fi

# ----------------------------------------------------------------------------------------------------

     End

#*\
##SRCE     +====================+===============================================+
##RFILE    +====================+=======+===================+======+=============+
#*/
