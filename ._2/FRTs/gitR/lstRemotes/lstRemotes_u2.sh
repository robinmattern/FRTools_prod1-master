#!/bin/bash

# --------------------------------------------------------------------------------------------------------------

function getRemotes( ) {

    cd $1

#   aProject="FormR_"
    aProject="$( pwd | awk '{ sub( /.+[\\/]/, "" ); print }' )";   # echo "aProject: '${aProject}'"; exit

    echo ""
#   echo " ${aProject}, rdir -r 2  '.git' -x '@'"
    echo " #####  <u>${aProject} -- '$( pwd )'</u>"
#   echo "------------------------------------------------------"
    echo ""

#   mGITs=$( rdir -r 2  '.git' -x '@' | awk '/.git$/ { print substr( $0, ($0 == ".git" ) ? 0 : 35 ) }' )
#   mGITs=$( rdir -r 2  '.git' -x '@' | awk '/.git$/ { a = substr( $0, 33 ); sub( /\.\//, "", a); print a }' )
    mGITs=$( rdir -r 2  '.git' -x '@' | awk '/.git$/ { a = substr( $0, 33 ); sub( /\.\//, "", a); print $2 $3 a }' )

#   echo "${mGITs}";  cd ..; return

if [ "${mGITs}" == "" ]; then cd ..; return; fi

    echo "| No. | Repository Account/Name                                      | Updated On       | F | P | Project/Stage                  | Remote Alias |"
    echo "| --- | ------------------------------------------------------------ | ---------------- | - | - | ------------------------------ | ------------ |"

#   ---------------------------------------------------------------------------------

    nNo=0
for aDir in ${mGITs}; do

    aDate="${aDir:0:16}"; aDate="${aDate:0:10} ${aDate:10:5}"
    aDir="${aDir:15}"
    nNo=$(( ${nNo} + 1 ))

#   echo " ${nNo}. aDir: '${aDir}', aDate: '${aDate}', pwd: '$( pwd )'";

aAWKpgm='
BEGIN{           aFile = FILENAME; sub( /\/.git\/config/, "", aFile ); aFile="'${aDir}'"; sub( /\/?\.git/, "", aFile ); } # print "aFile: " aFile; exit }

    /\[remote/ { aRepo = substr( $0, 10 ); sub( /"\]/, "", aRepo ) }
    /url =/    {
                 sub( /ram-github.com/, "    ram-github.com" ); sub( /\.git/, "" ); # print "|"  substr( $0, 27 ) "|"
                 sub( /github_/,        "        github_"    ); a = substr( $0, 27 ); split( a, mRepo, "/" )

               # printf "\n%-45s %-25s %s\n", "'${aProject}'/"aFile, aRepo, substr( $0, 8 )
                 printf "| %2d. | %19s/%-40s | %10s | N | L | %-30s | %-12s |\n", '${nNo}', mRepo[1], mRepo[2], "'${aDate}'", "'${aProject}'/"aFile, aRepo
                 }
END{ }'

#   awk '/url =/ { print FILENAME " " $0 }'  */.git/config
#   awk '/\[remote/ { aRepo = substr( $0, 10 ); sub( /"\]/, "", aRepo ) }; /url =/ { sub( /\/.git\/config/, "", FILENAME ); sub( /github_/, "        github_" ); printf "%-45s %-25s %s\n", "'${aProject}'/"FILENAME, aRepo, substr( $0, 8 ) }' "${aDir}/config"

    awk "${aAWKpgm}" "${aDir}/config"

    done;
#   ----------------------------------------------
    echo ""

    cd ..
    }
# -------------------------------------------------------------------------

function isDir( ) {
         aFind="$1";        bChildOk=$3;  bRootOnly=$2
         aChild=""; if [ "${bChildOk}"  == "1" ]; then aChild="/.+"; fi
         aRoot="?"; if [ "${bRootOnly}" == "1" ]; then aRoot="$";    fi
         aDir="$( pwd | awk '{ nPos = match( tolower($0), "'"/${aFind}(${aChild})${aRoot}"'", a ); print a[0] }' )"
 echo "${aDir:1}"
         }
# --------------------------------------------------------------

    echo "<body><style> table { border-spacing: 0; border-collapse: collapse; margin-top: -25px; }"
    echo "                 td { padding: 1px 7px 1px 7px; font-size: 13px; } th { font-size: 15px; }"
    echo "     td:first-child { text-align: right; } </style>"
    echo ""

#   ----------------------------------------

#       aApps="nodeapps"
#       aApps="reactapps"
#       aApps="repos"

        aApps="$1"
if [ "${aApps}" == "" ]; then aApps=$( isDir 'repos'    ); fi
if [ "${aApps}" == "" ]; then aApps=$( isDir 'nodeapps' ); fi
if [ "${aApps}" == "" ]; then echo "oops"; exit; fi

#       echo "aApps: '${aApps}'"; exit

#   ----------------------------------------

 if [ "${aApps}" == "nodeapps" ]; then

#    cd nodeapps

    for aDir in $( ls -1 ); do

     if [ -d "${aDir}" ]; then
#       echo "getRemotes ${aDir}"
              getRemotes ${aDir}
        fi
        done
        exit

#       getRemotes "FRTools_"; exit
        getRemotes "FormR_"; exit

        getRemotes "ArtWyrk_"
        getRemotes "Carousels"
        getRemotes "Discord"
        getRemotes "FormR"
        getRemotes "FormR_"

        getRemotes "FRApps"
        getRemotes "FRApps_"

        getRemotes "FRDocs"
        getRemotes "FRDocs_"
        getRemotes "FRER_"
        getRemotes "FRTools_"
        getRemotes "MyProject"
        getRemotes "SimpleApp_"
        getRemotes "SimpleReactApps"
        getRemotes "SimpleReactApps_"
        getRemotes "Traversy-Bootcamp"
    fi
#   ----------------------------------------

 if [ "${aApps}" == "reactapps" ]; then

 cd reactapps

    getRemotes "ReactQuery"
    fi
#   ----------------------------------------

 if [ "${aApps}" == "reactapps" ]; then

 cd FRTools_v11203

    getRemotes "FRTools_v11203"
    fi
#   ----------------------------------------

 if [ "${aApps}" == "repos" ]; then

#   getRemotes "FRApps_"; exit

    getRemotes "50projects";
    getRemotes "BasicTraining";
    getRemotes "FRApps"; # exit
    getRemotes "FRApps_"
    getRemotes "FRApps_basic-training-robin"
    getRemotes "FRTools"
    getRemotes "dotenv"
    fi
#   ----------------------------------------

