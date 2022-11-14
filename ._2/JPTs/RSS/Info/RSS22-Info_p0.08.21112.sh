#!/bin/bash
#*\
##=========+====================+================================================+
##RD         Info               | RSS Set and Show Stuff
##RFILE    +====================+=======+===================+======+=============+
##FD   RSS22-Info.sh            |   9510|  9/26/18 22:53|   191| v0.07.80923
##FD   RSS22-Info.sh            |  17214| 11/12/22 16:04|   318| p0.08.21112-1604
##FD   RSS22-Info.sh            |  18141| 11/12/22 18:28|   327| p0.08.21112-1828
##FD   RSS22-Info.sh            |  19554| 11/13/22 17:25|   344| p0.08.21113-1725
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
# .(21113.04 11/12/22 RAM  5:25p| SETX didn't work again

##PRGM     +====================+===============================================+
##ID 69.600. Main               |
##SRCE     +====================+===============================================+
#*/
          aVdt="Nov 12, 2022 6:28p"

          aVer="$( echo $0 | awk '{ match( $0, /_[dpstuv][0-9]+\.[0-9]+/ ); print substr( $0, RSTART+1, RLENGTH-1) }' )"  # .(21111.04.1)

          LIB=RSS; LIB_LOG=${LIB}_LOG; LIB_USER=${LIB}_USER

function  logIt() {
            aFncLine="$1[$2]             "; aFncLine="${aFncLine:0:17} $3";
#           aFncLine="${aFncLine/ \//\/}";  aFncLine="${aFncLine/ C:/C:}";  aFncLine="${aFncLine/ D:/D:}";  aFncLine="${aFncLine/ M:/M:}";
   if [ -f "$LIB_LOG" ]; then echo "$( date '+%Y%m%d-%H%M%S%z')  ${SCN_SERVER:0:11} ${LIB_USER:0:8}  ${aFncLine}" >>"$LIB_LOG"; fi
         }
#   +===== +================== +=========================================================== # ==========+

     if [ "$1" == "test"     ]; then bTest=1; shift; else bTest=0; fi

            aCmd1=$1
            aCmd2=$2
            aArg1=$3
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
#           echo "*** aCmd: $aCmd1.$aCmd2 \"$aArg1\", bCmdRan: ${aCmdRan}"; exit
#   +----- +------------------ +----------------------------------------------------------- # ----------+

