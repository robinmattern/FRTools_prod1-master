#!/bin/bash
#*\
##=========+====================+================================================+
##RD         gitr clone         | Git Clone {Project}
##RFILE    +====================+=======+===============+======+=================+
##FD   FRT23_gitR_clone.sh      |  24859| 11/01/22 15:58|   474| p1.03-21101-1558
##FD   FRT23_gitR_clone.sh      |  27579| 11/05/22 18:00|   507| p1.03-21105-1800
##FD   FRT23_gitR_clone.sh      |  28520| 11/05/22 19:00|   515| p1.03-21105-1900
##FD   FRT23_gitR_clone.sh      |  29196| 11/07/22 08:45|   528| p1.03-21107-0845
##FD   FRT23_gitR_clone.sh      |  33656| 11/27/22 17:20|   567| p1.04-21127.1720
##DESC     .--------------------+-------+---------------+------+-----------------+
#            Use the commands in this script to run gitr clone {Project}
#
##LIC      .--------------------+----------------------------------------------+
#            Copyright (c) 2021 8020Data-FormR * Released under
#            MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+----------------------------------------------+
##CHGS     .--------------------+----------------------------------------------+
# .(21026.01 10/26/22 RAM 12:00p| Delete all files in RepoDir)
# .(21029.01 10/29/22 RAM 12:00p| Copy/Zip repo to ${aRepoDir}_v${aTS})
# .(21029.02 10/29/22 RAM 14:16p| Create config file if not found
# .(21029.03 10/29/22 RAM  8:29p| Improved Dir location
# .(21030.01 10/30/22 RAM  6:00p| Don't remove _ from Backup folder/zipfile name
# .(21101.01 11/01/22 RAM  5:11p| Parse Clone URL if passed
# .(21101.02 11/01/22 RAM  5:58p| Determine Parent folder
# .(21101.03 11/01/22 RAM  5:58p| Doit if config file is created or updated
# .(21105.01 11/05/22 RAM  4:29p| If no {Stage}, then aStage == "", not {stg1}-{ownr}
# .(21105.02 11/05/22 RAM  5:00p| Show config after update
# .(21105.03 11/05/22 RAM  5:43p| If Github URL parsed, then modify RepoDir
# .(21105.04 11/05/22 RAM  6:00p| Always set aWebsDir to aPDir, and fix
# .(21105.05 11/05/22 RAM  7:00p| Set c1 if parsing and in Project_ folder
# .(21107.01 11/07/22 RAM  8:45a| Check if RepoDir is completely removed
# .(21118.02 11/27/22 RAM  3:10p| Add RepoDir folder to parsed argument
# .(21127.01 11/27/22 RAM  3:10p| Change name of gitr-config file
# .(21127.02 11/27/22 RAM  3:10p| RDir may not exist
# .(21127.08 11/27/22 RAM  8:30p| Added ${aLstSp} in various places 
# .(21129.02 11/27/22 RAM  8:45a| Display full git pull and clone result

##PRGM     +====================+===============================================+
##ID 69.600. Main               |
##SRCE     +====================+===============================================+
#*/
#========================================================================================================== #  ===============================  #

                               bHelp=0
 if [ "$1" ==  "help"  ]; then bHelp=1; shift; fi
 if [ "$1" == "-help"  ]; then bHelp=1; shift; fi
 if [ "$2" == "-help"  ]; then bHelp=1; fi
 if [ "$3" == "-help"  ]; then bHelp=1; fi

                               bAll=0
 if [ "$1" == "-all"   ]; then bAll=1; shift; fi
 if [ "$2" == "-all"   ]; then bAll=1; fi
 if [ "$3" == "-all"   ]; then bAll=1; fi

                               bDoit=0
 if [ "$1" == "-doit"  ]; then bDoit=1; shift; fi
 if [ "$2" == "-doit"  ]; then bDoit=1; fi
 if [ "$3" == "-doit"  ]; then bDoit=1; fi
 if [ "$4" == "-doit"  ]; then bDoit=1; fi

                               aPrj="$1"
#if [ "${aPrj}" == ""  ]; then aPrj="FRNet"; fi
 if [ "${aPrj}" == ""  ]; then bHelp=1; fi

                               aRepoDir="$2"   # .(21118.02.1 RAM)

