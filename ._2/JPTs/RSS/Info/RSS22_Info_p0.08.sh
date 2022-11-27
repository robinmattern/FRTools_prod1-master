#!/bin/bash
#*\
##=========+====================+================================================+
##RD         Info               | RSS Set and Show Stuff
##RFILE    +====================+=======+===================+======+=============+
##FD   RSS22-Info.sh            |   9510|  9/26/18 22:53|   191| v0.07.80923
##FD   RSS22-Info.sh            |  17214| 11/12/22 16:04|   318| p0.08.21112-1604
##FD   RSS22-Info.sh            |  18141| 11/12/22 18:28|   327| p0.08.21112-1828
##FD   RSS22-Info.sh            |  19554| 11/13/22 17:25|   344| p0.08.21113-1725
##FD   RSS22_Info.sh            |  25926| 11/20/22 13:43|   434| p0.08-21120.1343
##FD   RSS22_Info.sh            |  34136| 11/22/22 09:34|   523| p0.08-21122.0934
##DESC     .--------------------+-------+-------------------+------+------------+
#
#
##LIC      .--------------------+----------------------------------------------+
#            Copyright (c) 2018 SicommNet-JPT * Released under
#            MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+-------+-------------------+------+-----------+
#
##CHGS     .--------------------+-------+-------------------+------+-----------+
# .(80923.01  9/23/18 RAM  3:26p| Create it
# .(80926.06  9/26/10 RAM 10:52p| Fix backslashes
# .(80929.01  9/29/10 RAM  8:19p| Add 2 spaces to: info path
# .(81014.02 10/14/10 RAM  9:30a| Modify Version cmd
# .(81014.03 10/14/10 RAM 10:15a| Show Help if bCmdRan == 0
# .(81014.04 10/14/10 RAM 11:00a| Add newCmd template
# .(21112.01 11/12/22 RAM 12:00p| Modify RSS Version
# .(21112.03 11/12/22 RAM  4:04p| Add RSS Info Var Set
# .(21112.06 11/12/22 RAM  6:28p| Put quotes around value if necessary
# .(21113.04 11/13/22 RAM  5:25p| SETX didn't work again
# .(21114.01 11/14/22 RAM  5:55a| Make Path Show smarter
# .(21114.02 11/14/22 RAM  2:00p| Add -doit to Path Clean and Add
# .(21114.04 11/14/22 RAM  6:30a| Add Path clean
# .(21114.05 11/14/22 RAM  7:55a| Add Path add
# .(21120.06 11/20/22 RAM  1:40p| Add cvt to AwkPgm to deal with Windows' paths
# .(21121.01 11/21/22 RAM  4:30p| Fix searching for a path in windows
# .(21121.03 11/21/22 RAM  4:00p| Allow for .bashrc or profile
# .(21122.01 11/22/22 RAM  9:00a| Add Parse args
# .(21124.01 11/24/22 RAM  2:00p| Get $PATH with REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" -v PATH 

##PRGM     +====================+===============================================+
##ID 69.600. Main               |
##SRCE     +====================+===============================================+
#*/
          aVdt="Nov 20, 2022  1:43p"; aVTitle="OS Info Tools"
          aVer="$( echo $0 | awk '{ match( $0, /_[dpstuv][0-9]+\.[0-9]+/ ); print substr( $0, RSTART+1, RLENGTH-1) }' )"  # .(21111.04.1)

          LIB=RSS; LIB_LOG=${LIB}_LOG; LIB_USER=${LIB}_USER

function  logIt() {
            aFncLine="$1[$2]             "; aFncLine="${aFncLine:0:17} $3";
#           aFncLine="${aFncLine/ \//\/}";  aFncLine="${aFncLine/ C:/C:}";  aFncLine="${aFncLine/ D:/D:}";  aFncLine="${aFncLine/ M:/M:}";
   if [ -f "$LIB_LOG" ]; then echo "$( date '+%Y%m%d-%H%M%S%z')  ${SCN_SERVER:0:11} ${LIB_USER:0:8}  ${aFncLine}" >>"$LIB_LOG"; fi
         }
