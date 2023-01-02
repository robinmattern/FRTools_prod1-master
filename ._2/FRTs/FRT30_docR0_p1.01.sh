#!/bin/bash
#*\
##=========+====================+================================================+
##RD         frt                | FormR Tools MT Template
##RFILE    +====================+=======+=================+======+===============+
##FD   FRT30_Doc0.sh            |  11350| 11/28/22 08:01|   188| p1.01-21128.0801
##FD   FRT30_docR0.sh           |  16049| 11/28/22 13:51|   274| p1.01-21128.1351
##DESC     .--------------------+-------+-----------------+------+---------------+
#            Use the commands in this script to document sample commands
#
##LIC      .--------------------+----------------------------------------------+
#            Copyright (c) 2022 8020Data-FormR * Released under
#            MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+-------+-------------------+------+-----------+
#            Help               | 
#            Start              |
#            Step               |
#            Code               |
#            End                |
#                               |
##CHGS     .--------------------+-------+-------------------+------+-----------+
# .(11002.01 10/02/21 RAM 10:35p| Created
# .(21128.01 11/28/22 RAM  8:00p| Add docR Commands
# .(21128.02 11/28/22 RAM  1:50p| Add docR Commands
# .(21128.02 11/28/22 RAM  8:00p| Finish docR Commands

##PRGM     +====================+===============================================+
##ID 69.600. Main               |
##SRCE     +====================+===============================================+
#*/
#========================================================================================================== #  ===============================  #

        aVdt="Nov 28, 2022  1:51p"; aVtitle="OS Info Tools"
        aVer="$( echo $0 | awk '{ match( $0, /_[dpstuv][0-9]+\.[0-9]+/ ); print substr( $0, RSTART+1, RLENGTH-1) }' )"  # .(21111.04.1)

        LIB=DOC; LIB_LOG=${DOC}_LOG; LIB_USER=${LIB}_USER

        aFns="$( dirname "${BASH_SOURCE}" )/../JPTs/JPT12_Main2Fns_p1.07.sh";  if [ ! -f "${aFns}" ]; then  # .(21113.05.9 RAM Use JPT12_Main2Fns_p1.07.sh)
        echo -e "\n ** FRT30[ 35]  JPT Fns script, '.${aFns#*._2}', NOT FOUND\n"; exit; fi; #fi
        source "${aFns}";

#   +===== +================== +=========================================================== # ==========+

        bDoit=0                                                                                             ##.(20501.01.5 RAM !Important don't reset in Sub script)
        bQuiet=1                                                                                            ##.(20501.01.6 RAM).(20601.02.2 bQuiet by default)
        bDebug=0                                                                                            ##.(20501.01.7 RAM)
        bSpace=0;                                                                                           # .(20620.04.8 RAM A space hasn't been displayed, print one next; was 1)

        Begin "$@"                                                                                          # .(21113.05.16)

        setOS; bSpace=1;                                                                                    #  A space hasn't been displayed, print one next
        aLstSp="echo "; if [ "${aOSv/w}" != "${aOSv}" ]; then aLstSp=""; fi                                 # .(10706.09.1 RAM Windows returns an extra blank line).(21113.06.1 RAM Reverse).(21120.02.2)
#       echo  "  - FRT30[ 49]  aOSv: ${aOSv}, ${aOS}, aLstSp: '${aLstSp}'"; ${aLstSp}; # exit

#    -- --- ---------------  =  ------------------------------------------------------  #

#       sayMsg    "FRT30[ 53]  aServer: '${aServer}', aOS: '${aOS}', bDebug: '${bDebug}'" 2

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       HELP Command
#
#====== =================================================================================================== #

function Help() {

        sayMsg    "FRT30[ 65]  aCmd:  '${aCmd}', aCmd0: '$1', aCmd1: '${aCmd1}'" -1

     if [ "${aCmd}" == "" ]; then bQuiet=0; sayMsg " ** Invalid gitR Command: '$1'" 3; aCmd="Help";  fi     # .(21117.01.2 RAM Works best)
     if [ "${aCmd}" == "Help" ]; then                                                                       # .(21117.01.3)

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

        echo ""
        echo "  Useful DocR Commands   (${aVer})                                 (${aVdt})"
        echo "  -------------------------------------------------------------- -----------------------------------"
        echo "    docR Start {title}                                           Begin a document"            # .(21128.01.1 RAM Beg Add)
        echo "    docR Type [ text | markdown ]                                Set the type"
        echo "    docR Title {title}                                           Begin a document"
        echo "    docR Line                                                    Write a Line "               # .(21128.02.4)
        echo "    docR Space                                                   Write a Blank Line "         # .(21128.02.7)
        echo "    docR Note  {note}                                            Write a Note"
        echo "    docR Step  {step}                                            Write a Step"                # .(21128.02.1)
        echo "    docR Set Pause [ on | off ]                                  Set pausing before code"
        echo "    docR Code {code}                                             Run some code"
        echo "    docR Alert {alert}                                           Write an alert"              # .(21128.01.1 RAM End)
        ${aLstSp}; exit                                                                                     # .(10706.09.3)
        fi
        } # eof Help
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#========================================================================================================== #  ===============================  #

        setArgs "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9"

  if [ "${bDebug}" == "1" ]; then dBg=1; fi # echo "setCmds ${dBug}"; fi # exit; fi

        getOpts "bdqgl" 0; # Set dBug=0

        setCmds

        sayMsg sp "FRT30[ 97]  \$1: '$1', \$2: '$2', \$3: '$3', \$4: '$4', \$5: '$5', \$6: '$6', \$7: '$8'" -1
        sayMsg    "FRT30[ 98]  aCmd:  '${aCmd}', aCmd1: '${aCmd1}', aCmd2: '${aCmd2}', aCmd3: '${aCmd3}', aCmd0: '${aCmd0}', bDoit: '$bDoit', bDebug: '$bDebug', bQuiet: '$c' " -1
