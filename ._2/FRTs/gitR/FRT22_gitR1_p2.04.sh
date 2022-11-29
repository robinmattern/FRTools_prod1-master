#!/bin/bash
#*\
##=========+====================+================================================+
##RD         gitr               | Git Helper Tools
##RFILE    +====================+=======+===============+======+=================+
##FD   FRT22_GitR1.sh           |  66449|  5/08/22 16:10|  1169| p2.02-20508-1610
##FD   FRT22_GitR1.sh           |  67037|  5/04/22 19:40|  1178| p2.02-20504-1940
##FD   FRT22_GitR1.sh           |  66020|  5/03/22 19:15|  1165| p2.02-20503-1915
##FD   FRT22_GitR1.sh           |  65476|  5/03/22 14:11|  1164| p2.02-20503-1411
##FD   FRT22_GitR1.sh           |  64877|  5/03/22 09:17|  1155| p2.02-20503-0917
##FD   FRT22_GitR1.sh           |  66326|  5/01/22 20:53|  1173| p2.02-20501-2053
##FD   FRT22_GitR1.sh           |  66693|  5/15/22 13:06|  1174| p2.02-20515-1306
##FD   FRT22_gitR1.sh           |  69290|  6/23/22 13:03|  1227| p2.02-20623-1303
##FD   FRT22_GitR1.sh           |  67621|  6/25/22 14:45|  1179| p2.02-20625-1445
##FD   FRT22_gitR1.sh           |  73907|  6/25/22 15:41|  1288| p2.02-20625-1541
##FD   FRT22_gitR1.sh           |  75750|  6/27/22 09:04|  1302| p2.02-20627-0904
##FD   FRT22_gitR1.sh           |  77248| 10/25/22 19:43|  1332| p2.03-21025-1943
##FD   FRT22_gitR1.sh           |  79863| 10/27/22 10:20|  1361| p2.04-21027-1020
##FD   FRT22_gitR1.sh           |  80647| 11/03/22 16:05|  1370| p2.04-21103-1605
##FD   FRT22_gitR1.sh           |  81638| 11/11/22 17:09|  1387| p2.04-21111-1709
##FD   FRT22_gitR1.sh           |  83204| 11/17/22 12:00|  1404| p2.04-21117-1200
##FD   FRT22_gitR1.sh           |  83707| 11/20/22 13:55|  1402| p2.04-21120.1355
##FD   FRT22_gitR1.sh           |  86848| 11/27/22 17:04|  1419| p2.04-21127.1704
##DESC     .--------------------+-------+---------------+------+-----------------+
#            Use the commands in this script to run git commands with helpfull
#            output.
#
##LIC      .--------------------+----------------------------------------------+
#            Copyright (c) 2021 8020Data-FormR * Released under
#            MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+----------------------------------------------+
#            Init               | Create .git folder                                                        # .(20430.01.1 RAM Added)
#                               |
#            Commit Comment     |
#            Push               |
#            Fetch              | [All]
#            Pull               |
#            Clone              |                                                                           # .(21027.01.1)
#            Sparse             |                                                                           # .(21025.01.1)
#                               |
#            List               | [Local|Remote] Commmits
#            Count              | [Local|Remote] Commmits
#                               |
#            List               | [Local|Remote] Branches
#            Count              | [Local|Remote] Branches
#            Checkout           | [Local|Remote] Branch
#                               |
#            Add                | Remote
#            List               | Remotes [Repo|All]
#            Rename             | Remote
#            Delete             | Remote                                                                    # .(11127.01.1 RAM Was: Remove)
#                               |
#            Var                | 
#            Var List           | 
#            Var Set            | 
#            Var Get            | 

#            setBranch          |
#            setProjVars        |
#            getCurRemote       |
#            getCurBranch       |
#            shoGitRemotes1     |
#            shoGitRemotes2     |
#
##CHGS     .--------------------+----------------------------------------------+

# .(10822.01 08/22/21 RAM 12:00p| ???
# .(10824.01 08/24/21 RAM  9:35a| Created
# .(11127.01 11/27/21 RAM  8:40a| Changed 'remove remote' to 'delete remote'
# .(11127.02 11/27/21 RAM 10:25a| Changed width of Remote name
# .(20122.01  1/22/22 RAM 10:45a| Added "remote alias" local
# .(20122.03  1/22/22 RAM 12:00p| Changed debug to -debug
# .(20122.04  1/22/22 RAM 12:20p| Added aCmd="List Local Commit"
# .(20429.07  4/29/22 RAM  6:45p| Check Git dir
# .(20430.01  4/30/22 RAM  6:22p| Add Git Init and Vars commands
# .(20501.01  5/01/22 RAM 11:30a| Enable JPT12_Main2Fns_p1.05.sh in sub-scripts
# .(20429.09  5/01/22 RAM  2:45p| Run Args_toLower once
# .(20501.03  5/01/22 RAM 12:22p| Add Git create command
# .(20502.06  5/02/22 RAM 12:00p| Major Overhaul of JPT12_Main2Fns_p1.06.sh
# .(20508.03  5/08/22 RAM  4:10p| Moved THE_SERVER checks to JPT12_Main2Fns
# .(20601.06  6/01/22 RAM 10:15p| Check if .git is in parent folder
# .(20615.01  6/15/22 RAM  8:20p| Set ProjVars when in C:\Repos
# .(20623.13  6/23/22 RAM  1:03p| Move List Remotes All
# .(20623.13  6/26/22 RAM  6:30p| Change Cmd Name to List All Remotes
# .(20627.01  6/27/22 RAM  6:30p| Create Cmd List Branch Commits
# .(21025.01 10/25/22 RAM  7:30p| Add sparse on / off
# .(21026.01 10/26/22 RAM  4:30p| Add sparse list
# .(21027.01 10/27/22 RAM  9:04a| Add clone
# .(21027.02 10/27/22 RAM  9:25a| Chop single command to 4 letters
# .(21027.03 10/27/22 RAM 10:20a| Add "*" as optional getCmd
# .(21111.02 11/11/22 RAM  2:30p| Special case for gitr pull FRTools
# .(21111.03 11/11/22 RAM  5:09p| FormR_U is in /webs not /webs/nodeapps
# .(21113.05 11/13/22 RAM  5:30p| Display Version and Source in Begin
# .(21117.01 11/17/22 RAM 12:00p| Improve gitR Helps
# .(21120.02 11/20/22 RAM  1:55p| Fix aOSv and aLstSp
# .(21122.03 11/20/22 RAM  1:30p| Swap FormR_U for SCN2_U Proj Folder sniffer 
# .(21122.04 11/22/22 RAM  7:20p| Swap @ for | in list commits 
# .(21118.02 11/27/22 RAM  3:00p| Use gitR_clone_p1.04
# .(21127.03 11/27/22 RAM  4:45p| Improve Git Pull -hard 
# .(21127.03 11/27/22 RAM  9:15p| More improvements to Git Pull -hard 
# .(21128.05 11/27/22 RAM  6:30p| Sort list commits 
# .(21128.06 11/27/22 RAM  7:30p| Implement vars set/get 

##PRGM     +====================+===============================================+
##ID 69.600. Main               |
##SRCE     +====================+===============================================+
#*/
#========================================================================================================== #  ===============================  #

        aVdt="Nov 27, 2022  5:04p"; aVtitle="formR gitR Tools"                                              # .(21113.05.6 RAM Add aVtitle for Version in Begin)
        aVer="$( echo $0 | awk '{  match( $0, /_[dpstuv][0-9]+\.[0-9]+/ ); print substr( $0, RSTART+1, RLENGTH-1) }' )"  # .(21031.01.1 RAM Add [d...).(20416.03.8 "_p2.02", or _d1.09)

        LIB="GITR"; LIB_LOG=${LIB}_LOG; LIB_USER=${LIB}_USER; Lib=${LIB}                                    # .(80923.01.1)

        aFns="$( dirname "${BASH_SOURCE}")/../../JPTs/JPT12_Main2Fns_p1.07.sh"; if [ ! -f "${aFns}" ]; then # .(21113.05.7 RAM Use JPT12_Main2Fns_p1.07.sh)
        echo -e "\n ** RSS1[ 71]  JPT Fns script, '${aJFns}', NOT FOUND\n"; exit; fi; #fi
        source "${aFns}";

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

        bDoit=0                                                                                             ##.(20501.01.5 RAM !Important don't reset in Sub script)
        bQuiet=1                                                                                            ##.(20501.01.6 RAM).(20601.02.2 bQuiet by default)
        bDebug=0                                                                                            ##.(20501.01.7 RAM)
        bSpace=0;                                                                                           # .(20620.04.8 RAM A space hasn't been displayed, print one next; was 1)

        Begin "$@"                                                                                          # .(21113.05.16)

        setOS; bSpace=1;                                                                                    #  A space hasn't been displayed, print one next
#       aLstSp="echo "; if [ "${aOSv:0:1}" == "w" ]; then aLstSp=""; fi                                     ##.(10706.09.1 RAM Windows returns an extra blank line).(21113.06.1 RAM Reverse).(21120.02.2)
        aLstSp="echo "; if [ "${aOSv/w}" != "${aOSv}" ]; then aLstSp=""; fi                                 # .(10706.09.1 RAM Windows returns an extra blank line).(21113.06.1 RAM Reverse).(21120.02.2)
#       echo "  - GitR1[125]  aOSv: ${aOSv}, ${aOS}, aLstSp: '${aLstSp}'"; ${aLstSp}; # exit

#    -- --- ---------------  =  ------------------------------------------------------  #

#       aOSv=gfw1 | w10p | w08s
#       aOSv=rh62 | rh70 | uv14 | ub16

#       sayMsg    "GitR1[132]  aServer: '${aServer}', aOS: '${aOS}', bDebug: '${bDebug}'" 2

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       HELP Command
#
#====== =================================================================================================== #  ===========

