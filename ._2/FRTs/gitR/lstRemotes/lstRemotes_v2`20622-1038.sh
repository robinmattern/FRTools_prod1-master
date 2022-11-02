#!/bin/bash

    echo "<body><style> table { border-spacing: 0; border-collapse: collapse; }"
    echo "                 td { padding: 1px 7px 1px 7px; font-size: 13px; }"
    echo "     td:first-child { text-align: right; } </style>"
    echo ""

function getRemotes( ) {

    cd $1

#   aProject="FormR_"
    aProject="$( pwd | awk '{ sub( /.+[\\/]/, "" ); print }' )";   # echo "aProject: '${aProject}'"; exit

    echo ""
#   echo " ${aProject}, rdir -r 2  '.git' -x '@'"
    echo " ### ${aProject}, '$( pwd )'"
#   echo "------------------------------------------------------"
    echo ""
    echo "| No. | Repository Account/Name                                      | Updated On       | F | P | Project / Stage                | Remote Name"
    echo "| --- | ------------------------------------------------------------ | ---------------- | - | - | ------------------------------ | --------------------------"

#   mGITs=$( rdir -r 2  '.git' -x '@' | awk '/.git$/ { print substr( $0, ($0 == ".git" ) ? 0 : 35 ) }' )
#   mGITs=$( rdir -r 2  '.git' -x '@' | awk '/.git$/ { a = substr( $0, 33 ); sub( /\.\//, "", a); print a }' )
    mGITs=$( rdir -r 2  '.git' -x '@' | awk '/.git$/ { a = substr( $0, 33 ); sub( /\.\//, "", a); print $2 $3 a }' )

if [ "${mGITs}" == "" ]; then cd ..; return; fi

#   echo "${mGITs}";  cd ..; return

#   ----------------------------------------------

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
                 printf "| %2d. | %19s/%-40s | %10s | N | L | %-30s | %-20s |\n", '${nNo}', mRepo[1], mRepo[2], "'${aDate}'", "'${aProject}'/"aFile, aRepo
                 }
END{ }'

#   awk '/url =/ { print FILENAME " " $0 }'  */.git/config
#   awk '/\[remote/ { aRepo = substr( $0, 10 ); sub( /"\]/, "", aRepo ) }; /url =/ { sub( /\/.git\/config/, "", FILENAME ); sub( /github_/, "        github_" ); printf "%-45s %-25s %s\n", "'${aProject}'/"FILENAME, aRepo, substr( $0, 8 ) }' "${aDir}/config"

    awk "${aAWKpgm}" "${aDir}/config"

    done;
#   ----------------------------------------------

    cd ..
    }
# -------------------------------------------------------------------------

#   getRemotes "FRApps"
#   getRemotes "FRApps_"
#   exit

#   ----------------------------------------

#   aApps="nodeapps"
#   aApps="reactapps"
    aApps="repos"


 if [ "${aApps}" == "nodeapps" ]; then

 cd nodeapps

#   getRemotes "FRTools_"; exit

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

