#!/bin/bash

#   aSSH_Host=vultr-formr1-nimda;

 if [ -f ".env" ]; then
    aHomePage="$( cat package.json | awk '/homepage/ { sub( /"\//, "" ); gsub( /[",]/, "" ); print $2   }' )"
    aDomain="$(   cat ".env" | awk '/DOMAIN/   { gsub( /[":=]/, " " ); a = $2 }; END { print a ? a : "" }' )"
    aSSH_Host="$( cat ".env" | awk '/SSH_HOST/ { gsub( /[":=]/, " " ); a = $2 }; END { print a ? a : "" }' )"
    aPrjApp="$(   cat ".env" | awk '/PROJECT/  { gsub( /[":=]/, " " ); a = $2 }; END { print a ? a : "" }' )"

    aProject="$( echo "${aPrjApp}" | awk '{ sub( /\/.+/, ""); print }' )"
    aAppDir="$(  echo "${aPrjApp}" | awk '{ sub( /.+\//, ""); print }' )"
    fi
 if [ "${aAppDir}" == "" ]; then
# __dirName="$( dirname $0 )"; cd "${__dirName}"; __dirName="$( pwd -P )"
                                                  __dirName="$( pwd -P )"
    aAppDir="$( echo "${__dirName}" | awk '{ n = split( $0, a, "/" ); print a[ n-1 ]"/"a[ n ] }' )"
    aAppDir="$( echo "${aAppDir}"   | awk 'BEGIN {IGNORECASE = 1} { sub( /(client|server)\//, "" ); print }' )"  # remove /client or /server
    fi
                                if [ "$1" != "" ]; then aSSH_Host=$1; fi
    aWebsDir=/webs/${aProject}; if [ "$2" != "" ]; then aWebsDir=$2;  fi
                                if [ "$3" != "" ]; then aAppDir=$3; fi
    aBuildDir=build;            if [ "$4" != "" ]; then aBuildDir=$4; fi

#   -------------------------------------------------------------------------------------------

 if [ "${aSSH_Host}" == "" ]; then

    echo ""
    echo "  Usage: ./deploy.sh {SSH_Host} {WebsDir} {BuildDir}"
    echo ""
    echo "   After running, npm run build, deploy the static React files to remote host server"
    echo ""
    echo "   {SSH_Host} - must be in .ssh/config for SSH and SCP to login to remote server"
    echo "   {WebsDir}  - path to web folder in remote server, e.g. /webs/FRApps"
    echo "                note: web files are saved to {WebsDir}/client/{AppName}/{BuildDir}"
    echo "   {BuildDir} - local f older containing static React Files. Default: build"
    echo ""
    exit
    fi
#   -------------------------------------------------------------------------------------------

#   echo "  __dirName: '${__dirName}'";
#   echo "    aAppDir:   '${aAppDir}'";
#   echo "    RemoteDir: '${aWebsDir}/${aAppDir}/${aBuildDir}'"
#   echo "    aSSH_Host: '${aSSH_Host}'";  # exit

    echo ""
    echo "*************************************************************************************************"
    echo ""
    echo "  Copying NGinx files from ./etc-nginx/* to: ${aSSH_Host}:/etc/nginx/*"
    echo ""
    echo "  $ scp -r etc-nginx/* ${aSSH_Host}:/etc/nginx/"
    echo ""
              scp -r etc-nginx/* ${aSSH_Host}:/etc/nginx/

    echo "*************************************************************************************************"
    echo ""
    echo "  Copying React files from ./${aBuildDir}/* to: ${aSSH_Host}:${aWebsDir}/${aAppDir}/${aBuildDir}/*"
    echo ""
    echo "  $ ssh  ${aSSH_Host}  mkdir -p ${aWebsDir}/${aAppDir}/${aBuildDir}/"
    echo "  $ scp -r build/* ${aSSH_Host}:${aWebsDir}/${aAppDir}/${aBuildDir}/"
    echo ""
              ssh  ${aSSH_Host}  mkdir -p ${aWebsDir}/${aAppDir}/${aBuildDir}/   >/dev/null 2>&1
              scp -r build/* ${aSSH_Host}:${aWebsDir}/${aAppDir}/${aBuildDir}/

    echo "*************************************************************************************************"
    echo ""
    echo "  App, http:/${aDomain}/${aHomePage}, deployed at: $( date '+%Y-%m-%d %H:%M' )"
    echo ""
