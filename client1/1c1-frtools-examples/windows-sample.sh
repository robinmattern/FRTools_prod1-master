#!/bin/bash
#*\
##=========+====================+================================================+
##RD         ubuntu-sample      | Steps to
##RFILE    +====================+=======+=================+======+===============+
##FD   FRT30_Doc0.sh            |  11350| 11/28/22 08:01|   188| p1.01-21128.0801
##FD   FRT99_Template0.sh       |  10134| 11/28/22 13:47|   169| p1.01-21128.1347
##FD   windows-sample.sh        |   4476| 12/05/22 10:00|    96| p1.01-21205.1000
##DESC     .--------------------+-------+-----------------+------+---------------+
#            This script contains formR's docR steps to test and document the
#            steps to install FRTools.
#               1. Revert the system back to no trace of FRTools
#               2. Clone the FRTools repository
#               3. Run setPath to make all scripts avaiable from anywhere
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
# .(11201.07 12/02/22 RAM 12:00a| Rewrote lost changes - not done
# .(11205.06 12/05/22 RAM 10:00a| Made minor edits
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

  docR start "## FRTools Windows Install Script"

  docR step  " 1. Login to Windows"      1
  docR step  "    - Remove System Environment PATHs"   2
  docR text  "        Start Charms -> Env ->"
  docR text  "        Click on System Variables"
  docR text  "        In User Variables for %User% panel, delete path C:/Repos/FRTools/._2/bin"
  docR text  "        In System Variables panel, delete path C:/Repos/FRTools/._2/bin"
  docR text  "        Click on OK three times"
  docR step  "    - In Windows Explorer, select C:\Repos, open Git Bash" 2
  docR code  "    $ nano ~/.bashrc"
  docR text  "        Remove "C:/Repos/FRTools/._2/bin:" from export PATH="\$PATH:...""
  docR text  "        CTRL-X"
  docR step  "    - Remove the folder FRTools if present"
  docR code  "    $ rm -R /c/Repos/FRTools"
  docR code  "    $ rm    /c/Repos/frtools/*"
  docR code  "    - Logout of Windows and log back in"
  docR step  "    - Check the FRTools is not installed"
  docR code  "    $ frtools"

  docR space
  docR step  " 2. Clone the FRTools Repository"
  docR step  "    - Open Windows Command console"   2
  docR code  "    $ cd \Repos"
  docR code  "    $ git clone https://github.com/robinmattern/FRTools_prod1-master FRTools"

  docR space
  docR step  " 3. Set the Path to the FRTools scripts"
  docR code  "    $ cd FRTools"
  docR code  "    $ ./setPath"
  docR code  "    $ ./setPath -doit"
  docR code  "    - Logout of Windows and log back in"
  docR step  "    - Check that the FRTools scripts are installed"
  docR code  "    $ FRTools"

  docR space
  docR step  " 4. Get new version of FRTools"
  docR code  "    $ cd \Repos\FRTools"
  docR code  "    $ gitr pull "
  docR code  "    $ gitr pull -hard"

  docR end

#==========================================================================================================#
#*\
##SRCE     +====================+===============================================+
##RFILE    +====================+=======+===================+======+=============+
#*/

