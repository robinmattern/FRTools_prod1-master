#!/bin/bash
#*\
##=========+====================+================================================+
##RD         JPT Installer      | Installs JScriptware Power Tools script
##RFILE    +====================+=======+===================+======+=============+
##FD   JPT_install.sh           |  90159|  4/20/22  7:36:00p|  1315| v1.4.20420
##DESC     .--------------------+-------+-------------------+------+------------+
#            Puts a JPT Launch script, jpt, into C:\Home\_0\bin, or \home\_0\bin
#            on Ubuntu.  That script launches a major JPT script version located
#            in the directory that JPT_Install.sh is in.
#
#            That major JPT version script,  JPT00_jpt_p1.sh, then launches the
#            latest "p1" minor version: e.g. JPT00_jpt_p1.05.sh.
#
#            It takes an argument of: p|p1|p2, t|t1|t2 or u|u1|u2. If such a
#            version exists, a JPT script for major version, jpt, jpt1, or jpt2
#            will be created.  Note: JPT_Install.sh with no arg will install the
#            latest script: i.e. u3 among JPT00_jpt_p1,sh, JPT00_jpt_u2.sh
#            and/or JPT00_jpt_u3.sh.
#
##LIC      .--------------------+----------------------------------------------+
#            Copyright (c) 2022 JScriptware Power Tools * Released under
#            MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+-------+-------------------+------+-----------+
#
##CHGS     .--------------------+-------+-------------------+------+-----------+
# .(80916.02  2/16/22 RAM  8:50a| Created
# .(20420.01  4/20/22 RAM  9:15a| Put version number after JPT script, e.g. JPT2
# .(20420.02  4/20/22 RAM  2:00p| Check if JPT version exists
# .(20420.03  4/20/22 RAM  4:15p| Copied to JPT_Install.sh
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

                               aJPT_Home="${__dirname}"
if [ "${bUnix}" == "0" ]; then aJPT_Home="${aJPT_Home/C://C}"; fi
if [ "${bUnix}" == "0" ]; then aJPT_Home="${aJPT_Home//\\//}"; fi

if [ "${bUnix}" == "0" ]; then aBin="C:/Home/_0/bin"; fi
if [ "${bUnix}" == "1" ]; then aBin="/home/_0/bin";   fi

#  echo "  aFRT_Home: '${aFRT_Home}', bUnix: ${bUnix}"; exit
#  echo "  aJPT_File: '${aJPT_Home}/JPT00_jpt_p1.sh'; bUnix: ${bUnix}";  exit

#  ------------------------------------------------------------------------

   aJPT="JPT00_jpt_"

   aVer=""
#  aVer="p1"

#  ------------------------------------------------------------------------

 function sayErr( ) {                                                                   # .(20420.02.3 RAM Use err msg function)
   echo ""; echo " * $1"; echo ""; exit
   }
#  --------------------------------------------------------------

 function chkScriptVer( ) {                                                             # .(20420.02.1 Beg RAM Check if JPT version exists)

        aFind="$( find . -name "${aJPT}*.sh" )";   # sayErr "ll ${aJPT}*.sh, aFind: '${aFind}'; len('$1'): ${#1}";
if [ "${aFind}" == "" ];                        then sayErr "No JPT script files exit for: '${aJPT}*.sh'"; fi

        aFind=$( echo "$1" | awk '/[ptu][0-2]?[.0-4]{0,3}/ { print 1 }' )
if [ "${aFind}" == "" ] && [ "$1" != "" ];      then sayErr "You can only install JPT script versions: p|p1|p2, t|t1|t2 or u|u1|u2, if they exist."; fi

#  ----------------------------------------------------

   if [ "${#1}" == "0" ]; then aFind="[ptu][.0-9]{1,3}.sh"; fi
   if [ "${#1}" == "1" ]; then aFind="$1[.0-9]{1,4}.sh"; fi
#  if [ "${#1}" == "2" ]; then aFind="$1[.0-9]{1,3}.sh"; fi
   if [ "${#1}" == "2" ]; then aFind="$1[.0-9]{0,4}.sh"; fi
   if [ "${#1}" == "5" ]; then aFind="$1.sh"; fi

#  echo                              "  ls -1 ${aJPT}*.sh | sort | awk '/${aFind}/   { print }'; \$1: '${1}',  len: ${#1} "
#  echo "---------------------------";  ls -1 ${aJPT}*.sh | sort | awk '/'${aFind}'/ { print "        " $0 }'; echo "---------------------------"
                                aVer=$( ls -1 ${aJPT}*.sh | sort | awk '/'${aFind}'/ { sub( /'${aJPT}'/, "" ); sub( /.sh/, "");  a = $0 }; END { print a }' )  # returns the last one
#  echo "aVer: ${aVer}";   # exit

#  ----------------------------------------------------

if [ "${aVer}" == "" ];                         then sayErr "No JPTools scripts, '${aJPT}$1.MM.sh', exist in the current folder."; fi

#  ----------------------------------------------------
   } # eof chkScriptVer                                                                 # .(20420.02.1 End)