function Help() {                                                                           #.(81014.03.1 Beg RAM Create function)
#           echo "  $LIB Info Functions              $( echo $0 | awk '{ gsub( /.+_[ptuv]|.sh/, ""); print }' )"
            echo "  RSS Info Functions   (${aVer})           (${aVdt})"                             # .(21111.04.2)
            echo "  -------------------------------------  ---------------------------------"
            echo "    RSS Path Show                        Show PATH"
            echo "    RSS Vars Show {Search}               Show environment variables (Use ! for non-leading search string)"
            echo "    RSS Vars Set  {Name} {Value}         Set environment variable"
#           echo "    RSS Top                              Show top running programs"
            echo "    RSS Log Show                         Show $LIB Log"
            echo "    RSS Log Set {LogFile} {User}         Set $LIB log"
            echo "    RSS Log On                           Turn $LIB log on"
            echo "    RSS Log Off                          Turn $LIB log off"
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

     if [ "$aCmd2" == "show" ]; then
     if [ "$aArg1" == ""     ]; then echo $PATH | tr : "\n" | awk            '{ print "  " $0 }'; fi    # .(80929.01.1 Added print)
     if [ "$aArg1" != ""     ]; then echo $PATH | tr : "\n" | awk '/'$aArg1'/ { print "  " $0 }'; fi    # .(80929.01.2 Added print)
            bCmdRan="1"                                                                   #.(81014.03.8)
            fi                          # eif aCmd2 == path show
#    +---- +------------------ +----------------------------------------------------------- # --------+
        fi                              # eif aCmd1 == path
#   +----- +------------------ +----------------------------------------------------------- # ----------+


#   +===== +================== +=========================================================== # ==========+

function setBashrc() {                                                                                  # .(21112.03.1 RAM Beg Write it)
#        aVar="$1"; aVal="$2"; if [ "${aVal/ /}" != "${aVal}" ]; then aVal="\\\"${aVal}\\\""; fi;       # .(21112.06.1  RAM Put Quotes if necessary)
         aVar="$1"; aVal="$2"; if [ "${aVal/ /}" != "${aVal}" ]; then aVal="\\\"${aVal}\\\""; fi;       # .(21112.06.1  RAM Put Quotes if necessary)
#        echo -e "\n aVal: '${aVal}'"; # exit
aAwkPgm='
BEGIN { bNew=1 }
    /export '${aVar}'/ { sub( /=.+/, "='${aVal}'" ); print $0; bNew=0; next }; { print }
END { if ( bNew == 1 ) { print ""; print "  export '${aVar}'='${aVal}'" } }'

#        echo "-----------------------------------------"
#        echo "${aAwkPgm}";
#        echo "-----------------------------------------"
#        exit

         aTS=$( date '+%y%m%d.%H%M'); aBak=".bashrc_v${aTS}"
         cd ~
         mv  .bashrc  ${aBak}
         cat ${aBak} | awk "${aAwkPgm}" >.bashrc
#        cat .bashrc
#        source .bashrc
         echo -e "  The Var, '${aVar}' has been set in your bash profile.      Please run: source ~/.bashrc"
         }                                                                                              # .(21112.03.1 RAM End)
#    +---- +------------------ +----------------------------------------------------------- # --------+

     if [ "$aCmd1" == "vars" ]; then    # if  aCmd1 == vars

#    +---- +------------------ +----------------------------------------------------------- # --------+

     if [ "$aCmd2" == "set"  ]; then                                                                    # .(21112.03.2 RAM Beg Add vars set)

         aVar="${aArg1}"; aVal="$4"; aVal1="${aVal}"
#        if [ "${aVal/ /}" != "${aVal}" ]; then aVal1="\\\"${aVal}\\\""; fi;
#        if [ "${aVal/ /}" != "${aVal}" ]; then aVal1="\"\"${aVal}\"\""; fi;
         if [ "${aVal/ /}" != "${aVal}" ]; then aVal1="\"${aVal}\""; fi;

#        echo -e "  rss info vars set '${aVar}' '${aVal}' for aOSv: ${aOSv}"; exit

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
                 ${aDir}/../../../bin/nircmd.exe elevatecmd execmd  "${aSETX}"                          # .(21113.04.4 RAM This works!!)

#        bBash=$( rss info path | awk 'BEGIN{ b=0 }; /\/(Git|git)\/usr/ { b=1; exit }; END { print b }' ); # echo -e "\n * bBash: ${bBash}"
         bBash=0; if [ "${aOSv:0:3}" == "gfw" ]; then bBash=1; fi
 if [ "${bBash}" == "1" ]; then

         echo -e "  The Var, '${aVar}', has been set for all users in Windows."
#        echo "  Bash  (${aOSv}): setBashrc \"${aVar}\" \"${aVal}\""
                                  setBashrc  "${aVar}"   "${aVal}"
       else # OS == Linux
         echo -e "  The Var, '${aVar}', has been set for all users in Windows.  Please restart this session"

         fi
       else # OS == Linux

#        echo "  Linux (${aOSv}): setBashrc \"${aVar}\" \"${aVal}\""
                                  setBashrc  "${aVar}"   "${aVal}"
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

     if [ "${aCmd1}" == "source"  ]; then echo $0 | awk '{                         print "  '$LIB' ScriptFile: "   $0 }'; echo ""; exit; fi
#    if [ "${aCmd1}" == "version" ]; then echo $0 | awk '{ gsub( /.+_v|.sh/, "" ); print "  '$LIB' Version: "      $0 }'; echo ""; exit; fi  ##.(81014.02.1)
#    if [ "${aCmd1}" == "version" ]; then echo $0 | awk '{ gsub( /.+_v|.sh/, "" ); print "  '$LIB' Info Version: " $0 }'; echo ""; exit; fi  # .(81014.02.1)
#    if [ "${aCmd1}" == "version" ]; then echo "  $LIB Info Version: $0"; echo ""; exit; fi ##.(81014.02.1).(21112.01.2)
     if [ "${aCmd1}" == "version" ]; then echo "  $LIB Info Version: ${aVer}  (${0##*/})"   # .(21112.01.1 RAM Beg)
            echo -e "    ${0%/*}\n"
            exit; fi                                                                        # .(21112.01.1 RAM End)

#   +----- +------------------ +----------------------------------------------------------- # ----------+

     if [ "${bCmdRan}" == "0" ]; then                                                       #.(81014.03.11 Beg)

           echo "* Info Function Not Found: $aCmd1 $aCmd2"; echo ""
           Help;
           fi                                                                               #.(81014.03.11 End)
# +------- +------------------ +----------------------------------------------------------- # ------------+ ------------------- # --------------+

           echo ""
#          echo "*** aCmd: $aCmd1.$aCmd2 \"$aArg1\", bCmdRan: ${aCmdRan}"; exit
#*\
##SRCE     +====================+===============================================+
##RFILE    +====================+=======+===================+======+=============+
#*/