function Help( ) {

        sayMsg    "GitR1[144]  aCmd:  '${aCmd}', aCmd0: '$1', aCmd1: '${aCmd1}'" -1

#    if [ "${aCmd}" != "Help" ] && [ "help" != "$1" ]; then return; fi                                      ##.(21117.01.1)

#    if [ "$1" != "help"  ]; then sayMsg " ** Invalid Command: '$1'" 3 sp; aCmd="Help"; fi                  ##.(20625.05.1)
#    if [ "$1" != "help"  ]; then sayMsg " ** Invalid Command: '$1'" sp 3; fi                               ##.(20625.05.1 RAM A little help with help)
#    if [ "$1" != "help"  ]; then sayMsg " ** Invalid Command: '$1'" 3;    fi                               ##.(20625.05.1 RAM A little help with help)
#    if [ "${aCmd/Help}" == "${aCmd}" ]; then sayMsg " ** Invalid Command: '$1'" 3; aCmd="Help";  fi        ##.(21117.01.2 RAM Works best)
     if [ "${aCmd}" == "" ]; then bQuiet=0; sayMsg " ** Invalid gitR Command: '$1'" 3; aCmd="Help";  fi     # .(21117.01.2 RAM Works best)

     if [ "${aCmd}" == "Help" ]; then                                                                       # .(21117.01.3)

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

        echo ""
        echo "  Useful gitR Commands   (${aVer})                                 (${aVdt})"
        echo "  -------------------------------------------------------------- -----------------------------------"
        echo "   gitR  Init                                                    Create a .git folder"        # .(20429.03.2 End)
        echo ""
        echo "   gitR  Commit {Comment}                                        Stage and Commit all changes"
        echo "         Push                                                    Upload changes to remote"
        echo "         Fetch                                                   Fetch remote changes (Refs only, i.e. no local changes)"
        echo "         Fetch [All]                                             Fetch remote changes for all remotes and branches"
        echo "         Pull                                                    Merge remote changes (if no merge conflicts)"
        echo "         Pull  -hard  [ hard | --hard ]                          Remove all changes before merge"                 # .(21127.03.8)
        echo "         Sparse On | Off | List                                  Turn sparse-checkout on and/or off"              # .(21025.01.2 RAM Added).(21026.01.1)
        echo "         Clone {Project} [-doit] [-all]                          Backup and Clone Repo with sparse-checkout"      # .(21027.01.2 RAM Added)
        echo "         Clone {RepoURL} [-doit] [-all]                          Create config file: gitr_{project}_config.sh"    # .(21101.05.1 RAM Added)
        echo ""
        echo "         List Local Commmits [{BranchName}] [-d {Days}]          List Local Commits"
        echo "         Count Local Commmits [{BranchName}                      Count Local Commits"
#       echo "         List Remote Commmits [{GitHost} {GitUser}] {Branch}     List Remote Commits"
        echo "         List Remote Commmits [{BranchName}] [-d {Days}]         List Remote Commits"
        echo "         Count Remote Commmits [{RemoteName}/][{BranchName}      Count Remote Commits"
        echo ""
        echo "         List [Local|Remote] Branches                            List Local and/or Remote Branches"
        echo "         Checkout [{RemoteName}] {BranchName}                    Checkout Local or Remote Branch"
        echo ""
        echo "         Rename Remote [{OldRemoteName}] {OldRemoteName}         Rename Remote e.g. \"origin\""
        echo "         Create Remote {RemoteName} {RemoteURL}                  Create a Repository with Remote URL"             # .(20501.03.1 RAM)
        echo "         Add    Remote {RemoteName} {RemoteURL}                  Add Remote Name for URL"
#       echo "         List Remotes [{RepoName}]                               List Remote URLs for one/current Project Repo"
        echo "         List Remotes                                            List Remote URLs and Branches"
        echo "         List All Remotes                                        List Remote URLs and Branches for all Project Repos"     # .(20623.13.11)
        echo "         Delete Remote [RemoteName}                              Delete Remote Name"                              # .(11127.01.4 RAM Was: Remove Remotes)
        echo ""
        echo "         Var List                                                List all local and global config variables"      # .(20501.02.1 RAM)
        echo "         Var Set {Name} {Value} [-g]                             Set [global] config value"                       # .(20501.02.12)
        echo "         Var Get {Name}                                          Set [global] config value"                       # .(21128.06.1)
        echo ""
        echo "  Notes: Only two lowercase letter are needed for each command, seperated by spaces"
        echo "         One or more command options follow. Help for the command is dispayed if no options are given"
        echo "         The options, -debug, -doit and -quietly, can follow anywhere after the command"      # .(20122.03.2)
#       echo ""
        ${aLstSp}                                                                                           # .(10706.09.3)
        exit
        fi                                                                                                  # .(21117.01.4)

#       sayMsg    "GitR1[200]  ${aCmd}" 2
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

  if [ "${aCmd}"  == "Show Help" ]; then
        echo ""
        echo "         Show the Git Remote URLs for fetch, pull and push for a Repository Project."
        echo "         The current folder must be a Project folder containing Git branches"
        echo "         Enter a Branch folder name or [all] to show the URLs for all branches"
        ${aLstSp}                                                                                           # .(10706.09.3)
        exit
     fi
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

  if [ "${aCmd}"  == "List Help" ]; then
        echo ""
        echo "         List the Git commits for a Repository Project Branch"
        echo "         The current folder must be a Project folder containing Git branches"
        echo "         Like the Show command, the Remote Alias, referring to a remote repository, "
        echo "           is set for Project Branch folder, but you can provide explicitly"
        ${aLstSp}                                                                                           # .(10706.09.3)
        exit
     fi
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

  if [ "${aCmd}"  == "Remote Help" ]; then
        echo ""
        echo "         Git Remotes are Alias Names that refer to SSH Host Names contained in your SSH Config file"
        echo "         Use the command, Keys Set SSH Hosts, to create them for different Git Keys files"
        echo "         These names allow Git Keys to be used with the git fetch, pull and push commands"
        ${aLstSp}                                                                                           # .(10706.09.3)
        exit
     fi
     } # eof Help
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#========================================================================================================== #  ===============================  #

        setArgs "${1:0:4}" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9"                                          # .(21027.02.1 RAM 'gitr clone'; didn't work, but 'gitr clon' does)

  if [ "${bDebug}" == "1" ]; then dBg=1; fi # echo "setCmds ${dBug}"; fi # exit; fi

        getOpts "bdqgl"
        setCmds                                    # ${dBg}   # 1 # dBug

#       sayMsg sp "GitR1[244]  \$1: '$1', \$2: '$2', \$3: '$3', \$4: '$4', \$5: '$5', \$6: '$6', \$7: '$8'" 1
        sayMsg    "GitR1[245]  aCmd:  '${aCmd}', aCmd1: '${aCmd1}', aCmd2: '${aCmd2}', aCmd3: '${aCmd3}', aCmd0: '${aCmd0}', bDoit: '$bDoit', bDebug: '$bDebug', dBug: '$dBug', bQuiet: '$bQuiet' " sp -1
#       sayMsg    "GitR1[246]  aCmd:  '$aCmd',   aCmd1: '$aCmd1', aCmd2: '$aCmd2', aCmd3: '$aCmd3', aCmd0: '$aCmd0' "

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#       Help

        getCmd "in"             "Init"                                                  # .(20502.06.x End)

        getCmd "push"           "Push"
#       getCmd "pull"           "Pull"
        getCmd "pull"  "*"      "Pull"                                                  # .(21127.03.1)
        getCmd "clon"  "*"      "Clone"                                                 # .(21027.01.3).(21027.03.2)

        getCmd "fe"    "al"     "Fetch All"       0
        getCmd "fetch"          "Fetch"           0     # aArg1 could be All
        getCmd "fe"    ""       "Fetch"                 # is wrong: 'Fetch All'         # .(20625.02.1 RAM Fixed getCmd)

        getCmd "sp"    "on"     "Sparse"                                                # .(21025.01.3)
        getCmd "sp"    "of"     "Sparse"                                                # .(21025.01.3)
        getCmd "sp"    "li"     "Sparse"                                                # .(21026.01.2)

        getCmd "co"             "Add Commit"
        getCmd "ad" "co"        "Add Commit"

        getCmd "ad" "re"        "Add Remote"
        getCmd "ad" "br"        "Add Branch"

        getCmd "cr" "re"        "Create Remote"   #1

#       getCmd "li" "re" "al"   "List All Remotes"                                       # .(20623.13.12)
#       getCmd "li" "re"        "List Remotes"           # maybe ok: 'List Remotes All'

        getCmd "rm" "re"        "Remove Remote"
        getCmd "de" "re"        "Remove Remote"
        getCmd "re" "re"        "Rename Remote"

        getCmd "ch" "br"        "Checkout Branch" # 1
        getCmd "ch"             "Checkout Branch"

        getCmd "li" "va"        "List Vars"
        getCmd "se" "va"        "Set Var"
        getCmd "ge" "va"        "Get Var"                                               # .(21128.06.2)

        getCmd "li" "co" "br"   "List Branch Commits"                                   # .(20627.01 RAM Create Cmd List Branch Commits)

        getCmd "li" "co" "al"   "List All Commits"
        getCmd "li" "co" "lo"   "List Local Commits"    # is wrong: 'List All Commits'  # .(20625.02.3)
        getCmd "li" "co" "re"   "List Remote Commits"   # is wrong: 'List All Commits'  # .(20625.02.4)
        getCmd "li" "co"        "List Local Commits"    # is wrong: 'List All Commits'  # .(20625.02.5)

#       getCmd "co" "re" "li"   "List Remote Commits"   # is wrong: 'List All Commits'  # .(20625.02.4)
#       getCmd "re" "co" "li"   "List Remote Commits"   # is wrong: 'List All Commits'  # .(20625.02.4)

        getCmd "li" "br" "al"   "List All Branches"
        getCmd "li" "lo" "br"   "List Local Branches"
        getCmd "li" "re" "br"   "List Remote Branches"  # is wrong: 'List Remotes All'  # .(20625.02.2)
        getCmd "li" "br"        "List Local Branches"   # is wrong: 'List All Branches' # .(20625.02.6)

        getCmd "co" "co" "al"   "Count All Commits"
        getCmd "co" "co" "lo"   "Count Local Commits"   # is wrong: 'List All Commits'   # .(20625.02.7)
        getCmd "co" "co" "re"   "Count Remote Commits"  # is wrong: 'List All Commits'   # .(20625.02.8)
        getCmd "co" "co"        "Count Local Commits"   # is wrong: 'List All Commits'   # .(20502.06.x End).(20625.02.9)
        getCmd "co" "re"        "Count Remote Commits"

        getCmd "li" "re" "al"   "List All Remotes"                                       # .(20623.13.12)
        getCmd "li" "re"        "List Remotes"          # maybe ok: 'List Remotes All'

        getCmd "he" "re"        "Remote Help"
        getCmd "he" "sh"        "Show Help"
        getCmd "he" "li"        "List Help"

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

        sayMsg    "GitR1[317]  aCmd:  '${aCmd}', aArg1: '${aArg1}', aArg2: '${aArg2}', aArg3: '${aArg3}', aArg4: '$aArg4', aArg5: '$aArg5', aArg6: '$aArg6', aArg7: '$aArg7', aArg8: '$aArg8', aArg9: '$aArg9'" -1
#       sayMsg    "GitR1[318]  aCmd:  '${aCmd}', aArg1: '${aArg1}', aArg2: '${aArg2}', aArg3: '${aArg3}', aCmd0: '$aCmd0', bGlobal: '${bGlobal}'" -1 # 2
        sayMsg    "GitR1[319]  aCmd:  '${aCmd}', '$aCmd1', '$aCmd2', '$aCmd3', '$aCmd0', '$c1', '$c2', '$c3', '${aArg1}' " -1 # -1 or 2