#  ------------------------------------------------------------------------

   chkScriptVer "$1";      # echo "        JPT aVer: ${aVer}";     # exit
   aJPT=${aJPT}${aVer}.sh; # echo "       aJPT script: '${aJPT}'"; # exit

if [ ! -f "${aJPT}" ];                          then sayErr "The JPTools script, '${aJPT}', does not exist."; fi
if [ "${PATH/ome\/_0\/bin/}" == "${PATH}" ];    then sayErr "The folder, ${aBin}, is not in the PATH."; fi
if [ ! -d "${aBin}" ];                          then sayErr "The folder, ${aBin}, does not exist."; fi

#  ----------------------------------------------------

   jpt="jpt";         if [ "${aVer}" != "p1" ]; then jpt="jpt${aVer:1:1}"; fi           # .(20420.01.1 Beg RAM Put version number after JPT script, e.g. JPT2)
   JPTools="JPTools"; if [ "${aVer}" != "p1" ]; then JPTools="JPTools${aVer:1:1}"; fi

#  --------------------------------------------------------------

   aScr=$( echo '#!/bin/bash
#  JPTools Launch Script on rm212p-w10p

   aCmd="'${aJPT_Home}/${aJPT}'"

   if [ "$1" == "-v" ]; then echo ""; echo "  '${aJPT}'  ($( date "+%b %-d %Y %H:%M" ))" ; exit; fi

  "${aCmd}" "$@"
   ')
#  ----------------------------------------------------






#  ----------------------------------------------------                                 # .(20429.05.1 End)

if [ "test" != "text" ]; then

#  echo "aScr:"; echo "${aScr}";               exit  # print script
#  echo "aScr:"; echo "${aScr2//{Sub\}/KEYS}"; exit  # print script

   echo "${aScr}"               >"${jpt}"
   echo "${aScr}"               >"${JPTools}"
         chmod  755              "${jpt}"                                               # .(20429.06.1  RAM Removed sudo from chmod 777)
         chmod  755              "${JPTools}"

   echo "${aScr}"               >"${aBin}/${jpt}"
   echo "${aScr}"               >"${aBin}/$( echo ${JPTools} | awk '{ print tolower( $1 ) }' )"
         chmod  755              "${aBin}/${jpt}"
         chmod  755              "${aBin}/$( echo ${JPTools} | awk '{ print tolower( $1 ) }' )"










   fi
#  ----------------------------------------------------

   echo ""
   echo "  Installed JPTools script, ${jpt} into: '${aBin}/'"                           # .(20420.01.1 End)
   echo "    for: '${aJPT_Home}/${aJPT}'"

#  ----------------------------------------------------

if [ -f "${aBin}/${jpt}" ]; then                                                        # .(20420.01.2 Beg)
   echo ""
   echo "  You can now run ${jpt} commands, e.g. ${jpt} help:"
#  echo ""
            ${jpt} help
   fi
if [ ! -f "${aBin}/${jpt}" ];                   then sayErr "The JPT script, '${aBin}/${jpt}', was not installed properly."; fi
                                                                                        # .(20420.01.2 End)
# -------------------------------------------------------------------------------