#       sayMsg    "FRT30[ 99]  aCmd:  '$aCmd',  aCmd1: '$aCmd1', aCmd2: '$aCmd2', aCmd3: '$aCmd3', aCmd0: '$aCmd0' "

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

        getCmd  "he"                 "Help"
#       getCmd  "start"              "docR Start"                                                            ##.(21128.01.2 RAM No Workie)
#       getCmd  "start"  "*"         "docR Start"                                                            # .(21128.01.2 RAM No Workie)
        getCmd  "start"  "*"         "docR Start"      # Any 2nd cmd                                         # .(21128.01.2 RAM Beg Left arg must be lowercase)
#       getCmd  "start"  "*"         "docR Start"   1  # Sets dBug=1                                         # .(21128.01.2 RAM Beg Left arg must be lowercase)
        getCmd  "type"   "*"         "docR Type"
        getCmd  "alert"  "*"         "docR Alert"
        getCmd  "title"  "*"         "docR Title"
        getCmd  "note"   "*"         "docR Note"
        getCmd  "line"   "*"         "docR Line"                                                             # .(21128.02.5) 
        getCmd  "space"  "*"         "docR Blank Line"                                                       # .(21128.02.8) 
        getCmd  "bl"     "li"        "docR Blank Line"                                                       # .(21128.02.9) 
        getCmd  "step"   "*"         "docR Step"                                                             # .(21128.02.2) 
        getCmd  "se"     "pa"  "on"  "docR Set Pause On"  # 1
        getCmd  "se"     "pa"  "of"  "docR Set Pause Off"
        getCmd  "code"   "*"         "docR Code"
        getCmd  "end"    "*"         "docR End"                                                              # .(21128.01.2 RAM End)

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

        sayMsg "FRT30[119]  \$1: '$1', \$2: '$2', \$3: '$3', \$4: '$4', \$5: '$5', \$6: '$6', \$7: '$8'"
        sayMsg "FRT30[120]  aArg1: '$aArg1', aArg2: '$aArg2', aArg3: '$aArg3', aArg4: '$aArg4', aArg5: '$aArg5', aArg6: '$aArg6', aArg7: '$aArg7', aArg8: '$aArg8', aArg9: '$aArg9'"
        sayMsg "FRT30[121]  aCmd:  '${aCmd}', aCmd1: '${aCmd1}', aCmd2: '${aCmd2}', aCmd3: '${aCmd3}', aCmd0: '${aCmd0}', bDoit: '${bDoit}', bDebug: '${bDebug}', bQuiet: '${bQuiet}" -1

        Help ${aCmd0}

        sayMsg "FRT30[125]  aCmd:  '${aCmd}', aArg1: '${aArg1}', aArg2: '${aArg2}', aArg3: '${aArg3}', bGlobal: '${bGlobal}'" -1 # 2

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       Doc Functions                                                                                       #
#
#====== =================================================================================================== #

function subFunction() {                                                                                    # .(21128.01.3 RAM Beg Add subFunction)

        sayMsg "FRT30[137]  subFunction[1]  Begin" 1


     } # eof subFunction                                                                                    # .(21128.01.3 RAM End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== ==============================================================================  #  ================ # .(21128.01.4 RAM Beg Add Command)
#       docR Start Command
# ----- ------------------------------------------------------------------------------

        sayMsg "FRT30[147]  docR Start (${aCmd})" -1

  if [ "${aCmd}" == "docR Start" ]; then
#       sayMsg "FRT30[150]  docR Start" -1

        echo "# ============================================================================================================================================== #"
        echo "    ${aArg1}"
        echo "  + -----------------------  =  ------------------------------------------------------  +  -------------- +"

        ${aLstSp}
     fi # eoc docR Start                                                                                    # .(21128.01.4 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== ==============================================================================  #  ================ # .(21128.01.5 RAM Beg Add Command)
#       docR Note Command
# ----- ------------------------------------------------------------------------------

        sayMsg "FRT30[166]  docR Note (${aCmd})" -1

  if [ "${aCmd}" == "docR Note" ]; then
#       sayMsg "FRT30[169] docR Note" -1

        echo ""
        echo "         ${aArg1}"
        echo "       + ------------------  =  ------------------------------------------------------  +  -------------- +"