#   +===== +================== +=========================================================== # ==========+

     if [ "$1" == "test"     ]; then bTest=1; shift; else bTest=0; fi

                     mArgs1=( "$@" ); mArgs2=(); j=0                                                 # .(21122.01.1 RAM Beg Added Parse Args)
          for (( i = 0; i < ${#mArgs1[@]}; i++ )); do aArg="$( echo "${mArgs1[i]}" | tr '[:upper:]' '[:lower:]' )"
          case "${aArg}" in
          -do*) bDoit=1;  ;;
               *) j=$(( j + 1 )); mArgs2[j]="${mArgs1[i]}"; ;;
            esac                                                                            # .(21122.01.1 RAM End)
            done
            aCmd1="${mArgs2[1]}"                                                            # .(21122.01.2)
            aCmd2="${mArgs2[2]}"                                                            # .(21122.01.3)
            aArg1="${mArgs2[3]}"                                                            # .(21122.01.4)
            aArg2="${mArgs2[4]}"                                                            # .(21122.01.5)
            bCmdRan=0

     if [ "$aCmd1" == ""        ]; then aCmd1=help; fi
     if [ "$aCmd2" == ""        ]; then aCmd2=show; fi

     if [ "$aCmd1" == "show"    ]; then aCmd1=vars
        if [ "$aCmd2" == "path" ]; then aCmd1=path; fi
        if [ "$aCmd2" == "vars" ]; then aCmd1=vars; fi
        if [ "$aCmd2" == "log"  ]; then aCmd1=log;  fi
              aCmd2=show
        fi
            echo ""
#           echo "*** aCmd: $aCmd1.$aCmd2 '$aArg1', '${aArg2}', bCmdRan: ${aCmdRan}"; # exit
#   +----- +------------------ +----------------------------------------------------------- # ----------+

function Help() {                                                                           #.(81014.03.1 Beg RAM Create function)
#           echo "  $LIB Info Functions              $( echo $0 | awk '{ gsub( /.+_[ptuv]|.sh/, ""); print }' )"
            echo "  RSS Info Tools   (${aVer})                    (${aVdt})"                # .(21111.04.2)
            echo "  ------------------------------------------  ---------------------------------"
            echo "    RSS Path [Show]                           Show PATH"
            echo "    RSS Path Add [System] {Path} [-doit]      Add {Path} to [System] PATH"
            echo "    RSS Path Clean [System]      [-doit]      Remove Duplicate Paths from [System] PATH"
            echo "    RSS Vars Show {Search}                    Show Environment Variables (Use ! for non-leading search string)"
            echo "    RSS Vars Set [System] {Name} {Value}      Set [System] Environment Variable"
#           echo "    RSS Top                                   Show Top Running Programs (Unix only)"
#           echo "    RSS Log Show                              Show $LIB Log"
#           echo "    RSS Log Set {LogFile} {User}              Set $LIB log"
#           echo "    RSS Log On                                Turn $LIB log on"
#           echo "    RSS Log Off                               Turn $LIB log off"
            echo ""
            exit
        }
     if [ "$aCmd1" == "help" ]; then Help; fi                                               #.(81014.03.1 End)

#   +----- +------------------ +----------------------------------------------------------- # ----------+

#   +===== +================== +=========================================================== # ==========+

     if [ "$aCmd1" == "log" ]; then     # if  aCmd1 == log

     if [  "$aCmd2" == "set" ] || [ "$aCmd2" == "on"  ]; then # if  aCmd2 == log set
#    if [[ "$aCmd2" == "set"   ||   "$aCmd2" == "on" ]]; then
#    if [  "$aCmd2" == "set" ]; then

                aTS=$( date '+%Y%m%d'); aTS=${aTS:3}
                export RSS_USER="${USERNAME%%.*}          "  # First name; Delete after and including ."

#               LIB_LOG="/C/Home/SCN2/_/LOGs/${LIB}s/"
            if [ "${SCN_SERVER:7:1}" == "w" ];then           # sc163d-w08s_Sherman3 (192.168.109.8)
#               LIB_LOG="/C/Home/SCN2/_/LOGs/${LIB}s/"
                LIB_LOG="C:\\Home\\SCN2\\_\\LOGs\\RSSs\\"

                if [ ! -d "/C/Home/SCN2"                ]; then mkdir "/C/Home/SCN2"; fi
                if [ ! -d "/C/Home/SCN2/_"              ]; then mkdir "/C/Home/SCN2/_"; fi
                if [ ! -d "/C/Home/SCN2/_/LOGs"         ]; then mkdir "/C/Home/SCN2/_/LOGs"; fi
                if [ ! -d "/C/Home/SCN2/_/LOGs/${LIB}s" ]; then mkdir "/C/Home/SCN2/_/LOGs/${LIB}s"; fi

              else
                LIB_LOG="/home/SCN2/_/LOGs/${LIB}s/"

                if [ ! -d "/home/SCN2"                  ]; then mkdir "/home/SCN2"; fi
                if [ ! -d "/home/SCN2/_"                ]; then mkdir "/home/SCN2/_"; fi
                if [ ! -d "/home/SCN2/_/LOGs"           ]; then mkdir "/home/SCN2/_/LOGs"; fi
                if [ ! -d "/home/SCN2/_/LOGs/${LIB}s"   ]; then mkdir "/home/SCN2/_/LOGs/${LIB}s"; fi
                fi
#               fi

                RSS_LOG="${LIB_LOG}${LIB}-Log_v${aTS}.log"

#           if [ ! -f "$RSS_LOG" ]; then
                echo "" >"$RSS_LOG";
                echo "$( date '+%Y%m%d-%H%M%S%z')  ${SCN_SERVER:0:11} ${JPT_USER:0:8}  RSS-setLog[1]     Created Log file: ${RSS_LOG}" >>"${RSS_LOG}"
                echo "  Created Log file: ${RSS_LOG}"
                echo ""
#               fi

                aCmd2="on"
                bCmdRan="1"                                                               #.(81014.03.2)
            fi                          # eif aCmd2 == log set
#    +---- +------------------ +----------------------------------------------------------- # --------+

     if [ "$aCmd2" == "on" ]; then      # if  aCmd2 == log on

            if [ "${SCN_SERVER:7:1}" == "w" ];then  # sc163d-w08s_Sherman3 (192.168.109.8)
                echo "  setx RSS_USER \"${RSS_USER}   \""
                echo "  set  RSS_USER=\"${RSS_USER}   \""
                echo "  setx RSS_LOG \"$( echo "${RSS_LOG}" | tr "\\\\", "/" )\""                       # .(80926.06.1 RAM My goodness)
                echo "  set  RSS_LOG=\"$( echo "${RSS_LOG}" | tr "\\\\", "/" )\""                       # .(80926.06.2)
              else
                echo "  export RSS_USER=\"${RSS_USER}\""
                echo "  export RSS_LOG=\"${RSS_LOG}\""
                fi

                echo "" >>"${RSS_LOG}"
                echo "$( date '+%Y%m%d-%H%M%S%z')  ${SCN_SERVER:0:11} ${RSS_USER:0:8}  RSS-setLog[2]     Start Logging" >>"${RSS_LOG}"
                bCmdRan="1"                                                               #.(81014.03.3)
            fi                          # eif aCmd2 == log on
#    +---- +------------------ +----------------------------------------------------------- # --------+

     if [ "$aCmd2" == "off" ]; then     # if  aCmd2 == log off

       if [ ! -f "$RSS_LOG" ]; then
            echo "* Logfile does not exist"
         else
                echo "" >>"${RSS_LOG}"
                echo "$( date '+%Y%m%d-%H%M%S%z')  ${SCN_SERVER:0:11} ${RSS_USER:0:8}  RSS-setLog[3]     Stop Logging"  >>"${RSS_LOG}"

            if [ "${SCN_SERVER:7:1}" == "w" ];then
                echo "  setx ${LIB}_USER "
                echo "  set  ${LIB}_USER="
              else
                echo "  export ${LIB}_LOG="
                fi
            fi
                bCmdRan="1"                                                               #.(81014.03.6)
            fi                          # eif aCmd2 == log off
#    +---- +------------------ +----------------------------------------------------------- # --------+

     if [ "$aCmd2" == "show" ]; then    # if  aCmd2 == log show

       if [ ! -f "$RSS_LOG" ]; then
            echo "* Logfile does not exist"
         else
            echo "  Showing RSS log file: \"$( echo "${RSS_LOG}" | tr "\\\\", "/" )\""; echo ""         # .(80926.06.3 If it contains backslashes)
            tail -n 20 "${RSS_LOG}"
            fi
            bCmdRan="1"                                                                   #.(81014.03.7)
            fi                          # eif aCmd2 == log show
#    +---- +------------------ +----------------------------------------------------------- # --------+
        fi                              # eif aCmd1 == log
#   +----- +------------------ +----------------------------------------------------------- # ----------+


#   +===== +================== +=========================================================== # ==========+

     if [ "$aCmd1" == "path" ]; then    # if  aCmd1 == path

function cvt2winPath() { nLen=110                                                                    # .(21131.06.1 RAM Beg)
      if [ "$2" != "w" ];  then aNewPath="$1"; else
         aNewPath="$1" #="$( echo "$1" | awk '{ sub( /\/n/, "{n}" ); print }' )"
         aNewPath="$( echo "${aNewPath}" | awk '{ gsub( /:/, ";"); gsub( /\/[cC]/, "C:" ); gsub( /\//, "\\" ); print }' )"
#        aNewPath="$( echo "${aNewPath}" | awk '{ sub( /{n}/, "\\n" ); print }' )"
         fi
      if [ "$3" == "1" ]; then echo "${aNewPath}"; return; fi
         echo "${aNewPath}" | awk '{ n = length($0);  print n < '${nLen}' ? $0 : substr( $0, 1, '${nLen}' ) "..." }'  # Find 1st 80 chars in $PATH
         }                                                                                           # .(21131.06.1 RAM End)
aAwkPgm='
function cvt(a) { if (d == ";") { sub( /\/[cC]/, "C:", a ); gsub( /\//, "\\", a ) } return a }       # .(21120.06.1 RAM cvt path character)
BEGIN  {  aPath = ";"; d=ARGV[1]; bShow=ARGV[2] != "new"; ARGC=1 }                                   # .(21114.01.1 RAM Beg Write Awk program to mark dups)
       {  if ( index( aPath, d $0 d ) ) { if (bShow) { print " x " cvt( $0 ) } }                     # .(21120.06.2)
                                   else { if (bShow) { print "   " cvt( $0 ) }; aPath = aPath d $0 } # .(21120.06.3)
          }
END    { if (bShow != 1) { print aPath } }                                                           # .(21114.01.1 RAM End)
'
           aDelim=":"; if [ "${aOSv:0:1}" == "w" ]; then aDelim=";"; fi;                             # .(21120.06.4)

     if [ "$aCmd2" != "show"  ] && [ "$aCmd2" != "clean"  ] && [ "$aCmd2" != "add"  ]; then          # .(21120.04.1 RAM)
           aArg1="$aCmd2"; aCmd2="show"; fi                                                          # .(21120.04.2)

#    +---- +------------------ +----------------------------------------------------------- # --------+

#          a="$( cmd /c "echo %PATH%" )"                                                                           # .(21120.06.5 RAM How to get Windows Path)
#          echo "-- aCmd2: $aCmd2, aArg1: $aArg1, PATH: ${PATH};"; exit
     if [ "$aCmd2" == "show"  ]; then
#    if [ "$aArg1" == ""      ]; then echo $PATH | tr : "\n" | awk             '{ print "  " $0 }'    ; fi         ##.(80929.01.1 Added print).(21114.01.2)
     if [ "$aArg1" == ""      ]; then echo $PATH | tr : "\n" |                    awk "${aAwkPgm}" "${aDelim}"; fi # .(21114.01.2 RAM Use AwkPgm).(21120.06.6)

#    if [ "$aArg1" != ""      ]; then echo $PATH | tr : "\n" | awk '/'$aArg1'/  { print "  " $0 }'    ; fi         # .(80929.01.2 ?? if $aArg1 != "")
     if [ "$aArg1" != ""      ]; then echo $PATH | tr : "\n" | awk '/'$aArg1'/' | awk "${aAwkPgm}" "${aDelim}"; fi # .(80929.01.2 Added print).(21114.01.3).(21120.06.7)
            bCmdRan="1"                                                                                            # .(81014.03.8)
            fi                          # eif aCmd2 == path show
#    +---- +------------------ +----------------------------------------------------------- # --------+

     if [ "$aCmd2" == "clean" ]; then                                                       # .(21114.04.1 RAM Beg Add clean)

#           aDoit=""; if [ "$4" == "-doit" ]; then aDoit="-doit"; fi
#           aNewPATH="$( echo $PATH | tr : "\n" | awk  "${aAwkPgm}" "${aDelim}" "new" )"    ##.(21120.06.8).(21124.01.1)
#           aNewPATH="$( cvt2winPath "${aNewPATH:2}" ${aOSv:0:1} 1 )"                       ##.(21124.01.2)
#                        cmd //c REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" -v PATH
#           aOldPATH="$( echo "${aOldPATH}" | awk '{ sub( /[\s\S ]+REG_SZ /, "" ); print }' )"     # {aOldPATH:105}"                        ##.(21124.01.3)
            aOldPATH="$( cmd //c REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" -v PATH )"     # .(21124.01.3 RAM Get Windows PATH)
            aOldPATH="$( echo "${aOldPATH}" | awk '/PATH/ { sub( /.+REG_SZ +/, "" ); print }' )"     # {aOldPATH:105}"                      # .(21124.01.4)

            aNewPATH="$( echo "${aOldPATH}" | awk "${aAwkPgm}" "${aDelim}" "new" )"; aNewPATH="${aNewPATH:2}"                               # .(21124.01.5)

      if [ "${#aNewPATH}" -gt "2047" ]; then                                                # .(21124.02.1 RAM Beg Check if PATH len > 2047)
            echo -e " ** The new PATH can't be greater than 2047 characters. It is now ${#aNewPATH} chars."
            echo    "    You can reset the registry value of HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\Path."
            echo -e "    and then reboot Windows.\n"
            exit
            fi                                                                              # .(21124.02.1 RAM End)

            nDups=$(( ${#aOldPATH} - ${#aNewPATH} )); # echo "nDups: '${nDups}'"; # exit    # .(21125.01.6 RAM Beg)  

    if [ "${nDups}" == "0" ]; then                                                        	          
            echo -e "  * The New PATH will be the same as the Old PATH."
            exit
            fi                                                                              # .(21125.01.6 RAM End)            
      if [ "$3" == "-doit" ]; then

#           echo "$0 vars set -doit PATH \"${aNewPATH}\""
#                           "${BASH_SOURCE}      vars set -doit PATH \"${aNewPATH}\""
#                "$( dirname ${BASH_SOURCE} )/$0 vars set -doit PATH \"${aNewPATH}\""
#           echo                             "$0 vars set -doit PATH \"...\""

            echo -e "    About to remove ${nDups} chars from the global System PATH."

    if [ "${aDelim}" == ":" ]; then                                                       	# .(21125.01.7)
           "$0" vars set PATH -doit "${aNewPATH}"                                         	# .(21124.01.5 RAM Let's see if this works)
      if [ "$?" == "1" ]; then exit; fi                                                   	# .(21124.01.6 RAM Exit if it doesn't)
          else                                                                            	# .(21125.01.8)             
            cmd //c REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" -v PATH -d "${aNewPath}" # .(21125.01.9)            
            fi                                                                            	# .(21125.01.10)             
            echo -e "    The new PATH has been reset (${#aNewPATH} chars).\n"
         else
            echo -e "    The Old PATH will have (${nDups}) chars removed from the new PATH (${#aNewPATH} chars)\n"; echo "${aNewPATH}"
            fi
            fi
            bCmdRan="1"                                                                     # .(81014.03.8)
            fi                          # eif aCmd2 == path clean                           # .(21114.04.1 RAM End)
#    +---- +------------------ +----------------------------------------------------------- # --------+

     if [ "$aCmd2" == "add" ]; then                                                         # .(21114.05.1 RAM Beg Add Path Add)

#           aDoit=""; if [ "$4" == "-doit" ]; then aDoit="-doit"; fi
#           aNewPath=$( echo "$4;$PATH" | tr : "\n" | awk  "${aAwkPgm}" ";" "new" )
                                         bDoit=0;     aPath="$3"
            if [ "$3" == "-doit" ]; then bDoit=1;     aPath="$4"; fi
            if [ "$4" == "-doit" ]; then bDoit=1; fi; aPath="$( echo "${aPath}" | awk '{ gsub(/^ +| +$/, "" ); print }' )"

#           -----------------------------------------------------------

      if [ "${aOSv:0:1}" == "w" ]; then                 aOSname="Windows System"
#           aWinPath="$( echo "${aPath}" | awk '{ sub( /\/[cC]/, "C:" ); gsub( /\//, "\\" ); print }' )"  # .(21121.01.1 RAM aPath for Windows
#           echo "aPath: '/${aPath//\//\\\/}/'"; # exit
#           aOldPath="$( echo "${PATH}" | tr : "\n" | awk /${aPath//\//\\\/}/ | awk 'NR == 1' )"  # Find $aPath in $PATH
#           aOldPath="$( echo "${PATH}"     | awk '{ n = length($0); print substr( $0, 1, n < 80 ? n : 80 ) "..." }' )"  # Find 1st 80 chars in $PATH
#           aOldPath="$( echo "${aPath}"    | awk '{ gsub( /:/, ";"); gsub( /\/[cC]/, "C:" ); gsub( /\//, "\\" ); print }' )"
            aOldPATH="${PATH}"
#     if [ "$aOldPath" != "" ]; then                                                            # if $PATH exists, it always will in Windows
#           echo "Found: aPath:    ${aPath}"
#           echo "   in: aOldPath: ${aOldPath}"; # exit
#           aNewPath="${aPath}:${aOldPath/${aPath};/}"                                          ##.(21121.01.2 Find aPath in Path and remote it if found)

#           aOldPath="$( echo "${PATH}"     | awk '{ gsub( /:/, ";"); gsub( /\/[cC]/, "C:" ); gsub( /\//, "\\" ); print }' )"
#           aOldPath="$( echo "${aOldPath}" | awk '{ n = length($0);  print n < '${nLen}' ? $0 : substr( $0, 1, '${nLen}' ) "..." }' )"    # Find 1st 80 chars in $PATH
            aOldPath="$( cvt2winPath "${aOldPATH}" ${aOSv:0:1} )"                               # .(21121.01.1 For display)
            echo "    Old PATH: '${aOldPath}"
#           echo "    aAwkPgm: '{ sub( /"${aPath//\//\\\/}":/, \"\" ); print }'"
            aNewPATH="$( echo "${PATH}" | awk '{ sub( /'${aPath//\//\\\/}':/, "" ); print }' )" # .(21121.01.2 Find aPath in PATH and remove it if found)
            aNewPATH="${aPath}:${aNewPATH}"                                                     # .(21121.01.3 Put  aPath (back) in front of PATH)
#           aNewPath="$( cvt2winPath "${aPath}:${aNewPATH}" ${aOSv:0:1} )"
            aNewPath="$( cvt2winPath "${aNewPATH}" ${aOSv:0:1} )"                               # .(21121.01.4 For display)
#           aNewPath="$( echo "${aNewPath}" | awk '{ gsub( /:/, ";"); gsub( /\/[cC]/, "C:" ); gsub( /\//, "\\" ); print }' )"
#           aNewPath="$( echo "${aNewPath}" | awk '{ n = length($0);  print n < '${nLen}' ? $0 : substr( $0, 1, '${nLen}' ) "..." }' )"    # Find 1st 80 chars in $PATH
            aNewPath="${aNewPath};\$PATH";
#           echo "    New Path: '${aNewPath}'"; # exit

 #      else                                                                      # Not Found
#           aNewPath="${aPath};\$PATH"                                            ##.(21121.01.3
#           aNewPath="${aWinPath};\$PATH"                                         # .(21121.01.3
#           aNewPath="$( echo "${aNewPath}" | awk '{ gsub( /:/, ";"); gsub( /\/[cC]/, "C:" ); gsub( /\//, "\\" ); print }' )"
#           aNewPath="$( echo "${aNewPath}" | awk '{ n = length($0);  print n < 90 ? $0 : substr( $0, 1, 90 ) "..." }' )"    # Find 1st 80 chars in $PATH
#           echo "       aNewPath: ${aNewPath}"; # exit
#           fi
#         -----------------------------------------------------------

        else # if aOSv is Windows
            aBashrc=".bashrc"; if [ ! -f -a "~/${aBashrc}" ]; then aBashrc="profile"; fi           # .(21121.03.1 RAM Use alternate profile file)
                                                        aOSname="~/${aBashrc} file"                # .(21121.03.2)
            aOldPATH="$( cat ~/${aBashrc} | awk '/export PATH=/ { sub( /.+=/, "" ); print }' )"    # .(21121.03.3)
      if [ "$aOldPATH" != "" ]; then                                                               # if $PATH exists in .bashrc
            aNewPATH="${aPath}:${aOldPATH/${aPath}:/}"; aNewPath="$( cvt2winPath "${aNewPATH}" ${aOSv:0:1} )"  #.(21121.01.3 Put aPath (back) in front of PATH))
            echo "    Old PATH: '${aOldPATH}'"
        else
            echo "    Old PATH: '${aOldPATH}'"
            aNewPATH="${aPath}:\$PATH"                ; aNewPath="$( cvt2winPath "${aNewPATH}" ${aOSv:0:1} )"
            fi

          fi # eif aOSv not Windows
#         -----------------------------------------------------------

#             echo "    Old PATH: '$( cvt2winPath "${aOldPATH}" ${aOSv:0:1} 1 )'"
#             echo "    New PATH: '$( cvt2winPath "${aNewPATH}" ${aOSv:0:1} 1)'";exit
#             echo "    Old PATH: '${aOldPATH}'"
#             echo "    New PATH: '${aNewPATH}'";  exit

#     if [ "${aOldPath}" == "${aNewPath}" ]; then
      if [ "${aOldPATH}" == "${aNewPATH}" ]; then

            echo "    New PATH: '${aNewPath}'"
            echo "  * The ${aOSname} PATH will remain unchanged."
            exit 1
        else
            echo "    New PATH: '${aNewPath}'"

      if [ "${bDoit}" == "1" ]; then

#           echo "$0 vars set -doit PATH \"${aNewPath:2}\""
#                "${BASH_SOURCE} vars set -doit PATH \"${aNewPath:2}\""
#                "$( dirname ${BASH_SOURCE} )/$0 vars set -doit PATH \"${aNewPath:2}\""
#           echo "  $0" vars set -doit PATH "\"${aNewPath}\""
                 "$0" vars set PATH -doit "$( cvt2winPath "${aNewPATH}" ${aOSv:0:1} 1)"     # Convert to Windows path, but no length chop
#           echo -e "    The path, '${aPath}', has been added to the global PATH."
         else
            echo    "    The path, '$( cvt2winPath "${aPath}" ${aOSv:0:1} )', will be added to the ${aOSname} PATH."
#           echo -e "    The path, '${aPath}', will be added to the ${aOSname} PATH."
            fi
            fi # eif "${aOldPath}" != "${aNewPath}"

            bCmdRan="1"                                                                     # .(81014.03.8)
            fi                          # eif aCmd2 == path add                             # .(21114.05.1 RAM End)
#    +---- +------------------ +----------------------------------------------------------- # --------+
        fi                              # eif aCmd1 == path
#   +----- +------------------ +----------------------------------------------------------- # ----------+


#   +===== +================== +=========================================================== # ==========+

function setBashrc() { bDoit=$3                                                                          # .(21112.03.1 RAM Beg Write it).(21114.02.11)
#        aVar="$1"; aVal="$2"; if [ "${aVal/ /}" != "${aVal}" ]; then aVal="\\\"${aVal}\\\""; fi;        # .(21112.06.1 RAM Put Quotes if necessary)
         aVar="$1"; aVal="$2"; if [ "${aVal/ /}" != "${aVal}" ]; then aVal="\\\"${aVal}\\\""; fi;        # .(21112.06.1 RAM Put Quotes if necessary)
#        echo -e "\n aVal: '${aVal}'"; # exit
aAwkPgm='
BEGIN { bNew=1 }
    /export '${aVar}'=/ { sub( /=.+/, "='${aVal}'" ); print $0; bNew=0; next }; { print }
END { if ( bNew == 1 ) { print ""; print "  export '${aVar}'='${aVal}'" } }'

#        echo "-----------------------------------------"
#        echo "${aAwkPgm}"; echo ""
#        echo "-----------------------------------------"
#        exit

   if [ "${bDoit}" == "1" ]; then aVerb="has been"; #aToDo="      Please run: source ~/${aBashrc}"       # .(21114.02.12).(21121.03.4)
                                                     aToDo="      Please logout and login again"         # .(21121.03.4)
         cd ~
         aBashrc=".bashrc"; if [ ! -f -a "~/${aBashrc}" ]; then aBashrc="profile"; fi                    # .(21121.03.2)

         aTS=$( date '+%y%m%d.%H%M'); aBak="${aBashrc}_v${aTS}"                                          # .(21121.03.5)
         mv  ${aBashrc}  ${aBak};                                                                        # .(21121.03.6)
         cat ${aBak}  | awk "${aAwkPgm}" >${aBashrc}                                                     # .(21121.03.7)
#        cat ${aBashrc}
#        source ${aBashrc}
      else                                                                                               # .(21114.02.13)
                                 aVerb="will be"; aToDo=""                                               # .(21114.02.14)
         fi                                                                                              # .(21114.02.15)
         echo -e "    The Var, '${aVar}' ${aVerb} set in your bash profile. $aToDo"                      # .(21114.02.16)
         }                                                                                               # .(21112.03.1 RAM End)
#    +---- +------------------ +----------------------------------------------------------- # --------+

     if [ "$aCmd1" == "vars" ]; then    # if  aCmd1 == vars

#    +---- +------------------ +----------------------------------------------------------- # --------+

     if [ "$aCmd2" == "set"  ]; then                                                                    # .(21112.03.2 RAM Beg Add vars set)

#        aArg2="$4"; aArg3="$5";            bDoit=0                                                     # .(21114.02.1 RAM Beg Add bDoit)
#        if [ "${aArg1}" == "-doit" ]; then bDoit=1; aArg1="${aArg2}"; aArg2="${aArg3}"; fi
#        if [ "${aArg2}" == "-doit" ]; then bDoit=1; aArg2="${aArg3}"; fi
#        if [ "${aArg3}" == "-doit" ]; then bDoit=1; fi

         aVar="${aArg1}"; aVal="${aArg2}"; aVal1="${aVal}"                                              # .(21114.02.1 RAM End)
         if [ "${aVal/ /}" != "${aVal}" ]; then aVal1="\\\"${aVal}\\\""; fi;
         if [ "${aVal/ /}" != "${aVal}" ]; then aVal1="\"\"${aVal}\"\""; fi;
         if [ "${aVal/ /}" != "${aVal}" ]; then aVal1="\"${aVal}\""; fi;

#        echo "  rss info vars set '${aVar}' '${aVal}' for aOSv: ${aOSv}; bDoit=${bDoit}"; exit

      if [ "${aOSv:0:1}" == "w" ] || [ "${aOSv:0:1}" == "g" ]; then

#        echo -e "  Windows aOSv: '${aOSv}'"
#        echo "  setx ${aVar}=\"${aVal}\" /M"
#                setx ${aVar}="${aVal}" /M
#                /C/WEBs/8020/VMs/et218t/webs/nodeapps/FRTools_/prod1-master/._2/bin/nircmd.exe elevatecmd execmd "SETX ${aVar} ${aVal} /M"
         aDir="$( dirname "${BASH_SOURCE}" )"; aSETX="SETX ${aVar} ${aVal1} /M"
#                ${aDir}/../../../bin/nircmd.exe elevatecmd execmd  "SETX ${aVar} \"${aVal}\" /M"       # .(21113.04.1 RAM No workie)
#        echo "  ${aDir}/../../../bin/nircmd.exe elevatecmd execmd \"SETX ${aVar} ${aVal1} /M\""
#                ${aDir}/../../../bin/nircmd.exe elevatecmd execmd  "SETX ${aVar} ${aVal1} /M"          # .(21113.04.2 RAM No workie)
#        echo "  ${aDir}/../../../bin/nircmd.exe elevatecmd execmd   SETX ${aVar} ${aVal1} /M"
#                ${aDir}/../../../bin/nircmd.exe elevatecmd execmd   SETX ${aVar} ${aVal1} /M           # .(21113.04.3 RAM No workie)
#        echo "  ${aDir}/../../../bin/nircmd.exe elevatecmd execmd  \"${aSETX}\""

                                         aTodo="Please restart this session"                            # .(21114.02.2)
         if [ "${bDoit}" == "0" ]; then                                                                 # .(21114.02.3)
                 echo "  ${aSETX}"     ; aToDo=""                              ; aVerb="will be"        # .(21114.02.4)

           else                                                                                         # .(21114.02.5)
#                echo nircmd.exe elevatecmd execmd  "${aSETX}" ; aVerb="has been"
                      ${aDir}/../../../bin/nircmd.exe elevatecmd execmd  "${aSETX}" ; aVerb="has been"  # .(21113.04.4 RAM This works!!)
              if [ "$?" != "1" ]; then exit 1; fi                                                       # .(21122.01.7)
              fi                                                                                        # .(21114.02.6)

#        bBash=$( rss info path | awk 'BEGIN{ b=0 }; /\/(Git|git)\/usr/ { b=1; exit }; END { print b }' ); # echo -e "\n * bBash: ${bBash}"
         bBash=0; if [ "${aOSv:0:3}" == "gfw" ]; then bBash=1; fi
 if [ "${bBash}" == "1" ]; then

         echo -e "  The Var, '${aVar}', ${aVerb} set for all users in Windows."                         # .(21114.02.7)
#        echo "  Bash  (${aOSv}): setBashrc \"${aVar}\" \"${aVal}\""
                                  setBashrc  "${aVar}"   "${aVal}"  ${bDoit}                            # .(21114.02.8)
       else # eif OS == Windows

         echo -e "  The Var, '${aVar}', ${aVerb} set for all users in Windows.  ${aTodo}"               # .(21114.02.9)

         fi
       else # OS == Linux

#        echo "  Linux (${aOSv}): setBashrc \"${aVar}\" \"${aVal}\""
                                  setBashrc  "${aVar}"   "${aVal}"  ${bDoit}                            # .(21114.02.10)
         fi

         bCmdRan="1"
         fi                             # eif aCmd2 == vars set                                         # .(21112.03.2 RAM End)
#    +---- +------------------ +----------------------------------------------------------- # --------+

     if [ "$aCmd2" != "show" ]; then aArg1=$aCmd2; aCmd2=show; fi

     if [ "$aCmd2" == "show" ]; then
     if [ "$aArg1" == ""     ]; then       set | awk '/^[A-Z]+=/ { print "  "$0 }'; fi

     if [ "$aArg1" != ""     ]; then
         if [ "${aArg1:0:1}" == "!" ]; then aArg1="${aArg1:1}.+="; else aArg1="^${aArg1}"; fi
             if [ "$bTest" == 1 ]; then
                  echo "set | awk '/^[A-Z]+=/' | awk 'BEGIN {IGNORECASE=1} /$aArg1/'" | awk '{ print "  "$0 }'; echo ""; fi
                        set | awk '/^[A-Z]+=/' | awk 'BEGIN {IGNORECASE=1} /'$aArg1'/ { print "  "$0 }'
         fi
         bCmdRan="1"                                                                      #.(81014.03.9)
         fi                             # eif aCmd2 == vars show
#    +---- +------------------ +----------------------------------------------------------- # --------+
     fi                                 # eif aCmd1 == vars
#   +----- +------------------ +----------------------------------------------------------- # ----------+

#   +===== +================== +=========================================================== # ==========+

     if [ "$aCmd1" == "top"     ]; then # if  aCmd1 == top                                  #.(81014.05.1 Beg)

            top -b -n 1 | awk '/^[ 0-9]/ { if ($10 > 0.0) { print "    " $0 } }' | sort -k11,11 -k12r   #[bdfgiMhnRrV],
            bCmdRan="1"
     fi                                 # eif aCmd1 == newcmd1                              #.(81014.05.1 End)
#   +----- +------------------ +----------------------------------------------------------- # ----------+

#   +===== +================== +=========================================================== # ==========+

     if [ "$aCmd1" == "newcmd1" ]; then # if  aCmd1 == newcmd1                              #.(81014.04.1 Beg)

     if [ "$aCmd2" == "show"    ]; then # if  aCmd2 == newcmd1 show

            echo "  Running $aCmd1 $aCmd2"

            bCmdRan="1"
            fi                          # eif aCmd2 == newcmd1 show
#    +---- +------------------ +----------------------------------------------------------- # --------+

     if [ "$aCmd2" == "newcmd2" ]; then # if  aCmd2 == newcmd1 newcmd2

            echo "  Running $aCmd1 $aCmd2"

            bCmdRan="1"
            fi                          # eif aCmd2 == newcmd1 newcmd2
#    +---- +------------------ +----------------------------------------------------------- # --------+
            bCmdRan="1"
     fi                                 # eif aCmd1 == newcmd1                              #.(81014.04.1 End)
#   +----- +------------------ +----------------------------------------------------------- # ----------+

#   +===== +================== +=========================================================== # ==========+

     if [ "${aCmd1}" == "source"  ]; then echo $0 | awk '{                         print "  '$LIB' ScriptFile: "   $0    }'; echo ""; exit; fi
#    if [ "${aCmd1}" == "source"  ]; then                                                  echo "                  ${aFns}"; echo ""; exit; fi  # .(21114.03.1 RAM There is not Main2Fns)
#    if [ "${aCmd1}" == "version" ]; then echo $0 | awk '{ gsub( /.+_v|.sh/, "" ); print "  '$LIB' Version: "      $0 }';    echo ""; exit; fi  ##.(81014.02.1)
#    if [ "${aCmd1}" == "version" ]; then echo $0 | awk '{ gsub( /.+_v|.sh/, "" ); print "  '$LIB' Info Version: " $0 }';    echo ""; exit; fi  # .(81014.02.1)
#    if [ "${aCmd1}" == "version" ]; then echo "  $LIB Info Version: $0"; echo ""; exit; fi ##.(81014.02.1).(21112.01.2)
     if [ "${aCmd1}" == "version" ]; then echo "  $LIB Info Version: ${aVer}  (${0##*/})"   # .(21112.01.1 RAM Beg)
            echo "$0" | awk '{ print "   " $0 }'
            exit; fi                                                                        # .(21112.01.1 RAM End)

#   +----- +------------------ +----------------------------------------------------------- # ----------+

     if [ "${bCmdRan}" == "0" ]; then                                                       #.(81014.03.11 Beg)

           echo "* Info Function Not Found: $aCmd1 $aCmd2"; echo ""
           Help;
           fi                                                                               #.(81014.03.11 End)
# +------- +------------------ +----------------------------------------------------------- # ------------+ ------------------- # --------------+

#          echo ""
#          echo "*** aCmd: $aCmd1.$aCmd2 \"$aArg1\", bCmdRan: ${aCmdRan}"; exit
#*\
##SRCE     +====================+===============================================+
##RFILE    +====================+=======+===================+======+=============+
#*/
