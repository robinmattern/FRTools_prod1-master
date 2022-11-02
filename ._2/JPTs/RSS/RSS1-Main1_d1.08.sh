#!/bin/bash
#*\
##=========+====================+================================================+
##RD         RSS Launcher       | Robin's Shell Scripts Command Launcher
##RFILE    +====================+=======+===================+======+=============+
##FD   RSS1-Main1.sh            |  11798|  3/15/19 10:30|   178| v1.8.90315.01
##FD   RSS1-Main1.sh            |  16304| 10/31/22 21:05|   225| d1.08-21031-2114
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
# .(81014.01 10/07/18 RAM  9:30a| Modified aVnTS to be aVTS1 and aVTS2
# .(81216.01 12/16/18 RAM  8:45p| Add rss net
# .(90315.01  3/15/19 RAM 10:30a| Add rss zip and {obj}
# .(90315.02  3/15/19 RAM 10:30a| Use 1.5.90315 of RSS1-Main2Fns.sh
# .(90315.03  3/15/19 RAM 11:15a| Enabled rss dirlist and use latest vesion
# .(90315.04  3/15/19 RAM  1:15p| Allow bQuiet and bTest to be set by calling script
# .(90326.01  3/26/19 RAM  1:45p| Add aVars = {Lib}-Parms.sh and source it
# .(90326.03  3/26/19 RAM  2:45p| Use RSS1-Main2Fns_v1.6.90321.sh
# .(90327.02  3/27/19 RAM 11:45a| Add RSS20-{Obj1}.sh
# .(90327.04  3/27/19 RAM  9:30p| Use 1.6.90327 of RSS1-Main2Fns.sh
# .(90328.01  3/28/19 RAM  9:15a| Move setting bTest and bQuiet to here
# .(90328.02  3/28/19 RAM  1:40p| Move say and debug fns to Main2Fns
# .(21031.04 10/31/22 RAM  9:14p| Allow for Main2Fns_d1.06.90327

##PRGM     +====================+===============================================+
##ID 69.600. Main               |
##SRCE     +====================+===============================================+
#*/
     LIB="RSS"; LIB_LOG=${LIB}_LOG; LIB_USER=${LIB}_USER; Lib="RSS"                                       # .(80923.01.1 RAM Lib is for Main2Fns.sh)

#    aCmd=; bTest=1; bTestFns=1; bQuiet=0                 # "-test" and "-quiet" options won't be set or shifted away!
#    echo "  Main1[0]:   1: '$1'; 2: '$2'; 3: '$3'; 4: '$4'; bTest: ${bTest}; bQuiet: ${bQuiet}"; # exit

     aFldr=$( echo $0 | awk '{ gsub( /[//\\][^//\\]*$/, ""    ); print }' ); # aFldr=${aFldr}/../${Lib}s  # .(81007.02.1 RAM Override path)

#    aVnTS=$( echo $0 | awk '{ gsub( /.+[-_]v|\.[^.]+$/,   "" ); print }' );   aVnTS="1.6.80925"          ##.(81007.02.2 RAM Hardcode version, v1.3.80916.2301).(81014.01.1)
#    aVTS1=$( echo $0 | awk '{ gsub( /.+[-_]v|\.[^.]+$/,   "" ); print }' );   aVTS2="1.6.80925" #=$aVTS1 ##.(81014.01.1 Hardcode version, v1.3.80916.2301).(90326.03.2)
     aVTS1=$( echo $0 | awk '{ gsub( /.+[-_]v|\.[^.]+$/,   "" ); print }' );   aVTS2="1.6.90321"          # .(90326.03.2 Hardcode version, v1.6.90321)
                                                                               aVTS2="d1.06.90327"        # .(90327.04.1).(21031.04.1 RAM Add d1.06)

#    aFncs=${aFldr}/${Lib}1-Main2Fns_v${aVnTS}.sh;  source "${aFncs}"; # echo "# aFncs: ${aFncs}";        ##.(80920.02.1 RAM Require "${LIB}-main2Fns.sh").(81014.01.1)
     aFncs=${aFldr}/${Lib}1-Main2Fns_${aVTS2}.sh;   source "${aFncs}"; export aFncs                       # .(81014.01.1 RAM).(90328.02.1 export aFncs).(21031.04.2 RAM Remove v${aVTS2})

# +------- +------------------ +----------------------------------------------------------- # ------------+ ------------------- # --------------+

