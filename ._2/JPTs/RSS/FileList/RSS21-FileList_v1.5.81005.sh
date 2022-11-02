#!/bin/bash
#*\
##=========+====================+================================================+
##RD         FileList           | RSS File Lister
##RFILE    +====================+=======+=================+======+===============+
##FD   RSS21-FileList.sh        |   9479| 10/08/18  1:48a |   136| v1.5.81008.01
##DESC     .--------------------+-------+-----------------+------+---------------+
#
#
##LIC      .--------------------+----------------------------------------------+
#            Copyright (c) 2018 SicommNet-JPT * Released under
#            MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+-------+-------------------+------+-----------+
#
##CHGS     .--------------------+-------+-------------------+------+-----------+
# .(80916.01  9/16/18 RAM  3:26p| Add source command
# .(80916.02  9/16/18 RAM  8:15a| Add version
# .(80916.03  9/17/18 RAM  2:08p| Add Header
# .(80920.03  9/20/18 RAM  3:00p| Change heading; Add LogIt for old heading
# .(80923.03  9/23/18 RAM  6:50a| Change JPT to RSS
# .(80925.04  9/25/18 RAM  6:25a| Replace % with *
# .(81005.01 10/05/18 RAM 10:00p| Fix sort sequence
# .(81005.02 10/05/18 RAM 11:30p| Make -s 3 the default
# .(81008.01 10/08/18 RAM  1:45a| Always sort by Date-Time 2nd 
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

    nMaxDepth=1; i=-1;                                                                                                          ##.(60506.01.1)
#hile [[ $# > 1 ]]; do key="$1"; # echo "key: '${key}', \$2: '$2'"
while [[ $# > 0 ]]; do key="$1"; # echo "key: '${key}', \$2: '$2'"
                                                                                       aExcl="node_mod|bower_comp|.git"         # .(80118.01.1)
   case $key in
       -r|-R)  if [ "${2:0:1}" != "-" ] && [ ! -z $2 ]; then nMaxDepth=$2; shift; else nMaxDepth=99;                fi; ;; # echo "nMaxDepth: $nMaxDepth"; ;;
       -d|-D)  if [ "${2:0:1}" != "-" ] && [ ! -z $2 ]; then nDays=$2;                       shift;                 fi; ;; # echo "nDays: $nDays"; ;;
       -m|-M)  if [ "${2:0:1}" != "-" ] && [ ! -z $2 ]; then nMths=$2; nDays=$[nMths * 30];  shift;                 fi; ;; # echo "nDays: $nDays"; ;;
       -s|-S)  if [ "${2:0:1}" != "-" ] && [ ! -z $2 ]; then nSort="$2";   shift; else nSort="2";                   fi; ;; # echo "nSort: $nSort"; ;;
       -x|-X)  if [ "${2:0:1}" != "-" ] && [ ! -z $2 ]; then aExcl="$2";   shift; else aExcl="node_mod|bower_comp"; fi; ;; # echo "aExcl: $aExcl"; ;;
       -f|-F)  if [ "${2:0:1}" != "-" ]               ; then bFile="1" ;                     shift;                 fi; ;; # echo "bFile: $bFile"; ;;
       -h|--help)                                            aHelp=true;             ;;
       source)                                               bSrce=true;             ;;     # .(80916.01.1)
       -v|version)                                           bVersion=true;          ;;     # .(80916.01.2)
       *)                         i=`expr $i + 1`;           mArgs[$i]="$key";       ;;     # .(60506.01.2)
    esac;
    shift;
   done
# +------- +------------------ +----------------------------------------------------------- # ------------+ ------------------- # --------------+

#             if [ "${1:0:1}" != "-" ];                then mArgs[i++]="$1"; fi
#
# a="."; b='*'; opt="-maxdepth 1"
# echo "mArgs: '${mArgs[*]}', len=${#mArgs[*]}, bSrc: ${bSrc}, bVersion: ${bVersion}"

