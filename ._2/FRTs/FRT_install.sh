#!/bin/bash
#*\
##=========+====================+================================================+
##RD         FRT Installer      | Install FormR Tools script
##RFILE    +====================+=======+===================+======+=============+
##FD   FRT_install.sh           |  90159|  4/20/22  7:36:00p|  1315| v1.4.20420
##DESC     .--------------------+-------+-------------------+------+------------+
#            Puts a FRT Launch script, jpt, into C:\Home\_0\bin, or \home\_0\bin
#            on Ubuntu.  That script launches a major JPT script version located
#            in the directory that FRT_Install.sh is in.
#
#            That major FRT version script,  FRT00_jpt_p1.sh, then launches the
#            latest "p1" minor version: e.g. FRT00_jpt_p1.05.sh.
#
#            It takes an argument of: p|p1|p2, t|t1|t2 or u|u1|u2. If such a
#            version exists, a FRT script for major version, frt, frt1, or frt2
#            will be created.  Note: FRT_Install.sh with no arg will install the
#            latest script: i.e. u3 among FRT00_frt_p1,sh, FRT00_frt_u2.sh
#            and/or FRT00_frt_u3.sh.
#
##LIC      .--------------------+----------------------------------------------+
#            Copyright (c) 2022 JScriptware Power Tools * Released under
#            MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+-------+-------------------+------+-----------+
#
##CHGS     .--------------------+-------+-------------------+------+-----------+
# .(80916.02  2/16/22 RAM  8:50a| Created
# .(20420.01  4/20/22 RAM  9:15a| Put version number after frt script, e.g. frt2
# .(20420.02  4/20/22 RAM  2:00p| Check if JPT version exists
# .(20429.05  4/29/22 RAM  3:50p| Add keys and gitr
# .(20429.06  4/29/22 RAM  4:10p| Removed sudo from chmod 777

##PRGM     +====================+===============================================+
##ID 69.600. Main               |
##SRCE     +====================+===============================================+
#*/
# -------------------------------------------------------------------------------

#  echo "         \$0: '$0'";   # echo "BASH_SOURCE: '${BASH_SOURCE}'"; echo "        pwd: '$( pwd )'"; echo " dirname \$0: '$(dirname $0)'"

#  __dirname="$( pwd )";        # echo "  __dirname: '${__dirname}', \${__dirname:0:2}: '${__dirname:0:2}'";   exit
   __dirname="$( dirname $0 )"; # echo "  __dirname: '${__dirname}', \${__dirname:0:2}: '${__dirname:0:2}'";   exit

#  ------------------------------------------------------------------------

                                        bUnix=1
if [ "${__dirname:0:2}" == "/c" ]; then bUnix=0; fi  # Windows Git-Bash
if [ "${__dirname:0:2}" == "C:" ]; then bUnix=0; fi  # Windows DOS

                               aFRT_Home="${__dirname}"
if [ "${bUnix}" == "0" ]; then aFRT_Home="${aFRT_Home/C://C}"; fi
if [ "${bUnix}" == "0" ]; then aFRT_Home="${aFRT_Home//\\//}"; fi

if [ "${bUnix}" == "0" ]; then aBin="C:/Home/_0/bin"; fi
if [ "${bUnix}" == "1" ]; then aBin="/home/_0/bin";   fi

#  echo "  aFRT_Home: '${aFRT_Home}', bUnix: ${bUnix}"; exit
#  echo "  aJPT_File: '${aJPT_Home}/JPT00_jpt_p1.sh'; bUnix: ${bUnix}";  exit

#  ------------------------------------------------------------------------

   aFRT="FRT00_frt_"

   aVer=""
#  aVer="p1"

#  ------------------------------------------------------------------------

 function sayErr( ) {                                                                   # .(20420.02.3 RAM Use err msg function)
   echo ""; echo " * $1"; echo ""; exit
   }
#  --------------------------------------------------------------

 function chkScriptVer( ) {                                                             # .(20420.02.1 Beg RAM Check if FRT version exists)

        aFind="$( find . -name "${aFRT}*.sh" )";   # sayErr "ll ${aFRT}*.sh, aFind: '${aFind}'; len('$1'): ${#1}";
if [ "${aFind}" == "" ];                        then sayErr "No FRT script files exit for: '${aFRT}*.sh'"; fi

        aFind=$( echo "$1" | awk '/[ptu][0-2]?[.0-4]{0,3}/ { print 1 }' )
if [ "${aFind}" == "" ] && [ "$1" != "" ];      then sayErr "You can only install FRT script versions: p|p1|p2, t|t1|t2 or u|u1|u2, if they exist."; fi

#  ----------------------------------------------------

   if [ "${#1}" == "0" ]; then aFind="[ptu][.0-9]{1,3}.sh"; fi
   if [ "${#1}" == "1" ]; then aFind="$1[.0-9]{1,4}.sh"; fi
#  if [ "${#1}" == "2" ]; then aFind="$1[.0-9]{1,3}.sh"; fi
   if [ "${#1}" == "2" ]; then aFind="$1[.0-9]{0,4}.sh"; fi
   if [ "${#1}" == "5" ]; then aFind="$1.sh"; fi

#  echo                              "  ls -1 ${aFRT}*.sh | sort | awk '/${aFind}/   { print }'; \$1: '${1}',  len: ${#1} "
#  echo "---------------------------";  ls -1 ${aFRT}*.sh | sort | awk '/'${aFind}'/ { print "        " $0 }'; echo "---------------------------"
                                aVer=$( ls -1 ${aFRT}*.sh | sort | awk '/'${aFind}'/ { sub( /'${aFRT}'/, "" ); sub( /.sh/, "");  a = $0 }; END { print a }' )  # returns the last one
#  echo "aVer: ${aVer}";   # exit

#  ----------------------------------------------------

if [ "${aVer}" == "" ];                         then sayErr "No FRTools scripts, '${aFRT}$1.MM.sh', exist in the current folder."; fi

#  ----------------------------------------------------
   } # eof chkScriptVer                                                                 # .(20420.02.1 End)
