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
# .(80923.01  9/23/18 RAM  3:26p| Create it
# .(80926.06  9/26/10 RAM 10:52p| Fix backslashes
# .(80929.01  9/29/10 RAM  8:19p| Add 2 spaces to: info path
# .(81014.02 10/14/10 RAM  9:30a| Modify Version cmd 
# .(81014.03 10/14/10 RAM 10:15a| Show Help if bCmdRan == 0 
# .(81014.04 10/14/10 RAM 11:00a| Add newCmd template 
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
            echo "  $LIB Info Functions              v$( echo $0 | awk '{ gsub( /.+_v|.sh/, ""); print }' )"
            echo "  ------------------------------  -----------------------------------------------------------------"
            echo "       path show                  Show PATH"
            echo "       vars show {Search}         Show environment variables (Use ! for non-leading search string)"
            echo "       vars set  {Name} {Value}   Set environment variable"
            echo "       top                        Show top running programs"
            echo "       log show                   Show $LIB Log"
            echo "       log set {LogFile} {User}   Set $LIB log"
            echo "       log on                     Turn $LIB log on"
            echo "       log off                    Turn $LIB log off"
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

     if [ "$aCmd1" == "vars" ]; then    # if  aCmd1 == vars

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
     if [ "${aCmd1}" == "version" ]; then echo "  $LIB Info Version: $0"; echo ""; exit; fi  # .(81014.02.1) 

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
