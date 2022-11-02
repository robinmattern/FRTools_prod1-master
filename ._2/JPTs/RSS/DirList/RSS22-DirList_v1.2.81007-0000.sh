#!/bin/bash
#*\
##=========+====================+================================================+
##RD         DirList            | RSS Dir Lister
##RFILE    +====================+=======+===================+======+=============+
##FD   RSS22-DirList.sh         |   6390| 10/07/18  4:12:00a|   136| v1.2.81007
##DESC     .--------------------+-------+-------------------+------+------------+
#
#
##LIC      .--------------------+----------------------------------------------+
#            Copyright (c) 2018 SicommNet-JPT * Released under
#            MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+-------+-------------------+------+-----------+
#
##CHGS     .--------------------+-------+-------------------+------+-----------+
# .(81007.01 10/07/18 RAM  2:00a| Created
# .(81007.03 10/07/18 RAM  2:00a| Get rid of ErrorLog 
# .(81007.04 10/07/18 RAM  8:00a| Add quotes  
##PRGM     +====================+===============================================+
##ID 69.600. Main               |
##SRCE     +====================+===============================================+
#*/
          LIB=RSS; LIB_LOG=${LIB}_LOG; LIB_USER=${LIB}_USER                                 # .(80923.01.1)

function logIt() {                                                                          # .(80920.02.1)
         aFncLine="$1[$2]             "; aFncLine="${aFncLine:0:17} $3";
#        aFncLine="${aFncLine/ \//\/}";  aFncLine="${aFncLine/ C:/C:}";  aFncLine="${aFncLine/ D:/D:}";  aFncLine="${aFncLine/ M:/M:}";
  if [ -f "$LIB_LOG" ]; then echo "$( date '+%Y%m%d-%H%M%S%z')  ${SCN_SERVER:0:11} ${LIB_USER:0:8}  ${aFncLine}" >>"$LIB_LOG"; fi
         }
# +------- +------------------ +----------------------------------------------------------- # ------------+ ------------------- # --------------+

   aDir=$1; if [ "$1" = "" ]; then aDir="."; fi
   nLvl=$2; if [ "$2" = "" ]; then nLvl=1;   fi
   aTyp=$3; if [ "$3" = "" ]; then aTyp=2;   fi   # 1)Names only, 2)Sizes only, 3)Files and Dirs
   aNums="123456789" 
   
   if [ -z "${aNums##*$aDir*}" ]; then aTyp=${nLvl}; nLvl=${aDir}; aDir="."; fi 

#  echo "  aDir: ${aDir}; nLvl: ${nLvl}; aTyp: ${aTyp}"  
#  exit
#HELP
#---------------------------------------------------------------

#if [ "${aCmd}" == ""        ]; then aCmd=help; fi
 if [ "${aCmd}" ==  "-help"  ]; then aCmd=help; fi
 if [ "${aCmd}" == "--help"  ]; then aCmd=help; fi
 if [ "${aCmd}" == "help"    ]; then

       echo "" 
       echo "  List Directory File Counts and Sizes"
       echo "  -----------------------------------------  ------------------------------------------------------------------"                                         
       echo "    Dir List  {Dir}        {Level} {Typ}    Display NFS Directories, down to level {Level}"
       echo "                                   {Typ}      1)Names only, 2)Sizes only, 3)Files and Dirs"
       echo "" 
       exit 
   fi
#  ------------------------------------------------------------------------------------------

function getCnts1() {
   a=$1; if [ ! "${a/lost+found/}" = "$a" ]; then return; fi
#  printf "%12s %7s %6s     %s\n" "" "" "" $1
   printf "%12s %9s %7s  %s\n" "" "" "" $1
   }