#  ------------------------------------------------------------------------

   chkScriptVer "$1";      # echo "        FRT aVer: ${aVer}";     # exit
   aFRT=${aFRT}${aVer}.sh; # echo "       aFRT script: '${aFRT}'"; # exit

if [ ! -f "${aFRT}" ];                          then sayErr "The FRTools script, '${aFRT}', does not exist."; fi
if [ "${PATH/ome\/_0\/bin/}" == "${PATH}" ];    then sayErr "The folder, ${aBin}, is not in the PATH."; fi
if [ ! -d "${aBin}" ];                          then sayErr "The folder, ${aBin}, does not exist."; fi

#  ----------------------------------------------------

   frt="frt";         if [ "${aVer}" != "p1" ]; then frt="frt${aVer:1:1}"; fi           # .(20420.01.1 Beg RAM Put version number after frt script, e.g. frt2)
   FRTools="frtools"; if [ "${aVer}" != "p1" ]; then FRTools="FRTools${aVer:1:1}"; fi

#  --------------------------------------------------------------

   aScr=$( echo '#!/bin/bash
#  FRTools Launch Script on rm212p-w10p

   aCmd="'${aFRT_Home}/${aFRT}'"

   if [ "$1" == "-v" ]; then echo ""; echo "  '${aFRT}'  ($( date "+%b %-d %Y %H:%M" ))" ; exit; fi

  "${aCmd}" "$@"
   ')
#  ----------------------------------------------------
                                                                                        # .(20429.05.1 Beg RAM)
   aScr2=$( echo '#!/bin/bash
#  FRT {cmd} Launch Script on rm212p-w10p

   frt {cmd} "$@"
   ')
#  ----------------------------------------------------                                 # .(20429.05.1 End)

if [ "test" != "text" ]; then

#  echo "aScr:"; echo "${aScr}";               exit  # print script
#  echo "aScr:"; echo "${aScr2//{Sub\}/KEYS}"; exit  # print script

   echo "${aScr}"               >"${frt}"
   echo "${aScr}"               >"${FRTools}"
         chmod  755              "${frt}"                                               # .(20429.06.1  RAM Removed sudo from chmod 777)
         chmod  755              "${FRTools}"

   echo "${aScr}"               >"${aBin}/${frt}"
   echo "${aScr}"               >"${aBin}/$( echo ${FRTools} | awk '{ print tolower( $1 ) }' )"
         chmod  755              "${aBin}/${frt}"
         chmod  755              "${aBin}/$( echo ${FRTools} | awk '{ print tolower( $1 ) }' )"

   echo "${aScr2//{cmd\}/gitr}" >"${aBin}/gitr"                                         # .(20429.05.2 Beg RAM)
   echo "${aScr2//{cmd\}/keys}" >"${aBin}/keys"
         chmod  755              "${aBin}/gitr"
         chmod  755              "${aBin}/keys"

#  echo "${aScr2//{cmd\}/gitr}" >"GitR/gitr"                                            # .(20429.05.3 RAM GitR and Keys are folders)
#  echo "${aScr2//{cmd\}/keys}" >"Keys/keys"                                            # .(20429.05.4)
#        chmod  755              "GitR/gitr"
#        chmod  755              "Keys/keys"                                            # .(20429.05.2 End)
   fi
#  ----------------------------------------------------

   echo ""
   echo "  Installed FRTools script, ${frt} into: '${aBin}/'"                           # .(20420.01.1 End)
   echo "    for: '${aFRT_Home}/${aFRT}'"

#  ----------------------------------------------------

if [ -f "${aBin}/${frt}" ]; then                                                        # .(20420.01.2 Beg)
   echo ""
   echo "  You can now run ${frt} commands, e.g. ${frt} help:"
#  echo ""
            ${frt} help
   fi
if [ ! -f "${aBin}/${frt}" ];                   then sayErr "The FRT script, '${aBin}/${frt}', was not installed properly."; fi
                                                                                        # .(20420.01.2 End)
# -------------------------------------------------------------------------------
