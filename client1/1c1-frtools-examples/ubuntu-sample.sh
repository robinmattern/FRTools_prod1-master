#!/bin/bash
#*\
##=========+====================+================================================+
##RD         ubuntu-sample      | Steps to
##RFILE    +====================+=======+=================+======+===============+
##FD   FRT30_Doc0.sh            |  11350| 11/28/22 08:01|   188| p1.01-21128.0801
##FD   FRT99_Template0.sh       |  10134| 11/28/22 13:47|   169| p1.01-21128.1347
##DESC     .--------------------+-------+-----------------+------+---------------+
#            This script contains formR's docR steps to test and document the
#            steps to install FRTools.
#               1. Revert the system back to no race of FRTools
#               2. Clone the FRTools repository
#               3. Run setPath to make all scripots avaiable from anywhere
#               4. Get a new version of the FRTools repository
#               5. Other usefull commnds
#
##LIC      .--------------------+----------------------------------------------+
#            Copyright (c) 2022 8020Data-formR * Released under
#            MIT License: http://www.opensource.org/licenses/mit-license.php
#
##CHGS     .--------------------+-------+-------------------+------+-----------+
# .(11130.03 11/30/22 RAM 10:00p| Created
# .(11201.06 12/01/22 RAM 11:53a| Updated for Bruce
# .(11201.06 12/01/22 RAM  4:48p| Last 4 hours of work lost
# .(11201.06 12/02/22 RAM 10:00a| Rewrote lost changes
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

  docR step  " 1. Login to Remote Ubuntu Server"      1
  docR step  "    - Open Bitvise Profile .tlp file"   2
  docR step  "    - Click the Login button"           2
  docR step  "    - Open New terminal console"        2
  docR step  "    - In the remote terminal console, remove existing PATH" 2
  docR code  "    $ nano /root/.profile"
  docR text  "        Remove "/webs/FRTools/._2/bin:" from export PATH="\$PATH:..." in /root/.profile"
  docR text  "        CTRL-X"
  docR code  "    $ logout"
  docR step  "    - In Bitvise, Open New terminal console"
  docR step  "    - Check the FRTools is not installed"
  docR code  "    $ frtools"
  docR step  "    - Remove the FRTools if present"
  docR code  "    $ rm -R webs/FRTools"
  docR code  "    $ rm    webs/frtools/*"

  docR space
  docR step  " 2. Clone the FRTools Repository"
  docR code  "    $ cd /webs"
  docR code  "    $ git clone https://github.com/robinmattern/FRTools_prod1-master FRTools"

  docR space
  docR step  " 3. Set the Path to the FRTools scripts"
  docR code  "    $ cd /webs/FRTools"
  docR code  "    $ chmod 755 setPath"
  docR code  "    $ ./setPath"
  docR code  "    $ ./setPath -doit"
  docR code  "    $ logout"
  docR step  "    - In Bitvise, Open New terminal console"
  docR step  "    - Check that the FRTools scripts are installed"
  docR code  "    $ FRTools"

  docR space
  docR step  " 4. Get new version of FRTools"
  docR code  "    $ cd /webs/FRTools"
  docR code  "    $ gitr pull "
  docR code  "    $ gitr pull -hard"

  docR end

#==========================================================================================================#
#*\
##SRCE     +====================+===============================================+
##RFILE    +====================+=======+===================+======+=============+
#*/