#   -----------------------------------------------------------------

 if [ "${bHelp}" == "1" ]; then
    echo ""
    echo "  Syntax: gitr clone {Project}|{GitHub URL} [{RepoDir}] [-all] [-doit]"
    echo ""
    echo "    Clone a GitHub Repository for {Project} or {GitHub URL}, partially or fully"
    echo "      If {Project} is a GitHub URL, then parse it and save a Config File"
    echo "      If {RepoDir} is present, then save it into Config File as well"
    echo "      if -all  is  provided, then clone all repository files"
    echo "      If -doit is not provided, then show contents of the Git {Project} Config File "
    echo "      If -doit is provided, then backup {RepoDir} and clone a new Repossitory"
    echo ""
    echo "    Uses a Config File, \"gitr_{project}_config.sh\", in the current {WebsDir} folder"
    echo "    It contains the following variables, for example: (no spaces before or after = )"
    echo ""
    echo "      Project=\"FRApps\""
    echo "      Stage=\"prod-master\""
    echo "      GitHub_Cert=\"github-btg\""
    echo "      GitHub_Acct=\"8020data\""                                                               # .(21101.01.1 RAM Add Acct and SSH Key)
    echo "      GitHub_SSH=\"no\""                                                                      # .(21101.01.2)
    echo ""
    echo "      RepoDir=\"{Project}_{Stage}\"   # In Workstation: C:\\Repos "
    echo "      RepoDir=\"{Project}\"           # In Server:      /webs "
    echo ""
    echo "      Apps=( \"/._2\" )               # Support files, including FRTools"
    echo "      Apps[1]=\"/client1/1c1_my-html-custom-app/\""
    echo "      Apps[2]=\"/client3/1c3_my-react-custom-app/\""
    echo "      Apps[2]=\"/server3/1c3_my-react-custom-api/\""
    echo ""
    echo "      WebsDir=\"C:\\Repos\", or \"/webs\""
    echo ""
    exit
    fi
#   -----------------------------------------------------------------

    aStage_var="{prod1-robin}"
    aGitHub_Cert_var="{github-ram}"
    aGitHub_Acct_var="{robinmattern}"                                                                   # .(21101.01.3)
    aGitHub_SSH_var="{yes}"                                                                             # .(21101.01.4)

#   -------------------------------------- GitHub URL arg -----

# if [ "${aPrj/-/}"  != "${aPrj}" ] || [ "${aPrj/:/}" != "${aPrj}" ] || [ "${aPrj/-/}" != "${aPrj}" ]; then bParse=1; else bParse=0; fi

         bParse=$( echo "${aPrj}" | awk '/^[a-zA-Z0-9]+_?$/ { print 0; exit }; { print 1 }' );         # .(21101.01.4 RAM 1st work contains _)
#        echo -e "\n  bParse: ${bParse}"; exit
 if [ "${bParse}" == "1" ]; then                                                                       # .(21101.01.5 RAM Beg Parse if aPrj = location)

#       {Project}_{stg1}-{ownr}
#       {GitHub_Cert}:{GitHub_Acct}/{Project}_{stg1}-{ownr}
#        git@github.com:robinmattern/FRTools_prod1-robin.git
#        https://github.com/{GitHub_Acct}/{Project}_{stg1}-{ownr}
#        https://github.com/robinmattern/FRTools_prod1-robin.git

#       {GitHub_Cert}:{GitHub_Acct}/{Project}_{stg1}-{ownr}"
#       {GitHub_Acct}              /{Project}_{stg1}-{ownr}"

#   -------------------------------- Parse GitHub URL arg -----