#    if [ "${aCmd}" == "" ]; then aCmd="Help"; fi                                       ##.(20625.05.2 RAM A little help with help).(21117.1.5)

        Help ${aCmd0}

#    if [ "${aCmd3}" == "li-br-al" ]; then sayMsg "  * List Branches All is not a valid command" 3; fi
#    if [ "${aCmd3}" == "ls-br-al" ]; then sayMsg "  * List Branches All is not a valid command" 3; fi
#    if [ "${aCmd3}" == "sh-br-al" ]; then sayMsg "  * Show Branches All is not a valid command" 3; fi
#    if [ "${aCmd3}" == "br-li-al" ]; then sayMsg "  * List Branches All is not a valid command" 3; fi
#    if [ "${aCmd3}" == "br-ls-al" ]; then sayMsg "  * List Branches All is not a valid command" 3; fi
#    if [ "${aCmd3}" == "br-sh-al" ]; then sayMsg "  * Show Branches All is not a valid command" 3; fi

# ------------------------------------------------------------------------------------
#
#       GITR Functions
#
#====== =================================================================================================== #  ===========

# function sayMsg( ) {  ... }                                                                                               ##.(20501.01.6)

#====== =================================================================================================== #  ===========

function setBranch( ) {
     if [ "$1" == "" ]; then return; fi; aBranch=""
        sayMsg "setBranch[ 1 ]  Checking Branch: '$1'";
     if [ "${1/-test/}"  != "$1" ]; then  aBranch=$1; fi
     if [ "${1/-prod/}"  != "$1" ]; then  aBranch=$1; fi
     if [ "${1/-dev/}"   != "$1" ]; then  aBranch=$1; fi
     if [ "${1/main/}"   != "$1" ]; then  aBranch=$1; fi
     if [ "${1/master/}" != "$1" ]; then  aBranch=$1; fi
     if [ "${1/Main/}"   != "$1" ]; then  aBranch=$1; fi
     if [ "${1/Master/}" != "$1" ]; then  aBranch=$1; fi
     if [ "${aBranch}"   != ""   ]; then
        sayMsg "setBranch[ 2 ]  Found Branch: '${aBranch}'" # 1;
      else
        sayMsg "setBranch[ 3 ]  It's not a Branch" # 1;
        fi
     }
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========

function chkGitDir() {             # Check to see if the current dir contains .git source control           # .(20429.07.1 Beg RAM)

    bOk=0; if [ -d       ".git" ]; then bOK=1; fi
           if [ -d    "../.git" ]; then bOK=1; cd ..; fi                                                    # .(20601.06.1 RAM Look up one, too)
           if [ -d "../../.git" ]; then bOK=1; cd ../..; fi                                                 # .(20601.06.1 RAM Look up two, too)

    if [ "${bOK}" != "1" ]; then sayMsg sp "You must be in a folder with Git source control." 2; fi

        aGitDir=$( basename $( pwd ) )
#       echo "    aGitDir: '${aGitDir}'"; exit
        }                                                                                                   # .(20429.07.1 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========

