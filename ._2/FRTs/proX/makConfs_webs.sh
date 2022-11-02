#!/bin/bash

    aScrDir="FRTs/Proxy"
    aScript="makNginxConf.njs"

    aScriptDir=".";
    aFile=""

    if [ "${aFile}" == "" ]; then aScr="$( dirname "$0"    )/._1/${aScrDir}/${aScript}";  if [ -f "${aScr}" ]; then aFile="${aScr}"; fi; echo "${aScr}: '${aFile}'"; fi;

    if [ "${aFile}" == "" ]; then aScr="$( dirname "$( pwd )" )/._3c/${aScrDir}/${aScript}"; if [ -f "${aScr}" ]; then aFile="${aScr}"; fi; echo "${aScr}: '${aFile}'"; fi;
    if [ "${aFile}" == "" ]; then aScr="$( dirname "$( pwd )" )/._3s/${aScrDir}/${aScript}"; if [ -f "${aScr}" ]; then aFile="${aScr}"; fi; echo "${aScr}: '${aFile}'"; fi;
    if [ "${aFile}" == "" ]; then aScr="$( dirname "$( pwd )" )/._2/${aScrDir}/${aScript}";  if [ -f "${aScr}" ]; then aFile="${aScr}"; fi; echo "${aScr}: '${aFile}'"; fi;
    if [ "${aFile}" == "" ]; then aScr="$( dirname "$( pwd )" )/._1/${aScrDir}/${aScript}";  if [ -f "${aScr}" ]; then aFile="${aScr}"; fi; echo "${aScr}: '${aFile}'"; fi;

    cd ..                                                                                                                                 ; echo ""
    if [ "${aFile}" == "" ]; then aScr="$( dirname "$( pwd )" )/._2/${aScrDir}/${aScript}";  if [ -f "${aScr}" ]; then aFile="${aScr}"; fi; echo "${aScr}: '${aFile}'"; fi;
    if [ "${aFile}" == "" ]; then aScr="$( dirname "$( pwd )" )/._1/${aScrDir}/${aScript}";  if [ -f "${aScr}" ]; then aFile="${aScr}"; fi; echo "${aScr}: '${aFile}'"; fi;

    cd ..                                                                                                                                 ; echo ""
    if [ "${aFile}" == "" ]; then aScr="$( dirname "$( pwd )" )/._1/${aScrDir}/${aScript}";  if [ -f "${aScr}" ]; then aFile="${aScr}"; fi; echo "${aScr}: '${aFile}'"; fi;

    cd ..                                                                                                                                 ; echo ""
    if [ "${aFile}" == "" ]; then aScr="$( dirname "$( pwd )" )/._1/${aScrDir}/${aScript}";  if [ -f "${aScr}" ]; then aFile="${aScr}"; fi; echo "${aScr}: '${aFile}'"; fi;

 if [ ! -f "${aFile}" ]; then echo ""; echo " ** ${aScrDir/\// } script, '${aScript}' Not Found"; echo ""; exit; fi

    echo ""; echo "aScriptFile: '${aFile}'"; exit



  echo "App Code       URI                 Log                 .Conf file"
  echo "-------------- ------------------- ------------------- -----------------------------------------"
#  node   makeNginxConf.njs  FRApps/6c; exit

  node   makeNginxConf.njs  FRApps
  node   makeNginxConf.njs  my-react-app
  node   makeNginxConf.njs  react-app
  node   makeNginxConf.njs  FRApps/5c
  node   makeNginxConf.njs  FRApps/6c
  node   makeNginxConf.njs  Nginx2
  node   makeNginxConf.njs  iCat15
  node   makeNginxConf.njs  PrMo31


# C:\WEBs\8020\VMs\et218t\webs\nodeapps\FRApps_\prod1-robin\client\5c-my-react-app
# /c/WEBs/8020/VMs/et218t/webs/nodeapps/FRApps_/prod1-robin

# '/c/WEBs/8020/VMs/et218t/webs/nodeapps/FRApps_/prod1-robin/._2/FRTs/Proxy/makeNginxConf.njs'

