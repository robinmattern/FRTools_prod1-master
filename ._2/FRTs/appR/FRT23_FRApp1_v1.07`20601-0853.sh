#!/bin/bash
#*\
##=========+====================+================================================+
##RD         FRAPP              | FormR App Tools
##RFILE    +====================+=======+===============+======+=================+
##FD   FRT23_FRAPP.sh           |  66449|  5/08/22 16:10|  1169| p2.02-20508-1610
##FD   FRT23_FRApp.sh           |  15405|  5/08/22 16:12|   246| p1.06-20508-1612
##FD   FRT23_FRApp.sh           |  20004|  5/09/22 07:18|   332| p1.06-20509-0718
##FD   FRT23_FRApp.sh           |  23218|  5/15/22 13:05|   383| p1.06-20515-1305
##FD   FRT23_FRApp.sh           |  23723|  5/15/22 15:23|   389| p1.06-20515-1523
##FD   FRT23_FRApp.sh           |  26270|  5/21/22 20:05|   428| p1.06-20521-2005
##DESC     .--------------------+-------+---------------+------+-----------------+
#            Use the commands in this script to run git commands with helpfull
#            output.
#
##LIC      .--------------------+----------------------------------------------+
#            Copyright (c) 2021 8020Data-FormR * Released under
#            MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+----------------------------------------------+
#            runSSH()           |
#            setSSH_Host()      |
#            chkAppDir()        |
#            runDeploy()        |
#            savFiles()         | Save DirList into !faNNpN_App Comment                 # .(20515.01.1)
#            appDoc()           | Print scripts to printable file                       # .(20515.02.1)
#            makLaunch()        | Save a launch.json file for Repository                # .(20520.01.1)
#
##CHGS     .--------------------+----------------------------------------------+
# .(20501.01  5/01/22 RAM 11:30a| Enable JPT12_Main2Fns_p1.05.sh in sub-scripts
# .(20415.01  4/15/22 RAM 12:00p| Added RunDeplay
# .(20429.09  5/01/22 RAM  2:45p| Run Args_toLower once
# .(20501.03  5/01/22 RAM 12:22p| Add Git create command
# .(20502.06  5/02/22 RAM 12:00p| Major Overhaul of JPT12_Main2Fns_p1.06.sh
# .(20508.01  5/08/22 RAM  3:50p| Put App Commands into separate script
# .(20515.01  5/15/22 RAM  1:10p| Add App Save Files Command
# .(20515.02  5/15/22 RAM  2:00p| Add App Doc Command
# .(20520.01  5/20/22 RAM  4:30p| Add App Make Launch Command
# .(20521.03  5/21/22 RAM  8:00p| Rework App Files Command
# .(20601.01  6/01/22 RAM  8:30a| Add App List Styles and Rename Styles
#
##PRGM     +====================+===============================================+
##ID 69.600. Main               |
##SRCE     +====================+===============================================+
#*/
#========================================================================================================== #  ===============================  #

        aVdt="May 8, 2022 4:16a"
        aVer="$( echo $0 | awk '{ sub( /.+_p/, "p" ); sub( /\.sh/, ""); print }' )"

     if [ "${1:0:3}" == "ver" ] || [ "${1:0:2}" == "-v" ]; then
        echo ""
#       echo "  FRApp Tools Version ${aVer}  ($( date "+%b %-d %Y %H:%M" ))"
        echo "  FRApp Tools Version ${aVer}  (${aVdt})"
        echo ""
        exit
        fi
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

     if [ "${aJFns}" != "" ]; then source ${aJFns};
   else echo  " ** FRApp[ 59]  Unable to load Script Fns, 'JPT12_Main2Fns_p*.sh'"; exit; fi;             # .(20501.01.2 RAM)

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

        setOS; bSpace=1;                                                                                    #  A space hasn't been displayed, print one next
        aLstSp="echo "; if [ "${aOSv:0:1}" == "w" ]; then aLstSp=""; fi                                     # .(10706.09.1 RAM Windows returns an extra blank line)

#       bDoit=0                                                                                             ##.(20501.01.5 RAM !Important don't reset in Sub script)
#       bQuiet=0                                                                                            ##.(20501.01.6 RAM)
#       bDebug=0                                                                                            ##.(20501.01.7 RAM)

        sayMsg    "FRApp[ 70]  aServer: '${aServer}', aOS: '${aOS}', bDebug: '${bDebug}'"

# ------------------------------------------------------------------------------------
#
#       HELP
#
#====== =================================================================================================== #  ===========

function Help( ) {

        aCmd0="$1"
        sayMsg    "FRApp[ 81]  aCmd:  '${aCmd}', aCmd0: '${aCmd0}' -- Help" 1

     if [ "${aCmd}"  ==   ""   ]; then   aCmd="Help"; fi                                # .(20515.03.1 RAM aCmd is "" when invalid)
     if [ "${aCmd}"  != "Help" ] && [ "${aCmd0}" != "help" ]; then return; fi

        echo ""
#    if                             [ "${aCmd0}" != "help" ]; then sayMsg " ** Invalid Command: '${aCmd0}'" 3 "sp"; aCmd="Help"; fi   ##.(20515.03.2)
     if [ "${aCmd}"  == "Help" ] && [ "${aCmd0}" != "help" ]; then sayMsg " ** Invalid Command: '${aCmd0}'" 3 "sp"; aCmd="Help"; fi   # .(20515.03.2)

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

        echo "    Useful Git Commands  (${aVer})      (${aVdt})"
        echo "    ------------------------------------------- -----------------------------------"
#       echo ""
        echo "    frt app set domain {domain}"                                          # .(20407.03.1 RAM Added)
        echo "    frt app set homepage {homepage}"                                      # .(20407.01.1 RAM Added).(20410.03.1 RAM)
        echo "    frt app set port {port}"                                              # .(20407.02.1 RAM Added)
        echo "    frt app set title {app title}"                                        # .(20409.03.1 RAM Added)
        echo "    frt app set ssh_host {ssh login alias}"                               # .(20411.03.1 RAM Added)
        echo "    frt app list"                                                         # .(20410.02.1 RAM Added)
        echo ""
        echo "    frt app start"
        echo "    frt app build"
        echo "    frt app run prod"
        echo "    frt app deploy"                                                       # .(20411.08.1 RAM Added)
        echo "    frt app list files"                                                   # .(20515.01.2 RAM Added).(20521.01.1 RAM Was: save files)
        echo "    frt app list styles"                                                  # .(20601.01.4 RAM Added)
        echo "    frt app rename styles"                                                # .(20601.01.5 RAM Added)
        echo "    frt app save backup"                                                  # .(2xxxx.xx.2 RAM Added)
        echo "    frt app make launch file"                                             # .(20520.01.2 RAM Added)
        echo "    frt app doc"                                                          # .(20515.02.2 RAM Added)
        echo ""
        echo "    frt run start"
        echo "    frt run build"
        echo "    frt run prod"
        echo "    frt run deploy"
        ${aLstSp}                                                                                           # .(10706.09.3)
        exit
     } # eof Help
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#========================================================================================================== #  ===============================  #

        setArgs "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9"

        getOpts "bdq"
        setCmds

        sayMsg    "FRApp[127]  aCmd:  '${aCmd}', aCmd1: '${aCmd1}', aCmd2: '${aCmd2}', aCmd3: '${aCmd3}', aCmd0: '${aCmd0}', bDoit: '$bDoit', bDebug: '$bDebug', bQuiet: '$c' " 1
#       sayMsg    "FRApp[128]  aCmd:  '$aCmd',  aCmd1: '$aCmd1', aCmd2: '$aCmd2', aCmd3: '$aCmd3', aCmd0: '$aCmd0' "
        sayMsg sp "FRApp[129]  \$1: '$1', \$2: '$2', \$3: '$3', \$4: '$4', \$5: '$5', \$6: '$6', \$7: '$8'"

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#       Help

        getCmd "in"             "Init";                                                 # .(20502.06.x End)

        getCmd "files"           "List Files";                                          # .(20521.01.3 RAM Added)
        getCmd "li"    "fi"      "List Files";                                          # .(20515.01.3).(20521.01.2)
        getCmd "docs"  "do"      "Doc App";                                             # .(20515.02.3)
        getCmd "ma"    "la"      "Make Launch File";                                    # .(20520.01.3)
        getCmd "st"    "li"      "List Styles";                                         # .(20601.01.6)
        getCmd "st"    "re"      "Rename Styles";                                       # .(20601.01.7)

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#       sayMsg    "FRApp[144]  aCmd:  '${aCmd}', aArg1: '${aArg1}', aArg2: '${aArg2}', aArg3: '${aArg3}', aArg4: '$aArg4', aArg5: '$aArg5', aArg6: '$aArg6', aArg7: '$aArg7', aArg8: '$aArg8', aArg9: '$aArg9'" 1
        sayMsg    "FRApp[145]  aCmd:  '${aCmd}', aArg1: '${aArg1}', aArg2: '${aArg2}', aArg3: '${aArg3}', bGlobal: '${bGlobal}'" 1 # 2

     if [ "${aCmd}"  == "Help" ] || [ "${aCmd0}" != "help" ] || [ "${aCmd}" == "" ]; then                   # .(20521.04.1 RAM Check here rather than inside Help())

        Help ${aCmd0}
        fi                                                                                                  # .(20521.04.2)

# ------------------------------------------------------------------------------------
#
#       APP Functions
#
#====== =================================================================================================== #  ===========

 function runSSH() {                                                                                        # .(20412.02.2 Beg RAM Added)
        setSSH_Host "$1"
        echo ""
        echo "  ssh ${aSSH_Host}"
        echo ""
                ssh ${aSSH_Host}
        }                                                                                                   # .(20412.02.2 End)
#    -- --- ---------------  =  ------------------------------------------------------  #

#====== =================================================================================================== #  ===========

 function setSSH_Host() {                                                               # .(20412.01.2 RAM Added)
        aSSH_Host="$1"
     if [ "$1" == "" ] && [ -f .env ]; then
        aSSH_Host="$( cat ".env" | awk '/SSH_HOST/ { gsub( /[":=]/, " " ); a = $2 }; END { print a ? a : "" }' )"
        fi
     if [ "${aSSH_Host}" == "" ]; then
        echo ""
        echo "* SSH_Host is not defined in your .env file"
#       echo ""
        exit
        fi
#       echo "  --- aSSH_Host: '${aSSH_Host}'"; # exit
        }
# ----------------------------------------------------

#====== =================================================================================================== #  ===========

 function chkAppDir() {                                                                 # Check to see if the current dir contains an app

        bOK=0
     if [ -f "package.json" ]; then
#       bOK=$( cat "package.json" | awk '/.bin\\\\react-scripts +start/        { print 1 }' )
        bOK=$( cat "package.json" | awk '/"start": .+live-server/   { print 1 }' ); if [ "${bOK}" != "1" ]; then
        bOK=$( cat "package.json" | awk '/"start": .+react-scripts/ { print 1 }' ); fi

#       bOK=$( ls  "../node_modules/.bin" | awk '/react-scripts.cmd/    { print 1 }' )
#       bOK=$( cat "./src/index.js"       | awk '/from \'react\'/       { print 1 }' )
        fi
     if [ "${bOK}" != "1" ]; then sayMsg sp "You must be in an App folder." 2; fi

        aAppDir=$( basename $( pwd ) )
#       echo "    aAppDir: '${aAppDir}'"
        }
#    -- --- ---------------  =  ------------------------------------------------------  #

#====== =================================================================================================== #  ===========

function runBuild() {                                                                   # .(20409.04.1 Beg REACT_APP_TITLE=My Custom App (6c prod))

#       aOldTitle="$( cat ".env" | awk '/REACT_APP_TITLE/ { gsub( /[":,=]/, " " ); print $2" "$3" "$4" "$5" "$6" "$7" "$8" "$9 }' )"
        aOldTitle="$( cat ".env" | awk '/REACT_APP_TITLE/ { gsub( /[":,=]/, " " ); sub( /REACT_APP_TITLE +/, "" ); print $0 }' )"
if [ "${aOldTitle}" == "" ]; then
        aOldTitle="$( basename "$( pwd )" | awk '{ n = match( $0, /[0-9][cs]?[- ]/ ); if (n > 0) { b = " (" substr($0,1,RLENGTH-1) ")"; a = substr($0,RLENGTH+1) } else { a = $0; b = "" }; print a b }' )"
        fi
        aProdCmt="$( echo "$1" | awk '{ sub ( /^ +/, "" ); sub( / +$/, "" ); print }' )"
if [ "${aProdCmt}" != "" ]; then
        echo
#       echo "aProdCmt: '${aProdCmt}',     awk ' /)/ { sub( /)/, \" '\"${aProdCmt}\"')\" ); print; exit }'"
        aNewTitle=$( echo "${aOldTitle}" | awk '/)/  { sub( /)/, " '"${aProdCmt}"')"     ); print; exit } { print $0 "("'"${aProdCmt}"'")" }' )
#       aNewTitle="${aOldTitle/)/ Prod)}"
   else aNewTitle="${aOldTitle}"
        fi
#       echo "aOldTitle: '${aOldTitle}', aNewTitle: '${aNewTitle}'";  exit
        echo "Building Production App: ${aNewTitle}"; echo ""

        setEnVar "${aNewTitle}" "REACT_APP_TITLE" "App Title" "quietly"
        "../node_modules/.bin/react-scripts"  build
        setEnVar "${aOldTitle}" "REACT_APP_TITLE" "App Title" "quietly"
        }                                                                               # .(20407.02.2 End)
#    -- --- ---------------  =  ------------------------------------------------------  #

#====== =================================================================================================== #  ===========

 function runDeploy() {                                                                 # .(20411.05.1 RAM Added)

        bQuiet=$1; if [ "$1" == "-q" ] || [ "${1:0:5}" == "quiet" ]; then bQuiet="-q1"; fi; # echo ""; echo "-- \${bQuiet}: '${bQuiet}'"; # exit

        aHomePage="$( cat package.json | awk '/homepage/ { sub( /"\//, "" ); gsub( /[",]/, "" ); print $2   }' )"
        aSSH_Host="$( cat ".env" | awk '/SSH_HOST/ { gsub( /[":=]/, " " ); a = $2 }; END { print a ? a : "" }' )"
        aDomain="$(   cat ".env" | awk '/DOMAIN/   { gsub( /[":=]/, " " ); a = $2 }; END { print a ? a : "" }' )"
        aPrjApp="$(   cat ".env" | awk '/PROJECT/  { gsub( /[":=]/, " " ); a = $2 }; END { print a ? a : "" }' )"
        aProject="$( echo "${aPrjApp}" | awk '{ sub( /\/.+/, "/"); print }' )"
        aAppDir="$(  echo "${aPrjApp}" | awk '{ sub( /.+\//, "" ); print }' )"

    if [ "${aAppDir}" == "" ]; then
#      __dirName="$( dirname $0 )"; cd "${__dirName}"; __dirName="$( pwd -P )"
                                                       __dirName="$( pwd -P )";                             # echo "--- __dirName: '${__dirName}'"
        aAppDir="$( echo "${__dirName}" | awk '{ n = split( $0, a, "/" ); print a[ n-1 ]"/"a[ n ] }' )";    # echo "---   aAppDir: '${aAppDir}'"
        aAppDir="$( echo "${aAppDir}"   | awk 'BEGIN {IGNORECASE = 1} { sub( /(client|server)\//, "" ); print }' )"  # remove /client or /server
        fi

  if [ "${bQuiet}" != "-q1" ] && [ "${bQuiet}" != "-q4" ]; then
        echo ""
        echo "  Copying app build files to remote folder: /webs/${aProject}${aAppDir}/build"
        echo "     after creating FRApp config files for:  http://${aDomain}/${aHomePage}"
        echo ""
        askYN "Is it OK to do deploy this app using SSH Login Alias: ${aSSH_Host}?"
if [ "${aAnswer}" != "y" ]; then exit; fi
        fi

        frt FRApp conf make "${bQuiet}"

#       $(dirname $0)/App/deploy_u1.01.sh ${aSSH_Host} "/webs/{aProject}" build
  if [ "${bQuiet}" == "-q1" ]; then
        $(dirname $0)/App/deploy_u1.01.sh  >/dev/null
     else
        $(dirname $0)/App/deploy_u1.01.sh
        fi
        }
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#========================================================================================================== #  ===============================  #

# ------------------------------------------------------------------------------------
#
#       MAKE LAUNCH FILE                                                                                    # .(20520.01.4 Beg RAM Added Command)
#
#====== =================================================================================================== #

        sayMsg    "FRApp[272]  Make Launch File Command" sp # 1

  if [ "${aCmd}" == "Make Launch File" ]; then
#       sayMsg      "Make Launch File not implemented yet" 2

        bOK=0
     if [ -f ".launch.json" ]; then cd ..; fi                                                              #
     if [ -d ".vscode" ]; then                                                                             # .(20520.02.1 RAM Check to see if the current dir a launch.json file)
        bOK=$( ls  ".vscode" | awk '/launch.json/  { print 1 }' )
        fi
     if [ "${bOK}" != "1" ]; then sayMsg sp "You must be in an VSCode Project folder." 2; fi

        cd .vscode

#       rdir
#       echo "    node  $( dirname $0 )/makLaunch.json.njs"
                  node "$( dirname $0 )/makLaunch.json.njs"
        ${aLstSp}
        exit
     fi # eoc Make Launch File                                                                              # .(20520.01.4 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       APP Commands
#
#====== =================================================================================================== #

        chkAppDir

# ------------------------------------------------------------------------------------
#
#       LIST FILE NAMES                                                                                     # .(20515.01.4 Beg RAM Added command)
#
#====== =================================================================================================== #

        sayMsg    "FRApp[310]  ${aCmd}" sp # 1

  if [ "${aCmd}" ==  "List Files" ]; then                                                                   # .(20521.03.1 RAM Was: "Save Files")
#       sayMsg       "List Files Command not implemented yet" 2

#    if [ -f "files.md" ]; then cd ..; fi                                                                   # .(
        sayMsg sp "FRApp[316]  $( dirname $0 )/listFiles_u1.03.sh"  1                                       # .(20521.03.2 RAM Was: /savFiles_u1.02.sh)
                              "$( dirname $0 )/listFiles_u1.03.sh" "files"                                  # .(20521.03.3 RAM New version)
#                             "$( dirname $0 )/savFiles_u1.02.sh"  "${aArg1}" "${aArg2}" "${aArg3}"         ##.(20521.03.3)
        ${aLstSp}
        exit
     fi # eoc Save Files                                                                                    # .(20515.01.4 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========  # Start copy here

# ------------------------------------------------------------------------------------
#
#       LIST STYLES                                                                                         # .(20601.01.8 RAM Beg Added Command)
#
#====== =================================================================================================== #

        sayMsg    "FRApp[406]  List Styles" sp # 1

  if [ "${aCmd}" == "List Styles" ]; then
        sayMsg      "List Styles Command not implemented yet" 1

        aScrName="shoSelectors.sh"

        echo "    $( dirname $0 )/{aScrName}" "${aArg1}" "${aArg2}" "${aArg3}"
#                "$( dirname $0 )/{aScrName}" "${aArg1}" "${aArg2}" "${aArg3}"

        ${aLstSp}
        exit
     fi # eoc List Styles                                                                                   # .(20601.01.9 RAM End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========  # Start copy here

# ------------------------------------------------------------------------------------
#
#       RENAME STYLES                                                                                       # .(20601.01.10 RAM Beg Added Command)
#
#====== =================================================================================================== #

        sayMsg    "FRApp[406]  Rename Styles" sp # 1

  if [ "${aCmd}" == "Rename Styles" ]; then
        sayMsg      "Rename Styles Command not implemented yet" 2

        aScrName="shoSelectors.sh"

        echo "    $( dirname $0 )/{aScrName}" "${aArg1}" "${aArg2}" "${aArg3}"
#                "$( dirname $0 )/{aScrName}" "${aArg1}" "${aArg2}" "${aArg3}"

        ${aLstSp}
        exit
     fi # eoc Rename Styles                                                                                 # .(20601.01.11 RAM End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========

#       chkAppDir

    if [ "${1:0:3}" == "set" ]; then
    if [ "${2:0:3}" == "app" ]; then shift; fi                                                              # .(20411.03.1)
    if [ "${2:0:3}" == "nam" ]; then echo ""; setAppName "$3"; fi                                           # .(20409.08.1)
    if [ "${2:0:3}" == "hom" ]; then echo ""; setAppName "$3"; fi                                           # .(20411.03.1)
    if [ "${2:0:3}" == "por" ]; then echo ""; setPort    "$3"; fi                                           # .(20409.08.2)
    if [ "${2:0:3}" == "dom" ]; then echo ""; setEnVar   "$3" "DOMAIN"             "Domain"; fi             # .(20409.08.3)
    if [ "${2:0:3}" == "tit" ]; then echo ""; setEnVar   "$3" "REACT_APP_TITLE" "App Title"; fi             # .(20409.08.4)
    if [ "${2:0:3}" == "pro" ]; then echo ""; setEnVar   "$3" "PROJECT"       "Project/App"; fi             # .(20409.02.1)
    if [ "${2:0:3}" == "ssh" ]; then echo ""; setEnVar   "$3" "SSH_HOST"   "SSH Host Alias"; fi             # .(20411.03.1)
       fi

#      echo "frt.sh[1]  \${1:0:3}: '${1:0:3}', \${2:0:3}: '${2:0:3}'"

 if [ "${1:0:3}" == "lis" ] && [ "${2:0:3}" == "app" ]; then  shoAppVars; fi                                # .(20410.02.3)

#    ------------------------------------------------------------------


    if [ "${1:0:3}" == "app" ] || [ "${1:0:3}" == "run" ]; then                                             # .(20429.05.1)

    if [ "${2:0:3}" == "set" ]; then                                                                        # .(20407.02.3)
    if [ "${3:0:3}" == ""    ]; then shoAppVars; fi                                                         # .(20412.03.1)
    if [ "${3:0:3}" == "nam" ]; then echo ""; setAppName "$4"; fi                                           # .(20407.01.3)
    if [ "${3:0:3}" == "hom" ]; then echo ""; setAppName "$4"; fi                                           # .(20410.03.2)
    if [ "${3:0:3}" == "por" ]; then echo ""; setPort    "$4"; fi                                           # .(20407.02.4)
    if [ "${3:0:3}" == "dom" ]; then echo ""; setEnVar   "$4" "DOMAIN"             "Domain"; fi             # .(20407.03.3)
    if [ "${3:0:3}" == "tit" ]; then echo ""; setEnVar   "$4" "REACT_APP_TITLE" "App Title"; fi             # .(20409.02.1)
    if [ "${3:0:3}" == "pro" ]; then echo ""; setEnVar   "$4" "PROJECT"       "Project/App"; fi             # .(20409.02.1)
    if [ "${3:0:3}" == "ssh" ]; then echo ""; setEnVar   "$4" "SSH_HOST"   "SSH Host Alias"; fi             # .(20411.03.1)
       fi                                                                                                   # .(20407.02.3)

#     echo "frt.sh[2]  \${2:0:3}: '${3:0:3}', \${3:0:3}: '${2:0:3}'"

    if [ "${2:0:3}" == "lis" ]; then shoAppVars; fi                                                         # .(20410.02.4)

#   if [ "${2:0:3}" == "sta" ]; then npm run start;  fi
    if [ "${2:0:3}" == "sta" ]; then echo ""; "../node_modules/.bin/react-scripts"  start; fi

#   if [ "${1:0:3}" == "app" ] && [ "${2:0:3}" == "run" ]; then                                             # .(20409.01.1 Beg)
    if [ "${2:0:3}" == "run" ] ; then                                    # .(20409.01.1 Beg)
    if [ "${3:0:3}" == ""    ]; then echo ""; "../node_modules/.bin/react-scripts"  start; fi               # .(20409.01.2 RAM Added app run )
    if [ "${3:0:3}" == "dev" ]; then echo ""; "../node_modules/.bin/react-scripts"  start; fi               # .(20409.01.3 RAM Added app run dev)
    if [ "${3:0:3}" == "pro" ]; then echo ""; node "$( dirname $0)/App/serveProd_u1.03.js" "$@"; fi         # .(20409.01.4 RAM Added app run prod)
       fi
#   if [ "${1:0:3}" == "run" ] && [ "${2:0:3}" == "app" ]; then
    if [ "${2:0:3}" == "app" ] ; then
    if [ "${3:0:3}" == ""    ]; then echo ""; "../node_modules/.bin/react-scripts"  start; fi               # .(20409.01.5 RAM Added run app )
    if [ "${3:0:3}" == "dev" ]; then echo ""; "../node_modules/.bin/react-scripts"  start; fi               # .(20409.01.6 RAM Added run app dev)
    if [ "${3:0:3}" == "pro" ]; then echo ""; node "$( dirname $0)/App/serveProd_u1.03.js" "$@"; fi         # .(20409.01.7 RAM Added run app prod)
       fi                                                                                                   # .(20409.01.1 End)
#   if [ "${2:0:3}" == "bui" ]; then npm run build;  fi
#   if [ "${2:0:3}" == "bui" ]; then echo ""; "../node_modules/.bin/react-scripts"  build; fi
    if [ "${2:0:3}" == "bui" ]; then echo ""; runBuild "$3 $4 $5 $6 $7 $8 $9"; fi

#   if [ "${2:0:3}" == "pro" ]; then          npm run prod;   fi
    if [ "${2:0:3}" == "pro" ]; then echo ""; node "$( dirname $0)/App/serveProd_u1.03.js" "$@"; fi
    if [ "${2:0:3}" == "dep" ]; then          runDeploy "$3"; fi;                                           # .(20411.05.2)
    exit
    fi   # eif command app or run                                                                           # .(20429.05.1)

    if [ "${1:0:3}" == "bui" ]; then echo ""; runBuild "$2 $3 $4 $5 $6 $7 $8 $9"; fi
#   if [ "${1:0:3}" == "dep" ]; then          node "$( dirname $0)/App/deployProd_u1.01.js"; fi;            # .(20411.05.3)
    if [ "${1:0:3}" == "dep" ]; then          runDeploy "$2"; fi;                                           # .(20411.05.4)

    if [ "${1:0:3}" == "ssh" ]; then          runSSH  "$2"; fi;                                             # .(20412.01.3 RAM Added)
    if [ "${1:0:3}" == "set" ]; then          shoAppVars; fi                                                # .(20412.03.2)

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========  # Start copy here

# ------------------------------------------------------------------------------------
#
#       NEXT COMMAND                                                                                        # .(20102.01.4 USR Beg Added Command)
#
#====== =================================================================================================== #

        sayMsg    "FRApp[406]  {CmdName}" sp # 1

  if [ "${aCmd}" == "{CmdName}" ]; then
        sayMsg      "{CmdName} Command not implemented yet" 2

        aScrName="{ScrName}_u1.01.sh"

        echo "    $( dirname $0 )/{aScrName}" "${aArg1}" "${aArg2}" "${aArg3}"
#                "$( dirname $0 )/{aScrName}" "${aArg1}" "${aArg2}" "${aArg3}"

        ${aLstSp}
        exit
     fi # eoc {CmdName}                                                                                     # .(20102.01.4 USR End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       END
#
#========================================================================================================== #  ===============================  #
#*\
##SRCE     +====================+===============================================+
##RFILE    +====================+=======+===================+======+=============+
#*/