awkPgm='
BEGIN { bDebug = 0;                               aSSH = "yes" }

       /http/       { sub( /https?:\/\//,   "" ); aSSH = "no"  }
            bDebug  { print "\n  1    $0: " $0 ", aSSH: " aSSH }

       /\.git/      { sub( /\.git/, "" ) }
       /github.com/ { sub( /github.com\//, "" ) }
            bDebug  { print "  2    $0: " $0 }

#      /\//         { split( $0"/", m, /\// ); sub( /\/.+/, "" );  aRepo1 = m[2] ? m[2] : m[1]
                    { split( $0"/", m, /\// ); sub( /\/.+/, "" );  aRepo1 = m[2] ? m[2] : m[1];  aRepo = match( aRepo1, /^([a-zA-Z0-9_-]+)$/ ) ? aRepo1 : "{Project}";
        if (bDebug) { print "  3    $0: " $0 ", aRepo1: " aRepo1 }
                      split( $0":", m, /:/); if ( aSSH == "no" ) { aCert = "n/a"; aAcct = m[1] }
                                                            else { aCert = m[2] ? m[1] : "n/a";  aAcct = m[2] ? m[2] : "n/a"; aSSH = aCert == "n/a" ? "no" : aSSH } }
            bDebug  { print "  4 aRepo: " aRepo ", aCert: " aCert ", aAcct: " aAcct ", aSSH: " aSSH }

                    { split( aRepo"_", m, /_/ );                   aProj = ( m[1] != aAcct) ? m[1] : "{Project}";     aStge = m[2] ? m[2] : "{stg1}-{ownr}"
        if (bDebug) { print "  5 aProj: " aProj ", aStge: " aStge }
                      split( aStge"-", m, /-/ );                   aOwnr = m[2] ? "-" m[2] : ""; aStge = m[1] ? "_" m[1] : "" }
            bDebug  { print "  6 aProj: " aProj ", aStge: " aStge ", aOwnr: " aOwnr "\n" }

                    { print  aAcct " " aProj " " aStge""aOwnr " " aSSH " " aCert }

END   { }'
#   -----------------------------------------

    aURL="$( echo "${aPrj}" | awk "${awkPgm}" )";  # echo "${aURL}"; exit
#   echo -e "   Parsed URL: '${aURL}'"; # exit

    aGitHub_Acct_arg="$( echo "${aURL}" | awk '{ print $1 }' )"
    aProj_arg="$(        echo "${aURL}" | awk '{ print $2 }' )"
    aStage_arg="$(       echo "${aURL}" | awk '{ print $3 }' )"; aStage_arg="${aStage_arg/_}"
    aGitHub_SSH_arg="$(  echo "${aURL}" | awk '{ print $4 }' )"
    aGitHub_Cert_arg="$( echo "${aURL}" | awk '{ print $5 }' )"

if [ "${aProj_arg}"        != "{Project}"     ]; then aPrj="${aProj_arg}"; fi

#f [ "${aStage_arg}"       == "{stg1}-{ownr}" ]; then aStage_var="${aStage_var}"; fi   ##.(21105.01.11)
#f [ "${aStage_arg}"       != "{stg1}-{ownr}" ]; then aStage_var="${aStage_arg}"; fi   ##.(21105.01.11)
                                                      aStage_var="${aStage_arg}"       # .(21105.01.11)

if [ "${aGitHub_Cert_arg}" != "n/a"           ]; then aGitHub_Cert_var="${aGitHub_Cert_arg}"; fi
if [ "${aGitHub_Acct_arg}" != "n/a"           ]; then aGitHub_Acct_var="${aGitHub_Acct_arg}"; fi
                                                      aGitHub_SSH_var="${aGitHub_SSH_arg}";
    fi  # eif "${bParse}" == "1"                                                                        # .(21101.01.5 RAM End)
#   -----------------------------------------------------------

# if [ "${aRepoDir}" == "" ]; then aRepoDir="${aStage_var}"; fi                                         # .(21118.02.2)

    aProj="$( echo "${aPrj}" | tr '[:upper:]' '[:lower:]' )"                                            # .(21101.02.1 RAM End)
#   echo -e "   aRepo: '${aPrj/_}_${aStage_var}', aCert: '${aGitHub_Cert_var}', aAcct: '${aGitHub_Acct_var}', aSSH: '${aGitHub_SSH_var}'"; #exit

#   -----------------------------------------

         aDir="$( basename $( pwd ) )";        # echo "-- aPDir: ${aPDir}"
         aPDir=$( basename $( cd ..; pwd ) );  # echo "-- aPDir: ${aPDir}, aPrj: ${aPrj}"

 if [  "${aDir}" == "webs" ] || [  "${aDir}" == "nodeapps" ] || [  "${aDir}" != "Repos" ]; then aPDir="${aDir}"; fi
 if [ "${aPDir}" != "webs" ] && [ "${aPDir}" != "nodeapps" ] && [ "${aPDir}" != "Repos" ]; then aPDir=""; fi

 if [ "${aPDir}" == "" ] && [ "1" == "0" ]; then                                                        # .(21101.03.1 RAM Don't abort)

    echo ""
    echo "     ** The folder, '${aDir}', doesn't appear to be a /Repos or /webs folder."
    echo ""
    exit
    fi                                                                                                  # .(21101.02.1 RAM End)
#   -----------------------------------------

                                                 aConfigFile=""                                                      ##.(21127.01.1 RAM Beg)
#if [ -f "../../gitr_${aProj}-config.sh" ]; then aConfigFile="../../gitr_${aProj}-config.sh";  aCurDir="../../"; fi
#if [ -f "../../gitr_${aProj}_config.sh" ]; then aConfigFile="../../gitr_${aProj}_config.sh";  aCurDir="../../"; fi  # .(21029.03.1 RAM)
#if [ -f "../../gitr_${aProj}config.sh"  ]; then aConfigFile="../../gitr_${aProj}config.sh";   aCurDir="../../"; fi
#if [ -f    "../gitr_${aProj}-config.sh" ]; then aConfigFile="../gitr_${aProj}-config.sh";     aCurDir="../"; fi
#if [ -f    "../gitr_${aProj}_config.sh" ]; then aConfigFile="../gitr_${aProj}_config.sh";     aCurDir="../"; fi     # .(21029.03.2)
#if [ -f    "../gitr_${aProj}config.sh"  ]; then aConfigFile="../gitr_${aProj}config.sh";      aCurDir="../"; fi
#if [ -f       "gitr_${aProj}-config.sh" ]; then aConfigFile="gitr_${aProj}-config.sh"; fi;    aCurDir="./"
#if [ -f       "gitr_${aProj}_config.sh" ]; then aConfigFile="gitr_${aProj}_config.sh"; fi;    aCurDir="./"          # .(21029.03.3)
#if [ -f       "gitr_${aProj}config.sh"  ]; then aConfigFile="gitr_${aProj}config.sh"; fi;     aCurDir="./"          ##.(21127.01.1 RAM End)

                                                aConfigFile=""                                                       # .(21127.01.2 RAM Beg Change Config file name)
 if [ -f "../../${aPrj}_gitr-config.sh" ]; then aConfigFile="../../${aPrj}_gitr-config.sh";  aCurDir="../../"; fi
 if [ -f "../../${aPrj}_gitr_config.sh" ]; then aConfigFile="../../${aPrj}_gitr_config.sh";  aCurDir="../../"; fi    # .(21029.03.1 RAM)
 if [ -f    "../${aPrj}_gitr-config.sh" ]; then aConfigFile="../${aPrj}_gitr-config.sh";     aCurDir="../"; fi
 if [ -f    "../${aPrj}_gitr_config.sh" ]; then aConfigFile="../${aPrj}_gitr_config.sh";     aCurDir="../"; fi       # .(21029.03.2)
 if [ -f       "${aPrj}_gitr-config.sh" ]; then aConfigFile="${aPrj}_gitr-config.sh"; fi;    aCurDir="./"
 if [ -f       "${aPrj}_gitr_config.sh" ]; then aConfigFile="${aPrj}_gitr_config.sh"; fi;    aCurDir="./"            # .(21029.03.3).(21127.01.2 RAM End)

 if [ "${aWebsDir}" == "" ]; then
#   aWebsDir=$( basename $( ls -1 ${aCurDir} ) )
#   aWebsDir=$( dirname ${aConfigFile} )
    aWebsDir=$( builtin cd ${aCurDir}; pwd )
#   aWebsDir="/C/WEBs/8020/VMs/et217p_formR0/webs"
#   aWebsDir="/C/Repos"
#   aWebsDir="/webs"

#   echo "   Setting aWebsDir: '${aWebsDir}', aCurDir: ${aCurDir}"
    fi
#   -----------------------------------------
#   echo "   Setting aWebsDir: '${aWebsDir}', aCurDir: ${aCurDir}"; exit

                                                 aConfigFile="${aConfigFile/_-/_}"
 if [ "${aConfigFile}" == "" ]; then                                                        # .(21127.01.3 RAM It wasn't found above)
#        aConfigFile=gitr_${aProj}-config.sh;    aConfigFile="${aConfigFile/_-/_}"          ##.(21127.01.4)
         aConfigFile=${aProj}_gitr-config.sh;    aConfigFile="${aConfigFile/_-/_}"          # .(21127.01.4 RAM Create one with this name)

    if [ "${bDoit}" != "1" ]; then                                                          # .(21101.02.1)
#   echo ""
#   echo "   Syntax: gitr clone {Project} [-all] [-doit]"
    echo ""
    echo "     ** Config file, '${aConfigFile}', not found."
    echo ""
    fi                                                                                      # .(21101.02.2)

#   -----------------------------------------------------------------

                                              bDir=1;              c1="#"; c2="#"       # 1 /webs/prj  or /webs/prj_                            # .(21029.03.4 RAM Beg)
    if [ "${aDir/_}"  != "${aPrj/_}"  ]; then bDir=0;                                   # 0 /webs
    if [ "${aPrj/_}"  == "${aPDir/_}" ]; then bDir=3; fi; else                          # 3 /webs/prj/stg
    if [ "${aDir/_}"  == "${aDir}"    ]; then bDir=2; fi; fi;      c3="#"; c4="#"       # 2 /webs/prj

#   echo "aPrj: ${aPrj}, aStage_var: '${aStage_var}', aDir: ${aDir}, aPDir: ${aPDir}, bDir: ${bDir}; '${c1}${c2}${c3}${c4}'"

    if [ "${bDir}" == "0" ] && [ "${aPrj/_}_" == "${aPrj}" ]; then c1=" "; fi;          # 1 /webs/prj_stg   # 1 gitr_{Project}_config.sh
    if [ "${bDir}" == "3" ] && [ "${aPrj/_}_" == "${aPrj}" ]; then c2=" "; c1="#"; fi;  # 2 /webs/prj_/stg  # 2 gitr_{Project}_stg-config.sh
    if [ "${bDir}" == "1" ] && [ "${aPrj/_}_" == "${aPrj}" ]; then c2=" "; fi;          # 2 /webs/prj_/stg  # 2 gitr_{Project}_stg-config.sh

#   if [ "${bDir}" == "0" ] && [ "${aPrj/_}"  == "${aPrj}" ]; then c3=" "; fi;          # 3 /webs/prj       # 3 gitr_{Project}-config.sh
    if [ "${bDir}" == "0" ] && [ "${aPrj/_}"  == "${aPrj}" ]; then c1=" "; fi;          # 3 /webs/prj       # 3 gitr_{Project}-config.sh
    if [ "${bDir}" == "2" ] && [ "${aPrj/_}"  == "${aPrj}" ]; then c3=" "; c1="#"; fi;  # 3 /webs/prj       # 3 gitr_{Project}-config.sh
    if [ "${bDir}" == "1" ] && [ "${aPrj/_}"  == "${aPrj}" ]; then c4=" "; fi;          # 4 /webs/prj/stg   # 4 gitr_{Project}-stg-config.sh    # .(21029.03.4 RAM End)

#   echo "aPrj: ${aPrj}, aStage_var: '${aStage_var}', aDir: ${aDir}, aPDir: ${aPDir}, bDir: ${bDir}; '${c1}${c2}${c3}${c4}', aConfigFile: '${aConfigFile}'" ; # exit

#   if [ "${bDir}" == "1" ] && [ "${bParse}"      == "1 "  ]; then c1=" "; c4="#"; fi;  # 1 /webs/prj_stg   # 1 gitr_{Project}_config.sh  ##.(21105.05.1)
    if [ "${bDir}" == "1" ] && [ "${bParse}${c4}" == "1 "  ]; then c1=" "; c4="#"; fi;  # 1 /webs/prj_stg   # 1 gitr_{Project}_config.sh  # .(21105.05.1 RAM Set c1 only if c4 was set)
    if [ "${bDir}" == "1" ] && [ "${bParse}${c4}" == "1#"  ]; then c2=" "; c1="#"; fi;  # 1 /webs/prj_stg   # 1 gitr_{Project}_config.sh  ##.(21105.05.2 RAM Set c2, if c4 was not set, or just keep it set to c2)

if [ "${aStage_var}" == "{stg1}-{ownr}" ]; then aStage_var="";         c3=" "; c1="#"; c2="#"; c4="#"; fi   # .(21105.01.1 RAM If no ${aStage}).(21105.04.2)
if [ "${aRepoDir}"   == ""   ]; then                           c5="#";
                                else                           c5=" "; c3="#"; c1="#"; c2="#"; c4="#"; fi

#   echo "   aPrj: '${aPrj}', aStage_var: '${aStage_var}', aDir: ${aDir}, aPDir: ${aPDir}, bDir: ${bDir}; '${c1}${c2}${c3}${c4}', aConfigFile: '${aConfigFile}'" ; # exit

if [ "${bDir}" == "1" ]; then aWebsDir=$( builtin cd ..; pwd ); fi                                          # .(21105.04.1 RAM Always set to /webs)

    echo "#!/bin/bash"                                                                  > "${aConfigFile}"  # .(21029.02.1 RAM Beg Create it if not found)
    echo ""                                                                             >>"${aConfigFile}"
    echo "    Project=\"${aPrj/_}\""                                                    >>"${aConfigFile}"
#   echo "    Stage=\"{stg1}-{owner}\""                                                 >>"${aConfigFile}"
#   echo "    GitHub_Acct=\"github-{usr}:{account}\""                                   >>"${aConfigFile}"
    echo "    Stage=\"${aStage_var}\""                                                  >>"${aConfigFile}"
    echo "    GitHub_Cert=\"${aGitHub_Cert_var}\""                                      >>"${aConfigFile}"
    echo "    GitHub_Acct=\"${aGitHub_Acct_var}\""                                      >>"${aConfigFile}"
    echo "    GitHub_SSH=\"${aGitHub_SSH_var}\""                                        >>"${aConfigFile}"
    echo ""                                                                             >>"${aConfigFile}"
if [ "$c5" == "#" ]; then
    echo "$c1   RepoDir=\"\${Project}_\${Stage}\"     # 1 {Project}_gitr_config.sh"     >>"${aConfigFile}"
    echo "$c2   RepoDir=\"\${Project}_/\${Stage}\"    # 2 {Project}_gitr_stg-config.sh" >>"${aConfigFile}"
    echo "$c3   RepoDir=\"\${Project}\"              # 3 {Project}_gitr-config.sh"      >>"${aConfigFile}"
    echo "$c4   RepoDir=\"\${Project}/\${Stage}\"     # 4 {Project}_gitr-stg-config.sh" >>"${aConfigFile}";
    echo ""; fi
if [ "$c5" == " " ]; then
    echo "    RepoDir=\"${aRepoDir}\"               # 5 {Project}_gitr_config.sh"       >>"${aConfigFile}";
    fi                                                                                  >>"${aConfigFile}"
    echo "    WebsDir=\"${aWebsDir}\""                                                  >>"${aConfigFile}"
#   echo "#   WebsDir=\"/webs\""                                                        >>"${aConfigFile}"
    echo ""                                                                             >>"${aConfigFile}"
    echo "    Apps=(  \"/._2/\" )"                                                      >>"${aConfigFile}"
    echo "    Apps[1]=\"/client1/\""                                                    >>"${aConfigFile}"
    echo "    Apps[2]=\"/server1/\""                                                    >>"${aConfigFile}"
    echo "    Apps[2]=\"/README.md\""                                                   >>"${aConfigFile}"
    echo "    Apps[2]=\"/code-workspace\""                                              >>"${aConfigFile}"
#   echo "    Apps[1]=\"/client1/1c1_my-html-custom-app/\""                             >>"${aConfigFile}"
#   echo "    Apps[2]=\"/client1/2c1_my-html-remote-app/\""                             >>"${aConfigFile}"
    echo ""                                                                             >>"${aConfigFile}"
    echo "#   ------------------------------------------------"                         >>"${aConfigFile}"
    echo ""                                                                             >>"${aConfigFile}"
    echo "    export aProject=\"\${Project}\""                                          >>"${aConfigFile}"
    echo "    export aStage=\"\${Stage}\""                                              >>"${aConfigFile}"
    echo "    export aGitHub_Cert=\"\${GitHub_Cert}\""                                  >>"${aConfigFile}"
    echo "    export aGitHub_Acct=\"\${GitHub_Acct}\""                                  >>"${aConfigFile}"
    echo "    export aGitHub_SSH=\"\${GitHub_SSH}\""                                    >>"${aConfigFile}"
    echo "    export aRepoDir=\"\${RepoDir}\""                                          >>"${aConfigFile}"
    echo "    export aWebsDir=\"\${WebsDir}\""                                          >>"${aConfigFile}"
    echo "    export Apps"                                                              >>"${aConfigFile}"
    echo ""                                                                             >>"${aConfigFile}" # .(21029.02.1 RAM End)

#   -----------------------------------------

    if [ "${bDoit}" != "1" ]; then                                                          # .(21101.02.3 RAM Continue if bDoit)

    echo "  Please edit the vars, Stage, GitHub_Acct and Apps as appropriate"
    echo "    in this config file just created: "
    echo ""
    echo "-------------------------------------------------------------------------------"
     cat   "${aConfigFile}"
    echo "-------------------------------------------------------------------------------"
    echo ""
    echo "  Then run the command again, gitr clone ${aPrj} to view the settings."

    {aLstSp}; exit
    fi                                                                                      # .(21101.02.4)
#   -----------------------------------------
    fi
#   -----------------------------------------

if [ "${bParse}" == "1" ]; then

    aTS=$( date '+%y%m%d.%H%M' ); aTS=${aTS:1}
    cp -p "${aConfigFile}" "${aConfigFile/.sh}_v${aTS}.sh"

                                                    aRepoDir_arg="\${Project}_/\${Stage}";   # .(21105.03.1)
    if [ "${aPrj/_}_" != "${aDir}" ];          then aRepoDir_arg="\${Project}_\${Stage}"; fi # .(21105.03.2)
    if [ "${aStage_arg}" == "{stg1}-{ownr}" ]; then aRepoDir_arg="\${Project}"; fi           # .(21105.03.3)
    if [ "${aStage_arg}" == "{stg1}-{ownr}" ]; then aStage_arg=""; fi                        # .(21105.01.2 RAM Here too)

awkPgm='
BEGIN { }
    /    Stage=/                                           { print "    Stage=\"'${aStage_arg}'\""            ; next }
    /    GitHub_Cert=/ && "'${aGitHub_Cert_arg}'" != "n/a" { print "    GitHub_Cert=\"'${aGitHub_Cert_arg}'\""; next }
    /    GitHub_Acct=/ && "'${aGitHub_Acct_arg}'" != "n/a" { print "    GitHub_Acct=\"'${aGitHub_Acct_arg}'\""; next }
    /    GitHub_SSH=/                                      { print "    GitHub_SSH=\"'${aGitHub_SSH_arg}'\""  ; next }
    /    RepoDir=/                                         { print "#   " substr( $0, 5)                                # .(21105.03.4)
                                                             print "    RepoDir=\"'${aRepoDir_arg}'\""        ; next }  # .(21105.03.5)
                                                           { print }
      { }
END   { }'

    cat "${aConfigFile/.sh}_v${aTS}.sh" | awk "${awkPgm}" >"${aConfigFile}"

    echo -e "\n * Config file, '${aConfigFile}', updated."

#   echo -e "\n-------------------------------------"; cat "${aConfigFile}"; echo -e "-------------------------------------\n"

    if [ "${bDoit}" != "1" ]; then                                                          # .(21101.02.5)

       $0 "${aPrj}"                                                                         # .(21105.02.1 RAM Show updated config)
       echo ""; exit                                                                        # .(21127.08.5)
    fi                                                                                      # .(21101.02.6)
    fi
#   --------------------------------------------------------------------------------------------------

#   source  "gitr_${aProj}-config.sh"
    source  "${aConfigFile}"

#   echo "aWebsDir: ${aWebsDir}"; exit

if [ "${aStage_arg}"       != "" ]; then aStage="${aStage_arg}"; fi
if [ "${aGitHub_Cert_arg}" != "" ]; then aGitHub_Cert="${aGitHub_Cert_arg}"; fi
if [ "${aGitHub_Acct_arg}" != "" ]; then aGitHub_Acct="${aGitHub_Acct_arg}"; fi
if [ "${aGitHub_SSH_arg}"  != "" ]; then aGitHub_SSH="${aGitHub_SSH_arg}"; fi

    bSSH=$( echo "${aGitHub_SSH}" | awk '/yes|Yes|YES/ { print "1"; }' ); if [ "${bSSH}" != "1" ]; then bSSH="0"; fi
#   bSSH=$( echo "${aGitHub_SSH}" | awk '/yes|Yes|YES/ { print "1"; exit }; { print "0" }' ); if [ "${bSSH}" != "1" ]; then bSSH="0"; fi

    aGitHub_URL="${aGitHub_Cert}:${aGitHub_Acct}"
if [ "${bSSH}" == "0" ]; then
    aGitHub_URL="https://github.com/${aGitHub_Acct}"
    fi
#   echo -e "\n  aGitHub_URL: ${aGitHub_URL}/${aProject}_${aStage}\n"; # exit

#   -----------------------------------------------------------------

                                        bCone=0;
 if [ "${aWebsDir:0:2}" == "/C" ]; then bCone=1; fi  # Get files in root folder
 for (( i=0; i<=$(( ${#Apps[*]}  - 1 )); i++ )); do mApps[$i]=${Apps[$i]}; done

    aRepo=${aProject}_${aStage}; if [ "${aStage}" == "" ]; then aRepo=${aProject}; fi                       # .(21105.01.3 RAM Get rid of _)

#   -----------------------------------------------------------------

 if [ "${bDoit}" == "0" ]; then
    echo ""
#   echo "  The file, ${aCurDir}gitr_${aProj}-config.sh, contains:"
    echo "  The file, ${aConfigFile}, contains:"
    echo "  -------------------------------------------------"
    echo "    Project: ${aProject}"
    echo "    Stage:   ${aStage}"
    echo ""

#        aAll="";          aCone="only those files in {Apps[i]} folders in Repo: ${aProject}_${aStage}"     ##.(21105.01.4)
         aAll="";          aCone="only those files in {Apps[i]} folders in Repo: ${aRepo}"                  # .(21105.01.4 RAM Was: ${aProject}_${aStage})
 if [ "${bCone}" == "1" ]; then aCone="all files in Repo root (i.e. bCone=1), and\n         ${aCone:5} "; fi
 if [ "${bAll}"  == "1" ]; then aCone="all files in all folders in Repo : ${aRepo}"; aAll="-all "; fi       # .(21105.01.5)

    echo "    Git Cmd: git clone ${aGitHub_URL}/${aRepo}.git  ${aRepoDir}"                                  # .(21105.01.6)
    echo "    Git URL: http://gitHub.com/${aGitHub_Acct}/${aRepo}"                                          # .(21105.01.7)
    echo "    GitHub_Cert: ${aGitHub_Cert}"
    echo "    GitHub_Acct: ${aGitHub_Acct}"
    echo "    bCone: ${bCone}, bAll: ${bAll}; bSSH: ${bSSH}"
    echo ""
    echo "    WebsDir: ${aWebsDir}"
    echo "    RepoDir: ${aRepoDir}"
    echo ""
    echo "    Apps[0]: ${mApps[0]}"
#   for aApp in "${mApps[@]}"; do  echo "  ${aApp}"; done
    for (( i=1; i<=$(( ${#mApps[*]} - 1 )); i++ )); do
    echo "        [${i}]: ${mApps[$i]}"
    done

    echo ""
    echo -e "  To clone ${aCone}"
    echo ""
    echo    "    Run: gitr clone ${aPrj} ${aAll}-doit"                          # .(21127.08.3 RAM Uppercase Project)

    ${aLstSp}; exit                                                             # .(21127.08.4)
    fi

#   -----------------------------------------------------------------

#   echo "aWebsDir: ${aWebsDir}"; echo "aCurrDir: $( pwd )"
    cd "${aWebsDir}"

#   echo "Using Gitr config file: ${aConfigFile}"

#   -----------------------------------------------------------------

    bCpy=1; bZip=0

 if [ -d "${aRepoDir}/.git" ] && [ "${bCpy}" == "1" ]; then                     # .(21029.01.1 RAM Beg Copy repo to ${aRepoDir}_v${aTS})

    aTS=$( date '+%y%m%d.%H%M' ); aTS=${aTS:1}
    if [ ! -d "${aRepoDir}_v${aTS}" ]; then mkdir  "${aRepoDir}_v${aTS}"; fi    # .(21030.01.1 RAM Don't remove _)
    echo -e "\nBacking up to '${aWebsDir}/${aRepoDir}_v${aTS}'"
#   cp -pr "${aRepoDir}"/*  "${aRepoDir}_v${aTS}";
    cp -pa "${aRepoDir}"/.  "${aRepoDir}_v${aTS}";
    fi                                                                          # .(21029.01.1 RAM End)
#   -----------------------------------------------------------------

 if [ -d "${aRepoDir}/.git" ] && [ "${bZip}" == "1" ]; then                     # .(21029.01.2 RAM Beg Zip repo to ${aRepoDir}_v${aTS}.zip)

    aTS=$( date '+%y%m%d.%H%M' ); aTS=${aTS:1}
    aZipFile="${aRepoDir}_v${aTS}.zip"                                          # .(21030.01.2 RAM Don't remove _)
    if [ -f "${aZipFile}" ]; then rm "${aZipFile}"; fi
    echo -e "\nZiping into '${aZipFile}'"
    zip a -r -bt '-x!node_modules' "${aZipFile}" "${aRepoDir}" | awk '/to archive|size/ { print "  " $0 }; /Globa/ { print "  In " $4 " secs" }'
    fi                                                                          # .(21029.01.2 RAM End)
#   -----------------------------------------------------------------

    rm -fr "${aRepoDir}"/*  2>/dev/null                                         # .(21026.01.1 RAM Delete all files in RepoDir)
    rm -fr "${aRepoDir}"/.* 2>/dev/null

 if [ -d "${aRepoDir}" ]; then                                                  # .(21127.08.3 RAM check if folder is still there)
            nCnt=$( ls -la "${aRepoDir}" | awk '/total/ { print $2 }' )         # .(21107.01.1 RAM Check if RepoDir contains files)
    if [ "${nCnt}" != "0" ]; then

         echo -e "\n * The repo folder, ${aRepoDir} was not completey removed"

                   aRDir="../../JPTs/RSS/DirList\RSS22_DirList.sh"              # .(21127.02.1 RDir may not exist)
         if [ -f "${aRDir}" ]; then "${aRDir}" "${aRepoDir}"; exit; fi          # .(21127.02.2)
         exit
      fi                                                                        # .(21127.08.3)  
    fi
#   -----------------------------------------------------------------

#   exit
    echo ""
    echo "Cloning ${aGitHub_URL}/${aRepo}.git"                                                  # .(21105.01.8)

 if [ "${bAll}" == "1" ]; then

#   git clone               "${aGitHub_URL}/${aProject}_${aStage}.git"  "${aRepoDir}" 2>&1 | awk '{ print "   " $0 }'; nErr=$?  ##.(21105.01.9).(21129.02.2)
    git clone               "${aGitHub_URL}/${aRepo}.git"               "${aRepoDir}" 2>&1 | awk '{ print "   " $0 }'; nErr=$?  # .(21105.01.9).(21129.02.2)
#   git clone               "https://github.com/8020data/FRApps_prod-master.git"

    if [ "${nErr}" != "0" ]; then exit; fi

    cd "${aRepoDir}"

  else
    git clone --no-checkout "${aGitHub_URL}/${aRepo}.git"               "${aRepoDir}" 2>&1 | awk '{ print "   " $0 }'; nErr=$?  # .(21105.01.10).(21129.02.3)
#   git clone --no-checkout "github-ram:robinmattern/FRApps_prod-robin.git" FRApps;    nErr=$?

    if [ "${nErr}" != "0" ]; then exit; fi

    cd "${aRepoDir}"

    git sparse-checkout init             # same as init --cone
#   git sparse-checkout init --cone
#   git sparse-checkout init --sparse-index
#   git sparse-checkout init --no-sparse-index

#   echo ""
#   echo "git config --worktree core.sparse --- before -------------------------------------------------------"
#   git config --worktree -l | awk '/sparse|exten/ { print "   " $0 }'
#   git config --local    -l | awk '/sparse|exten/ { print "   " $0 }'

if [ "${bCone}" == "0" ]; then

    git config --worktree core.sparsecheckoutcone false    # Don't get files in root folder
    fi

    echo ""
    echo "git config --worktree core.sparse ---------------------------------------------------"
    git config --worktree  -l | awk '/sparse|exten/ { print "   " $0 }'
    git config --local     -l | awk '/sparse|exten/ { print "   " $0 }'


#   echo ""; exit

#   echo "  git sparse-checkout set '${mApps[0]}'"
    git sparse-checkout set "${mApps[0]}"

for (( i=1; i<=$(( ${#mApps[*]} - 1 )); i++ )); do

#   echo "  git sparse-checkout add '${mApps[$i]}'"
    git sparse-checkout add "${mApps[$i]}"
    done

#   git sparse-checkout add ".code-workspace"   # root files pulled due to --cone
#   git sparse-checkout add ".vscode/*"
#   git sparse-checkout add ".url"

#   git sparse-checkout add "/LICENSE"
#   git sparse-checkout add "/README.md"
#   git sparse-checkout add "/index.html"

    echo ""
    echo "cat .git/info/sparse-checkout -----------------------------------------------------------"
          cat .git/info/sparse-checkout | awk '{ print "   " $0 }'

#   echo ""; exit

    echo ""
    git checkout

    fi  # eif bAll == 0

#   echo ""
#   rdir -r 9 "index"     | awk           'NF > 0 { print }'
#   rdir -r 9 "README.md" | awk 'NR > 3 && NF > 0 { print }'
#   rdir -r 9 "LICENSE"   | awk 'NR > 3 && NF > 0 { print }'

    rss dirlist 1 3

    echo "Be sure to change into your new Repo folder: cd ${aRepoDir}"
#   echo ""

#   -----------------------------------------------------------------

#   git sparse-checkout list

#   git sparse-checkout disable

#   git config --worktree core.sparsecheckout true
#   git sparse-checkout reapply
