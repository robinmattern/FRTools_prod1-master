#!/bin/bash
#*\
##=========+====================+================================================+
##RD         Proxy              | FormR Proxy Tools
##RFILE    +====================+=======+===============+======+=================+
##FD   FRT24_Proxy.sh           |  12313|  5/09/22 08:26|   260| p1.06-20509-0826
##FD   FRT24_Proxy.sh           |  12592|  6/20/22 10:42|   273| p1.06-20620-1042
##FD   FRT24_Proxy1.sh          |  12616|  6/20/22 10:52|   264| u1.07-20620-1052
##FD   FRT24_Proxy1.sh          |  13090|  6/22/22 18:01|   275| u1.07-20622-1801
##DESC     .--------------------+-------+---------------+------+-----------------+
#            Use the commands in this script to run proxy commands with helpfull
#            output.
#
##LIC      .--------------------+----------------------------------------------+
#            Copyright (c) 2021 8020Data-FormR * Released under
#            MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+----------------------------------------------+
#            Help               |
#            sysCtl             |
#            chkProxy           |
#
##CHGS     .--------------------+----------------------------------------------+
# .(20101.01  1/01/22 RAM  1:00a| Created
# .(10706.09  7/06/21 RAM 11:15a| Supress Windows final space
# .(20412.02  4/12/22 RAM  2:00p| Add Proxy Local command
# .(20412.04  4/12/22 RAM  3:00p| Add Proxy Check command
# .(20501.01  5/01/22 RAM 12:00p| Load Script fns
# .(20620.01  6/20/22 RAM 12:00p| Add -vv wordy version command
#
##PRGM     +====================+===============================================+
##ID 69.600. Main               |
##SRCE     +====================+===============================================+
#*/
#========================================================================================================== #  ===============================  #

        aVdt="May 8, 2022 4:16a"
#       aVer="$( echo $0 | awk '{ sub( /.+_p/, "p" ); sub( /\.sh/, ""); print }' )"
        aVer="$( echo $0 | awk '{  match( $0, /_[pstuv][0-9]+\.[0-9]+/ ); print substr( $0, RSTART+1, RLENGTH-1) }' )"  # "p2.02"

     if [ "${1:0:3}" == "ver" ] || [ "${1:0:2}" == "-v" ]; then
        echo ""
#       echo "  FRTool proX Version ${aVer}  ($( date "+%b %-d %Y %H:%M" ))"
        echo "  FRTool proX Version ${aVer}  (${aVdt})"
        if [ "${1:0:3}" == "-vv" ]; then echo "  $0"; fi                                                    # .(20620.01.4 RAM End)
        echo ""
        exit
        fi
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

     if [ "${aJFns}" != "" ]; then source ${aJFns};
       else echo " ** Unable to load Script Fns, 'JPT12_Main2Fns_p*.sh'"; exit; fi;     # .(20501.01.2 RAM)

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

        setOS; bSpace=0;                                                                                    #  A space hasn't been displayed, print one next
        aLstSp="echo "; if [ "${aOSv:0:1}" == "w" ]; then aLstSp=""; fi                                     # .(10706.09.1 RAM Windows returns an extra blank line)

#       bDoit=0                                                                                             ##.(20501.01.5 RAM !Important don't reset in Sub script)
#       bQuiet=0                                                                                            ##.(20501.01.6 RAM)
#       bDebug=0                                                                                            ##.(20501.01.7 RAM)

#       sayMsg    "FRT24[ 62]  aServer: '${aServer}', aOS: '${aOS}', bDebug: '${bDebug}'" 2

# ------------------------------------------------------------------------------------
#
#       HELP
#
#====== =================================================================================================== #  ===========