#       echo ""

        ${aLstSp}
     fi # eoc docR Start                                                                                    # .(21128.01.5 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== ==============================================================================  #  ================ # .(21128.02.9 RAM Beg Add Command)
#       docR Line Command
# ----- ------------------------------------------------------------------------------

        sayMsg "FRT30[166]  docR Blank Line (${aCmd})" -1

  if [ "${aCmd}" == "docR Blank Line" ]; then
#       sayMsg "FRT30[169] docR Blank Line" -1

        echo ""

        ${aLstSp}
     fi # eoc docR Blank                                                                                    # .(21128.02.9 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== ==============================================================================  #  ================ # .(21128.02.6 RAM Beg Add Command)
#       docR Line Command
# ----- ------------------------------------------------------------------------------

        sayMsg "FRT30[166]  docR Line (${aCmd})" -1

  if [ "${aCmd}" == "docR Line" ]; then
#       sayMsg "FRT30[169] docR Line" -1

#       echo "       + ------------------  =  ------------------------------------------------------  +  -------------- +"

        ${aLstSp}
     fi # eoc docR Line                                                                                     # .(21128.02.6 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== ==============================================================================  #  ================ # .(21128.02.3 RAM Beg Add Command)
#       docR Step Command
# ----- ------------------------------------------------------------------------------

        sayMsg "FRT30[166]  docR Step (${aCmd})" -1

  if [ "${aCmd}" == "docR Step" ]; then
#       sayMsg "FRT30[169] docR Step" -1

        echo "         - ${aArg1}"
#       echo "       + ------------------  =  ------------------------------------------------------  +  -------------- +"

        ${aLstSp}
     fi # eoc docR Step                                                                                     # .(21128.02.3 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== ==============================================================================  #  ================ # .(21128.01.6 RAM Beg Add Command)
#       docR Code Command
# ----- ------------------------------------------------------------------------------

        sayMsg "FRT30[187]  docR Code (${aCmd})" -1

  if [ "${aCmd}" == "docR Code" ]; then
        sayMsg "FRT30[190]  docR Code" -1

        bPause=$( git config --global --get frt.docr.pause )
        shift
#       echo "        $@ (${bPause})"; exit 
#       echo "#       -------------------  =  ------------------------------------------------------  #"

        echo "       + ------------------  =  ------------------------------------------------------  +  -------------- +"
        echo ""
  if [ "${bPause}" == "1" ]; then
 #      read -s -n 1 -p "        Press any key..."; echo ""
        read -s -n 1 -p "         $ $@"; echo ""
     else
        echo            "         # $@"; echo ""
        fi
        aCmd="$@"; aCmd=${aCmd//\"/}
        echo "       + ------------------  =  ------------------------------------------------------  +---------------- +"
                     $@ | awk '{ print "       |" $0 }'
        echo "       + ------------------  =  ------------------------------------------------------  +---------------- +"
        echo "" 
        ${aLstSp}
     fi # eoc docR Code                                                                                     # .(21128.01.6 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== ==============================================================================  #  ================ # .(21128.01.7 RAM Beg Add Command)
#       docR Set PAUSE Command
# ----- ------------------------------------------------------------------------------

#       sayMsg "FRT30[214]  ${aCmd}" -1

  if [ "${aCmd}" == "docR Set Pause On" ] || [ "${aCmd}" == "docR Set Pause Off" ]; then
#       sayMsg "FRT30[217]  docR Set Pause ${aCmd:15:2}" 1

        bOn=0; if [ "${aCmd:15:2}" == "On" ]; then bOn=1; fi 
        git config --global --add  frt.docr.pause  ${bOn}
        bPause=$( git config --global --get frt.docr.pause )
#       sayMsg "FRT30[224]  frt.docr.pause: ${bPause}" 1

        ${aLstSp}
     fi # eoc docR End                                                                                      # .(21128.01.7 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== ==============================================================================  #  ================ # .(21128.01.8 RAM Beg Add Command)
#       docR End Command
# ----- ------------------------------------------------------------------------------

        sayMsg "FRT30[232]  docR End (${aCmd})" -1

  if [ "${aCmd}" == "docR End" ]; then
        sayMsg "FRT30[235] docR End" -1

        echo "# ============================================================================================================================================== #"

        ${aLstSp}
     fi # eoc docR End                                                                                      # .(21128.01.8 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       {COMMAND2} Commands                                                                                 # .(20416.02.3 Beg RAM Added Command)
#
#====== =================================================================================================== #

        sayMsg "{JPT}[178]  {Command2}" # sp

  if [ "${aCmd}" == "{Command2}" ]; then
        sayMsg "{JPT}[181]  {Command2}" 1

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #


        ${aLstSp}                                                                                           # .(10706.09.14)
     fi # eoc {Command2}                                                                                    # .(20416.02.3 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

# ------------------------------------------------------------------------------------
#
#       END
#
#========================================================================================================== #  ===============================  #
#*\
##SRCE     +====================+===============================================+
##RFILE    +====================+=======+===================+======+=============+
#*/