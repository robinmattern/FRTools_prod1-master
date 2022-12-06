#!/bin/bash
#*\
##=========+====================+================================================+
##RD         ubuntu-IODD-sample | Steps to
##RFILE    +====================+=======+=================+======+===============+
##FD   FRT30_Doc0.sh            |  11350| 11/28/22 08:01|   188| p1.01-21128.0801
##FD   FRT99_Template0.sh       |  10134| 11/28/22 13:47|   169| p1.01-21128.1347
##FD   windows-IODD-sample.sh   |   4476| 12/05/22 10:09|    96| p1.01-21205.1009
##DESC     .--------------------+-------+-----------------+------+---------------+
#            This script contains formR's docR steps to test and document the
#            steps to install the 8020 Data's IODD Repository.
#               1. Revert the system back to no trace of IODD
#               2. Clone the IODD repository
#               4. Get a new version of the IODD repository
#               5. Save your own version of the IODD repository
#               5. Other usefull commnds
#
##LIC      .--------------------+----------------------------------------------+
#            Copyright (c) 2022 8020Data-formR * Released under
#            MIT License: http://www.opensource.org/licenses/mit-license.php
#
##CHGS     .--------------------+-------+-------------------+------+-----------+
# .(11205.03 12/05/22 RAM 10:00p| Created
#
##PRGM     +====================+===============================================+
##ID 69.600. Main               |
##SRCE     +====================+===============================================+
#*/
#==========================================================================================================#

function docR() {
if [ "$1" == "start" ]; then aMD="$( basename $0 )"; aTS=$( date '+%y%m%d.%H%M' );
                             aMD="${aMD/.sh/}_v${aTS:1}.md";
                             echo ""                    >"${aMD}"; fi
if [ "$1" == "space" ]; then echo -e "\n    &nbsp;"    >>"${aMD}"; return; fi
if [ "$1" == "code"  ]; then echo "  \` # ${2:6} \`  " >>"${aMD}";
                        else echo         "$2   "      >>"${aMD}"; fi
if [ "$1" == "end"   ]; then cat "${aMD}"; fi
      }
        aDocRcmd="$( which _docR 2>&1 )"
if [ "${aDocRcmd/bin\/docR/}" != "${aDocRcmd}" ]; then unset -f docR; fi

# -----------------------------------------------------------------------------

# docR set pause off
# docR set pause on

  docR start "## FRTools Ubuntu Install Script"

  docR step  " 1. Login to Windows"      1
  docR step  "    - In Windows Explorer, select C:\Repos, open Git Bash" 2
  docR step  "    - Remove the folder FRTools if present"
  docR code  "    $ rm -R /C/Repos/IODD"
  docR code  "    $ rm    /C/Repos/iodd_gitr-config/*"

  docR space
  docR step  " 2. Clone the IODD Repository"
  docR step  "    - In Windows Explorer, select C:\Repos, open Git Bash" 2
  docR code  "    $ cd /C/Repos"
  docR code  "    $ gitr clone https://github.com/brucetroutman-gmail/IODDCOM_prod-master IODD"

  docR space
  docR step  " 4. Get new version of FRTools"
  docR code  "    $ cd /C/Repos/IODD"
  docR code  "    $ gitr pull "
  docR code  "    $ gitr pull -hard"

  docR end

#==========================================================================================================#
#*\
##SRCE     +====================+===============================================+
##RFILE    +====================+=======+===================+======+=============+
#*/