function Help( ) {

        sayMsg    "FRT24[ 72]  aCmd:  '${aCmd}', aCmd0: '$1'" -1

     if [ "${aCmd}" != "Help" ] && [ "help" != "$1" ]; then return; fi
     if [ "$1" != "help" ]; then sayMsg " ** Invalid Command: '$1'" 3 "sp"; aCmd="Help"; fi

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

        echo ""
        echo "  Useful formR proX Commands  (${aVer})      (${aVdt})"
        echo "  ------------------------------------------- -----------------------------------"
        echo "    frt prox [ check | stop | start | restart | reload | list ]"
        echo "        prox log  [ list | acc | err | set {app} ]"
        echo "        prox conf [ make | show ]"
        echo "        prox make"
        ${aLstSp}                                                                                           # .(10706.09.3)
        exit
     } # eof Help
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#========================================================================================================== #  ===============================  #

        setArgs "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9"

        getOpts "bdq"
        setCmds

        sayMsg sp "FRT24[ 97]  \$1: '$1', \$2: '$2', \$3: '$3', \$4: '$4', \$5: '$5', \$6: '$6', \$7: '$8'" -1

  if [ "${aCmd}"  == "" ] || [ "${aCmd}" == "Help" ]; then
        Help
        fi

# ------------------------------------------------------------------------------------
#
#       PROXY Functions
#
#====== =================================================================================================== #

 function  chkProxy() {
        sayMsg sp "FRT24[111]  chkProxy: " -1

                                    aProxy=''                                           # .(20412.02.1)
#                                   aProxy='local'                                      ##.(20412.02.1 RAM Was aProxy='')
     if [ -d "/etc/nginx"   ]; then aProxy='nginx';   fi
     if [ -d "/etc/apache2" ]; then aProxy='apache2'; fi
     if [ "${aProxy}" == "" ]; then sayMsg "You must be in a proxy server." 2; fi
     }
#    -- --- ---------------  =  ------------------------------------------------------  #

 function  sysCtl( ) {

     chkProxy

     aCmd="systemctl $1 $2"                                                             # .(20412.04.3 Beg)
  if [ "$1" == "check" ]; then
     aCmd="nginx -t"
     fi                                                                                 # .(20412.04.3 End)
#    echo " -- aCmd: '${aCmd}'"; exit
  if [ "${aProxy}" == "local" ]; then                                                   # .(20412.02.2 Beg RAM Added)
     setSSH_Host
     echo ""
     echo "  $ ssh  ${aSSH_Host}  ${aCmd}"
               ssh  ${aSSH_Host}  ${aCmd} | awk '{ print "   " $0 }'
     exit
   else                                                                                 # .(20412.02.2 End)
     echo ""
#    systemctl $1 $2;    2>&1 | awk '{ print "   " $0 }';                               ##.(20412.04.3)
     ${aCmd}             2>&1 | awk '{ print "   " $0 }';                               # .(20412.04.3)
     fi
     echo "  * NGinx $1ed at $( date '+%Y-%m-%d %H:%M' )"
     echo ""
     }
#    -- --- ---------------  =  ------------------------------------------------------  #

# ------------------------------------------------------------------------------------
#
#       PROXY Commands
#
#====== =================================================================================================== #

     if [ "${1:0:3}" == "sto" ]; then sysCtl stop nginx;    fi
     if [ "${1:0:3}" == "sta" ]; then sysCtl start nginx;   fi
     if [ "${1:0:3}" == "res" ]; then sysCtl restart nginx; fi
     if [ "${1:0:3}" == "rel" ]; then sysCtl reload nginx;  fi
#    if [ "${1:0:3}" == "tes" ]; then nginx -t | awk '{ print "   " $0 }'; fi           ##.(20412.04.1 RAM
     if [ "${1:0:3}" == "tes" ]; then sysCtl check nginx;   fi                          # .(20412.04.1 RAM
     if [ "${1:0:3}" == "che" ]; then sysCtl check nginx;   fi                          # .(20412.04.2 RAM

#    -- --- ---------------  =  ------------------------------------------------------  #

     if [ "${1:0:3}" == "log" ]; then

           chkProxy

       if [ "${2:0:2}" == "li" ]; then
          rdir -d 2 -s 2 /var/log/nginx
          exit
          fi