# if [ "$1"      == "-test"   ]; then                         bTest=1;           shift;     fi            ##.(90328.01.1)
##if [ "$1"      == "-noisy"  ]; then                         bTest=1; bQuiet=0; shift;     fi            ##.(90328.01.2)
# if [ "$1"      == "-noisy"  ]; then                                  bQuiet=0; shift;     fi            ##.(90328.01.3)
# if [ "$1"      == "-debug"  ]; then                         bTest=1; bQuiet=0; shift;     fi            ##.(90328.01.4)
# if [ "$1"      == "source"  ]; then if [ "$2" != "" ]; then bTest=1;           shift; fi; fi            ##.(90328.01.5)

  if [ "$1"      != ""        ]; then aCmd=$1;        fi
  if [ "${aCmd}" == ""        ]; then aCmd=help;      fi

  if [ "${aCmd}" == "dir"     ]; then if [ "$2" == "list" ]; then aCmd="dirlist"; shift; shift; fi; fi
  if [ "${aCmd}" == "dl"      ]; then aCmd="dirlist"; shift; fi
  if [ "${aCmd}" == "du"      ]; then aCmd="dirlist"; shift; fi
  if [ "${aCmd}" == "dirlist" ]; then aCmd="dirlist"; shift; fi                                           # .(90315.03.1 RAM Add rss dirlist)

#    aOSv=gfw1 | w10p | w08s
#    aOSv=rh62 | rh70 | uv14 | ub16

# ----------------------------------------------------------------------------------------------------

function Help() {
     echo ""
     echo "  Robin's Shell Scripts ($LIB)           v${aVTS1}"                                            # .(90315.02.2 RAM Show RSS1-Main2Fns.sh Version)
     echo "  --+---------------------------------  ---------------------------------"
     echo "    $LIB Dir      {Dir} {FileSearch}     List or Find files"
     echo "    $LIB Dir List {Dir} {Lv} {Typ}       List Directory Counts (see: dirlist -help)"
     echo "    $LIB Net                             Set Up Network"
     echo "    $LIB Info                            Set and Show Info"
     echo "    $LIB makSH                           Make a  "
     echo "    $LIB Zip      {Dir}                  Archive a directory into ../_/ZIPs"
     echo "    $LIB source   {Cmd}                  Check command file locations"
     echo "    $LIB version  {Cmd}                  Show $LIB version or source script"
     echo "    $LIB -test    {Cmd}                  Test $LIB {Cmd}"
     echo "    $LIB -debug   {Cmd}                  Debug $LIB"
     echo ""
     exit
     }
  if [ "${aCmd}"  == "help" ]; then Help;    fi

# ----------------------------------------------------------------

     setOS

     Begin "$@"

# ----------------------------------------------------------------------------------------------------

  if [ "${aCmd}" == "dir" ]; then
                               LIB_FileList=FileList/${LIB}21-FileList
     Run  0x ""                         rdir-v1.3.80119          #                 {Drv1}/Home/_0/bin/rdir-v1.3.80119
     Run  1c "home/SCN2"     ${LIB_FileList}.sh                  #  {Drv1}/home/robin/_1/RSSs/fileList/RSS21-fileList.sh    # .(81020.05.1 RAM Beg Use Default Version)
     Run  1r "home/Robin"    ${LIB_FileList}.sh                  #  {Drv1}/home/robin/_1/RSSs/fileList/RSS21-fileList.sh
     Run  1d "home/SCN2"     ${LIB_FileList}.sh                  #  {Drv1}/home/SCN2/_1/RSSs/fileList/RSS21-fileList.sh
     Run  1d "home/Robin"    ${LIB_FileList}.sh                  #  {Drv1}/home/robin/_1/RSSs/fileList/RSS21-fileList.sh
     Run  1m "U06/SCN2"      ${LIB_FileList}.sh                  #  {Drv2}/U06/SCN2/_1/RSSs/fileList/RSS21-fileList.sh
     Run  1n "U06/SCN2"      ${LIB_FileList}.sh                  #  {Drv2}/U06/SCN2/_1/RSSs/fileList/RSS21-fileList.sh      # .(90315.03.2 RAM)
     Run  7  "robin"         ${LIB_FileList}.sh                  #       {VOL1}/robin/_1/RSSs/fileList/RSS21-fileList.sh
     Run  8  "SCN2"          ${LIB_FileList}.sh                  #       {VOL2}/SCN2/_1/RSSs/fileList/JPT21-fileList.sh
     Run  9x "home"          ${LIB_FileList}.sh                  #       {VOL2}/home/_0/RSSs/fileList/RSS21-fileList.sh     # .(81020.05.1 RAM End Use Default Version)