#  if [ ${#mArgs[*]} = 1 ];   then if [ ! -d  ${mArgs[0]}  ]; then   ##.(60910.01.1 if 1st arg is a folder, use it)
   if [ ${#mArgs[*]} = 1 ];   then if [ ! -d "${mArgs[0]}" ]; then   # .(70930.01.1 opps)
       mArgs[1]=${mArgs[0]};  mArgs[0]="."; fi; fi

       opt="-maxdepth ${nMaxDepth}"; aNum=""
  if [   -z "${mArgs[0]}" ]; then aDir="."; else aDir="${mArgs[0]}";     fi
  if [   -z "${mArgs[1]}" ]; then aStr='*'; else aStr="*${mArgs[1]}*";   fi; aSearch="-iname \"${aStr}\""
  if [ ! -z "${nDays}"    ]; then aSearch="-mtime -${nDays} ${aSearch}"; fi

                                                                     aSort=" | sort -k4";    # .(81005.02.1)                
  if [ ! -z "${nSort}"    ]; then if [ "${nSort:0:1}" == "1" ]; then aNum="n";  fi
                                  if [ "${nSort:0:1}" == "2" ]; then aNum=",3"; fi
                                  if [ "${nSort:0:1}" == "3" ]; then nSort=4${nSort:1:1}; fi
                                                                     aSort=" | sort -k${nSort:0:1}${aNum}";
                                  if [ "${nSort:1:1}" == "r" ]; then aSort="${aSort}r";   fi
                                  if [ "${nSort:0:1}" == "0" ]; then echo "don't sort";   fi 
                                  if [ "${nSort:0:1}" == "0" ]; then aSort="";  fi           # .(81005.02.2)                
                                  fi 
  if [ ! -z "${aExcl}"    ]; then      aExclude=" | awk '/${aExcl}/ { next }; { print}'"; aExcl=" -x '${aExcl}'"; fi; # echo "aExclude: '${aExclude}'"

  if [ ! -z "${bSrce}"    ]; then echo ""; echo $0 | awk '{                         print "  '$LIB' ScriptFile: " $0 }'; echo ""; exit; fi # .(80916.01.3)
  if [ ! -z "${bVersion}" ]; then echo ""; echo $0 | awk '{ gsub( /.+_v|.sh/, "" ); print "  '$LIB' Version: "    $0 }'; echo ""; exit; fi     # .(80916.01.4)

  if [ ! -z "${aHelp}"    ]; then
  echo ""
  echo " Syntax: dir [Path] [Opts] [SearchPattern]"
  echo "    Path:            Optional, defaults to '.'"
  echo "    Opts: -r [n]     Search [n] directory levels, defaults to 99"
  echo "          -d [n]     Search files saved in last [n] days, defaults to 1"
  echo "          -m [n]     Search files saved in last [n] months, defaults to 1"
  echo "          -s [n]     Sort output 1)Size, 2)Date & Time, 3)[path]/Filename"
  echo "          -s [n[r]]  Reverse sort order, defaults to 2r"
  echo "          -x [str]   Exclude RegEx pattern from result, defaults to 'node_mod|bower_comp'"
  echo "    SearchPattern:   Unix Find -iname search string, use % instead of *"
  echo ""
    else
           aSearch=${aSearch/\%/\*}                                                         # .(80925.04.1)

  logIt "${LIB}21-FileList" 0 " find \"${aDir}\" $opt ${aSearch}${aSort}${aExcl}"           # .(80920.03.1)

  echo ""
# echo "        find \"${aDir}\"" $opt -iname "'"${aStr}"'"
# echo "        find \"${aDir}\" $opt ${aSearch}${aSort}${aExcl}"                           ##.(80920.03.2)
# echo "    Size       Date Time        Path/File: $aDir/$aStr"                             # .(80920.03.2)
# echo "    Size       Date Time        $aDir/$aStr"                                        # .(80920.03.2).(80925.04.2)
  echo "    Size       Date Time        $aDir/${aStr/\%/\*}"                                # .(80925.04.2)

  if [ ! -z "${bFile}" ]; then
  echo "  ----------  ----------------  -------------------------------------------------------------------------------------------------------------  ------------------"
          aFmt='  %10s  %TY-%Tm-%Td %TH:%TM  %-110p %f \n';
    else
# echo "  ----------  ----------------  -----------------------------------------------------"                          ##.(80920.03.3)
# echo " ----------  ----------------  +-------------------------+---------+---------+----------------------------+"    # .(80920.03.3)
  echo "  +--------- +---------------- +----------------------------+-------------------+---------- +-------------+"    # .(81005.02.2)
          aFmt='  %10s  %TY-%Tm-%Td %TH:%TM  %p\n';  # echo "aFmt '${aFmt}'"
      fi

# aCmd="find \"${aDir}\" $opt ${aSearch} -printf \"  %10s  %TY-%Tm-%Td %TH:%TM  %p\n\"";      echo "aCmd: '${aCmd}'"
  aCmd="find \"${aDir}\" $opt ${aSearch} -printf \""${aFmt}"\"";                            # echo "aCmd: '${aCmd}'"

# aSort=" LC_ALL=C ${aSort/ -k/-f -k}"  # .(81005.02.1 Fix ignoring punctuation; sort by "!.1AaBb_") 
# if [ "${aSort}" != "" ]; then aSort=" | LC_ALL=C sort -f ${aSort:8}"; fi                  # .(81005.02.1 Fix ignoring punctuation; sort by "!.1AaBb_") 
  if [ "${aSort}" != "" ]; then aSort=" | LC_ALL=C sort -f ${aSort:8} -k2,3"; fi            # .(81008.01.1 Always sort by Date-Time 2nd) 

# echo "${aCmd}${aExclude}${aSort}"
  eval "${aCmd}${aExclude}${aSort}"
  echo ""
    fi
# +------- +------------------ +----------------------------------------------------------- # ------------+ ------------------- # --------------+
#*\
##SRCE     +====================+===============================================+
##RFILE    +====================+=======+===================+======+=============+
#*/
