#========================================================================================================== #  ===============================  #

# ------------------------------------------------------------------------------------
#
#       RUN APP Functions
#
#====== =================================================================================================== #

 function runSSH() {                                                                                        # .(20412.02.2 Beg RAM Added)
        setSSH_Host "$1"
        echo ""
        echo "  ssh ${aSSH_Host}"
        echo ""
                ssh ${aSSH_Host}
        }                                                                                                   # .(20412.02.2 End)
#    -- --- ---------------  =  ------------------------------------------------------  #

 function setSSH_Host() {                                   # .(20412.01.2 RAM Added)
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

 function chkAppDir() {             // Check to see if the current dir contains an app

        bOK=0
     if [ -f "package.json" ]; then
#       bOK=$( cat "package.json" | awk '/.bin\\\\react-scripts +start/ { print 1 }' )
        bOK=$( ls  "../node_modules/.bin" | awk '/react-scripts.cmd/    { print 1 }' )
#       bOK=$( cat "./src/index.js"       | awk '/from \'react\'/       { print 1 }' )
        fi
     if [ "${bOK}" != "1" ]; then sayMsg sp "You must be in an App folder." 2; fi

        aAppDir=$( basename $( pwd ) )
#       echo "    aAppDir: '${aAppDir}'"
        }
#    -- --- ---------------  =  ------------------------------------------------------  #

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

 function runDeploy() {                                                                 # .(20411.05.x RAM Added)

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
        echo "     after creating proxy config files for:  http://${aDomain}/${aHomePage}"
        echo ""
        askYN "Is it OK to do deploy this app using SSH Login Alias: ${aSSH_Host}?"
if [ "${aAnswer}" != "y" ]; then exit; fi
        fi

        frt proxy conf make "${bQuiet}"

#       $(dirname $0)/App/deploy_u1.01.sh ${aSSH_Host} "/webs/{aProject}" build
  if [ "${bQuiet}" == "-q1" ]; then
        $(dirname $0)/App/deploy_u1.01.sh  >/dev/null
     else
        $(dirname $0)/App/deploy_u1.01.sh
        fi
        }
#    -- --- ---------------  =  ------------------------------------------------------  #

# ------------------------------------------------------------------------------------
#
#       RUN APP Commands
#
#====== =================================================================================================== #

        sayMsg "FRT10[326]  App Commands" 2

        chkAppDir

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

 if [ "${1:0:3}" == "app" ] || [ "${1:0:3}" == "run" ]; then

    if [ "${2:0:3}" == "set" ]; then                                                                        # .(20407.02.3)
    if [ "${3:0:3}" == ""    ]; then shoAppVars; fi                                                         # .(20412.03.1)
    if [ "${3:0:3}" == "nam" ]; then echo ""; setAppName "$4"; fi                                           # .(20407.01.3)
    if [ "${3:0:3}" == "hom" ]; then echo ""; setAppName "$4"; fi                                           # .(20410.03.2)
    if [ "${3:0:3}" == "por" ]; then echo ""; setPort    "$4"; fi                                           # .(20407.02.4)
    if [ "${3:0:3}" == "dom" ]; then echo ""; setEnVar   "$4" "DOMAIN"             "Domain"; fi             # .(20407.03.3)
    if [ "${3:0:3}" == "tit" ]; then echo ""; setEnVar   "$4" "REACT_APP_TITLE" "App Title"; fi             # .(20409.02.1)
    if [ "${3:0:3}" == "pro" ]; then echo ""; setEnVar   "$4" "PROJECT"       "Project/App"; fi             # .(20409.02.1)
    if [ "${3:0:3}" == "ssh" ]; then echo ""; setEnVar   "$4" "SSH_HOST"   "SSH Host Alias"; fi             # .(20411.03.1)
       fi                                                                                                   # .(20407.02.5)

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
    if [ "${2:0:3}" == "dep" ]; then          runDeploy "$3"; fi;                                           # .(20411.05.x)
    exit
    fi   # eif command app or run

    if [ "${1:0:3}" == "bui" ]; then echo ""; runBuild "$2 $3 $4 $5 $6 $7 $8 $9"; fi
#   if [ "${1:0:3}" == "dep" ]; then          node "$( dirname $0)/App/deployProd_u1.01.js"; fi;            # .(20411.05.x)
    if [ "${1:0:3}" == "dep" ]; then          runDeploy "$2"; fi;                                           # .(20411.05.x)

    if [ "${1:0:3}" == "ssh" ]; then          runSSH  "$2"; fi;                                             # .(20412.01.3 RAM Added)
    if [ "${1:0:3}" == "set" ]; then          shoAppVars; fi                                                # .(20412.03.2)