#    Run  0x ""                         rdir-v1.3.80119          #                 {Drv1}/Home/_0/bin/rdir-v1.3.80119
##   Run  1c "home/SCN2"     ${LIB_FileList}_v1.5.80923.sh       #  {Drv1}/home/robin/_1/RSSs/fileList/RSS21-fileList_v1.4.80916.sh  ##.(81020.05.1)
#    Run  1c "home/SCN2"     ${LIB_FileList}.sh                  #  {Drv1}/home/robin/_1/RSSs/fileList/RSS21-fileList.sh             # .(81020.05.1)
#    Run  1r "home/Robin"    ${LIB_FileList}_v1.4r.80916.sh      #  {Drv1}/home/robin/_1/RSSs/fileList/RSS21-fileList_v1.4r.80916.sh
#    Run  1d "home/SCN2"     ${LIB_FileList}_v1.5.80923.sh       #  {Drv1}/home/SCN2/_1/RSSs/fileList/RSS21-fileList_v1.5.80923.sh   # .(80923.03.2)
#    Run  1d "home/Robin"    ${LIB_FileList}_v1.5.80923.sh       #  {Drv1}/home/robin/_1/RSSs/fileList/RSS21-fileList_v1.5.80923.sh  # .(80923.03.1)
#    Run  1m "U06/SCN2"      ${LIB_FileList}_v1.5.80923.sh       #  {Drv2}/U06/SCN2/_1/RSSs/fileList/RSS21-fileList_v1.5.80923.sh    # .(80923.03.1)
#    Run  7  "robin"         ${LIB_FileList}_v1.4.80916.sh       #       {VOL1}/robin/_1/RSSs/fileList/RSS21-fileList_v1.4.80916.sh
##   Run  8  "robin"         ${LIB_FileList}_v1.4.80916.sh       #       {VOL2}/robin/_1/RSSs/fileList/RSS21-fileList_v1.4.80916.sh  ##.(80923.03.3)
#    Run  8  "SCN2"          ${LIB_FileList}.sh                  #       {VOL2}/SCN2/_1/RSSs/fileList/JPT21-fileList_v1.5.80923.sh   # .(80923.03.3)
#    Run  9x "home"          ${LIB_FileList}_v1.4.80916.sh       #       {VOL2}/home/_0/RSSs/fileList/RSS21-fileList_v1.4.80916.sh

#    Run  0  ""                bin/rdir                          #                 {Drv1}/Home/_0/bin/rdir
#    Run  0  ""                bin/rdir-v1.3.80119               #                 {Drv1}/Home/_0/bin/rdir-v1.3.80119
#    Run  1  "home/robin"       RSS_Dir.sh                       #          {Drv1}/home/robin/_1/RSSs/RSS_Dir.sh
#    Run  1  "home/robin"      bin/rdir-v1.4.80730.sh            #      {Drv1}/home/robin/_1/JSHs/bin/rdir-v1.4.80730.sh
#    Run  1r "home/robin"      RSS21_fileList-v1.4r.80916.sh     #  {Drv1}/home/robin/_1/RSSs/RSS21_fileList-v1.4r.80916.sh
#    Run  1d "home/JSW"        RSS_FileList-v1.4.80916.sh        #  {Drv1}/home/JSW/_1/RSSs/RSS_FileList-v1.4.80916.sh
#    Run  7  "robin"           RSS_FileList-v1.4.80916.sh        #       {VOL1}/robin/_1/RSSs/RSS_FileList-v1.4.80916.sh
#    Run  7  "home/robin"      bin/rdir-v1.4.80730.sh            #      {VOL1}/home/robin/_1/JSHs/bin/rdir-v1.4.80730.sh
     fi
# ----------------------------------------------------------------

  if [ "${aCmd:0:4}" == "dirl" ]; then
                                        LIB_DirList=DirList/${LIB}22-DirList
     Run  0  ""                       ${LIB_DirList}.sh                                             # .(90515.03.3 RAM Added .sh)
     Run  1c "home/SCN2"              ${LIB_DirList}_v1.2.81007.sh                                  # .(90315.03.4 RAM Shouldn't they all go to latest version)
     Run  1d "home/SCN2"              ${LIB_DirList}_v1.2.81007.sh
     Run  1r "home/Robin"             ${LIB_DirList}_v1.2.81007.sh
     Run  1m "U06/SCN2"               ${LIB_DirList}.sh
     Run  1n "U06/SCN2"               ${LIB_DirList}.sh                                             # .(90315.03.5 RAM)
     Run  7  "robin"                  ${LIB_DirList}_v1.2.81007.sh
     Run  8  "SCN2"                   ${LIB_DirList}.sh
     Run  9  "home"                   ${LIB_DirList}_v1.2.81007.sh
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
     Run  1n "U06/SCN2"               ${LIB_Info}_v0.7.80923.sh                                     # .(90315.03.6 RAM)