function getCnts2() {
   a=$1; if [ ! "${aDir}/lost+found/" = "$a" ]; then return; fi

#  echo "" 
#  printf "aSize:%6d == du -L -b --max-depth=0 "$1"\n"        
#  printf "aFles:%6d == ls -l -L -R "$1" | grep ^- | wc -l\n" 
   printf "aDirs:%6d == ls -l -L -R "$1" | grep ^d | wc -l\n" 
   return 

   nSize=999; nFles="-"; nDirs="-"
if [ ! "$aTyp" = "2" ]; then
   nFles=$( ls -l -L -R  $1  2>/dev/null | grep ^- | wc -l )  # Counts number of files in all subfolders (takes a long time)
#  nDirs=$( ls -l -L -R  $1  2>>$aErrLog | grep ^d | wc -l )  # Counts number of folders in all subfolders (takes a long time)
#  nDirs=$( ls -l -L -R  $1  2>/dev/null | grep ^d | wc -l )  ##.(81007.03.1)
   nDirs=$( ls -l -L -R "$1" 2>/dev/null | grep ^d | wc -l )  # .(81007.04.1 Add quotes)
   fi

#  nSize=$( du -L    --max-depth=0 $1 2>>$aErrLog  )          # Counts number of bytes in all subfolders (quick)
   nSize=$( du -L    --max-depth=0 $1 2>/dev/null )           ##.(81007.03.2)
   nSize=$( du -L -b --max-depth=0 $1 2>/dev/null )           ##.(81007.04.1 Display bytes)

#  nSize=$( echo $nSize | sed 's/\x0*/ /' )
   aStrc=$( echo $nSize | awk '{ sub(/ .*/,""); print }' )
#  echo "'$nSize' '${aStrc}'"   # '2152308188/data' '2152308188'

#  echo "" 
#  printf "aSize:%6d == du -L -b --max-depth=0 $1\n"        ${aStrc}
#  printf "aFles:%6d == ls -l -L -R $1 | grep ^- | wc -l\n" ${nFles}
#  printf "aDirs:%6d == ls -l -L -R $1 | grep ^d | wc -l\n" ${nDirs}
#  return 
 
#  if [[ ${#aStrc} -gt 8 ]]; then aStrc=`expr $aStrc / 1000`; s="${aStrc}K"; fi   # results is a neg number ??

#  printf "%12d %7d %6d     %s\n" $s $a     $b     $1
#  printf "%12s %9s %7s  %s\n" $aStrc $nFles $nDirs $1
#  printf "%12s %9s %7s  %s/\n" $aStrc $nFles $nDirs  $1
   printf "%12s %9s %7s  %s/\n" $aStrc $nFles $nDirs "$1"     # .(81007.04.2 Add quotes)
   }
#  ------------------------------------------------------------------------------------------

 if [ "$aErrLog" = "" ]; then
   aDte=$(date +%y%m%d.%H%M); aDte=${aDte:1}
   aErrLog=sc${aDte}_dirlist-errors.log
if [ ! "$aTyp" = "1" ]; then
#  echo "" >$aErrLog                          ##.(81007.03.3)
   aErrLog=""                                 # .(81007.03.3)
   fi; fi

if [ "$bHdr" != "0" ]; then
   s="s"; if [ "${nLvl}" == "1" ]; then s=""; fi 
   echo ""
   echo " Folder Size  Files     Dirs    Path (${aDir} - ${nLvl} level$s)"
#  echo " ----------- ------- ------      ---------------------------------------------------"
#  echo " +---------- +-------- +------ +----------------------------+-------------------+---------- +-------------+"    # .(81005.02.2)
   echo "+--,--,--,-- +-------- +------ +----------------------------+-------------------+---------- +-------------+"    # .(81005.02.2)
 
  fi
   
if [   "$aTyp" = "1" ]; then
#  find $aDir -maxdepth $nLvl -type d 2>>$aErrLog | while read -r dir; do getCnts1 "$dir"; done   ##.(81007.03.4)
   find $aDir -maxdepth $nLvl -type d 2>/dev/null | while read -r dir; do getCnts1 "$dir"; done
  else
#  find $aDir -maxdepth $nLvl -type d 2>>$aErrLog | while read -r dir; do getCnts2 "$dir"; done   ##.(81007.03.5)
   find $aDir -maxdepth $nLvl -type d 2>/dev/null | while read -r dir; do getCnts2 "$dir"; done
   fi

if [ "$bHdr" != "0"  ]; then
   echo ""
   fi
#  ------------------------------------------------------------------------------------------




# +------- +------------------ +----------------------------------------------------------- # ------------+ ------------------- # --------------+
#*\
##SRCE     +====================+===============================================+
##RFILE    +====================+=======+===================+======+=============+
#*/
