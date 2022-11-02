#!/bin/bash

         bDoit=1

         aFCd='FRT10'; aFile="${aFCs}_frt_p1.05.sh"
         aFCd='GitR1'; aFile="FRT22_${aFCd}_p2.02.sh"
         aFCd='JPFns'; aFile="JPT12_Main2Fns_p1.06.sh"

# ------------------------------------------------------------------------------------------------------------------------------

      if [ ! -f "${aFile}" ]; then
         echo ""
         echo " ** The file, '${aFile}' NOT FOUND"
#        echo ""
         exit
         fi
# ---------------------------------------------------------------

#       "##FD   %-25s                    |%7d    | %-15s         |%6d   | %s\n"
#               -------------------------+-------+---------------+------+-----------------
#       '##FD   JPT21_gitr.sh            |   9479| 11/25/21 8:35a|   136| v1.02.11003.01
#     6) ##FD   FRT22_GitR1_p2.02.sh     |  66322|  5/01/22 20:40|  1173| p2.02-20501-2040

         aTS=$( date '+%y%m%d-%H%M' ); aTS="\`${aTS:1}"; # echo "  aTS: '${aTS}'"; # exit
         aCnts="$( wc ${aFile} | awk '{ printf "%7d%6d\n", $3, $1 }' )";
         nSize=${aCnts:1:6};
         nLines=${aCnts:8:5}
         aDate="$( date '+%-m/%d/%y %H:%M' )"
#        aVer="p2.02-${aTS:1}"
         aVer=$( echo ${aFile} | awk '{ v = gensub( /.+[-_]([ptu][0-9.]+).sh/, "\\1", "g", $0 ); print v }' )
         aFle=$( echo ${aFile} | awk '{ sub( /_'${aVer}'/, ""); print }' )
         aVer="${aVer}-${aTS:1}"

# ---------------------------------------------------------------------------------------

aAWKscr1='
BEGIN{ }
       /##FD/        { printf "%4d) ##FD   %-25s| %6d| %14s| %5d| %s\n", NR, "'${aFle}'", '${nSize}', "'${aDate}'", '${nLines}', "'${aVer}'"; next }
       /'${aFCd}'\[/ { gsub( /'${aFCd}'\[[0-9 ]+\]/, "'${aFCd}'" sprintf( "[%3d]", NR ) ); printf "%4d) %s\n", NR, $0;    next }
END{ }
'
aAWKscr2='
BEGIN{ }
       /##FD/        { printf      "##FD   %-25s| %6d| %14s| %5d| %s\n",     "'${aFle}'", '${nSize}', "'${aDate}'", '${nLines}', "'${aVer}'"; next }
       /'${aFCd}'\[/ { gsub( /'${aFCd}'\[[0-9 ]+\]/, "'${aFCd}'" sprintf( "[%3d]", NR ) ); print; next }
       { print }
END{ }
'
# ------------------------------------------------------------------------------------------------------------------------------

         echo "aAWKscr:"; echo "---------------------------"; echo "${aAWKscr1}"; echo "---------------------------"; echo ""
         cat "${aFile}" | awk "${aAWKscr1}"

#        echo ""
#        aFile2=${aFile/.sh/${aTS}.sh}
         echo "  cp -p \"${aFile}\" \"${aFile/.sh/${aTS}.sh}\""
#        echo "  cp -p \"${aFile}\" \"${aFile2}\""

# ---------------------------------------------------------------

   if [ "${bDoit}" == "1" ]; then

                 cp -p  "${aFile}"  "${aFile/.sh/${aTS}.sh}"

         cat "${aFile/.sh/${aTS}.sh}" | awk "${aAWKscr2}" >"${aFile}"

         echo "  reNum '${aFile}' complete"
#        echo ""

         fi
# ------------------------------------------------------------------------------------------------------------------------------



