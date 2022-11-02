#!/bin/bash

         aFile="$( basename $1 )"
         aFCd="$2"

      if [ "${bDoit}"  == "" ]; then bDoit=0; fi
      if [ "${bQuiet}" == "" ]; then bQuiet=0; fi
      if [ "${aFCd}"   == "" ]; then aFCd="${aFile:0:5}"; fi

#        aFCd='GitR1'; aFile="FRT22_${aFCd}_p2.02.sh"
#        aFCd='JPFns'; aFile="JPT12_Main2Fns_p1.06.sh"
#        aFCd='FRT10'; aFile="${aFCd}_frt_p1.06.sh"
#        aFCd='{JPT}'; aFile="FRT90_frt_u1.06-MT.sh"
#        aFCd='JPT10'; aFile="JPT10_Main0_p1.06.sh"

      if [ "${aFCd}" == "FRT22" ]; then aFCd="GitR1"; fi
      if [ "${aFCd}" == "FRT23" ]; then aFCd="FRApp"; fi
      if [ "${aFCd}" == "JPT12" ]; then aFCd="JPFns"; fi
      if [ "${aFCd}" == "FRT90" ]; then aFCd="{JPT}"; fi

#        bDoit=0

# ------------------------------------------------------------------------------------------------------------------------------

      if [ ! -f "${aFile}" ]; then
         echo ""
         echo " ** The script file, '${aFile}', is not in the current folder."
#        echo ""
         exit
         fi

         echo "  - JPT13[ 32]  aFCd: '${aFCd}', aFile: '${aFile}'"

# ---------------------------------------------------------------

#       "##FD   %-25s                    |%7d    | %-15s         |%6d   | %s\n"
#               -------------------------+-------+---------------+------+-----------------
#       '##FD   JPT21_gitr.sh            |   9479| 11/25/21 8:35a|   136| v1.02.11003.01
#     6) ##FD   FRT22_GitR1_p2.02.sh     |  66322|  5/01/22 20:40|  1173| p2.02-20501-2040

         aTS=$( date '+%y%m%d-%H%M' ); aTS="\`${aTS:1}";  # echo "  aTS: '${aTS}'"; # exit
         aCnts="$( wc ${aFile} | awk '{ printf "%7d%6d\n", $3, $1 }' )";
         nSize=${aCnts:1:6}; nSize=$(( ${nSize} + 82 ))
         nLines=${aCnts:8:5}
         aDate="$( date '+%-m/%d/%y %H:%M' )"

#                                                            FRT90_frt_u1.06-MT.sh
#        aVer=$( echo ${aFile} | awk '{ v = gensub( /.+[-_]([ptu][0-9.]+).sh/,       "\\1", "g", $0 ); print v }' )
         aVer=$( echo ${aFile} | awk '{ v = gensub( /.+[-_]([ptu][0-9.]+)(-MT)*.sh/, "\\1", "g", $0 ); print v }' )
         aFle=$( echo ${aFile} | awk '{ sub( /_'${aVer}'/, ""); print }' )

         aVer="${aVer}-${aTS:1}";      aVn="v${aVer:1}"

# ---------------------------------------------------------------------------------------

aAWKscr1='
BEGIN{ n = 0 }
#      /##FD/ && n == 0 { printf "%4d) ##FD   %-25s| %6d| %14s| %5d| %s\n", NR, "'${aFle}'", '${nSize}', "'${aDate}'", '${nLines}', "'${aVer/-MT/}'"; n = 1; }
       /##FD/           { printf "%4d) %s\n", NR + n, $0 }
       /##DESC/         { printf "%4d) ##FD   %-25s| %6d| %14s| %5d| %s\n", NR, "'${aFle}'", '${nSize}', "'${aDate}'", '${nLines}', "'${aVer/-MT/}'"; n = 1; print "" }
       /'${aFCd}'\[/    { gsub( /'${aFCd}'\[[0-9 ]+\]/, "'${aFCd}'" sprintf( "[%3d]", NR + n ) ); printf "%4d) %s\n", NR + n, $0; next }
END{   }
'
aAWKscr2='
BEGIN{ n = 0 }
#      /##FD/ && n == 0 { printf      "##FD   %-25s| %6d| %14s| %5d| %s\n",     "'${aFle}'", '${nSize}', "'${aDate}'", '${nLines}', "'${aVer/-MT/}'"; n = 1; }
#      /##FD/           { printf      "%s\n",         $0; next }
       /##DESC/         { printf      "##FD   %-25s| %6d| %14s| %5d| %s\n",     "'${aFle}'", '${nSize}', "'${aDate}'", '${nLines}', "'${aVer/-MT/}'"; n = 1; }
       /'${aFCd}'\[/    { gsub( /'${aFCd}'\[[0-9 ]+\]/, "'${aFCd}'" sprintf( "[%3d]", NR + n ) ); print; next }
       { print }
END{ }
'
# ------------------------------------------------------------------------------------------------------------------------------

         aFile2="$( echo "${aFile}" | awk '{ sub( /_[ptu]/,  "_v"  ); print }' )"
#        aFile2="${aFile/.sh/${aTS}.sh}"; aFile2=$( echo "${aFile2}" | awk '{ sub( /_[ptu]/,  "_v"  ); print }' )"
#                   echo                "'{ sub( /\.sh/, \"${aTS}.sh\" );     sub( /_[ptu]/, \"_v\" ); print }'"
#                   echo "$aFile2" | awk '{ sub( /\.sh/, "'${aTS}'.sh" );     sub( /_[ptu]/,  "_v"  ); print }'
#        aFile2="$( echo "$aFile2" | awk '{ sub( /\.sh/, "'${aTS}'.sh" );     sub( /_[ptu]/,  "_v"  ); print }' )"

# ---------------------------------------------------------------

#   if [ "${bQuiet}" == "0" ] && [ "${bDoit}" == 1 ]; then
    if [ "${bQuiet}" == "0" ]; then

         echo ""
    if [ "${bDebug}" == "1" ]; then
         echo "aAWKscr2:"; echo "---------------------------"; echo "${aAWKscr2}"; echo "---------------------------"; echo ""
         fi
         cat "${aFile}" | awk "${aAWKscr1}"

         echo ""
#        echo "  cp -p \"${aFile}\" \"${aFile2}\""

         echo "  cp -p  '${aFile}' '${aFile2/.sh/${aTS}.sh}'"
         fi

# ---------------------------------------------------------------

   if [ "${bDoit}" == "1" ]; then

#        echo "  cp -p  '${aFile}' '${aFile2/.sh/${aTS}.sh}'"
                 cp -p  "${aFile}"  "${aFile2/.sh/${aTS}.sh}"

         cat "${aFile2/.sh/${aTS}.sh}" | awk "${aAWKscr2}" >"${aFile}"

         echo ""
         echo "  script '${aFile}' has been formatted."
#        echo ""

         fi
# ------------------------------------------------------------------------------------------------------------------------------