#    Run  8  "SCN2"                   ${LIB_Info}_v0.7.80923.sh
     Run  8  "SCN2"                   ${LIB_Info}_v0.8.sh
     Run  8  "SCN2"                   ${LIB_Info}.sh
     fi
# ----------------------------------------------------------------

# if [ "${aCmd:0:2}" == "ne"  ]; then  Run  1  "home/robin"  "Config/rh70/bin/rnet-v80914.sh"; fi
  if [ "${aCmd:0:2}" == "ne"  ]; then                                                               # .(81216.01.1 BEG RAM Added net)
                                        LIB_Net=Net/${LIB}24-Net
     Run  1  "home/robin"            "Config/rh70/bin/rnet-v80914.sh";
     Run  1m "U06/SCN2"               ${LIB_Net}_v0.8.81216.sh
     Run  1n "U06/SCN2"               ${LIB_Net}_v0.8.81216.sh                                      # .(90315.03.7 RAM)
     Run  8  "SCN2"                   ${LIB_Net}_v0.8.81216.sh                                      # .(81216.01.1 END RAM)
     fi
  if [ "${aCmd:0:2}" == "sh"  ]; then  Run  1  "home/robin"  "Config/rh70/bin/rsho.sh"; fi
  if [ "${aCmd:0:2}" == "ma"  ]; then  Run  1  "home/robin"  "bin/makSH.sh"; fi
  if [ "${aCmd:0:2}" == "mt"  ]; then  Run  1n "U06/SCN2"    "MT/${LIB}22-MT1.sh"; fi               # .(90315.01.1 RAM)

# ----------------------------------------------------------------

  if [ "${aCmd:0:2}" == "zi" ]; then                                                                # .(90315.01.2 BEG RAM)
                                        LIB_ZIP1=ZIP/${LIB}25-ZIP1
     Run  1c "home/SCN2"              ${LIB_ZIP1}.sh                                                # .(90402.01.1)
     Run  1c "home/SCN2"              ${LIB_ZIP1}_v0.2.90327.sh
     Run  1c "home/SCN2"              ${LIB_ZIP1}_v0.1.70416.sh
     Run  1d "home/SCN2"              ${LIB_ZIP1}_v0.2.90327.sh
     Run  1n "U06/SCN2"               ${LIB_ZIP1}_v0.2.90327.sh
     Run  1m "U06/SCN2"               ${LIB_ZIP1}_v0.2.90327.sh
     Run  8  "SCN2"                   ${LIB_ZIP1}_v0.2.sh
     Run  8  "SCN2"                   ${LIB_ZIP1}.sh
     fi                                                                                             # .(90315.01.2 END)
# ----------------------------------------------------------------------------------------------------

  if [ "${aCmd}" == "obj" ]; then aCmd="{obj}"; fi                                                  # .(90328.02.1 DOS bash removes {} )
  if [ "${aCmd:0:5}" == "{obj}" ]; then                                                             # .(90327.02.2 BEG RAM)
                                        LIB_Obj1={MT-Obj}/${LIB}20-Obj1
     Run  1x "home/SCN2"              ${LIB_Obj1}.sh                     # .(90327.02.3 RAM It runs the 1st one it finds)
     Run  1c "home/SCN2"              ${LIB_Obj1}_v0.3.90327.sh
     Run  1c "home/SCN2"              ${LIB_Obj1}_v0.2.80416.sh
     Run  1c "home/SCN2"              ${LIB_Obj1}_v0.1.70416.sh
     Run  1d "home/SCN2"              ${LIB_Obj1}_v0.2.80416.sh
     Run  1n "U06/SCN2"               ${LIB_Obj1}_v0.2.80416-1306.sh
     Run  1m "U06/SCN2"               ${LIB_Obj1}_v0.2.80416-1306.sh
     Run  7  "robin"                  ${LIB_Obj1}_v0.2.sh
     Run  8  "SCN2"                   ${LIB_Obj1}_v0.2.sh
     Run  8  "home"                   ${LIB_Obj1}.sh
     fi                                                                                             # .(90327.02.4 END)
# ----------------------------------------------------------------------------------------------------

     End

#*\
##SRCE     +====================+===============================================+
##RFILE    +====================+=======+===================+======+=============+
#*/
