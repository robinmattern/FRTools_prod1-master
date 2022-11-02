#!/bin/bash
#!/bin/bash
#*\
##=========+====================+================================================+
##RD         makConfs           | JScriptWare Power Tools
##RFILE    +====================+=======+=================+======+===============+
##FD   FRT21_Proxy.sh           |   9479|   4/16/22  4:16a|   136| v1.05.20417.011
##DESC     .--------------------+-------+-----------------+------+---------------+
#            Create Proxy .conf files for Static, Express and React websites
#            resources.
#
##LIC      .--------------------+----------------------------------------------+
#            Copyright (c) 2022 8020 Data Services* Released under
#            MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+-------+-------------------+------+-----------+
#                               |
#                               |
#                               |
##CHGS     .--------------------+-------+-------------------+------+-----------+
# .(21001.01 10/01/20 RAM 10:00p| Created

##PRGM     +====================+===============================================+
##ID 69.600. Main               |
##SRCE     +====================+===============================================+
#*/
#             ./getFile.sh "FRTs/Proxy" "makNginxConf.njs"; exit
#             ./getFile.sh "FRTs/Proxy" "makNginxConf.njs" -noisy; exit
#   aFile="$( ./getFile.sh "FRTs/Proxy" "makNginxConf.njs" -noisy | awk '/FOUND/ { sub( /: FOUND/, ""); print }' )"
#   aFile="$( ./getFile.sh "FRTs/Proxy" "makNginxConf.njs" )"

    aFile="$( dirname $0 )/makNginxConf_u6.03.njs"

#   echo "aFile: ${aFile}"; # exit
#   echo "aPackage.json: "${aAppDir}/package.json";   exit

    if [ ! -f "${aFile}" ]; then echo ""; echo " ** ${aScrDir/\// } script, '${aScript}' Not Found"; echo ""; exit; fi
    if [   -f "${aFile}" ]; then makNginxConf=${aFile}; fi

#   node "${makNginxConf}" -v; echo "   makNginxConf: '${makNginxConf}'"; exit

    if [ "$1" == "-v"  ]; then node "${makNginxConf}" -v; exit; fi

#   echo "  \${1:0:3}: '${1:0:3} "; # exit
                                     aQuiet="-q2"       # print summary vars, with save
    if [ "${1:0:3}" == "qui" ]; then aQuiet="-q1"; fi   # with save only
    if [ "${1:0:2}" == "-q"  ]; then aQuiet="-q1"; fi   # with save only
    if [ "${1:0:3}" == "-qu" ]; then aQuiet="-q1"; fi   # with save only
    if [ "${1:0:3}" == "-q1" ]; then aQuiet="-q1"; fi   # with save only
    if [ "${1:0:3}" == "-q2" ]; then aQuiet="-q2"; fi   # print summary vars, with save
    if [ "${1:0:3}" == "-q3" ]; then aQuiet="-q3"; fi   # print .conf files, no save
    if [ "${1:0:3}" == "-q4" ]; then aQuiet="-q4"; fi   # print vars only, no save
#   echo "  \${aQuiet}': '${aQuiet} "; # exit

    aAppDir="$( pwd )"
#   aAppDir="/c/WEBs/8020/Apps/FRApps_/prod1-robin/client/6c-my-custom-app"
#   aAppDir="/c/WEBs/8020/Apps/FRApps_/prod1-robin/client/5c-my-react-app"

#   cat "${aAppDir}/package.json"
#   cat "${aAppDir}/.env"

    aNgxDir="${aAppDir}/etc-nginx"

# ------------------------------------------------------------------------------------------------

    aTests='test0'
#   aTests='test2'
#   aTests='test1,test2,test3'

# ------------------------------------------------------------------------------------------------

if [ "${aTests/test0}" != "${aTests}" ]; then

    aHomePage="$( cat "${aAppDir}/package.json" | awk '/homepage/  { gsub( /[":,]/, " " ); a = $2 }; END { print a ? a : "none" }' )"
    aProject="$(  cat "${aAppDir}/.env"         | awk '/PROJECT/   { gsub( /[":=]/, " " ); a = $2 }; END { print a ? a : "none" }' )"
    aDomain="$(   cat "${aAppDir}/.env"         | awk '/DOMAIN/    { gsub( /[":=]/, " " ); a = $2 }; END { print a ? a : "none" }' )"