function setProjVars( ) {

#       aWebs=$1
        aBrch=$1; # if [ "${aOpt1}" == "all" ]; then aBrch=""; fi

        aProject=""
        aBranch=""
        aStage=""
        aApp=""

# if [ "${aOS}" == "windows" ] || [ "${aOS}" == "GitBash" ]; then                                           ##.(21122.03.4 RAM Added || [ "${aOS}" == "GitBash" ]) 
  if [ "${aOSv/w}" != "${aOSv}" ]; then                                                                     # .(21122.03.4 RAM What we've been using)

          aDir=$( pwd -P );                  aVMs="/C/WEBs/SCN2/Files/VMs"; aWebs="SCN2"
  if [ "${aDir/8020/}"  != "${aDir}" ]; then aVMs="/C/WEBs/8020/VMs";       aWebs="8020";    fi
  if [ "${aDir/icat/}"  != "${aDir}" ]; then aVMs="/C/WEBs/SCN2/VMs";       aWebs="iCat";    fi
  if [ "${aDir/IODD/}"  != "${aDir}" ]; then aVMs="/C/WEBs/8020/IODD/FormR";aWebs="FormR_I"; fi; fi
  if [ "${aDir/repos/}" != "${aDir}" ]; then aVMs="/C/Repos";               aWebs="Repos";   fi;            # .(20615.01.1 RAM Repos)

  if [ "${aOS}" == "linux" ]; then

          aDir=$( pwd -P );                  aVMs="";                       aWebs="FormR_U"                 # .(21122.03.1 RAM Switch SCN2_ and FormR_U)
  if [ "${aServer:0:2}" == "sc" ];      then aVMs="";                       aWebs="SCN2_U"; fi
          fi

# if [ "${aDir/nodeapps/}" != "" ] && [ "${aWebs}" == "8020" ]; then        aWebs="8020_N";  fi             ##.(10821.01.1 RAM)

  if [ "${aWebs}" == "8020"    ]; then aApps=""; else aApps="/nodeapps"; fi
# if [ "${aWebs}" == "8020_N"  ]; then                aApps="/nodeapps"; fi                                 ##.(10821.01.2 RAM)
  if [ "${aWebs}" == "iCat"    ]; then                aApps="/icatapps"; fi
  if [ "${aWebs}" == "FormR_I" ]; then                aApps="/P09"     ; fi
# if [ "${aWebs}" == "FormR_U" ]; then                aApps="/nodeapps"; fi
# if [ "${aWebs}" == "FormR_U" ]; then                aApps=""         ; fi                                 ##.(21111.03.1)

  if [ "${aWebs}" == "Repos"   ]; then                aApps="/Repos";    fi                                 # .(20615.01.2)

  if [ "${aDir/nodeapps/}" != "" ]; then              aApps="/nodeapps"; fi                                 # .(10821.01.3 RAM).(21103.2 RAM ??)

  if [ "${aWebs}" == "FormR_U" ]; then                aApps=""         ; fi                                 # .(21111.03.1 RAM)

        sayMsg "setProjVars[ 1 ]  aOS:   '${aOS}', aWebs: ${aWebs}, aApps: '${aApps}', aVMs: '${aVMs}', aServer: '${aServer}'" # 1 # 2
#       sayMsg "setProjVars[ 2 ]  aDir: '${aDir}', aWebs: ${aWebs}, aDir: '${aDir}' match '${aVMs}/(.*)/webs/'" 1 # 2

#       aVM=$(     echo "${aDir}"   | awk '{ sub( /webs.+/, ""); sub( /.+VMs/, ""); print $0   }' )
        aVM=$(     echo "${aDir}"   | awk '{ match( $0, /VMs\/(.+)(\/webs)/,   a ); print a[1] }' );     if [ "${aVM}" == "" ]; then
        aVM=$(     echo "${aDir}"   | awk '{ match( $0, /VMs\/(.+)/,           a ); print a[1] }' ); fi;

  if [ "${aVM}" == ""      ]; then aVM="???"; fi
  if [ "${aOS}" == "linux" ]; then aVM=${aServer:0:5}; fi

        sayMsg "setProjVars[ 5 ]  aVM:   '${aVM}', aWebs: ${aWebs}, aDir: '${aDir}/' match '${aVMs}/(.*)(/webs)?/'" -1 # 2

        aRoot=${aVMs}/${aVM}                     # or "" if linux  
  if [ "${aOS}"  == "linux" ]; then aRoot=""; fi
#       aRoot="";  aDir="/webs/nodeapps/NuSvs/Main-dev04/server1"

        aPath=$(   echo "${aDir}"   | awk '{ print substr( $0, length( "'${aRoot}'" ) + 1 ) }' )          # .(10614.01.1 RAM Should be + 1)
#       aPath=$(   echo "${aDir}"   | awk '{ print length( "'${aRoot}'" ) }' )
#       aPath=${aDir/${aRoot}/}

        nLen=${#aRoot};  aDir1="'${aDir:0:${nLen}}' -- '${aDir:${nLen}}'"
        sayMsg "setProjVars[ 6 ]  aDir:  ${aDir1} (${#aRoot}), aPath: '${aPath}'" # 2 # 1

                                                                      aPath1="${aPath}"
  if [ "${aWebs}" == "SCN2"    ]; then aPath1="${aPath/nodeapps\//}"; aPath1="${aPath1/nodeapps/}"; fi
  if [ "${aWebs}" == "iCat"    ]; then aPath1="${aPath/icatapps\//}"; aPath1="${aPath1/icatapps/}"; fi
  if [ "${aWebs}" == "8020"    ]; then aPath1="${aPath/\/webs\//}";   aPath1="${aPath1/webs/}"; fi
# if [ "${aWebs}" == "8020_N"  ]; then aPath1="${aPath/\/webs\//}";   aPath1="${aPath1/webs/nodeapps}"; fi  # .(10821.01.4)
  if [ "${aWebs}" == "SCN2_U"  ]; then aPath1="${aPath/\/webs/}";     aPath1="${aPath1/\/nodeapps\//}"; fi
  if [ "${aWebs}" == "FormR_U" ]; then aPath1="${aPath/\/webs\//}";   aPath1="${aPath1/webs/}"; fi
  if [ "${aWebs}" == "FormR_I" ]; then aPath1="FormR${aPath}"; fi   # aPath1='{Project}/{Branch}/{Stage}/{App}' for split below

        sayMsg "setProjVars[ 7 ]  aRoot: '${aRoot}' (${#aRoot}), aPath1: '${aPath1}'" # 1

#       aProj=$(   echo "${aDir}"   | awk '{ match( $0, /nodeapps\/(.*)\//,  a ); print a[1] }' )
#       aBranch=$( echo "${aDir}"   | awk '{ match( $0, /'${avMs}'\/(.*)\//, a ); print a[1] }' )

        aProject=$(echo "${aPath1}" | awk '{ split( $0, a, /\// ); print a[1] }' )
        aBranch=$( echo "${aPath1}" | awk '{ split( $0, a, /\// ); print a[2] }' )
        aStage=$(  echo "${aPath1}" | awk '{ split( $0, a, /\// ); print a[3] }' )
        aApp=$(    echo "${aPath1}" | awk '{ split( $0, a, /\// ); print a[4] }' )
        a5=$(      echo "${aPath1}" | awk '{ split( $0, a, /\// ); print a[5] }' )                        # .(10821.01.5)

  if [ "${aProject}" == "nodeapps" ]; then                                                                # .(10821.01.6 Beg)
        aProject=${aBranch}
        aBranch=${aStage}
        aStage=${aApp}
        aApp=${aApp}
        fi                                                                                                # .(10821.01.6 End)

#       sayMsg "setProjVars[ 8 ]  aProject: '${aProject}', aBranch: '${aBranch}', aStage: '${aStage}', aApp: '${aApp}'" 1

  if [ "${aBrch}"  != ""  ]; then aBranch=${aBrch}; fi

        sayMsg "setProjVars[ 9 ]  aProject: '${aProject}', aBranch: '${aBranch}', aStage: '${aStage}', aApp: '${aApp}'" # 1

#       aDir="${aRoot}/webs${aApps}/${aProject}/${aBranch}"; # echo "aDir: ${aDir}"
        aProjDir="${aRoot}/webs${aApps}/${aProject}";        sayMsg "setProjVars[ 21]  aProjDir: ${aProjDir}"

 if [ "${aWebs}" == "FormR_I" ]; then
#       aProjDir="${aRoot}${aProject}";                      sayMsg "setProjVars[ 22]  aProjDir: ${aProjDir}"
        aProjDir="/C/WEBs/8020/IODD/FormR${aApps}";          sayMsg "setProjVars[ 23]  aProjDir: ${aProjDir}"
#       aProjDir="${aRoot}";                                 sayMsg "setProjVars[ 24]  aProjDir: ${aProjDir}"  # .(10614.02.1 RAM ??)
        fi

# if [  "${aProject}" == "nodeapps" ] || [ "${aProject}" == "" ]; then
  if [ "/${aProject}" == "${aApps}" ] || [ "${aProject}" == "" ]; then
#       aProjDir=${aProjDir/webs\//}; aProjDir=${aProjDir/nodeapps\//};

        sayMsg "You must be in a Project Repository folder: '${aProjDir}{Project}'" 2
        fi
        }  # eof setProjVars
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========

function  getCurRemote( ) {
        sayMsg "getCurRemote[ 1 ]  ( '$1' )" # 1
        aRemote=$( git branch -vv | awk '/\*/ { split( $0, a, /\[/ ); split( a[2], a, /\// ); print a[1] }' )
        }
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========

function  getCurBranch( ) {
        sayMsg "getBranch[ 1 ]  ( '$1' )" # 1
  if [ "$1" == "" ]; then aBranch=$( git branch | awk '/\*/ { print $2 }' ); return; fi
#       aBranch=$( git branch -vv | awk -v r=$1 '{ split( $0, a, /\[/ ); split( a[2], a, /\// ); print "a[1]: " a[1] ", " a[2]; if ( a[1] == r ) { split( a[2], a, /[:\]]/ ); print a[1]; exit } }' )
        aBranch=$( git branch -vv | awk -v r=$1 '{ split( $0, a, /\[/ ); split( a[2], a, /\// ); if ( a[1] == r ) { split( a[2], a, /[:\]]/ ); print a[1]; exit } }' )
        }
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========

function  shoGitRemotes1( ) {
        sayMsg "shoGitRemotes1[ 1 ]  ( '$1' )" # 1

#       ------------------------------------------

#       aDir="${aRoot}/webs/nodeapps/${aProject}/${aBranch}"; echo "aDir: ${aDir}"
# if [ ! -d "${aProjDir}" ]; then
#       echo ""; echo " ** Branch folder not found: '${aProjDir}'"; echo ""; exit
#       fi

        sayMsg "shoGitRemotes1[ 2 ]  cd ${aProjDir}/${aBranch}" # 1
  if [ ! -d ".git" ] || [ "${aBranch}" != "" ]; then

  if [ "${aBranch}" == "" ]; then
        sayMsg "You must be in a Repository folder: '${aProjDir}/{Repo}'" 2
        fi;  # fi;

        sayMsg "shoGitRemotes1[ 3 ]  cd ${aProjDir}/${aBranch}" # 1
# if [ ! -d ".git" ] || [ "${aBranch}" != "" ]; then
  if [   -d "${aProjDir}/${aBranch}" ]; then
        cd  ${aProjDir}/${aBranch}

      else
        sayMsg "There is no Branch folder, ${aBranch}" 2
        fi;
#       ------------------------------------------
        fi; # eif "${aBranch}" != ""

#       -------------------------------------------------------------------------
        sayMsg "shoGitRemotes1[ 4 ]  aOS: ${aOS}"

        sayMsg "" 3
  if [ "${aOS}" == "linux" ]; then
        echo "    Git Remotes for ${aServer}:/.../${aProject}/${aBranch}"
      else
        aSvr=${aVM}; if [ "${aWebs}" == "FormR" ]; then aSvr="FormR"; fi
        echo "    Git Remotes for ${aSvr}:/.../${aProject}/${aBranch} (${aServer})"
        fi
#       ------------------------------------------

        echo "    Remote Alias Name                         Repository URL"
#       echo "    -------------------------- -------  ---------------------------------------------"
        echo "    -------------------------------- -------  ---------------------------------------------"  # .(11127.02.1)

#       ------------------------------------------

#       mRemotes=$( git remote -v 2>&1 | awk '!/fatal:/' )
# if [ "${mRemotes}" != "" ]; then
#       echo "${aRemotes}" | awk '{ print "  "$0 }'
#       fi

        sayMsg "shoGitRemotes1[ 5 ]  cd: $( pwd )"
        mRemotes=$( bash -c '( git remote -v )' 2>&1 )  # So that no error message is disdplayed
#       mRemotes=$( bash -c '( git remote -v )' 2>&1 | sort -k1.47r)  # .(21128.05.1 RAM Sort) 

#       mRemotes=$( git remote -v )

#       echo "\${?}: ${?}..."
#   if [[ ${?} -ne 0 ]]; then
#       echo "error"
#       sayMsg "  * Git is not initialized." 3
#       exit
#       fi

#       echo "\${mRemotes:0:5}: ${mRemotes:0:5}"
  if [ "${mRemotes:0:5}" == "fatal" ]; then
        sayMsg " ** Git Error." 3
        sayMsg "    ${mRemotes}." 3
        exit
        fi

  if [ "${mRemotes}" == "" ]; then
        sayMsg "  * No Remotes are defined for this Repository." 3
      else

    for aRemote in "${mRemotes[@]}"; do
#       echo "${aRemote}" | awk '{ printf "    %-25s  %7s  %s\n", $1, $3, $2; if ($3 == "(push)") { print "" } }'
        echo "${aRemote}" | awk '{ printf "    %-31s  %7s  %s\n", $1, $3, $2; if ($3 == "(push)") { print "" } }'
        done
        fi
#       ------------------------------------------

#       git remote -v; nErr=$?; echo "nErr: ${nErr}"   # 2>&1
# if ! test $nErr -eq 0
#     then
##      echo >&2 "command failed with exit status $ret"
#       echo >&2 "  ** Git is not initialised!"
#       exit 1
#     else
#       git remote -v | awk '{ print "  "$0 }'
#       fi
#       ------------------------------------------

#       echo "--"
     }  # eof shoGitRemotes1
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========

function shoGitRemotes2( ) {
        sayMsg "shoGitRemotes2[  1]  ( '$1' )"  # 1                                                         # gitr li re al
        aBranch=${1:34}

        sayMsg "showGitRemotes2[  2]  aBranch: '${aBranch}', '$( pwd )/${aBranch}'" # 1                     # .(10824.01.1 RAM ${aBranch} S.B ${aRepo})
 if [ "" == "${aBranch}" ]; then return; fi
 if [  ! -d "${aBranch}" ]; then return; fi

        sayMsg "showGirRemotes2[  3]  aBranch: '${aBranch}'"
#       echo "keys show remote ${aBranch}"

#       ------------------------------------------

  if [ "${aBranch}" != ".git" ]; then                                                                       # .(10824.01.2 if ".git" we are in "Repo Folder")
        cd ${aBranch}
    else                                                                                                    # .(10824.01.3)
        aBranch=''                                                                                          # .(10824.01.4)
        fi

#       -------------------------------------------------------------------------
        sayMsg "shoGitRemotes2[  4]  aOS: ${aOS}"

        sayMsg "" 3
  if [ "${aOS}" == "linux" ]; then
        echo "    Git Remotes for ${aServer}:/.../${aProject}/${aBranch}"
        else
        aSvr=${aVM}; if [ "${aWebs}" == "FormR" ]; then aSvr="FormR"; fi
        echo "    Git Remotes for ${aSvr}:/.../${aProject}/${aBranch} (${aServer})"
        fi
#       ------------------------------------------

  if [ "${bFirstTime}" != "0" ]; then
        echo "    -----------------------------------------------------------------------------------------"
        echo "    Remote Alias Name                         Repository URL / Branch"
        fi
#       echo "    -------------------------- -------  ---------------------------------------------"
        echo "    -------------------------------- -------  ---------------------------------------------"  # .(11127.02.2)

#         ------------------------------------------

        bFirstTime=0

#       mRemotes=$( git remote -v 2>&1 | awk '!/fatal:/' )
# if [ "${mRemotes}" != "" ]; then
#       echo "${aRemotes}" | awk '{ print "  "$0 }'
#       fi

        IFS=$'\n'
        mRemotes=( $( bash -c '( git remote -v )' 2>&1               ) )
#       mRemotes=( $( bash -c '( git remote -v )' 2>&1 | sort -k1.47 ) ) ##.(21128.05.2 RAM Sort) 

#       mRemotes=$( git remote -v )

#       echo "\${?}: ${?}"
    if [ ${?} -ne 0 ]; then
        sayMsg "  * Git is not initialized." 3
      else
    if [ "${mRemotes}" == "" ]; then
        sayMsg "  * No Remotes are defined for this Repository." 3
      else
      for aRemote in "${mRemotes[@]}"; do     # sayMsg "aRemote1: ${aRemote}" 1
#       echo "${aRemote}" | awk            '{ printf "    %-25s  %7s  %s\n", $1, $3, $2 }'
#       echo "${aRemote}" | awk '/\(push\)/ { printf "    %-25s  %7s  %s\n", $1, $3, $2 }'
        echo "${aRemote}" | awk '/\(push\)/ { printf "    %-31s  %7s  %s\n", $1, $3, $2 }'                  # .(11127.02.3)

                aRemote=$( echo ${aRemote} | awk '/\(push\)/{ print $1 }' );   # sayMsg "aRemote2: ${aRemote}" 1
   if [ "${aRemote}" != "" ]; then
#       git branch -ra | awk -F'[/]' -v r="${aRemote}" '{ if ($1 == "  remotes") { aRemote = $2; aBranch = $3 } else { aBranch = $1 }; if (r == $2) { aHead = ""; if ( substr(aBranch,1,4) == "HEAD" ) { aHead = "HEAD "; aBranch = substr( aBranch, 9) }; printf "    %-25s  %7s  / %s\n", aRemote, aHead, aBranch } }'
        git branch -ra | awk -F'[/]' -v r="${aRemote}" '{ if ($1 == "  remotes") { aRemote = $2; aBranch = $3 } else { aBranch = $1 }; if (r == $2) { aHead = ""; if ( substr(aBranch,1,4) == "HEAD" ) { aHead = "HEAD "; aBranch = substr( aBranch, 9) }; printf "    %-31s  %7s  / %s\n", aRemote, aHead, aBranch } }'   # .(11127.02.4)
        fi
        done

#       git branch -ra | awk -F'[/]' '{ if ($1 == "  remotes") { aRemote = $2; aBranch = "  "$3 } else { aBranch = $1 }; printf "    %-25s  %5s  %s\n", aRemote, "", aBranch }'

        fi; fi
#       ------------------------------------------

        cd ..

#       git remote -v; nErr=$?; echo "nErr: ${nErr}"   # 2>&1
#  if ! test $nErr -eq 0
#       then
##      echo >&2 "command failed with exit status $ret"
#       echo >&2 "  ** Git is not initialised!"
#       exit 1
#     else
#       git remote -v | awk '{ print "    "$0 }'
#       fi
#       ------------------------------------------

        echo ""
     }  # eof shoGitRemotes2
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

function shoGitRemotes3( ) {                                                                                # .(60223.01.1 RAM End)
        sayMsg "shoGitRemotes3[  1]  ( '$1' )"  1                                                           # gitr li re al

        echo ""
     }  # eof shoGitRemotes3                                                                                # .(60223.01.1 RAM End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#========================================================================================================== #  ===============================  #
#       GIT COMMANDS
#====== =================================================================================================== #  ===========

        sayMsg "GitR1[711]  aCmd:  '${aCmd}', aArg1: '${aArg1}', aArg2: '${aArg2}', aArg3: '${aArg3}', bGlobal: '${bGlobal}'" -1 # 2

#====== =================================================================================================== #  ===========
#       GIT INIT                                                                                            # .(20430.01.3 Beg RAM Added)
#====== =================================================================================================== #

  if [ "${aCmd}" == "Init" ]; then
        sayMsg "GitR1[718]  Git Init"

        echo ""
        echo "git init"

#       echo ""
        exit
     fi # eoc Init                                                                                          # .(20430.01.3 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       GIT LIST VARS                                                                                       # .(20430.01.3 Beg RAM Added)
#====== =================================================================================================== #

  if [ "${aCmd}" == "List Vars" ]; then
        sayMsg "GitR1[733]  Git List Vars"
#       echo "git list vars"

        aAWK='
BEGIN{ }
  NR == 1 { aLast  = substr($0,1,3)  }
     {  if (aLast != substr($0,1,3)) { print ""; aLast = substr( $0,1,3) } }
     {  split( $0, m, "=" ); s = (substr(m[2], 1, 1) == "\"") ? "" : " "; printf "  %-28s = %s\n", m[1], s m[2]  }
END{ }
'
        echo ""
        echo "  Git Global Config Vars"
        echo "  ---------------------------- = ------------------------------------------------------------"
        git config --list --global | awk "${aAWK}"

    if [ -d ".git" ]; then

        echo ""
        echo "  Git Local Config Vars ($( pwd ))"
        echo "  ---------------------------- = ------------------------------------------------------------"
        git config --list --local  | awk "${aAWK}"
        fi

#       echo ""
        exit

     fi # eoc List Vars                                                                                     # .(20430.01.3 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       GITR SET VAR                                                                                        # .(20501.02.3 Beg RAM Added)
#====== =================================================================================================== #

  if [ "${aCmd}" == "Set Var" ]; then
        sayMsg "GitR1[767]  Git Set Var"

#       echo -e "]n   git set var '${aArg1}' '${aArg2}'"
        git config --global --add "${aArg1}" "${aArg2}"
        echo -e "\n  ${aArg1} is now set globally to \"${aArg2}\""

#       echo ""
        ${aLstSp}; exit
     fi # eoc Set Var                                                                                       # .(20501.02.3 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       GITR GET VAR                                                                                        # .(21128.06.3 Beg RAM Add Command)
#====== =================================================================================================== #

  if [ "${aCmd}" == "Get Var" ]; then
        sayMsg "GitR1[767]  Git Get Var"

#       echo -e "]n   git set var '${aArg1}' '${aArg2}'"
        aArg2=$( git config --global --get "${aArg1}" )
        echo -e "\n  ${aArg1}=${aArg2}"

        ${aLstSp}; exit
     fi # eoc Set Var                                                                                       # .(21128.06.3 RAM End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       CREATE REMOTE                                                                                       # .(20501.03.3 Beg RAM Added)
#====== =================================================================================================== #

  if [ "${aCmd}" ==  "Create Remote" ]; then
        sayMsg "GitR1[782]  Create Remote" 1
        sayMsg "GitR1[783]  aArg1: '${aArg1}', aArg2: '${aArg2}', aArg3: '${aArg3}', aArg4: '${aArg4}', bDoit: '${bDoit}', bDebug: '${bDebug}', bQuiet: '${bQuiet}'. bGlobal: '${bGlobal}'" 1

        echo ""
        echo "  git checkout -B '${aArg1}' '${aArg2}'"
#               git checkout -B "${aArg1}" "${aArg2}"

#       echo ""
        exit
     fi # eif Create Remote                                                                                 # .(20501.03.3 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       CLONE                                                                                               # .(21027.01.4 RAM Beg Added Clone command)
#====== =================================================================================================== #
        sayMsg "GitR1[797]  ${aCmd}" # 1

  if [ "${aCmd}" ==  "Clone" ]; then
#       sayMsg       "Clone Command not implemented yet" 2

        aDoit=""; if [ "${bDoit}" == "1" ]; then aDoit="-doit"; fi                                          #
#       echo "    $( dirname $0 )/gitr_clone_u1.03.sh"       "${mARgs[0]}" "${aArg2}" "${aArg3}" ${aDoit}
#       echo "    $( dirname $0 )/FRT23_gitR_clone_p1.03.sh" "${mARgs[0]}" "${aArg2}" "${aArg3}" ${aDoit}
#                "$( dirname $0 )/FRT23_gitR_clone_p1.04.sh" "${mARgs[0]}" "${aArg2}" "${aArg3}" ${aDoit}   # .(21118.02.1 RAM Used this version)
                 "$( dirname $0 )/FRT23_gitR_clone_p1.04.sh" "${mARgs[0]}" "${mARgs[1]}" "${aArg3}" ${aDoit} # .(21118.02.2 RAM Preserve RepoDir case)

        ${aLstSp}; exit
     fi # eoc Next Command                                                                                  # .(21027.01.4 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========

#       chkGitDir                                                                                           ##.(20429.07.3 RAM).(20623.13.1 RAM Beg Move from here to below)
#
#       setBranch $1; if [ "${aBranch}" != "" ]; then shift; fi
#       setBranch ${aArg1}
#
#       sayMsg "GitR1[819]  Begin GitR Commands"                                                            ##.(20623.13.1 RAM End Move from here to below)

#====== =================================================================================================== #  ===========
#        LIST ALL REMOTES                                                                                   # .(20623.13.13)
#====== =================================================================================================== # .(20623.13.2 RAM Beg Move to here from below)
#       sayMsg "GitR1[824]  List All Remotes" 1                                                             # .(20623.13.14)

  if [ "${aCmd}" ==  "List All Remotes" ]; then                                                             # .(20623.13.15)

#       ----------------------------------------------------------------------------
#       setProjVars

# if [ ! -d "${aProjDir}" ]; then
#       echo ""; echo " ** Project folder not found: '${aProjDir}'"; echo ""; exit
#    fi

#       echo "aProjDir: ${aProjDir}"
#       cd ${aProjDir};              # rdir "${aProjDir}"

  if [ -d ".git" ]; then
        shoGitRemotes2 "        4096  2021-06-11 12:43  ./.git"; exit;
        fi

        aDir=""
  if [ "${aDir}" == "" ]; then aDir="$( isDir 'repos'    1)"; fi
  if [ "${aDir}" == "" ]; then aDir="$( isDir 'nodeapps' 1)"; fi
  if [ "${aDir}" == "" ]; then
        sayMsg "You must be in a Repos or NodeApps folder" 2
      else
        aTS=$( date '+%y%m%d' ); aTS=${aTS:1}
        aDirF=$( pwd )

        aFile1="fr101_Remote-Repos_${aTS}.md"

        node  "$( dirname $0 )/api/gh2.njs" >"${aDirF}/${aFile1}"

        cat "${aDirF}/${aFile1}" | awk 'NR > 3'
#       chrome "${aDirF}/${aFile1}"

        aFile2="fr102_Local-Repos_${aTS}.md"
        "$( dirname $0 )/lstRemotes/lstRemotes_u2.sh"  "${aDir}"   >"${aDirF}/${aFile2}"

        echo ""                                                   >>"${aDirF}/${aFile2}"
        echo "#####  <u>Remote Repos</u>"                         >>"${aDirF}/${aFile2}"
        cat "${aDirF}/${aFile1}" | awk 'NR > 3'                   >>"${aDirF}/${aFile2}"
        echo ""                                                   >>"${aDirF}/${aFile2}"

        chrome "${aDirF}/${aFile2}"

        fi
        exit

#       rdir . | awk '/-dev|-test|-prod/'

        readarray -t    mFileList < <( rdir . -main   | awk 'NR > 3' | awk '!/-[dpt]/' ); sayMsg "For -main Repos"   1  # .(11125.01.1 RAM Was: Main)
    for aFileStat in "${mFileList[@]}"; do shoGitRemotes2 "${aFileStat}"; done

        readarray -t    mFileList < <( rdir . -master | awk 'NR > 3' | awk '!/-[dpt]/' ); sayMsg "For -master Repos" 1  # .(11125.01.2 RAM Was: Master)
    for aFileStat in "${mFileList[@]}"; do shoGitRemotes2 "${aFileStat}"; done

        readarray -t    mFileList < <( rdir "dev-"    | awk 'NR > 3' );                   sayMsg "For dev- Repos"    1  # .(11125.01.3 RAM Was: -dev)
    for aFileStat in "${mFileList[@]}"; do shoGitRemotes2 "${aFileStat}"; done

        readarray -t    mFileList < <( rdir "test-"   | awk 'NR > 3' );                   sayMsg "For test- Repos"   1  # .(11125.01.4 RAM Was: -test)
    for aFileStat in "${mFileList[@]}"; do shoGitRemotes2 "${aFileStat}"; done

        readarray -t    mFileList < <( rdir "prod-"   | awk 'NR > 3' );                   sayMsg "For prod- Repos"   1  # .(11125.01.5 RAM Was: -prod)
    for aFileStat in "${mFileList[@]}"; do shoGitRemotes2 "${aFileStat}"; done

        readarray -t    mFileList < <( rdir . docs-   | awk 'NR > 3' | awk '!/-[dpt]/' ); sayMsg "For docs- Repos"   1  # .(11125.01.6 RAM Added: docs-)
    for aFileStat in "${mFileList[@]}"; do shoGitRemotes2 "${aFileStat}"; done

        readarray -t    mFileList < <( rdir . tools-  | awk 'NR > 3' | awk '!/-[dpt]/' ); sayMsg "For tools- Repos"  1  # .(11125.01.7 RAM Added: tools-)
    for aFileStat in "${mFileList[@]}"; do shoGitRemotes2 "${aFileStat}"; done

     fi # eoc List All Remotes                                                                              # .(20623.13.16)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- # .(20623.13.2 RAM End Move to here from below)

#====== =================================================================================================== #  ===========

        chkGitDir                                                                                           # .(20429.07.3 RAM).(20623.13.3 RAM Beg Move to here from above)

#       setBranch $1; if [ "${aBranch}" != "" ]; then shift; fi
        setBranch ${aArg1}

#       sayMsg "GitR1[904]  Begin GitR Commands: aCmd: ${aCmd}" 1                                           # .(20623.13.3 RAM End Move to here from above)

#====== =================================================================================================== #  ===========
#       ADD COMMIT                                                                                          #
#====== =================================================================================================== #

  if [ "${aCmd}" ==  "Add Commit" ]; then
        sayMsg "GitR1[911]  Add Commit"

        echo ""
#       echo "git commit -a -m \"${aArg1}\""
              git add -A   >/dev/null 2>&1
              git commit -m  "${aArg1}"  | awk '/changed|nothing/ { print "  "$0 }'

#       echo ""
     fi # eif Add Commit
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       PUSH                                                                                                #
#====== =================================================================================================== #
        sayMsg "GitR1[925]  Push"

  if [ "${aCmd}" ==  "Push" ]; then

        git push | awk '/changed|Everything/ { print "  "$0 }'

#       echo ""
     fi # eif Push
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       PULL                                                                                                #
#====== =================================================================================================== #
        sayMsg "GitR1[938]  Pull"

  if [ "${aCmd}" ==  "Pull" ]; then
        setProjVars
        echo ""

    if [ "${aArg1}" == "hard"   ]; then  aArg1="-hard"; fi                                                   # .(21127.03.2)
    if [ "${aArg1}" == "--hard" ]; then  aArg1="-hard"; fi                                                   # .(21127.03.3)
    if [ "${aArg1}" == "-hard"  ]; then                                                                      # .(21127.03.4 RAM Beg Added)
#       git diff 
        git reset --hard | awk '{ print "   " $0 }'
        fi                                                                                                  # .(21127.03.5 RAM End)
        sayMsg "GitR1[948]  pull aOS: '${aOS}', aProject: '${aProject}', aProjDir: '${aProjDir}'" # 1

        git pull 2>&1 | awk '/changed|Already/ { print "   "$0 }'

    if [ "${aOS}" != "windows" ] && [ "${aProject}" == "FRTools" ]; then                                    # .(21111.02.1 RAM Beg)
        if [  -d  "../${aProjDir}" ]; then aProjDir="../${aProjDir}"; fi                                    # .(21127.03.6)  
#       chmod -R 755 "${aProjDir}" *.sh                                                                     ##.(21127.03.7)  
        chmod -R 755 "${aProjDir}"                                                                          # .(21127.03.7)  
        echo -e "\n * FRTools script permissions have been reset"

      else                                                                                                  # .(21111.02.1 RAM End)
        git pull 2>&1 | awk '/changed|Already/ { print "   "$0 }'
        fi

        ${aLstSp}                                                                                           # .(21127.08.2)
     fi # eif Pull
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       FETCH                                                                                               #
#====== =================================================================================================== #
        sayMsg "GitR1[967]  Fetch"

  if [ "${aCmd}" ==  "Fetch" ]; then

        echo ""
        git fetch | awk '/->/'

#       echo ""
     fi # eif Fetch
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       FETCH ALL                                                                                           #
#====== =================================================================================================== #
        sayMsg "GitR1[981]  Fetch All"

  if [ "${aCmd}" ==  "Fetch All" ]; then

        echo ""
        git fetch all

#       echo ""
     fi # eif Fetch All
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       ADD REMOTE                                                                                          #
#====== =================================================================================================== #
        sayMsg "GitR1[995]  Add Remote"

  if [ "${aCmd}" ==  "Add Remote" ]; then
#       sayMsg       "Add Remote not implemented yet" 2

#       setProjVars "${aBranch}"
        echo ""
        echo "  git remote add \"${aArg1}\" \"${aArg2}\""                                                # .(11127.03.1 RAM S.B. {aRepo} {aURL})
                git remote add  "${aArg1}"   "${aArg2}"                                                  # .(11127.03.2 RAM S.B. {aRepo})

#       echo ""
     fi # eif Add Remote
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       RENAME REMOTE                                                                                       #
#====== =================================================================================================== #
        sayMsg "GitR1[1012]  Rename Remote"

  if [ "${aCmd}" ==  "Rename Remote" ]; then

     if [ "${aArg2}" == "" ]; then aArg2=${aArg1}; aArg1=; fi

                                         getCurRemote; # sayMsg "aRemote: ${aRemote}" 2
        aGit_Remote_Old=${aArg1}; if [ "${aGit_Remote_Old}" == "" ]; then aGit_Remote_Old=${aRemote};   fi
        aGit_Remote_New=${aArg2}; if [ "${aGit_Remote_New}" == "" ]; then
        sayMsg "You must provide a new remote name" 2
        fi

        echo "  git  remote rename \"${aGit_Remote_Old}\" \"${aGit_Remote_New}\""
                git  remote rename  "${aGit_Remote_Old}"   "${aGit_Remote_New}"

#       echo ""
     fi # eif Rename Remotes
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       DELETE REMOTE                                                                                       #  # .(11127.01.5)
#====== =================================================================================================== #
        sayMsg "GitR1[1034]  Delete Remote"                                                                # .(11127.01.6)

  if [ "${aCmd}" ==  "Delete Remote" ]; then                                                             # .(11127.01.7)

#       setProjVars "${aBranch}"
        echo ""
        echo "  git remote remove \"${aArg1}\""                                                          # .(11127.03.2 RAM S.B. {aRepo})
                git remote remove  "${aArg1}"                                                            # .(11127.03.2 RAM S.B. {aRepo})

#       echo ""
     fi # eif Remove Remote                                                                              # .(11127.01.8)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       LIST REMOTES                                                                                  #
#====== =================================================================================================== #
        sayMsg "GitR1[1050]  List Remotes"

  if [ "${aCmd}" ==  "List Remotes" ]; then

        sayMsg "aCmd3: ${aCmd3}, aBranch: ${aBranch}" -1
        setProjVars "${aBranch}"

        echo shoGitRemotes1 "$@"

#       echo ""
     fi # eif List Remotes
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       LIST REMOTE BRANCHES                                                                                #
#====== =================================================================================================== #
        sayMsg "GitR1[1066]  List Remote Branches";

  if [ "${aCmd}" ==  "List Remote Branches" ]; then

        aBranch=${PWD##*/};
        setProjVars "${aBranch}"

        bLocal=0;  if [ "${aCmd3/lo/}"  != "${aCmd3}" ]; then bLocal=1;  fi   # true if removed, i.e. no equal
        bRemote=0; if [ "${aCmd3/re/}"  != "${aCmd3}" ]; then bRemote=1; fi;
                if [ "${bLocal}${bRemote}" == "00" ]; then bLocal=1; bRemote=1; fi
        sayMsg "List Branch: ${aBranch:1}, aCmd3: ${aCmd3}, bLocal: ${bLocal}, bRemote: ${bRemote}" # 2

  if [ "${bRemote}" == "1" ]; then
        cd ..
        shoGitRemotes2  "                                  ${aBranch}"
        cd ${aBranch}
        fi

  if [ "${bLocal}" == "1"  ]; then

        echo "    Git Local Branches for .../${aProject}/${aBranch}"
#       echo "    -------------------------- -------  ---------------------------------------------"
        echo "    -------------------------------- -------  ---------------------------------------------"  # .(11127.02.5)

#       git branch  | awk '{ printf "    %-25s  %7s  %s\n", "", "", $0 }'
        git branch  | awk '{ printf "    %-31s  %7s  %s\n", "", "", $0 }'                                   # .(11127.02.6)
        fi

#       sayMsg "List Remote Branches" 1; echo ""
#       echo "    Remote Alias Name                         Branch Name"
#       echo "    -------------------------- -------  ---------------------------------------------"
        echo "    -------------------------------- -------  ---------------------------------------------"  # .(11127.02.7)

#       git branch -ra | awk -F'[/]' '{ if ($1 == "  remotes") { aRemote = $2; aBranch = "  "$3 } else { aBranch = $1 }; printf "    %-25s  %5s  %s\n", aRemote, "", aBranch }'

#       echo ""
     fi # eoc List Remote Branches
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       CHECKOUT BRANCH                                                                                     #
#====== =================================================================================================== #
        sayMsg "GitR1[1108]  Checkout Branch"

     if [ "${aCmd}" ==  "Checkout Branch" ]; then
        bDebug=1
#       setProjVars "${aBranch}"

     if [ "${aArg2}" == "" ]; then aArg2=${aArg1}; aArg1=; fi
                                                                  getCurRemote; # sayMsg "aRemote: ${aRemote}" 2
        aGit_Remote=${aArg1}; if [ "${aGit_Remote}" == "" ]; then aGit_Remote=${aRemote};       fi                            # .(10822.01.1)

                                                                  getCurBranch ${aGit_Remote}; # sayMsg "aBranch: ${aBranch}" 2
        aGit_Branch=${aArg2}; if [ "${aGit_Branch}" == "" ]; then aGit_Branch=${aBranch}; fi

        sayMsg "Checkout Branch: ${aRemote} ${aBranch}" 2


#       echo ""
     fi # eif Checkout Branch
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#        LIST REMOTES ALL                                                                                   #
#====== =================================================================================================== #
#       sayMsg "GitR1[1131]  List Remotes All"                                                              ##.(20623.13.4 RAM Beg Move from here to above)
#
# if [ "${aCmd}" ==  "List Remotes All" ]; then
#
#       ----------------------------------------------------------------------------
#        setProjVars
#
# if [ ! -d "${aProjDir}" ]; then
#       echo ""; echo " ** Project folder not found: '${aProjDir}'"; echo ""; exit
#    fi
#
#       echo "aProjDir: ${aProjDir}"
#       cd ${aProjDir};              # rdir "${aProjDir}"
#
# if [ -d ".git" ]; then                shoGitRemotes2 "        4096  2021-06-11 12:43  ./.git"; exit; fi
#
#       rdir . | awk '/-dev|-test|-prod/'
#
#       readarray -t    mFileList < <( rdir . -main   | awk 'NR > 3' | awk '!/-[dpt]/' ); sayMsg "For -main Repos"   1  # .(11125.01.1 RAM Was: Main)
#   for aFileStat in "${mFileList[@]}"; do shoGitRemotes2 "${aFileStat}"; done
#
#       readarray -t    mFileList < <( rdir . -master | awk 'NR > 3' | awk '!/-[dpt]/' ); sayMsg "For -master Repos" 1  # .(11125.01.2 RAM Was: Master)
#   for aFileStat in "${mFileList[@]}"; do shoGitRemotes2 "${aFileStat}"; done
#
#       readarray -t    mFileList < <( rdir "dev-"    | awk 'NR > 3' );                   sayMsg "For dev- Repos"    1  # .(11125.01.3 RAM Was: -dev)
#   for aFileStat in "${mFileList[@]}"; do shoGitRemotes2 "${aFileStat}"; done
#
#       readarray -t    mFileList < <( rdir "test-"   | awk 'NR > 3' );                   sayMsg "For test- Repos"   1  # .(11125.01.4 RAM Was: -test)
#   for aFileStat in "${mFileList[@]}"; do shoGitRemotes2 "${aFileStat}"; done
#
#       readarray -t    mFileList < <( rdir "prod-"   | awk 'NR > 3' );                   sayMsg "For prod- Repos"   1  # .(11125.01.5 RAM Was: -prod)
#   for aFileStat in "${mFileList[@]}"; do shoGitRemotes2 "${aFileStat}"; done
#
#       readarray -t    mFileList < <( rdir . docs-   | awk 'NR > 3' | awk '!/-[dpt]/' ); sayMsg "For docs- Repos"   1  # .(11125.01.6 RAM Added: docs-)
#   for aFileStat in "${mFileList[@]}"; do shoGitRemotes2 "${aFileStat}"; done
#
#       readarray -t    mFileList < <( rdir . tools-  | awk 'NR > 3' | awk '!/-[dpt]/' ); sayMsg "For tools- Repos"  1  # .(11125.01.7 RAM Added: tools-)
#   for aFileStat in "${mFileList[@]}"; do shoGitRemotes2 "${aFileStat}"; done
#
#    fi # eoc List Remotes All                                                                              ##.(20623.13.4 RAM End Move from here to above)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       LIST REMOTE COMMITS xx
#====== =================================================================================================== #
        sayMsg "GitR1[1176]  List Remote Commits xx"

  if [ "${aCmd}" ==  "List Remote Commits xx" ]; then

        aGit_Repo=${aProject}; if [ "${aProject}"  == "" ]; then aGit_Repo=nusvs; fi
        aGit_Host=$1;          if [ "${aGit_Host}" == "" ]; then aGit_Host=git-suzee-account; fi
        aGit_User=$2;          if [ "${aGit_User}" == "" ]; then aGit_User=suzeeparker;  fi

        echo ""
#       echo "    3: $3, 4: $4, 5: $5"
#       echo "    aGit_Repo: ${aGit_Repo}, aGit_Host: ${aGit_Host} aGit_User: ${aGit_User}"
#       echo "    git ls-remote git-suzee-key:suzeeparker/nusvs.git"
        echo "    git ls-remote ${aGit_Host}:${aGit_User}/${aGit_Repo}.git"
        echo ""
        echo "    Commit       Comment"
        echo "    -------  -------------------------------"
#                 git ls-remote ${aGit_Host}:${aGit_User}/${aGit_Repo}.git | awk '{ printf "    %7s  %s\n", substr($1,1,7), $2 }'

        aCmd="git ls-remote ${aGit_Host}:${aGit_User}/${aGit_Repo}.git";
        mResults=$( bash -c "( ${aCmd} )" 2>&1               );
#       mResults=$( bash -c "( ${aCmd} )" 2>&1 | sort -k1.47 ) # .(21128.05.3 RAM Sort) 

# if [ ${?} -ne 0 ]; then
#       echo " ** Git Repo, ${aGit_Repo}, not found for Account, ${aGit_User}, using SSH_Key, ${aGit_Host}."
#     else

  if [ "${mResults:0:5}" == "fatal" ]; then
        sayMsg " ** Git Error." 3
        sayMsg "    ${mRemotes}." 3
        exit
        fi

#       sayMsg "GitR1[1206]  mResults: ${mResults}" 1
  if [ "${mResults}" == "" ]; then
          echo "  * No Commits found for Repo, ${aGit_Repo}, for Account, ${aGit_User}, using SSH_Key, ${SSH_Key}."
       else
    for aResult in "${mResults[@]}"; do
        echo "${aResult}" | awk '{ printf "    %7s  %s\n", substr($1,1,7), $2 }'
        done
        fi;

        echo ""
     fi # List Remote Commits
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       LIST LOCAL/REMOTE COMMITS
#====== =================================================================================================== #
        sayMsg "GitR1[1222]  ${aCmd}, nDays: '${nDays}'"                                                                    # .(21122.04.0 nDays Not assigned yet) 

  if [ "${aCmd}" ==  "List All Commits"    ]; then aCmd="List Remote Commits"; fi                                           # .(20623.03.1)
  if [ "${aCmd}" ==  "List Local Commits"  ]; then aCmd="List Remote Commits"; fi                                           # .(20122.04.2)
  if [ "${aCmd}" ==  "List Remote Commits" ]; then

  if [ "${aCmd2/lo/}" == "${aCmd2}" ] && [ "${aCmd3/lo/}" == "${aCmd3}" ]; then bLocal=0; else bLocal=1; fi                 # .(10824.02.1 RAM)

     aDO="-y";  # aDO="-d"                                                                                 # .(21122.04.1 RAM Beg Change -Days option)
     if [ "${nDays}"     == ""   ]; then nDays=14;
     if [ "${aArg1:0:2}" == $aDO ]; then nDays=$aArg2; aArg1="$aArg3"; aArg2="$aArg4"; aArg3="$aArg5"; aArg4="$aArg6"; aArg5="$aArg7"; fi
     if [ "${aArg2:0:2}" == $aDO ]; then nDays=$aArg3;                 aArg2="$aArg4"; aArg3="$aArg5"; aArg4="$aArg6"; aArg5="$aArg7"; fi
     if [ "${aArg3:0:2}" == $aDO ]; then nDays=$aArg4;                                 aArg3="$aArg5"; aArg4="$aArg6"; aArg5="$aArg7"; fi
     if [ "${aArg4:0:2}" == $aDO ]; then nDays=$aArg5;                                                 aArg4="$aArg6"; aArg5="$aArg7"; fi
     if [ "${aArg5:0:2}" == $aDO ]; then nDays=$aArg6;                                                                 aArg5="$aArg7"; fi
     if [ "${aArg6:0:2}" == $aDO ]; then nDays=$aArg7;                                                                                 fi 
                                                       fi;                                                                  # .(21122.04.1 RAM End)
     if [ "${nDays}"     == ""   ]; then nDays=14;     fi;                                                                  # .(21122.04.2 Added fi)
        setProjVars                                                                                                         # .(20122.01.1)
#       aStage=$(  echo "${aPath1}" | awk '{ n = split( $0, a, /\// ); print a[n] }' )                                      # .(20122.01.2)
        aStage=$(  echo "${aPath1}" | awk '{     split( $0, a, /\// ); print a[3] }' )                                      # .(20122.01.2 RAM Assumes path: "nodeapps/{Project}/{Stage}")

#       sayMsg "GitR1[1244]  nDays: '${nDays}', bLocal: '${bLocal}', aArg1: '${aArg1}', aArg2: '${aArg2}', aArg3: '${aArg3}', aArg4: '${aArg4}', bDoit: '${bDoit}', bDebug: '${bDebug}', bQuiet: '${bQuiet}'" 2
#       sayMsg "GitR1[1245]  aStage: ${aStage}; aPath1: '${aPath1}'" 2

        mResults=$( bash -c "( git branch )" 2>&1               ) # .(21128.05.4 RAM Sort) 
#       mResults=$( bash -c "( git branch )" 2>&1 | sort -k1.47 ) ##.(21128.05.4 RAM Sort) 

  if [ "${mResults:0:5}" == "fatal" ]; then
        sayMsg " ** Git Error." 3
        sayMsg "    ${mResults}." 3
        exit
        fi
                                                                  getCurRemote;                 # sayMsg "aRemote: ${aRemote}" 2
#       aGit_Remote=${aArg1}; if [ "${aGit_Remote}" == "" ]; then aGit_Remote=Bruce_FormR-test; fi                             ##.(10821.01.7)
#       aGit_Remote=${aArg1}; if [ "${aGit_Remote}" == "" ]; then aGit_Remote=$( git remote );  fi                             ##.(10821.01.7)
        aGit_Remote=${aArg1}; if [ "${aGit_Remote}" == "" ]; then aGit_Remote=${aRemote};       fi                             # .(10822.01.7)

                                                                  getCurBranch ${aGit_Remote};  # sayMsg "aBranch: ${aBranch}" 2
#       aGit_Branch=${aArg2}; if [ "${aGit_Branch}" == "" ]; then aGit_Branch=$( git branch | awk '/\*/ { print $2 }' ); fi    ##.(10821.01.8)
#       aGit_Branch=${aArg2}; if [ "${aGit_Branch}" == "" ]; then aGit_Branch=main; fi                                         ##.(10821.01.8)
        aGit_Branch=${aArg2}; if [ "${aGit_Branch}" == "" ]; then aGit_Branch=${aBranch}; fi                                   # .(10822.01.8)

        aPath=${aGit_Remote}; if [ "${aGit_Branch}" != "" ]; then aPath=${aPath}/${aGit_Branch}; fi; # sayMsg "aPath: ${aPath}" 2
#       sayMsg "GitR1[1264]  aPath: ${aPath}" 2

     if [ "${aGit_Remote}" == "" ] && [ "${bLocal}" == "0" ] ; then bLocal=1;                                               # .(10827.01.1 Beg RAM If no remote)
           echo ""; echo "  * No Remotes are defined for this Repository."
           fi                                                                                                               # .(10827.01.1 End)
     if [ "${bLocal}" == "1" ]                              ; then aPath="${aGit_Branch}"; fi                               ##.(10827.01.1)
#    if [ "${bLocal}" == "1" ] || [ "${aGit_Remote}" == "" ]; then aPath="${aGit_Branch}"; fi                               # .(10827.01.1 RAM If no remote)

        aSince=""; if [ "${nDays}" != "0" ]; then aSince="--since=\"${nDays} days ago\" "; fi
  if [ "${aSince}" == "" ]; then
        sayMsg "Commits for '${aPath}' since day 1" 1;
   else
        sayMsg "Commits for '${aPath}'   since ${aSince:8}" 1; # echo ""  # 2b0a8aa 2021-06-01 Bruce Troutman Finished Hardening
     fi
        echo "    git log '${aPath}' ${aSince}--date=format:'%Y-%m-%d %H:%M' --oneline --format=\"%h %ad %cn %s\" "; echo ""

  if [ "${bLocal}" == "1" ]; then
        echo "    Local                    Branch              Date    Time   Commit   Author            Commit Message"
#       aGit_Remote="${aStage} (local)"                                                                                     ##.(20122.01.3 RAM Was: "")
        aGit_Remote="${aStage}"                                                                                             # .(20122.01.3 RAM Was: "")
        aLorR=" L"                                                                                                          # .(20122.01.3 RAM Added)
   else
        echo "    Remote Alias Name        Branch              Date    Time   Commit   Author            Commit Message"
#       aGit_Remote="${aGit_Remote} (remote)"                                                                               ##.(20122.01.4 RAM Added)
        aLorR=" R"                                                                                                          # .(20122.01.4 RAM Added)
     fi
#       echo "    -----------------  ---------------  ----------------  -------  ----------------  -----------------------------------"
        echo "    -----------------------  ---------------  ----------------  -------  ----------------  -----------------------------------"   # .(11127.02.8)

#       aRemote="\"${aGit_Remote}\", \"${aGit_Branch}\", \$1, \$2, \$3, \$4"; sayMsg "aRemote: ${aRemote}" 1
#       aPrg="{ printf \"    %-18s %-15s %10s  %7s  %-17s %s\n\", \"${aGit_Remote}\", \"${aGit_Branch}\", \$2,         \$1, \$3, \$4 }"; # sayMsg "aPrg: ${aPrg}" 2
#       aPrg="{ printf \"    %-18s %-15s %16s  %7s  %-17s %s\n\", \"${aGit_Remote}\", \"${aGit_Branch}\", \$2\" \"\$3, \$1, \$4, \$5 }"; # sayMsg "aPrg: ${aPrg}" 2
#       aPrg="{ printf \"    %-18s %-15s %16s  %7s  %-17s %s\n\", \"${aGit_Remote}\", \"${aGit_Branch}\", \$2,    \$3, \$1, \$4, \$5 }";   sayMsg "aPrg: ${aPrg}" 1
#       aPrg="{ printf \"    %-18s %-16s %16s  %7s  %-17s %s\n\", \"${aGit_Remote}\", \"${aGit_Branch}\", \$2,         \$1, \$3, \$4; n++; d=\$2 }"; # sayMsg "aPrg: ${aPrg}" 2
#       aPrg="{ printf \"    %-24s %-16s %16s  %7s  %-17s %s\n\", \"${aGit_Remote}\", \"${aGit_Branch}\", \$2,         \$1, \$3, \$4; n++; d=\$2 }"; # sayMsg "aPrg: ${aPrg}" 2   # .(11127.02.9)
        aPrg="{ printf \" %s %-24s %-16s %16s  %7s  %-17s %s\n\", \"${aLorR}\", \"${aGit_Remote}\", \"${aGit_Branch}\", \$2,         \$1, \$3, \$4; n++; d=\$2 }"; # sayMsg "aPrg: ${aPrg}" 2   # .(11127.02.9).(20122.01.6)

#       aPrg="${aPrg} END { printf \"%3d Commits for '${aPath}' since '${aSince:8} days ago'\", n }"; # sayMsg "aPrg: ${aPrg}" 2
#       aPrg="${aPrg} END { printf \"%3d Commits for '${aPath}' since %s\", n, d ? d : \"then\"   }"; # sayMsg "aPrg: ${aPrg}" 2
        aPrg="${aPrg} END { printf \"    %s Commits for %-19s since: %-20s\", n, \"'${aPath}'\", (d ? d : \"then\") }"; # sayMsg "aPrg: ${aPrg}" 2

#       git log ${aPath} -n 25                 --oneline --format="%h|%as|%cn|%s" | awk -F'[|]' '{ printf "    %7s  %10s  %-17s %s\n", $1, $2, $3, $4 }'
#       git log ${aPath} --since="2021-07-25"  --oneline --format="%h|%as|%cn|%s" | awk -F'[|]' '{ printf "    %7s  %10s  %-17s %s\n", $1, $2, $3, $4 }'
#       git log ${aPath} --since="20 days ago" --oneline --format="%h|%as|%cn|%s" | awk -F'[|]' '{ printf "    %7s  %10s  %-17s %s\n", $1, $2, $3, $4 }'
#       git log ${aPath} "${aSince}"           --oneline --format="%h|%as|%cn|%s" | awk -F'[|]' '{ printf "    %-15s %-15s %7s  %10s  %-17s %s\n", ${aRemote} }'
#       git log ${aPath} "${aSince}" --date=format:'%Y-%m-%d %H:%M' --oneline --format="%h|%ad|%cn|%s"

  if [ "${aSince}" == "" ]; then
#       git log ${aPath}             --date=format:'%Y-%m-%d %H:%M' --oneline --format="%h!%ad!%cn!%s" | awk -F'[!]' -e "${aPrg}"                ##.(21122.04.4 RAM Swap ! for |).(21128.05.5)
        git log ${aPath}             --date=format:'%Y-%m-%d %H:%M' --oneline --format="%h!%ad!%cn!%s" | awk -F'[!]' -e "${aPrg}" | sort -k1.45  # .(21122.04.4 RAM Swap ! for |).(21128.05.5)
    else
#       git log ${aPath} "${aSince}" --date=format:'%Y-%m-%d %H:%M' --oneline --format="%h!%ad!%cn!%s" | awk -F'[!]' -e "${aPrg}" | sort         ##.(21122.04.5).(21128.05.6)
        git log ${aPath} "${aSince}" --date=format:'%Y-%m-%d %H:%M' --oneline --format="%h!%ad!%cn!%s" | awk -F'[!]' -e "${aPrg}" | sort -k1.45  # .(21122.04.5).(21128.05.6)
     fi

#       mRecs=$( bash -c "( git log ${aPath} "${aSince}" --date=format:'%Y-%m-%d %H:%M' --oneline --format="%h|%ad|%cn|%s" )" )
#       echo "Count: ${mRecs[@]} \"${aPath}\" since ${aSince:8}"

        echo ""
     fi # eoc List Remote Commits
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       COUNT REMOTE COMMITS
#====== =================================================================================================== #
        sayMsg "GitR1[1326]  Count Remote Commits";

  if [ "${aCmd}" ==  "Count Remote Commits" ]; then

  if [ "${aCmd3/al/}" != "${aCmd3}" ] || [ "${aCmd2}" == "co-al" ]; then
        echo ""; IFS=$'\n'
        mRemoteBranches=( $( gitr list branch remote | awk '$2 == "/" { print }' ) )
    for aRemoteBranch in "${mRemoteBranches[@]}"; do # sayMsg "aRemoteBranch: ${aRemoteBranch}" 1
        aRemote=$( echo ${aRemoteBranch} | awk '{ print $1 }' )
        aBranch=$( echo ${aRemoteBranch} | awk '{ print $3 }' )
        gitr list remote commits -d 0 ${aRemote} ${aBranch} | awk '/[0-9]+ Commits for/ { printf "%5d Commits for %-30s since %s %s\n", $1, $4, $6, $7 }'
        done
    else
        echo ""
        gitr list remote commits -d 0 ${aArg1} ${aArg2} ${aArg3} ${aArg4} ${aArg5} ${aArg6} | awk '/[0-9]+ Commits for/ { print "    "$0 }'
     fi
        echo ""
     fi # eoc Count Remote Commits
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       COUNT LOCAL COMMITS                                                                                 #
#====== =================================================================================================== #
        sayMsg "GitR1[1349]  Count Local Commits";

  if [ "${aCmd}" ==  "Count Local Commits" ]; then

  if [ "${aCmd3/al/}" != "${aCmd3}" ] || [ "${aCmd2}" == "co-al" ]; then
        echo ""; IFS=$'\n'
        mRemoteBranches=( $( gitr list branch remote | awk '$2 == "/" { print }' ) )
    for aRemoteBranch in "${mRemoteBranches[@]}"; do # sayMsg "aRemoteBranch: ${aRemoteBranch}" 1
        aRemote=$( echo ${aRemoteBranch} | awk '{ print $1 }' )
        aBranch=$( echo ${aRemoteBranch} | awk '{ print $3 }' )
        gitr list local commits -d 0 ${aRemote} ${aBranch} | awk '/[0-9]+ Commits for/ { printf "%5d Commits for %-30s since %s %s\n", $1, $4, $6, $7 }'
        done
    else
        echo ""
        gitr list local commits -d 0 ${aArg1} ${aArg2} ${aArg3} ${aArg4} ${aArg5} ${aArg6} | awk '/[0-9]+ Commits for/ { print "    "$0 }'
     fi
        echo ""
     fi # eoc Count Local Commits
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       SPARSE ON / OFF                                                                                     # .(21025.01.4 RAM Beg Added )
#====== =================================================================================================== #
#       sayMsg "GitR1[1372]  ${aCmd}" # 1

  if [ "${aCmd}" ==  "Sparse" ]; then
#       sayMsg       "Sparse not implemented yet. aCmd2: ${aCmd2}, ${aArg1}" 2

  if [ "${aCmd2}" == "sp-of" ]; then
        git sparse-checkout disable
        fi
  if [ "${aCmd2}" == "sp-li" ]; then                                                                        # .(21026.01.3 RAM Beg Added sparse list)

        echo -e "\n  Repository Sparse Folders"
        echo  "  ---------------------------------------------------"
        git sparse-checkout list 2>&1 | awk '{ print "  " $0 }'
        echo ""
        fi                                                                                                  # .(21026.01.3 End)
  if [ "${aCmd2}" == "sp-on" ]; then
        git config --worktree core.sparsecheckout true
        git sparse-checkout reapply
        fi

  if [ "${aArg1:0:2}" == "di" ]; then
        rss dirlist 1 3
        fi

        ${aLstSp}
     fi # eoc Next Command                                                                                  # .(21025.01.4 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       NEXT COMMAND                                                                                        # .(ymmdd.nn.4 USR Beg Added NEXT command)
#====== =================================================================================================== #
        sayMsg "GitR1[1403]  ${aCmd}" # 1

  if [ "${aCmd}" ==  "Next Command" ]; then
        sayMsg       "Next Command not implemented yet" 2

        echo "    $( dirname $0 )/command_u1.01.sh" "${aArg1}" "${aArg2}" "${aArg3}"
#                "$( dirname $0 )/command_u1.01.sh" "${aArg1}" "${aArg2}" "${aArg3}"

        ${aLstSp}
     fi # eoc Next Command                                                                                  # .(ymmdd.nn.4 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       END                                                                                                 #
#========================================================================================================== #  ===============================  #
#*\
##SRCE     +====================+===============================================+
##RFILE    +====================+=======+===================+======+=============+
#*/
