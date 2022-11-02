#!/bin/bash


                                    bQuiet=1; aArg1=$1; aArg2=$1;
    if [ "${1:0:2}" == "-n" ]; then bQuiet=0; aArg1=$2; aArg2=$3; fi
    if [ "${2:0:2}" == "-n" ]; then bQuiet=0; aArg1=$1; aArg2=$3; fi
    if [ "${3:0:2}" == "-n" ]; then bQuiet=0; aArg1=$1; aArg2=$2; fi

    aScrDir="${aArg1}"
    aScript="${aArg2}"

#   echo "aScrDir: '${aScrDir}', aScript: '${aScript}', bQuiet: ${bQuiet}"; # exit

    aScrDir="FRTs/Proxy"
    aScript="makNginxConf.njs"
#    bQuiet=1

# ------------------------------------------------------------

function getFile( ) {
         aVer=$1; aPwd=$2
    if [ "${aFile}" == "" ]; then

    if [ "$3"  == "cd" ]; then cd ..; echo "cd .."; fi
    if [ "$4"  == "cd" ]; then cd ..; echo "cd .."; fi

#        aScr="$( dirname "$0"      )/._1/${aScrDir}/${aScript}"
         aScr="$( dirname "${aPwd}" )/${aVer}/${aScrDir}/${aScript}"

    if [ -f "${aScr}" ]; then aFile="${aScr}"; fi

    if [ "${bQuiet}" == "0" ]; then
          if [ "${aFile}"  != ""  ]; then  echo "${aScr}: FOUND"; fi
          if [ "${aFile}"  == ""  ]; then  echo "${aScr}"; fi
       fi;
    fi
    }
# ------------------------------------------------------------

           aTest="test4"

    if [ "${aTest}" == "test1" ]; then

    if [ "${aFile}" == "" ]; then        aScr="$( dirname "$0"       )/._1/${aScrDir}/${aScript}";  if [ -f "${aScr}" ]; then aFile="${aScr}"; fi; echo "${aScr}: '${aFile}'"; fi;
    if [ "${aFile}" == "" ]; then        aScr="$( dirname "$( pwd )" )/._3c/${aScrDir}/${aScript}"; if [ -f "${aScr}" ]; then aFile="${aScr}"; fi; echo "${aScr}: '${aFile}'"; fi;
    if [ "${aFile}" == "" ]; then        aScr="$( dirname "$( pwd )" )/._3s/${aScrDir}/${aScript}"; if [ -f "${aScr}" ]; then aFile="${aScr}"; fi; echo "${aScr}: '${aFile}'"; fi;
    if [ "${aFile}" == "" ]; then        aScr="$( dirname "$( pwd )" )/._2/${aScrDir}/${aScript}";  if [ -f "${aScr}" ]; then aFile="${aScr}"; fi; echo "${aScr}: '${aFile}'"; fi;
    if [ "${aFile}" == "" ]; then        aScr="$( dirname "$( pwd )" )/._1/${aScrDir}/${aScript}";  if [ -f "${aScr}" ]; then aFile="${aScr}"; fi; echo "${aScr}: '${aFile}'"; fi;
    if [ "${aFile}" == "" ]; then cd ..; aScr="$( dirname "$( pwd )" )/._2/${aScrDir}/${aScript}";  if [ -f "${aScr}" ]; then aFile="${aScr}"; fi; echo "${aScr}: '${aFile}'"; fi;
    if [ "${aFile}" == "" ]; then        aScr="$( dirname "$( pwd )" )/._1/${aScrDir}/${aScript}";  if [ -f "${aScr}" ]; then aFile="${aScr}"; fi; echo "${aScr}: '${aFile}'"; fi;
    if [ "${aFile}" == "" ]; then cd ..; aScr="$( dirname "$( pwd )" )/._1/${aScrDir}/${aScript}";  if [ -f "${aScr}" ]; then aFile="${aScr}"; fi; echo "${aScr}: '${aFile}'"; fi;
    if [ "${aFile}" == "" ]; then cd ..; cd ..; aScr="$( dirname "$( pwd )" )/._1/${aScrDir}/${aScript}";  if [ -f "${aScr}" ]; then aFile="${aScr}"; fi; echo "${aScr}: '${aFile}'"; fi;

    echo "------------------------------------------------------------------------------------------------"
        fi


    if [ "${aTest}" == "test2" ]; then

    getFile '._1'  "$0"
    getFile '._3c' "$( pwd )"
    getFile '._3s' "$( pwd )"
    getFile '._2'  "$( pwd )"
    getFile '._1'  "$( pwd )"
    getFile '._2'  "$( pwd )"  "cd"
    getFile '._1'  "$( pwd )"
    getFile '._1'  "$( pwd )"  "cd"
    getFile '._1'  "$( pwd )"  "cd"  "cd"

    echo "------------------------------------------------------------------------------------------------"
       fi


    if [ "${aTest}" == "test3" ]; then

    getFile '._1'  "$0"
    getFile '._3c' "$( pwd )"
    getFile '._3s' "$( pwd )"
    getFile '._2'  "$( pwd )"
    getFile '._1'  "$( pwd )"  "cd"
    getFile '._2'  "$( pwd )"
    getFile '._1'  "$( pwd )"  "cd"
    getFile '._1'  "$( pwd )"  "cd"  "cd"
    getFile '._1'  "$( pwd )"

    echo "------------------------------------------------------------------------------------------------"
       fi

    if [ "${aTest}" == "test4" ]; then

    getFile '._3c' "$( pwd )"                   # /webs/nodeapps/{Project}/{Stage}/{Platform}/._3c/
    getFile '._3s' "$( pwd )"                   # /webs/nodeapps/{Project}/{Stage}/{Platform}/._3s/
    getFile '._2'  "$( pwd )"
    getFile '._1'  "$( pwd )";  cd ..
    getFile '._2'  "$( pwd )"                   # /webs/nodeapps/{Project}/{Stage}/._2/
    getFile '._1'  "$( pwd )";  cd ..
    getFile '._1'  "$( pwd )";  cd ..;  cd ..   # /webs/nodeapps/{Project}/._1/
    getFile '._1'  "$( pwd )"                   # /webs/._1/
    getFile '._1'  "$0"                         #
    getFile '._4'  "$0"                         # /webs/nodeapps/{Project}/{Stage}/{Platform}/{App}/._4/

#   echo "aFile: ${aFile}"
    echo "${aFile}"

#   echo "------------------------------------------------------------------------------------------------"
       fi