#   aProdPort="$( cat "${aAppDir}/.env"         | awk '/PROD_PORT/ { gsub( /[":=]/, " " ); a = $2 }; END { print a ? ":" a : "" }' )"
    aProdPort=""

    aHomePage="${aHomePage/\//}"        # aLeading slash becomes 'C:/Program Files/Git/${aHomePage}'   ????

 if [ "${aQuiet}" == "-q3" ]; then
    echo ""
    echo "    aProject:  '${aProject}'";
    echo "    aDomain:   '${aDomain}'";
    echo "    aHomePage: '${aHomePage}'";
    echo "    aProdPort: '${aProdPort}'";
    echo "    aNgxDir:   '${aNgxDir}'";
    echo "    aQuiet:    '${aQuiet}'";  # exit
 #  echo ""
    fi

#   node   "${makNginxConf}"  "custom-app"  formr-xxx-01.com:80   custom-app  ${aQuiet}
    node   "${makNginxConf}"  "${aProject}"  "${aDomain}" "${aHomePage}" "${aProdPort}"  "${aNgxDir}"  ${aQuiet}
    fi
# ------------------------------------------------------------------------------------------------

if [ "${aTests/test1}" != "${aTests}" ]; then

    aProject="FRApps/5c-my-react-app"
    aDomain="formr-xxx-01.com"
    aHomePage="none"
    aProdPort=""

 if [ "${aQuiet}" == "-q3" ]; then
    echo "    aProject:  '${aProject}'";
    echo "    aDomain:   '${aDomain}'";
    echo "    aHomePage: '${aHomePage}'";
    echo "    aProdPort: '${aProdPort}'";
    echo "    aNgxDir:   '${aNgxDir}'";
    echo "    aQuiet:    '${aQuiet}'";  # exit
    echo ""
    fi

#   node   "${makNginxConf}"  "custom-app"  formr-xxx-01.com:80   custom-app  ${aQuiet}
    node   "${makNginxConf}"  "${aProject}"  "${aDomain}" "${aHomePage}" "${aProdPort}"  "${aNgxDir}"  ${aQuiet}
    fi
# ------------------------------------------------------------------------------------------------

if [ "${aTests/test2}" != "${aTests}" ]; then

    aProject="FRApps/5c-my-react-app"
    aDomain="formr-xxx-01.com"
    aHomePage="5c-my-react-app"
    aProdPort=""

 if [ "${aQuiet}" == "-q3" ]; then
    echo "    aProject:  '${aProject}'";
    echo "    aDomain:   '${aDomain}'";
    echo "    aHomePage: '${aHomePage}'";
    echo "    aProdPort: '${aProdPort}'";
    echo "    aNgxDir:   '${aNgxDir}'";
    echo "    aQuiet:    '${aQuiet}'";  # exit
    echo ""
    fi

#   node   "${makNginxConf}"  "custom-app"  formr-xxx-01.com:80   custom-app  ${aQuiet}
    node   "${makNginxConf}"  "${aProject}"  "${aDomain}" "${aHomePage}" "${aProdPort}"  "${aNgxDir}"  ${aQuiet}
     fi
# ------------------------------------------------------------------------------------------------

if [ "${aTests/test3}" != "${aTests}" ]; then

    aProject="FRApps/5c-my-react-app"
    aDomain="formr-xxx-01.com"
    aHomePage="frapps/my-react-app"
    aProdPort=""

 if [ "${aQuiet}" == "-q3" ]; then
    echo "    aProject:  '${aProject}'";
    echo "    aDomain:   '${aDomain}'";
    echo "    aHomePage: '${aHomePage}'";
    echo "    aProdPort: '${aProdPort}'";
    echo "    aNgxDir:   '${aNgxDir}'";
    echo "    aQuiet:    '${aQuiet}'";  # exit
    echo ""
    fi

#   node   "${makNginxConf}"  "custom-app"  formr-xxx-01.com:80   custom-app  ${aQuiet}
    node   "${makNginxConf}"  "${aProject}"  "${aDomain}" "${aHomePage}" "${aProdPort}"  "${aNgxDir}"  ${aQuiet}
    fi
# ------------------------------------------------------------------------------------------------
