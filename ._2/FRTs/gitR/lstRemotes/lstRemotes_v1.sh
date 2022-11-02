#!/bin/bash


function getRemotes( ) {
    cd $1

#   mGITs=$( rdir -r 2  '.git' -x '@' | awk '/.git$/ { print substr( $0, ($0 == ".git" ) ? 0 : 35 ) }' )
    mGITs=$( rdir -r 2  '.git' -x '@' | awk '/.git$/ { a = substr( $0, 33 ); sub( /\.\//, "", a); print a }' )
#   echo "${mGITs}"
#   cd ..; return

    aProject="FormR_"
    aProject="$( pwd | awk '{ sub( /.+[\\/]/, "" ); print }' )";   # echo "aProject: '${aProject}'"; exit

for aDir in ${mGITs}; do
#   echo " aDir: ${aDir}"
    awk '/\[remote/ { aRepo = substr( $0, 10 ); sub( /"\]/, "", aRepo ) }; /url =/ { sub( /\/.git\/config/, "", FILENAME ); sub( /github_/, "        github_" ); printf "%-45s %-25s %s\n", "'${aProject}'/"FILENAME, aRepo, substr( $0, 8 ) }' "${aDir}/config"
#   awk '/url =/ { print FILENAME " " $0 }' */.git/config
    done;
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

    getRemotes "FRTools_"
    exit

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

    getRemotes "50projects"
    getRemotes "BasicTraining"
    getRemotes "FRApps"
    getRemotes "FRApps_"
    getRemotes "FRApps_basic-training-robin"
    getRemotes "FRTools"
    getRemotes "dotenv"
    fi
#   ----------------------------------------

