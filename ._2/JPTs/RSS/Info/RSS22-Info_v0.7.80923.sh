#!/bin/bash
#*\
##=========+====================+================================================+
##RD         Info               | RSS Set and Show Stuff
##RFILE    +====================+=======+===================+======+=============+
##FD   RSS22-Info.sh            |   9510|  9/26/18 10:53:00p|   191| v0.7.80923
##DESC     .--------------------+-------+-------------------+------+------------+
#
#
##LIC      .--------------------+----------------------------------------------+
#            Copyright (c) 2018 SicommNet-JPT * Released under
#            MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+-------+-------------------+------+-----------+
#
##CHGS     .--------------------+-------+-------------------+------+-----------+
# .(80923.01  9/23/18 RAM  3:26p| Created
# .(80926.06  9/26/10 RAM 10:52p| Fix backslashes
# .(80929.01  9/29/10 RAM  8:19p| Added 2 spaces to: info path
##PRGM     +====================+===============================================+
##ID 69.600. Main               |
##SRCE     +====================+===============================================+
#*/
          LIB=RSS; LIB_LOG=${LIB}_LOG; LIB_USER=${LIB}_USER

function  logIt() {
            aFncLine="$1[$2]             "; aFncLine="${aFncLine:0:17} $3";
#           aFncLine="${aFncLine/ \//\/}";  aFncLine="${aFncLine/ C:/C:}";  aFncLine="${aFncLine/ D:/D:}";  aFncLine="${aFncLine/ M:/M:}";
   if [ -f "$LIB_LOG" ]; then echo "$( date '+%Y%m%d-%H%M%S%z')  ${SCN_SERVER:0:11} ${LIB_USER:0:8}  ${aFncLine}" >>"$LIB_LOG"; fi
         }
# +------- +------------------ +----------------------------------------------------------- # ------------+ ------------------- # --------------+

     if [ "$1" == "test"     ]; then bTest=1; shift; else bTest=0; fi

            aCmd1=$1
            aCmd2=$2
            aArg1=$3

     if [ "$aCmd1" == ""     ]; then aCmd1=help; fi
     if [ "$aCmd2" == ""     ]; then aCmd2=show; fi

     if [ "$aCmd1" == "show" ]; then aCmd1=vars
     if [ "$aCmd2" == "path" ]; then aCmd1=path; fi
     if [ "$aCmd2" == "vars" ]; then aCmd1=vars; fi
     if [ "$aCmd2" == "log"  ]; then aCmd1=log;  fi
            aCmd2=show
        fi
            echo ""
#           echo "  aCmd: $aCmd1.$aCmd2 \"$aArg1\""
#   +----- +------------------ +----------------------------------------------------------- # ----------+

     if [ "$aCmd1" == "help" ]; then

            echo "  $LIB Info Functions"
            echo "       path show                  Show PATH"
            echo "       vars show {Search}         Show Environment Variables (Use ! for non-leading search string)"
            echo "       vars set  {Name} {Value}   Set Environment Variable"
            echo "       log show                   Show $LIB Log"
            echo "       log set {LogFile} {User}   Set $LIB Log"
            echo "       log on                     Turn $LIB Log on"
            echo "       log off                    Turn $LIB Log off"
      fi
#   +----- +------------------ +----------------------------------------------------------- # ----------+

     if [ "$aCmd1" == "log" ]; then
     

     if [  "$aCmd2" == "set" ] || [ "$aCmd2" == "on"  ]; then
#    if [[ "$aCmd2" == "set"   ||   "$aCmd2" == "on" ]]; then
#    if [  "$aCmd2" == "set" ]; then

                aTS=$( date '+%Y%m%d'); aTS=${aTS:3}
                export RSS_USER="${USERNAME%%.*}          "             # First name; Delete after and including ."

#               LIB_LOG="/C/Home/SCN2/_/LOGs/${LIB}s/"
            if [ "${SCN_SERVER:7:1}" == "w" ];then                      # sc163d-w08s_Sherman3 (192.168.109.8)
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
            fi    # eif aCmd2 == log set
#    +---- +------------------ +----------------------------------------------------------- # --------+

     if [ "$aCmd2" == "on" ]; then

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

            fi    # eif aCmd2 == log ont
#    +---- +------------------ +----------------------------------------------------------- # --------+

     if [ "$aCmd2" == "off" ]; then
     
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
            fi    # eif aCmd2 == log off
#    +---- +------------------ +----------------------------------------------------------- # --------+

     if [ "$aCmd2" == "show" ]; then

       if [ ! -f "$RSS_LOG" ]; then
            echo "* Logfile does not exist"
         else
            echo "  Showing RSS log file: \"$( echo "${RSS_LOG}" | tr "\\\\", "/" )\""; echo ""         # .(80926.06.3 If it contains backslashes)
            tail -n 20 "${RSS_LOG}"
            fi
            fi    # eif aCmd2 == log show
#    +---- +------------------ +----------------------------------------------------------- # --------+
        fi    # eif aCmd1 == log
#   +----- +------------------ +----------------------------------------------------------- # ----------+

     if [ "$aCmd1" == "path" ]; then

     if [ "$aCmd2" == "show" ]; then
     if [ "$aArg1" == ""     ]; then echo $PATH | tr : "\n" | awk            '{ print "  " $0 }'; fi    # .(80929.01.1 Added print)
     if [ "$aArg1" != ""     ]; then echo $PATH | tr : "\n" | awk '/'$aArg1'/ { print "  " $0 }'; fi    # .(80929.01.2 Added print)

            fi    # eif aCmd2 == path show
#    +---- +------------------ +----------------------------------------------------------- # --------+
        fi    # eif aCmd1 == path
#   +----- +------------------ +----------------------------------------------------------- # ----------+

     if [ "$aCmd1" == "vars" ]; then
     if [ "$aCmd2" != "show" ]; then aArg1=$aCmd2; aCmd2=show; fi

     if [ "$aCmd2" == "show" ]; then
     if [ "$aArg1" == ""     ]; then       set | awk '/^[A-Z]+=/ { print "  "$0 }'; fi

     if [ "$aArg1" != ""     ]; then
         if [ "${aArg1:0:1}" == "!" ]; then aArg1="${aArg1:1}.+="; else aArg1="^${aArg1}"; fi
             if [ "$bTest" == 1 ]; then
                  echo "set | awk '/^[A-Z]+=/' | awk 'BEGIN {IGNORECASE=1} /$aArg1/'" | awk '{ print "  "$0 }'; echo ""; fi
                        set | awk '/^[A-Z]+=/' | awk 'BEGIN {IGNORECASE=1} /'$aArg1'/ { print "  "$0 }'
         fi
         fi    # eif aCmd2 == vars show
#    +---- +------------------ +----------------------------------------------------------- # --------+
     fi    # eif aCmd1 == vars
#   +----- +------------------ +----------------------------------------------------------- # ----------+

     if [ "${aCmd1}" == "source"  ]; then echo $0 | awk '{                         print "  '$LIB' ScriptFile: "  $0 }'; echo ""; exit; fi
     if [ "${aCmd1}" == "version" ]; then echo $0 | awk '{ gsub( /.+_v|.sh/, "" ); print "  '$LIB' Version: "     $0 }'; echo ""; exit; fi

            echo ""

# +------- +------------------ +----------------------------------------------------------- # ------------+ ------------------- # --------------+
#*\
##SRCE     +====================+===============================================+
##RFILE    +====================+=======+===================+======+=============+
#*/