#         aApp="fr218d_Proxy-"
#         aApp="Proxy-"
          aApp=""

          aLog=access.log; aFmt="  %-15s  %s  %3s  %4s  %4s  %s"
       if [ "${2:0:3}" == "acc" ]; then
          aLog=${aApp}access.log;
          aFmt="  %-15s  %s  %3s  %4s  %4s  %s";
          aAwk="{ printf \"${aFmt}\\n\", \$1, substr(\$4,2), \$9, \$10, substr(\$6,2,4), \$7 }"
          fi
       if [ "${2:0:3}" == "err" ]; then
          aLog=${aApp}error.log;
          aFmt="  %s";
          aAwk="{ printf \"${aFmt}\\n\", \$0 }"
          fi
       if [ "${2:0:3}" == "deb" ]; then
          aLog=${aApp}debug.log;
          aFmt="  %s";
          aAwk="{ printf \"${aFmt}\\n\", \$0 }"
          fi
                                        aLines="-n 30";    bFollow=0
       if [ "${3:0:3}" == "fol" ]; then aLines="-n 30 -f"; bFollow=1; fi
       if [ "${3:0:2}" == "-f"  ]; then aLines="-n 30 -f"; bFollow=1; fi

          echo ""
 #        echo "  aAwk: ${aAwk}"; exit
          echo "$ tail ${aLines} \"/var/log/nginx/${aLog}\""
          echo ""

       if [ "${bFollow}" == "0" ]; then
            tail ${aLines} "/var/log/nginx/${aLog}" | awk -e "${aAwk}" | sort
          else
            tail ${aLines} "/var/log/nginx/${aLog}" | awk '/^X-/ { print "   " $0 }'
            fi
          echo ""
          exit

        fi # eof Proxy Log
#       --- ---------------  =  ------------------------------------------------------  #

#         echo "\${1:0:3}: '${1:0:3}', \${2:0:3}: '${2:0:3}'"

     if [ "${1:0:3}" == "con" ] && [ "${2:0:3}" == "mak" ]; then

#         echo "   $( dirname $0 )/Proxy/NGinxConf/makConfs_u6.sh"
                   $( dirname $0 )/Proxy/NGinxConf/makConfs_u6.sh "$4"

        fi # eof Proxy Conf Make
#       --- ---------------  =  ------------------------------------------------------  #

     if [ "${1:0:3}" == "con" ] && [ "${2:0:3}" == "var" ]; then

#         echo "   $( dirname $0 )/Proxy/NGinxConf/makConfs_u6.sh"
                   $( dirname $0 )/Proxy/NGinxConf/makConfs_u6.sh -q4

        fi # eof Proxy Conf Make
#       --- ---------------  =  ------------------------------------------------------  #

     if [ "${1:0:3}" == "con" ] && [ "${2:0:3}" == "sho" ]; then

#         echo "   $( dirname $0 )/Proxy/NGinxConf/makConfs_u6.sh"
                   $( dirname $0 )/Proxy/NGinxConf/makConfs_u6.sh -q3

        fi # eof Proxy Conf Make
#       --- ---------------  =  ------------------------------------------------------  #

#    fi   # eif command proxy                                                                               # .(20622.05.1 RAM We're in it)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------

     if [ "${1:0:3}" == "mak" ]; then

                   $( dirname $0 )/Proxy/NGinxConf/makConfs_u6.sh "$2"
        fi
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       NEXT COMMAND Commands                                                                               # .(20102.01.2 Beg RAM Added Command)
#
#====== =================================================================================================== #

        sayMsg    "FRT24[256]  Next Command" sp;

  if [ "${aCmd}" == "Next Command" ]; then

        sayMsg    "FRT24[260]  Next Command" 1

     ${aLstSp}
     fi # eoc Next Command                                                                                  # .(20102.01.2 End)
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
